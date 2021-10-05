package flashx.textLayout.elements
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.text.engine.TextLineValidity;
   import flash.utils.Dictionary;
   import flashx.textLayout.compose.FlowComposerBase;
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.compose.ISWFContext;
   import flashx.textLayout.compose.StandardFlowComposer;
   import flashx.textLayout.edit.ISelectionManager;
   import flashx.textLayout.events.DamageEvent;
   import flashx.textLayout.events.ModelChange;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [Event(name="updateComplete",type="flashx.textLayout.events.UpdateCompleteEvent")]
   [Event(name="damage",type="flashx.textLayout.events.DamageEvent")]
   [Event(name="scroll",type="flashx.textLayout.events.TextLayoutEvent")]
   [Event(name="inlineGraphicStatusChanged",type="flashx.textLayout.events.StatusChangeEvent")]
   [Event(name="click",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="rollOut",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="rollOver",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="mouseMove",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="mouseUp",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="mouseDown",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="compositionComplete",type="flashx.textLayout.events.CompositionCompleteEvent")]
   [Event(name="selectionChange",type="flashx.textLayout.events.SelectionEvent")]
   [Event(name="flowOperationComplete",type="flashx.textLayout.events.FlowOperationEvent")]
   [Event(name="flowOperationEnd",type="flashx.textLayout.events.FlowOperationEvent")]
   [Event(name="flowOperationBegin",type="flashx.textLayout.events.FlowOperationEvent")]
   public class TextFlow extends ContainerFormattedElement implements IEventDispatcher
   {
      
      public static var defaultConfiguration:Configuration = new Configuration();
      
      private static var _nextGeneration:uint = 1;
       
      
      private var _flowComposer:IFlowComposer;
      
      private var _interactionManager:ISelectionManager;
      
      private var _configuration:IConfiguration;
      
      private var _backgroundManager:BackgroundManager;
      
      private var normalizeStart:int = 0;
      
      private var normalizeLen:int = 0;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _generation:uint;
      
      private var _formatResolver:IFormatResolver;
      
      private var _interactiveObjectCount:int;
      
      private var _graphicObjectCount:int;
      
      private var _parentElement:FlowGroupElement;
      
      private var _elemsToUpdate:Dictionary;
      
      private var _hostFormatHelper:HostFormatHelper;
      
      public function TextFlow(config:IConfiguration = null)
      {
         super();
         this.initializeForConstructor(config);
      }
      
      private function initializeForConstructor(config:IConfiguration) : void
      {
         if(config == null)
         {
            config = defaultConfiguration;
         }
         this._configuration = Configuration(config).getImmutableClone();
         format = this._configuration.textFlowInitialFormat;
         if(this._configuration.flowComposerClass)
         {
            this.flowComposer = new this._configuration.flowComposerClass();
         }
         this._generation = _nextGeneration++;
         this._interactiveObjectCount = 0;
         this._graphicObjectCount = 0;
      }
      
      override public function shallowCopy(startPos:int = 0, endPos:int = -1) : FlowElement
      {
         var retFlow:TextFlow = super.shallowCopy(startPos,endPos) as TextFlow;
         retFlow._configuration = this._configuration;
         retFlow._generation = _nextGeneration++;
         if(this.formatResolver)
         {
            retFlow.formatResolver = this.formatResolver.getResolverForNewFlow(this,retFlow);
         }
         if(retFlow.flowComposer && this.flowComposer)
         {
            retFlow.flowComposer.swfContext = this.flowComposer.swfContext;
         }
         return retFlow;
      }
      
      tlf_internal function get interactiveObjectCount() : int
      {
         return this._interactiveObjectCount;
      }
      
      tlf_internal function incInteractiveObjectCount() : void
      {
         ++this._interactiveObjectCount;
      }
      
      tlf_internal function decInteractiveObjectCount() : void
      {
         --this._interactiveObjectCount;
      }
      
      tlf_internal function get graphicObjectCount() : int
      {
         return this._graphicObjectCount;
      }
      
      tlf_internal function incGraphicObjectCount() : void
      {
         ++this._graphicObjectCount;
      }
      
      tlf_internal function decGraphicObjectCount() : void
      {
         --this._graphicObjectCount;
      }
      
      public function get configuration() : IConfiguration
      {
         return this._configuration;
      }
      
      public function get interactionManager() : ISelectionManager
      {
         return this._interactionManager;
      }
      
      public function set interactionManager(newInteractionManager:ISelectionManager) : void
      {
         if(this._interactionManager != newInteractionManager)
         {
            if(this._interactionManager)
            {
               this._interactionManager.textFlow = null;
            }
            this._interactionManager = newInteractionManager;
            if(this._interactionManager)
            {
               this._interactionManager.textFlow = this;
               this.normalize();
            }
            if(this.flowComposer)
            {
               this.flowComposer.interactionManagerChanged(newInteractionManager);
            }
         }
      }
      
      override public function get flowComposer() : IFlowComposer
      {
         return this._flowComposer;
      }
      
      public function set flowComposer(composer:IFlowComposer) : void
      {
         this.changeFlowComposer(composer,true);
      }
      
      tlf_internal function changeFlowComposer(newComposer:IFlowComposer, okToUnloadGraphics:Boolean) : void
      {
         var oldSWFContext:ISWFContext = null;
         var newSWFContext:ISWFContext = null;
         var containerIter:int = 0;
         var origComposer:IFlowComposer = this._flowComposer;
         if(this._flowComposer != newComposer)
         {
            oldSWFContext = FlowComposerBase.computeBaseSWFContext(!!this._flowComposer ? this._flowComposer.swfContext : null);
            newSWFContext = FlowComposerBase.computeBaseSWFContext(!!newComposer ? newComposer.swfContext : null);
            if(this._flowComposer)
            {
               containerIter = 0;
               while(containerIter < this._flowComposer.numControllers)
               {
                  this._flowComposer.getControllerAt(containerIter++).clearSelectionShapes();
               }
               this._flowComposer.setRootElement(null);
            }
            this._flowComposer = newComposer;
            if(this._flowComposer)
            {
               this._flowComposer.setRootElement(this);
            }
            if(textLength)
            {
               this.damage(getAbsoluteStart(),textLength,TextLineValidity.INVALID,false);
            }
            if(oldSWFContext != newSWFContext)
            {
               this.invalidateAllFormats();
            }
            if(this._flowComposer == null)
            {
               if(okToUnloadGraphics)
               {
                  this.unloadGraphics();
               }
            }
            else if(origComposer == null)
            {
               this.prepareGraphicsForLoad();
            }
         }
      }
      
      tlf_internal function unloadGraphics() : void
      {
         if(this._graphicObjectCount)
         {
            applyFunctionToElements(function(elem:FlowElement):Boolean
            {
               if(elem is InlineGraphicElement)
               {
                  (elem as InlineGraphicElement).stop(true);
               }
               return false;
            });
         }
      }
      
      tlf_internal function prepareGraphicsForLoad() : void
      {
         if(this._graphicObjectCount)
         {
            appendElementsForDelayedUpdate(this,null);
         }
      }
      
      public function getElementByID(idName:String) : FlowElement
      {
         var rslt:FlowElement = null;
         applyFunctionToElements(function(elem:FlowElement):Boolean
         {
            if(elem.id == idName)
            {
               rslt = elem;
               return true;
            }
            return false;
         });
         return rslt;
      }
      
      public function getElementsByStyleName(styleNameValue:String) : Array
      {
         var a:Array = null;
         a = new Array();
         applyFunctionToElements(function(elem:FlowElement):Boolean
         {
            if(elem.styleName == styleNameValue)
            {
               a.push(elem);
            }
            return false;
         });
         return a;
      }
      
      public function getElementsByTypeName(typeNameValue:String) : Array
      {
         var a:Array = null;
         a = new Array();
         applyFunctionToElements(function(elem:FlowElement):Boolean
         {
            if(elem.typeName == typeNameValue)
            {
               a.push(elem);
            }
            return false;
         });
         return a;
      }
      
      override protected function get abstract() : Boolean
      {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String
      {
         return "TextFlow";
      }
      
      override tlf_internal function updateLengths(startIdx:int, len:int, updateLines:Boolean) : void
      {
         var newNormalizeStart:int = 0;
         if(this.normalizeStart != -1)
         {
            newNormalizeStart = startIdx < this.normalizeStart ? int(startIdx) : int(this.normalizeStart);
            if(newNormalizeStart < this.normalizeStart)
            {
               this.normalizeLen += this.normalizeStart - newNormalizeStart;
            }
            this.normalizeLen += len;
            this.normalizeStart = newNormalizeStart;
         }
         else
         {
            this.normalizeStart = startIdx;
            this.normalizeLen = len;
         }
         if(this.normalizeLen < 0)
         {
            this.normalizeLen = 0;
         }
         if(updateLines && this._flowComposer)
         {
            this._flowComposer.updateLengths(startIdx,len);
            super.updateLengths(startIdx,len,false);
         }
         else
         {
            super.updateLengths(startIdx,len,updateLines);
         }
      }
      
      override public function set mxmlChildren(array:Array) : void
      {
         super.mxmlChildren = array;
         this.normalize();
         applyWhiteSpaceCollapse(null);
      }
      
      tlf_internal function applyUpdateElements(okToUnloadGraphics:Boolean) : Boolean
      {
         var hasController:Boolean = false;
         var child:* = null;
         if(this._elemsToUpdate)
         {
            hasController = this.flowComposer && this.flowComposer.numControllers != 0;
            for(child in this._elemsToUpdate)
            {
               (child as FlowElement).applyDelayedElementUpdate(this,okToUnloadGraphics,hasController);
            }
            if(hasController)
            {
               this._elemsToUpdate = null;
               return true;
            }
         }
         return false;
      }
      
      override tlf_internal function preCompose() : void
      {
         do
         {
            this.normalize();
         }
         while(this.applyUpdateElements(true));
         
      }
      
      tlf_internal function damage(damageStart:int, damageLen:int, damageType:String, needNormalize:Boolean = true) : void
      {
         var newNormalizeLen:uint = 0;
         if(needNormalize)
         {
            if(this.normalizeStart == -1)
            {
               this.normalizeStart = damageStart;
               this.normalizeLen = damageLen;
            }
            else if(damageStart < this.normalizeStart)
            {
               newNormalizeLen = this.normalizeLen;
               newNormalizeLen = this.normalizeStart + this.normalizeLen - damageStart;
               if(damageLen > newNormalizeLen)
               {
                  newNormalizeLen = damageLen;
               }
               this.normalizeStart = damageStart;
               this.normalizeLen = newNormalizeLen;
            }
            else if(this.normalizeStart + this.normalizeLen > damageStart)
            {
               if(damageStart + damageLen > this.normalizeStart + this.normalizeLen)
               {
                  this.normalizeLen = damageStart + damageLen - this.normalizeStart;
               }
            }
            else
            {
               this.normalizeLen = damageStart + damageLen - this.normalizeStart;
            }
            if(this.normalizeStart + this.normalizeLen > textLength)
            {
               this.normalizeLen = textLength - this.normalizeStart;
            }
         }
         if(this._flowComposer)
         {
            this._flowComposer.damage(damageStart,damageLen,damageType);
         }
         if(this.hasEventListener(DamageEvent.DAMAGE))
         {
            this.dispatchEvent(new DamageEvent(DamageEvent.DAMAGE,false,false,this,damageStart,damageLen));
         }
      }
      
      tlf_internal function findAbsoluteParagraph(pos:int) : ParagraphElement
      {
         var elem:FlowElement = findLeaf(pos);
         return !!elem ? elem.getParagraph() : null;
      }
      
      tlf_internal function findAbsoluteFlowGroupElement(pos:int) : FlowGroupElement
      {
         var elem:FlowElement = findLeaf(pos);
         return elem.parent;
      }
      
      public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         if(!this._eventDispatcher)
         {
            this._eventDispatcher = new EventDispatcher(this);
         }
         this._eventDispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public function dispatchEvent(event:Event) : Boolean
      {
         if(!this._eventDispatcher)
         {
            return true;
         }
         return this._eventDispatcher.dispatchEvent(event);
      }
      
      public function hasEventListener(type:String) : Boolean
      {
         if(!this._eventDispatcher)
         {
            return false;
         }
         return this._eventDispatcher.hasEventListener(type);
      }
      
      public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         if(!this._eventDispatcher)
         {
            return;
         }
         this._eventDispatcher.removeEventListener(type,listener,useCapture);
      }
      
      public function willTrigger(type:String) : Boolean
      {
         if(!this._eventDispatcher)
         {
            return false;
         }
         return this._eventDispatcher.willTrigger(type);
      }
      
      tlf_internal function appendOneElementForUpdate(elem:FlowElement) : void
      {
         if(this._elemsToUpdate == null)
         {
            this._elemsToUpdate = new Dictionary();
         }
         this._elemsToUpdate[elem] = null;
      }
      
      tlf_internal function mustUseComposer() : Boolean
      {
         var elem:* = null;
         if(this._interactiveObjectCount != 0)
         {
            return true;
         }
         if(this._elemsToUpdate == null || this._elemsToUpdate.length == 0)
         {
            return false;
         }
         this.normalize();
         var rslt:Boolean = false;
         for(elem in this._elemsToUpdate)
         {
            if((elem as FlowElement).updateForMustUseComposer(this))
            {
               rslt = true;
            }
         }
         return rslt;
      }
      
      tlf_internal function processModelChanged(changeType:String, elem:Object, changeStart:int, changeLen:int, needNormalize:Boolean, bumpGeneration:Boolean) : void
      {
         if(elem is FlowElement)
         {
            (elem as FlowElement).appendElementsForDelayedUpdate(this,changeType);
         }
         if(bumpGeneration)
         {
            this._generation = _nextGeneration++;
         }
         if(changeLen > 0 || changeType == ModelChange.ELEMENT_ADDED)
         {
            this.damage(changeStart,changeLen,TextLineValidity.INVALID,needNormalize);
         }
         if(this.formatResolver)
         {
            switch(changeType)
            {
               case ModelChange.ELEMENT_REMOVAL:
               case ModelChange.ELEMENT_ADDED:
               case ModelChange.STYLE_SELECTOR_CHANGED:
                  this.formatResolver.invalidate(elem);
                  elem.formatChanged(false);
            }
         }
      }
      
      public function get generation() : uint
      {
         return this._generation;
      }
      
      tlf_internal function setGeneration(num:uint) : void
      {
         this._generation = num;
      }
      
      tlf_internal function processAutoSizeImageLoaded(elem:InlineGraphicElement) : void
      {
         if(this.flowComposer)
         {
            elem.appendElementsForDelayedUpdate(this,null);
         }
      }
      
      tlf_internal function normalize() : void
      {
         var normalizeEnd:int = 0;
         if(this.normalizeStart != -1)
         {
            normalizeEnd = this.normalizeStart + (this.normalizeLen == 0 ? 1 : this.normalizeLen);
            normalizeRange(this.normalizeStart == 0 ? uint(this.normalizeStart) : uint(this.normalizeStart - 1),normalizeEnd);
            this.normalizeStart = -1;
            this.normalizeLen = 0;
         }
      }
      
      public function get hostFormat() : ITextLayoutFormat
      {
         return !!this._hostFormatHelper ? this._hostFormatHelper.format : null;
      }
      
      public function set hostFormat(value:ITextLayoutFormat) : void
      {
         if(value == null)
         {
            this._hostFormatHelper = null;
         }
         else
         {
            if(this._hostFormatHelper == null)
            {
               this._hostFormatHelper = new HostFormatHelper();
            }
            this._hostFormatHelper.format = value;
         }
         formatChanged();
      }
      
      override tlf_internal function doComputeTextLayoutFormat() : TextLayoutFormat
      {
         var parentPrototype:TextLayoutFormat = !!this._hostFormatHelper ? this._hostFormatHelper.getComputedPrototypeFormat() : null;
         return FlowElement.createTextLayoutFormatPrototype(tlf_internal::formatForCascade,parentPrototype);
      }
      
      tlf_internal function getTextLayoutFormatStyle(elem:Object) : TextLayoutFormat
      {
         if(this._formatResolver == null)
         {
            return null;
         }
         var rslt:ITextLayoutFormat = this._formatResolver.resolveFormat(elem);
         if(rslt == null)
         {
            return null;
         }
         var tlfvh:TextLayoutFormat = rslt as TextLayoutFormat;
         return !!tlfvh ? tlfvh : new TextLayoutFormat(rslt);
      }
      
      tlf_internal function getExplicitStyle(elem:Object) : TextLayoutFormat
      {
         var rslt:ITextLayoutFormat = null;
         var tlfvh:TextLayoutFormat = null;
         if(this._formatResolver == null)
         {
            return null;
         }
         if(this._formatResolver is IExplicitFormatResolver)
         {
            rslt = (this._formatResolver as IExplicitFormatResolver).resolveExplicitFormat(elem);
            if(rslt == null)
            {
               return null;
            }
            tlfvh = rslt as TextLayoutFormat;
            return !!tlfvh ? tlfvh : new TextLayoutFormat(rslt);
         }
         return null;
      }
      
      tlf_internal function get backgroundManager() : BackgroundManager
      {
         return this._backgroundManager;
      }
      
      tlf_internal function clearBackgroundManager() : void
      {
         if(this._backgroundManager)
         {
            if(!BackgroundManager.BACKGROUND_MANAGER_CACHE)
            {
               BackgroundManager.BACKGROUND_MANAGER_CACHE = new Dictionary();
            }
            BackgroundManager.BACKGROUND_MANAGER_CACHE[this] = this._backgroundManager.getShapeRectArray().concat();
         }
         this._backgroundManager = null;
      }
      
      tlf_internal function getBackgroundManager() : BackgroundManager
      {
         if(!this._backgroundManager && this.flowComposer is StandardFlowComposer)
         {
            this._backgroundManager = (this.flowComposer as StandardFlowComposer).createBackgroundManager();
         }
         return this._backgroundManager;
      }
      
      public function get formatResolver() : IFormatResolver
      {
         return this._formatResolver;
      }
      
      public function set formatResolver(val:IFormatResolver) : void
      {
         if(this._formatResolver != val)
         {
            if(this._formatResolver)
            {
               this._formatResolver.invalidateAll(this);
            }
            this._formatResolver = val;
            if(this._formatResolver)
            {
               this._formatResolver.invalidateAll(this);
            }
            formatChanged(true);
         }
      }
      
      public function invalidateAllFormats() : void
      {
         if(this._formatResolver)
         {
            this._formatResolver.invalidateAll(this);
         }
         formatChanged(true);
      }
      
      public function get parentElement() : FlowGroupElement
      {
         return this._parentElement;
      }
      
      public function set parentElement(value:FlowGroupElement) : void
      {
         this._parentElement = value;
      }
      
      public function nestedInTable() : Boolean
      {
         return this.parentElement && this.parentElement is TableCellElement;
      }
   }
}

import flashx.textLayout.elements.FlowElement;
import flashx.textLayout.formats.ITextLayoutFormat;
import flashx.textLayout.formats.TextLayoutFormat;
import flashx.textLayout.tlf_internal;

use namespace tlf_internal;

class HostFormatHelper
{
    
   
   private var _format:ITextLayoutFormat;
   
   private var _computedPrototypeFormat:TextLayoutFormat;
   
   function HostFormatHelper()
   {
      super();
   }
   
   public function get format() : ITextLayoutFormat
   {
      return this._format;
   }
   
   public function set format(value:ITextLayoutFormat) : void
   {
      this._format = value;
      this._computedPrototypeFormat = null;
   }
   
   public function getComputedPrototypeFormat() : TextLayoutFormat
   {
      var useFormat:ITextLayoutFormat = null;
      if(this._computedPrototypeFormat == null)
      {
         if(this._format is TextLayoutFormat || this._format is TextLayoutFormat)
         {
            useFormat = this._format;
         }
         else
         {
            useFormat = new TextLayoutFormat(this._format);
         }
         this._computedPrototypeFormat = FlowElement.createTextLayoutFormatPrototype(useFormat,null);
      }
      return this._computedPrototypeFormat;
   }
}
