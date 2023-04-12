package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.BeriliaConstants;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.berilia.components.MapViewer;
   import com.ankamagames.berilia.enums.LocationTypeEnum;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.RadioGroup;
   import com.ankamagames.berilia.types.data.UISnapshot;
   import com.ankamagames.berilia.types.data.UiData;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.pools.PoolablePoint;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.errors.Result;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import flash.events.NativeWindowBoundsEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class UiRootContainer extends GraphicContainer implements UIComponent
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UiRootContainer));
       
      
      private var _magneticElements:Dictionary;
      
      private var _aNamedElements:Array;
      
      private var _bUsedCustomSize:Boolean = false;
      
      private var _root:Sprite;
      
      private var _aGraphicLocationStack:Array;
      
      private var _aSizeStack:Array;
      
      private var _aGraphicElementIndex:Array;
      
      private var _linkedUi:Array;
      
      private var _aPostFinalizeElement:Array;
      
      private var _aFinalizeElements:Array;
      
      private var pModificator_offset:Point;
      
      private var _rendering:Boolean = false;
      
      private var _ready:Boolean;
      
      private var _waitingFctCall:Array;
      
      private var _properties;
      
      var _lock:Boolean = true;
      
      private var _renderAsk:Boolean = false;
      
      private var _isFinalized:Boolean = false;
      
      private var _tempVisible:Boolean = true;
      
      private var _uiData:UiData;
      
      private var _scriptTime:Number;
      
      var _dragControllers:Dictionary;
      
      private var _resizeListening:Boolean = false;
      
      private var _lastVisibleStageX:Number = 0;
      
      private var _stageAddedWidth:Number = 0;
      
      public var windowOwner:ExternalUi;
      
      public var uiClass;
      
      public var uiModule:UiModule;
      
      public var strata:int;
      
      public var depth:int;
      
      public var scalable:Boolean = true;
      
      public var modal:Boolean = false;
      
      private var _modalContainer:GraphicContainer;
      
      private var _fullscreen:Boolean = false;
      
      public var giveFocus:Boolean = true;
      
      public var modalIndex:uint = 0;
      
      public var radioGroup:Array;
      
      public var cached:Boolean = false;
      
      public var hideAfterLoading:Boolean = false;
      
      public var transmitFocus:Boolean = true;
      
      public var setOnTopOnClick:Boolean = true;
      
      public var setOnTopBeforeMe:Array;
      
      public var setOnTopAfterMe:Array;
      
      public var constants:Array;
      
      public var tempHolder:DisplayObjectContainer;
      
      public var restoreSnapshotAfterLoading:Boolean;
      
      public var parentUiRoot:UiRootContainer = null;
      
      public var childUiRoot:UiRootContainer = null;
      
      public var subHintContainer:GraphicContainer;
      
      public function UiRootContainer(stage:Stage, uiData:UiData, root:Sprite = null)
      {
         this._dragControllers = new Dictionary();
         this.radioGroup = new Array();
         this.setOnTopBeforeMe = [];
         this.setOnTopAfterMe = [];
         super();
         this._root = root;
         this._magneticElements = new Dictionary(true);
         this._aNamedElements = new Array();
         this._aSizeStack = new Array();
         this._linkedUi = new Array();
         this._uiData = uiData;
         this._aGraphicLocationStack = new Array();
         this._aGraphicElementIndex = new Array();
         this._aPostFinalizeElement = new Array();
         this._aFinalizeElements = new Array();
         this._waitingFctCall = new Array();
         this.radioGroup = new Array();
         super.visible = false;
         this.pModificator_offset = PoolsManager.getInstance().getPointPool().checkOut() as PoolablePoint;
         this._lastVisibleStageX = StageShareManager.stageVisibleBounds.x;
      }
      
      public function get fullscreen() : Boolean
      {
         return this._fullscreen;
      }
      
      public function set fullscreen(value:Boolean) : void
      {
         if(this._fullscreen == value)
         {
            return;
         }
         this._fullscreen = value;
         this.listenResize(this._fullscreen);
         this.onResize();
      }
      
      public function get properties() : *
      {
         return this._properties;
      }
      
      public function set properties(o:*) : void
      {
         if(!this._properties)
         {
            this._properties = o;
         }
      }
      
      override public function get customUnicName() : String
      {
         return name;
      }
      
      override public function set visible(value:Boolean) : void
      {
         this._tempVisible = value;
         if(this._isFinalized)
         {
            super.visible = value;
         }
      }
      
      override public function get width() : Number
      {
         if(this._bUsedCustomSize)
         {
            return __width;
         }
         return super.width;
      }
      
      override public function set width(nW:Number) : void
      {
         this._bUsedCustomSize = true;
         __width = nW;
      }
      
      override public function get height() : Number
      {
         if(this._bUsedCustomSize)
         {
            return __height;
         }
         return super.height;
      }
      
      override public function set height(nH:Number) : void
      {
         this._bUsedCustomSize = true;
         __height = nH;
      }
      
      public function set useCustomSize(b:Boolean) : void
      {
         this._bUsedCustomSize = b;
      }
      
      public function get useCustomSize() : Boolean
      {
         return this._bUsedCustomSize;
      }
      
      public function set disableRender(b:Boolean) : void
      {
         this._rendering = b;
      }
      
      public function get disableRender() : Boolean
      {
         return this._rendering;
      }
      
      public function get ready() : Boolean
      {
         return this._ready;
      }
      
      public function set modalContainer(val:GraphicContainer) : void
      {
         this._modalContainer = val;
      }
      
      public function set showModalContainer(val:Boolean) : void
      {
         if(this.modal && this._modalContainer != null)
         {
            this._modalContainer.visible = val;
         }
      }
      
      public function get uiData() : UiData
      {
         return this._uiData;
      }
      
      public function get scriptTime() : Number
      {
         return this._scriptTime;
      }
      
      public function get childIndex() : int
      {
         return parent.getChildIndex(this);
      }
      
      public function set childIndex(pChildIndex:int) : void
      {
         parent.setChildIndex(this,pChildIndex);
      }
      
      public function get magneticElements() : Array
      {
         var elem:* = undefined;
         var elements:Array = new Array();
         for(elem in this._magneticElements)
         {
            elements.push(elem);
         }
         return elements;
      }
      
      public function addElement(sName:String, oElement:Object) : void
      {
         this._aNamedElements[sName] = oElement;
      }
      
      public function removeElement(sName:String) : void
      {
         delete this._aNamedElements[sName];
      }
      
      public function getElement(sName:String) : GraphicContainer
      {
         if(!this._aNamedElements[sName] && sName == name)
         {
            return this;
         }
         return this._aNamedElements[sName];
      }
      
      public function getElements() : Array
      {
         return this._aNamedElements;
      }
      
      public function registerHintContainer(oElement:Object) : void
      {
         this.subHintContainer = oElement as GraphicContainer;
      }
      
      public function getHintContainer() : GraphicContainer
      {
         return this.subHintContainer;
      }
      
      public function getConstant(name:String) : *
      {
         return this.constants[name];
      }
      
      public function iAmFinalized(target:FinalizableUIComponent) : void
      {
         var elem:FinalizableUIComponent = null;
         var t:int = 0;
         var result:Result = null;
         var cb:Callback = null;
         if(!this._lock || this._rendering)
         {
            return;
         }
         for each(elem in this._aFinalizeElements)
         {
            if(!elem.finalized)
            {
               return;
            }
         }
         this._lock = false;
         this.render();
         this._ready = true;
         if(this.tempHolder && this.tempHolder.parent)
         {
            if(!this.hideAfterLoading)
            {
               this.tempHolder.parent.addChildAt(this,this.tempHolder.parent.getChildIndex(this.tempHolder));
            }
            this.tempHolder.parent.removeChild(this.tempHolder);
         }
         this.tempHolder = null;
         this._isFinalized = true;
         var destroyNow:Boolean = false;
         if(this.uiClass && this.uiClass.hasOwnProperty("main"))
         {
            this._rendering = true;
            FpsManager.getInstance().startTracking("hook",7108545);
            t = getTimer();
            result = ErrorManager.tryFunction(this.uiClass["main"],[this._properties],"Une erreur est survenue lors de l\'exécution de la fonction main de l\'interface " + name + " (" + getQualifiedClassName(this.uiClass) + ")");
            this._scriptTime = getTimer() - t;
            FpsManager.getInstance().stopTracking("hook");
            this._rendering = false;
            if(!result.success)
            {
               destroyNow = true;
            }
            else if(this._renderAsk)
            {
               this.render();
            }
            this._ready = true;
            for each(cb in this._waitingFctCall)
            {
               cb.exec();
            }
            this._waitingFctCall.length = 0;
         }
         dispatchEvent(new UiRenderEvent(UiRenderEvent.UIRenderComplete,false,false,this));
         if(this._properties && this._properties.hasOwnProperty("visible"))
         {
            this.visible = this._properties.visible;
         }
         else
         {
            this.visible = this._tempVisible;
         }
         if(destroyNow)
         {
            _log.error("UI " + name + " has encountered an exception and must be unloaded.");
            _log.warn(result.stackTrace);
            Berilia.getInstance().unloadUi(name);
         }
         else if(this.restoreSnapshotAfterLoading)
         {
            this.restoreSnapshot();
         }
      }
      
      public function render() : void
      {
         var i:int = 0;
         var ge:GraphicElement = null;
         var dragControler:* = undefined;
         var pfc:FinalizableUIComponent = null;
         var stageVisibleBounds:Rectangle = null;
         var dc:DragControler = null;
         this._renderAsk = true;
         var wasReady:Boolean = this._ready;
         this._ready = false;
         if(this._rendering || this._lock)
         {
            return;
         }
         if(this.fullscreen)
         {
            stageVisibleBounds = StageShareManager.stageVisibleBounds;
            x = stageVisibleBounds.x;
            y = stageVisibleBounds.y;
         }
         this._rendering = true;
         this.zSort(this._aSizeStack);
         this.processSize();
         for(i = 0; i < this._aGraphicLocationStack.length; i++)
         {
            if(this._aGraphicLocationStack[i] != null)
            {
               this._aGraphicLocationStack[i].render = false;
            }
         }
         for(i = 0; i < this._aGraphicLocationStack.length; i++)
         {
            if(this._aGraphicLocationStack[i] != null)
            {
               if(!this._aGraphicLocationStack[i].render)
               {
                  ge = this._aGraphicLocationStack[i];
                  if(!ge.sprite.dynamicPosition)
                  {
                     this.processLocation(this._aGraphicLocationStack[i],true);
                  }
               }
            }
         }
         for(dragControler in this._dragControllers)
         {
            dc = DragControler(dragControler);
            if(dc.restrictionFunction != null)
            {
               dc.restrictionFunction.call();
            }
            else
            {
               dc.restrictPosition();
            }
         }
         this.updateLinkedUi();
         for each(pfc in this._aPostFinalizeElement)
         {
            pfc.finalize();
         }
         this._rendering = false;
         this._ready = wasReady;
         if(this.uiClass && Object(this.uiClass).hasOwnProperty("renderUpdate"))
         {
            this.uiClass.renderUpdate();
         }
      }
      
      public function registerMagneticElement(gc:GraphicContainer) : void
      {
         this._magneticElements[gc] = true;
      }
      
      public function removeMagneticElement(gc:GraphicContainer) : void
      {
         delete this._magneticElements[gc];
      }
      
      public function registerId(sName:String, geReference:GraphicElement) : void
      {
         if(this._aGraphicElementIndex[sName] != null && this._aGraphicElementIndex[sName] != undefined)
         {
            throw new BeriliaError(sName + " name is already used");
         }
         this._aGraphicElementIndex[sName] = geReference;
         this.addElement(sName,geReference.sprite);
      }
      
      public function deleteId(sName:String) : void
      {
         if(this._aGraphicElementIndex[sName] == null)
         {
            return;
         }
         delete this._aGraphicElementIndex[sName];
         this.removeElement(sName);
      }
      
      public function getElementById(sName:String) : GraphicElement
      {
         return this._aGraphicElementIndex[sName];
      }
      
      public function removeFromRenderList(sName:String) : void
      {
         var i:uint = 0;
         var ge:GraphicElement = null;
         for(i = 0; i < this._aGraphicLocationStack.length; i++)
         {
            ge = this._aGraphicLocationStack[i];
            if(ge != null && ge.sprite.name == sName)
            {
               delete this._aGraphicLocationStack[i];
               break;
            }
         }
         for(i = 0; i < this._aSizeStack.length; i++)
         {
            if(this._aSizeStack[i] != null && this._aSizeStack[i].name == sName)
            {
               delete this._aSizeStack[i];
               break;
            }
         }
      }
      
      public function addDynamicSizeElement(geReference:GraphicElement) : void
      {
         if(!geReference)
         {
            return;
         }
         for(var i:uint = 0; i < this._aSizeStack.length; i++)
         {
            if(this._aSizeStack[i] == geReference)
            {
               return;
            }
         }
         this._aSizeStack.push(geReference);
      }
      
      public function addDynamicElement(ge:GraphicElement) : void
      {
         for(var i:uint = 0; i < this._aGraphicLocationStack.length; i++)
         {
            if(this._aGraphicLocationStack[i] != null && this._aGraphicLocationStack[i].sprite.name == ge.sprite.name)
            {
               return;
            }
         }
         this._aGraphicLocationStack.push(ge);
      }
      
      public function addPostFinalizeComponent(fc:FinalizableUIComponent) : void
      {
         this._aPostFinalizeElement.push(fc);
      }
      
      public function addFinalizeElement(fc:FinalizableUIComponent) : void
      {
         if(!this._aFinalizeElements)
         {
            _log.error("_aFinalizeElements NULL, on ne peut pas push " + (fc as GraphicContainer).name + "  pour " + name);
            return;
         }
         this._aFinalizeElements.push(fc);
      }
      
      public function resetSizeAndPosition() : void
      {
         if(this.fullscreen)
         {
            this.listenResize(true);
         }
         else
         {
            this.listenResize(false);
         }
      }
      
      public function addRadioGroup(groupName:String) : RadioGroup
      {
         if(!this.radioGroup)
         {
            this.radioGroup = new Array();
         }
         if(!this.radioGroup[groupName])
         {
            this.radioGroup[groupName] = new RadioGroup(groupName);
         }
         return this.radioGroup[groupName];
      }
      
      public function getRadioGroup(name:String) : RadioGroup
      {
         if(!this.radioGroup)
         {
            return null;
         }
         return this.radioGroup[name];
      }
      
      public function addLinkedUi(uiName:String) : void
      {
         if(uiName != name)
         {
            this._linkedUi[uiName] = uiName;
         }
         else
         {
            _log.error("Cannot add link to yourself in " + name);
         }
      }
      
      public function removeLinkedUi(uiName:String) : void
      {
         delete this._linkedUi[uiName];
      }
      
      public function updateLinkedUi() : void
      {
         var ui:String = null;
         for each(ui in this._linkedUi)
         {
            if(Berilia.getInstance().getUi(this._linkedUi[ui]))
            {
               Berilia.getInstance().getUi(this._linkedUi[ui]).render();
            }
         }
      }
      
      public function call(fct:Function, args:Array, accesKey:Object) : void
      {
         if(accesKey !== SecureCenter.ACCESS_KEY)
         {
            throw new IllegalOperationError();
         }
         if(this._ready)
         {
            CallWithParameters.call(fct,args);
         }
         else
         {
            this._waitingFctCall.push(CallWithParameters.callConstructor(Callback,[fct].concat(args)));
         }
      }
      
      public function destroyUi() : void
      {
         var r:RadioGroup = null;
         var num:int = 0;
         var i:int = 0;
         var component:GraphicContainer = null;
         for each(r in this.radioGroup)
         {
            RadioGroup(r).destroy();
         }
         this.listenResize(false);
         this.radioGroup = null;
         this._root = null;
         this._magneticElements = new Dictionary(true);
         this._aNamedElements = [];
         this._aSizeStack = [];
         this._linkedUi = [];
         this._aGraphicLocationStack = [];
         this._aGraphicElementIndex = [];
         this._aPostFinalizeElement = [];
         if(this._aFinalizeElements)
         {
            num = this._aFinalizeElements.length;
            for(i = 0; i < num; i++)
            {
               component = this._aFinalizeElements[i];
               component.remove();
            }
         }
         if(this.windowOwner)
         {
            this.windowOwner.destroy();
         }
         this._aFinalizeElements = null;
         PoolsManager.getInstance().getPointPool().checkIn(this.pModificator_offset as PoolablePoint);
      }
      
      public function makeSnapshot() : void
      {
         var snapshot:UISnapshot = null;
         var tabName:String = null;
         var rg:RadioGroup = this.getRadioGroup("tabHGroup");
         if(rg && rg.selectedItem)
         {
            snapshot = new UISnapshot();
            tabName = (rg.selectedItem as GraphicContainer).customUnicName;
            if(tabName.indexOf("::") != -1)
            {
               tabName = tabName.split("::")[1];
            }
            snapshot.lastHorizontalTabName = tabName;
         }
         if(snapshot)
         {
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_SNAPSHOT,getQualifiedClassName(this.uiClass) + "_snapshot",snapshot);
         }
      }
      
      public function setOnTop() : void
      {
         parent.addChild(this);
      }
      
      private function restoreSnapshot() : void
      {
         var lastTab:ButtonContainer = null;
         var snapshot:UISnapshot = StoreDataManager.getInstance().getData(BeriliaConstants.DATASTORE_UI_SNAPSHOT,getQualifiedClassName(this.uiClass) + "_snapshot");
         if(snapshot)
         {
            if(snapshot.lastHorizontalTabName)
            {
               lastTab = this.getElement(snapshot.lastHorizontalTabName) as ButtonContainer;
               if(lastTab && lastTab.visible && !lastTab.selected && !lastTab.softDisabled && !lastTab.disabled)
               {
                  lastTab.selected = true;
                  this.uiClass.onRelease(this.uiClass[snapshot.lastHorizontalTabName]);
               }
               else if(this.uiClass && "hintsApi" in this.uiClass && "currentTabName" in this.uiClass)
               {
                  this.uiClass.hintsApi.uiTutoTabLaunch();
               }
            }
         }
         else if(this.uiClass && "hintsApi" in this.uiClass && "currentTabName" in this.uiClass)
         {
            this.uiClass.hintsApi.uiTutoTabLaunch();
         }
      }
      
      private function isRegisteredId(sName:String) : Boolean
      {
         return this._aGraphicElementIndex[sName] != null;
      }
      
      private function processSize() : void
      {
         var ge:GraphicElement = null;
         var newWidth:Number = NaN;
         var newHeight:Number = NaN;
         var p:Point = null;
         for(var i:uint = 0; i < this._aSizeStack.length; i++)
         {
            ge = this._aSizeStack[i];
            if(ge != null)
            {
               newWidth = NaN;
               newHeight = NaN;
               p = ge.sprite.getSavedDimension();
               if(p)
               {
                  this.listenResize(true);
                  newWidth = p.x;
                  newHeight = p.y;
               }
               else
               {
                  if(!isNaN(ge.size.x) && ge.size.xUnit == GraphicSize.SIZE_PRC)
                  {
                     if(ge.sprite && ge.sprite.parent && ge.sprite.parent.parent is UiRootContainer)
                     {
                        if(this.fullscreen)
                        {
                           newWidth = int(ge.size.x * StageShareManager.stageVisibleBounds.width);
                        }
                        else
                        {
                           newWidth = int(ge.size.x * StageShareManager.startWidth);
                        }
                     }
                     else if(GraphicContainer(ge.sprite).getParent())
                     {
                        newWidth = int(ge.size.x * GraphicContainer(ge.sprite).getParent().width);
                     }
                  }
                  if(!isNaN(ge.size.y) && ge.size.yUnit == GraphicSize.SIZE_PRC)
                  {
                     if(ge.sprite && ge.sprite.parent && ge.sprite.parent.parent is UiRootContainer)
                     {
                        if(this.fullscreen)
                        {
                           newHeight = int(ge.size.y * StageShareManager.stageVisibleBounds.height);
                        }
                        else
                        {
                           newHeight = int(ge.size.y * StageShareManager.startHeight);
                        }
                     }
                     else if(GraphicContainer(ge.sprite).getParent())
                     {
                        newHeight = int(ge.size.y * GraphicContainer(ge.sprite).getParent().height);
                     }
                  }
               }
               if(isNaN(newWidth) || isNaN(newHeight))
               {
                  if(!isNaN(newWidth))
                  {
                     ge.sprite.width = newWidth;
                  }
                  if(!isNaN(newHeight))
                  {
                     ge.sprite.height = newHeight;
                  }
               }
               else
               {
                  ge.sprite.finalized = false;
                  ge.sprite.width = newWidth;
                  ge.sprite.finalized = true;
                  ge.sprite.height = newHeight;
               }
            }
         }
      }
      
      public function processLocation(geElem:GraphicElement, fromRender:Boolean = false) : void
      {
         var ptTopLeftCorner:Point = null;
         var ptBottomRightCorner:Point = null;
         var width:Number = NaN;
         var height:Number = NaN;
         if(!fromRender)
         {
            this._stageAddedWidth = 0;
         }
         var ptNewPos:Point = PoolsManager.getInstance().getPointPool().checkOut() as PoolablePoint;
         var p:Point = geElem.sprite.getSavedPosition();
         if(p)
         {
            if(!geElem.sprite.dragController || geElem.sprite._dragController.savePosition)
            {
               this.listenResize(true);
               if(this.fullscreen)
               {
                  if(p.x > StageShareManager.startWidth / 2)
                  {
                     ptNewPos.x = p.x - StageShareManager.stageVisibleBounds.x + this._stageAddedWidth;
                  }
                  else
                  {
                     ptNewPos.x = p.x - StageShareManager.stageVisibleBounds.x - this._stageAddedWidth;
                  }
                  ptNewPos.y = p.y;
                  if(geElem.sprite && ptNewPos)
                  {
                     geElem.sprite.xNoCache = ptNewPos.x;
                     geElem.sprite.yNoCache = ptNewPos.y;
                  }
                  else
                  {
                     geElem.sprite.xNoCache = p.x;
                     geElem.sprite.yNoCache = p.y;
                  }
               }
               else
               {
                  geElem.sprite.xNoCache = p.x;
                  geElem.sprite.yNoCache = p.y;
               }
               return;
            }
         }
         var startValueX:Number = geElem.sprite.x;
         var startValueY:Number = geElem.sprite.y;
         geElem.sprite.xNoCache = 0;
         geElem.sprite.yNoCache = 0;
         if(geElem.locations.length > 1)
         {
            ptTopLeftCorner = (PoolsManager.getInstance().getPointPool().checkOut() as PoolablePoint).renew(geElem.sprite.x,geElem.sprite.y);
            ptTopLeftCorner = this.getLocation(ptTopLeftCorner,geElem.locations[0],geElem.sprite);
            ptBottomRightCorner = (PoolsManager.getInstance().getPointPool().checkOut() as PoolablePoint).renew(geElem.sprite.x,geElem.sprite.y);
            ptBottomRightCorner = this.getLocation(ptBottomRightCorner,geElem.locations[1],geElem.sprite);
            if(ptTopLeftCorner && ptBottomRightCorner)
            {
               width = Math.floor(Math.abs(ptBottomRightCorner.x - ptTopLeftCorner.x));
               height = Math.floor(Math.abs(ptBottomRightCorner.y - ptTopLeftCorner.y));
               if(geElem.sprite is MapViewer)
               {
                  (geElem.sprite as MapViewer).setSize(width,height);
               }
               else
               {
                  geElem.sprite.width = width;
                  geElem.sprite.height = height;
               }
            }
            else
            {
               _log.error("Erreur de positionement dans " + name + " avec " + geElem.name);
            }
            PoolsManager.getInstance().getPointPool().checkIn(ptTopLeftCorner as PoolablePoint);
            PoolsManager.getInstance().getPointPool().checkIn(ptBottomRightCorner as PoolablePoint);
         }
         ptNewPos.x = geElem.sprite.x;
         ptNewPos.y = geElem.sprite.y;
         ptNewPos = this.getLocation(ptNewPos,geElem.location,geElem.sprite);
         if(geElem.sprite && ptNewPos)
         {
            geElem.sprite.x = ptNewPos.x;
            geElem.sprite.y = ptNewPos.y;
         }
         else
         {
            geElem.sprite.x = startValueX;
            geElem.sprite.y = startValueY;
            _log.error("Erreur dans " + name + " avec " + geElem.name);
         }
         PoolsManager.getInstance().getPointPool().checkIn(ptNewPos as PoolablePoint);
      }
      
      private function getLocation(ptStart:Point, glLocation:GraphicLocation, doTarget:DisplayObject) : Point
      {
         var doRelative:DisplayObject = null;
         var ref:DisplayObject = null;
         var pTarget:Point = null;
         var pRef:Point = null;
         var uiTarget:Array = null;
         var ui:UiRootContainer = null;
         var pModificator:Point = PoolsManager.getInstance().getPointPool().checkOut() as PoolablePoint;
         if(glLocation.offsetXType == LocationTypeEnum.LOCATION_TYPE_RELATIVE || glLocation.offsetYType == LocationTypeEnum.LOCATION_TYPE_RELATIVE)
         {
            switch(glLocation.getRelativeTo())
            {
               case GraphicLocation.REF_PARENT:
                  pModificator.x = Math.floor(GraphicContainer(doTarget).getParent().width * glLocation.getOffsetX());
                  pModificator.y = Math.floor(GraphicContainer(doTarget).getParent().height * glLocation.getOffsetY());
            }
            if(glLocation.offsetXType == LocationTypeEnum.LOCATION_TYPE_RELATIVE)
            {
               ptStart.x += pModificator.x;
            }
            if(glLocation.offsetYType == LocationTypeEnum.LOCATION_TYPE_RELATIVE)
            {
               ptStart.y += pModificator.y;
            }
         }
         if(glLocation.offsetXType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE || glLocation.offsetYType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE)
         {
            pTarget = PoolsManager.getInstance().getPointPool().checkOut() as PoolablePoint;
            pModificator.x = 0;
            pModificator.y = 0;
            pRef = PoolsManager.getInstance().getPointPool().checkOut() as PoolablePoint;
            (pRef as PoolablePoint).renew(doTarget.x,doTarget.y);
            pRef = doTarget.localToGlobal(pRef);
            switch(glLocation.getRelativeTo())
            {
               case GraphicLocation.REF_PARENT:
                  pModificator.x = glLocation.getOffsetX();
                  pModificator.y = glLocation.getOffsetY();
                  break;
               case GraphicLocation.REF_SCREEN:
                  pModificator.x = glLocation.getOffsetX() - pRef.x;
                  pModificator.y = glLocation.getOffsetY() - pRef.y;
                  break;
               case GraphicLocation.REF_TOP:
                  pModificator.x = glLocation.getOffsetX() + (x - pRef.x);
                  pModificator.y = glLocation.getOffsetY() + (y - pRef.y);
                  break;
               default:
                  if(this.isRegisteredId(glLocation.getRelativeTo()))
                  {
                     ref = this._aGraphicElementIndex[glLocation.getRelativeTo()].sprite;
                  }
                  else if(Berilia.getInstance().getUi(glLocation.getRelativeTo()))
                  {
                     ref = Berilia.getInstance().getUi(glLocation.getRelativeTo());
                     UiRootContainer(ref).addLinkedUi(name);
                     doTarget = ref;
                  }
                  else
                  {
                     if(glLocation.getRelativeTo().indexOf(".") == -1)
                     {
                        _log.warn("[Warning] " + glLocation.getRelativeTo() + " is unknow graphic element reference");
                        return null;
                     }
                     uiTarget = glLocation.getRelativeTo().split(".");
                     ui = Berilia.getInstance().getUi(uiTarget[0]);
                     if(!ui)
                     {
                        _log.warn("[Warning] UI " + uiTarget[0] + " does not exist (found " + glLocation.getRelativeTo() + " in " + name + ")");
                        return null;
                     }
                     if(!ui.getElementById(uiTarget[1]))
                     {
                        _log.warn("[Warning] UI " + uiTarget[0] + " does not contain element [" + uiTarget[1] + "] (found " + glLocation.getRelativeTo() + " in " + name + ")");
                        return null;
                     }
                     ref = ui.getElementById(uiTarget[1]).sprite;
                     GraphicContainer(ref).getUi().addLinkedUi(name);
                  }
                  (pTarget as PoolablePoint).renew(ref.x,ref.y);
                  pTarget = doTarget.localToGlobal(pTarget);
                  pModificator.x = glLocation.getOffsetX() + (pTarget.x - pRef.x);
                  pModificator.y = glLocation.getOffsetY() + (pTarget.y - pRef.y);
            }
            if(glLocation.offsetXType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE)
            {
               ptStart.x += pModificator.x;
            }
            if(glLocation.offsetYType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE)
            {
               ptStart.y += pModificator.y;
            }
            PoolsManager.getInstance().getPointPool().checkIn(pModificator as PoolablePoint);
            PoolsManager.getInstance().getPointPool().checkIn(pRef as PoolablePoint);
            PoolsManager.getInstance().getPointPool().checkIn(pTarget as PoolablePoint);
         }
         pModificator = this.getOffsetModificator(glLocation.getPoint(),doTarget,this.pModificator_offset);
         ptStart.x -= pModificator.x;
         ptStart.y -= pModificator.y;
         switch(glLocation.getRelativeTo())
         {
            case GraphicLocation.REF_PARENT:
               if(doTarget.parent && doTarget.parent.parent)
               {
                  doRelative = doTarget.parent.parent;
               }
               break;
            case GraphicLocation.REF_SCREEN:
               doRelative = this._root;
               break;
            case GraphicLocation.REF_TOP:
               doRelative = this;
               break;
            default:
               doRelative = ref;
               if(doRelative == doTarget)
               {
                  _log.warn("[Warning] Wrong relative position : " + doRelative.name + " refer to himself");
               }
         }
         pModificator = this.getOffsetModificator(glLocation.getRelativePoint(),doRelative,this.pModificator_offset);
         ptStart.x += pModificator.x;
         ptStart.y += pModificator.y;
         return ptStart;
      }
      
      protected function listenResize(listen:Boolean) : void
      {
         if(this._resizeListening == listen)
         {
            return;
         }
         if(listen)
         {
            StageShareManager.stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZE,this.onResize,false,0,true);
            StageShareManager.stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.onResize,false,0,true);
         }
         else
         {
            StageShareManager.stage.nativeWindow.removeEventListener(NativeWindowBoundsEvent.RESIZE,this.onResize);
            StageShareManager.stage.removeEventListener(FullScreenEvent.FULL_SCREEN,this.onResize);
         }
         this._resizeListening = listen;
      }
      
      private function getOffsetModificator(nPoint:uint, doTarget:DisplayObject, offsetModificator:Point) : Point
      {
         var nWidth:uint = 0;
         var nHeight:uint = 0;
         if(doTarget == null || doTarget is UiRootContainer)
         {
            if(this._fullscreen)
            {
               nWidth = Math.abs(StageShareManager.stageVisibleBounds.width);
               nHeight = Math.abs(StageShareManager.stageVisibleBounds.height);
            }
            else
            {
               nWidth = Math.abs(StageShareManager.startWidth);
               nHeight = Math.abs(StageShareManager.startHeight);
            }
         }
         else
         {
            nWidth = Math.abs(doTarget.width);
            nHeight = Math.abs(doTarget.height);
         }
         offsetModificator.x = 0;
         offsetModificator.y = 0;
         switch(nPoint)
         {
            case LocationEnum.POINT_TOPLEFT:
               break;
            case LocationEnum.POINT_TOP:
               offsetModificator.x = nWidth / 2;
               break;
            case LocationEnum.POINT_TOPRIGHT:
               offsetModificator.x = nWidth;
               break;
            case LocationEnum.POINT_LEFT:
               offsetModificator.y = nWidth / 2;
               break;
            case LocationEnum.POINT_CENTER:
               offsetModificator.x = nWidth / 2;
               offsetModificator.y = nHeight / 2;
               break;
            case LocationEnum.POINT_RIGHT:
               offsetModificator.x = nWidth;
               offsetModificator.y = nHeight / 2;
               break;
            case LocationEnum.POINT_BOTTOMLEFT:
               offsetModificator.y = nHeight;
               break;
            case LocationEnum.POINT_BOTTOM:
               offsetModificator.x = nWidth / 2;
               offsetModificator.y = nHeight;
               break;
            case LocationEnum.POINT_BOTTOMRIGHT:
               offsetModificator.x = nWidth;
               offsetModificator.y = nHeight;
         }
         return offsetModificator;
      }
      
      private function zSort(aSort:Array) : Boolean
      {
         var ge:GraphicElement = null;
         var gl:GraphicLocation = null;
         var i:uint = 0;
         var j:uint = 0;
         var k:uint = 0;
         var bChange:Boolean = true;
         var bSwap:Boolean = false;
         while(bChange)
         {
            bChange = false;
            for(i = 0; i < aSort.length; i++)
            {
               ge = aSort[i];
               if(ge != null)
               {
                  for(j = 0; j < ge.locations.length; j++)
                  {
                     for(k = i + 1; k < aSort.length; k++)
                     {
                        gl = ge.locations[j];
                        if(aSort[k] != null)
                        {
                           if(gl.getRelativeTo().charAt(0) != "$" && gl.getRelativeTo() == aSort[k].sprite.name || gl.getRelativeTo() == GraphicLocation.REF_PARENT && aSort[k].sprite == ge.sprite.getParent())
                           {
                              bSwap = true;
                              bChange = true;
                              aSort[i] = aSort[k];
                              aSort[k] = ge;
                              break;
                           }
                        }
                     }
                  }
               }
            }
         }
         return bSwap;
      }
      
      protected function onResize(event:Event = null) : void
      {
         if(this._lock == false)
         {
            this.render();
         }
         this._stageAddedWidth += this._lastVisibleStageX - StageShareManager.stageVisibleBounds.x;
         this._lastVisibleStageX = StageShareManager.stageVisibleBounds.x;
      }
   }
}
