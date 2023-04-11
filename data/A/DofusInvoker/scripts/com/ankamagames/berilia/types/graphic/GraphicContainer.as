package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.BeriliaConstants;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.berilia.components.messages.ItemRollOutMessage;
   import com.ankamagames.berilia.components.messages.ItemRollOverMessage;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.berilia.managers.ThemeManager;
   import com.ankamagames.berilia.types.uiDefinition.SizeElement;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
   import com.ankamagames.jerakine.interfaces.IDragAndDropHandler;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.pools.GenericPool;
   import com.ankamagames.jerakine.pools.Poolable;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import gs.TweenLite;
   import gs.TweenMax;
   import gs.easing.Circ;
   import gs.easing.Expo;
   import gs.easing.Strong;
   
   public class GraphicContainer extends Sprite implements UIComponent, IRectangle, Poolable, IDragAndDropHandler, ICustomUnicNameGetter, FinalizableUIComponent
   {
      
      public static const COLOR_TRANSFORM_DEFAULT:ColorTransform = new ColorTransform(1,1,1,1);
      
      public static const COLOR_TRANSFORM_DISABLED:ColorTransform = new ColorTransform(0.6,0.6,0.6,1);
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GraphicContainer));
      
      private static var DOUBLE_SHARP:String = "##";
      
      private static var POS_SKEY_STRING:String = "##pos##";
      
      private static var SIZE_SKEY_STRING:String = "##size##";
       
      
      protected var __width:uint;
      
      protected var __widthNoScale:uint;
      
      protected var __height:uint;
      
      protected var __heightNoScale:uint;
      
      protected var __removed:Boolean;
      
      protected var _bgColor:int = -1;
      
      protected var _bgAlpha:Number = 1;
      
      protected var _bgMargin:Number = 0;
      
      protected var _borderColor:int = -1;
      
      protected var _bgCornerRadius:uint = 0;
      
      protected var _isSizeControler:Boolean = false;
      
      private var _hintAvailable:Boolean = false;
      
      private var _notMovableUIUnderConditions:Boolean = false;
      
      private var _isInstance:Boolean = false;
      
      protected var _aStrata:Array;
      
      private var _scale:Number = 1.0;
      
      private var _sLinkedTo:String;
      
      private var _bDynamicPosition:Boolean;
      
      private var _bDisabled:Boolean;
      
      private var _bSoftDisabled:Boolean;
      
      private var _bGreyedOut:Boolean;
      
      private var _shadow:DropShadowFilter;
      
      private var _luminosity:Number = 1.0;
      
      var _uiRootContainer:UiRootContainer;
      
      var _resizeController:ResizeController;
      
      var _dragController:DragControler;
      
      private var _dropValidatorFunction:Function;
      
      private var _processDropFunction:Function;
      
      private var _removeDropSourceFunction:Function;
      
      private var _themeDataId:String;
      
      private var _isMagnetic:Boolean;
      
      private var _customName:String;
      
      protected var _finalized:Boolean;
      
      private var _posSKey:String;
      
      private var _sizeSKey:String;
      
      public var minSize:GraphicSize;
      
      public var maxSize:GraphicSize;
      
      public function GraphicContainer()
      {
         this._aStrata = [];
         this._dropValidatorFunction = this.defaultDropValidatorFunction;
         this._processDropFunction = this.defaultProcessDropFunction;
         this._removeDropSourceFunction = this.defaultRemoveDropSourceFunction;
         super();
         focusRect = false;
         this.mouseEnabled = false;
         doubleClickEnabled = true;
      }
      
      public function get isMagnetic() : Boolean
      {
         return this._isMagnetic;
      }
      
      public function set isMagnetic(value:Boolean) : void
      {
         this._isMagnetic = value;
         if(value)
         {
            this.getUi().registerMagneticElement(this);
         }
         else
         {
            this.getUi().removeMagneticElement(this);
         }
      }
      
      public function get dragSavePosition() : Boolean
      {
         return this._dragController != null ? Boolean(this._dragController.savePosition) : false;
      }
      
      public function set dragSavePosition(value:Boolean) : void
      {
         if(!this._dragController)
         {
            this.dragController = true;
         }
         this._dragController.savePosition = value;
      }
      
      public function get resizeController() : Boolean
      {
         return this._resizeController != null;
      }
      
      public function set resizeController(value:Boolean) : void
      {
         if(!value && this._resizeController)
         {
            if(this._resizeController.parent)
            {
               this._resizeController.parent.removeChild(this._resizeController);
            }
            this._resizeController.destroy();
            this._resizeController = null;
         }
         else if(value && !this._resizeController)
         {
            this._resizeController = new ResizeController();
            this._resizeController.width = this.width;
            this._resizeController.height = this.height;
            this._resizeController.controler = this;
            this.getStrata(StrataEnum.STRATA_LOW).addChild(this._resizeController);
         }
      }
      
      public function getResizeController() : ResizeController
      {
         return this._resizeController;
      }
      
      public function get resizeTarget() : String
      {
         return this._resizeController != null ? this._resizeController.target : null;
      }
      
      public function set resizeTarget(id:String) : void
      {
         if(!this._resizeController)
         {
            this.resizeController = true;
         }
         this._resizeController.target = id;
      }
      
      public function get dragTarget() : String
      {
         return !!this._dragController ? this._dragController.target : null;
      }
      
      public function set dragTarget(value:String) : void
      {
         if(value == "null")
         {
            value = null;
         }
         if(value)
         {
            if(!this.dragController)
            {
               this.dragController = true;
            }
            this._dragController.target = value;
         }
         else if(this.dragController)
         {
            this.dragController = false;
         }
      }
      
      public function set dragBoundsContainer(id:String) : void
      {
         if(!this.dragController)
         {
            this.dragController = true;
         }
         this._dragController.boundsContainer = id;
      }
      
      public function get dragBoundsContainer() : String
      {
         return this._dragController != null ? this._dragController.boundsContainer : null;
      }
      
      public function set useDragMagnetism(b:Boolean) : void
      {
         if(!this.dragController)
         {
            this.dragController = true;
         }
         this._dragController.useDragMagnetism = b;
      }
      
      public function get useDragMagnetism() : Boolean
      {
         return this._dragController != null ? Boolean(this._dragController.useDragMagnetism) : false;
      }
      
      public function set restrictionFunctionName(funcName:String) : void
      {
         if(this._dragController && this.getUi().uiClass.hasOwnProperty(funcName))
         {
            this._dragController.restrictionFunction = this.getUi().uiClass[funcName];
         }
      }
      
      public function get dragController() : Boolean
      {
         return this._dragController != null;
      }
      
      public function set dragController(value:Boolean) : void
      {
         if(value && !this._dragController)
         {
            this._dragController = new DragControler();
            this._dragController.controler = this;
            this.getUi()._dragControllers[this._dragController] = true;
         }
         else if(!value)
         {
            if(this._dragController)
            {
               delete this.getUi()._dragControllers[this._dragController];
               this._dragController.destroy();
               this._dragController = null;
            }
         }
      }
      
      public function get notMovableUIUnderConditions() : Boolean
      {
         return this._notMovableUIUnderConditions;
      }
      
      public function set notMovableUIUnderConditions(value:Boolean) : void
      {
         this._notMovableUIUnderConditions = value;
      }
      
      public function get customUnicName() : String
      {
         if(!this._customName && this.getUi())
         {
            if(name.indexOf(this.getUi().name + "::") == 0)
            {
               this._customName = name;
            }
            else
            {
               this._customName = this.getUi().name + "::" + name;
            }
         }
         return this._customName;
      }
      
      public function set themeDataId(id:String) : void
      {
         this._themeDataId = id;
         if(!ThemeManager.getInstance().applyThemeData(this,id))
         {
            this._themeDataId = null;
         }
      }
      
      public function get themeDataId() : String
      {
         return this._themeDataId;
      }
      
      public function set dropValidator(dv:Function) : void
      {
         this._dropValidatorFunction = dv;
      }
      
      public function get dropValidator() : Function
      {
         return this._dropValidatorFunction;
      }
      
      public function set removeDropSource(rds:Function) : void
      {
         this._removeDropSourceFunction = rds;
      }
      
      public function get removeDropSource() : Function
      {
         return this._removeDropSourceFunction;
      }
      
      public function set processDrop(pd:Function) : void
      {
         this._processDropFunction = pd;
      }
      
      public function get processDrop() : Function
      {
         return this._processDropFunction;
      }
      
      public function set sizeControler(b:Boolean) : void
      {
         this._isSizeControler = b;
         if(this.getUi() && this.getUi().windowOwner)
         {
            this.getUi().windowOwner.sizeControler = !!b ? this : null;
         }
      }
      
      public function get finalized() : Boolean
      {
         return this._finalized;
      }
      
      public function set finalized(b:Boolean) : void
      {
         this._finalized = b;
      }
      
      public function get hintAvailable() : Boolean
      {
         return this._hintAvailable;
      }
      
      public function set hintAvailable(value:Boolean) : void
      {
         this._hintAvailable = value;
      }
      
      public function get isInstance() : Boolean
      {
         return this._isInstance;
      }
      
      public function set isInstance(value:Boolean) : void
      {
         this._isInstance = value;
      }
      
      public function finalize() : void
      {
         var ui:UiRootContainer = this.getUi();
         if(this._isSizeControler && ui && ui.windowOwner)
         {
            ui.windowOwner.sizeControler = this;
         }
         this._finalized = true;
      }
      
      public function focus() : void
      {
         Berilia.getInstance().docMain.stage.focus = this;
         FocusHandler.getInstance().setFocus(this);
      }
      
      public function get hasFocus() : Boolean
      {
         return FocusHandler.getInstance().hasFocus(this);
      }
      
      public function get colorTransform() : ColorTransform
      {
         return transform.colorTransform;
      }
      
      public function set colorTransform(ct:ColorTransform) : void
      {
         transform.colorTransform = ct;
      }
      
      public function get scale() : Number
      {
         return this._scale;
      }
      
      public function set scale(nScale:Number) : void
      {
         this.__width = this.__widthNoScale * (1 - nScale);
         this.__height = this.__heightNoScale * (1 - nScale);
         scaleX = nScale;
         scaleY = nScale;
         this._scale = nScale;
      }
      
      override public function set width(nW:Number) : void
      {
         var ge:GraphicElement = null;
         if(nW < 1)
         {
            this.__width = 1;
         }
         else
         {
            this.__width = nW;
         }
         if(this._bgColor != -1)
         {
            this.bgColor = this._bgColor;
         }
         this.__widthNoScale = this.__width;
         var ui:UiRootContainer = this.getUi();
         if(ui)
         {
            ge = ui.getElementById(name);
            if(ge && ui.ready)
            {
               ge.size.setX(nW,ge.size.xUnit);
            }
            ui.updateLinkedUi();
         }
         if(this._resizeController)
         {
            this._resizeController.width = this.width;
         }
      }
      
      public function set widthNoCache(nW:Number) : void
      {
         if(nW < 1)
         {
            this.__width = 1;
         }
         else
         {
            this.__width = nW;
         }
         if(this._bgColor != -1)
         {
            this.bgColor = this._bgColor;
         }
         this.__widthNoScale = this.__width;
         var ui:UiRootContainer = this.getUi();
         if(ui)
         {
            ui.updateLinkedUi();
         }
         if(this._resizeController)
         {
            this._resizeController.width = this.width;
         }
      }
      
      override public function set height(nH:Number) : void
      {
         var ge:GraphicElement = null;
         if(nH < 1)
         {
            this.__height = 1;
         }
         else
         {
            this.__height = nH;
         }
         if(this._bgColor != -1)
         {
            this.bgColor = this._bgColor;
         }
         this.__heightNoScale = this.__height;
         var ui:UiRootContainer = this.getUi();
         if(ui)
         {
            ge = ui.getElementById(name);
            if(ge && ui.ready)
            {
               ge.size.setY(nH,ge.size.yUnit);
            }
            ui.updateLinkedUi();
         }
         if(this._resizeController)
         {
            this._resizeController.height = this.height;
         }
      }
      
      public function set heightNoCache(nH:Number) : void
      {
         if(nH < 1)
         {
            this.__height = 1;
         }
         else
         {
            this.__height = nH;
         }
         if(this._bgColor != -1)
         {
            this.bgColor = this._bgColor;
         }
         this.__heightNoScale = this.__height;
         var ui:UiRootContainer = this.getUi();
         if(ui)
         {
            ui.updateLinkedUi();
         }
         if(this._resizeController)
         {
            this._resizeController.height = this.height;
         }
      }
      
      override public function get width() : Number
      {
         if(isNaN(this.__width) || !this.__width)
         {
            return this.contentWidth * scaleX;
         }
         return this.__width * scaleX;
      }
      
      override public function get height() : Number
      {
         if(isNaN(this.__height) || !this.__height)
         {
            return this.contentHeight * scaleY;
         }
         return this.__height * scaleY;
      }
      
      public function get contentWidth() : Number
      {
         return super.width;
      }
      
      public function get contentHeight() : Number
      {
         return super.height;
      }
      
      override public function set x(value:Number) : void
      {
         var ge:GraphicElement = null;
         super.x = value;
         var ui:UiRootContainer = this.getUi();
         if(ui)
         {
            ge = ui.getElementById(name);
            if(ge && ui.ready)
            {
               ge.location.setOffsetX(value);
            }
            ui.updateLinkedUi();
         }
      }
      
      public function set xNoCache(value:Number) : void
      {
         super.x = value;
      }
      
      override public function set y(value:Number) : void
      {
         var ge:GraphicElement = null;
         super.y = value;
         var ui:UiRootContainer = this.getUi();
         if(ui)
         {
            ge = ui.getElementById(name);
            if(ge && ui.ready)
            {
               ge.location.setOffsetY(value);
            }
            ui.updateLinkedUi();
         }
      }
      
      public function set yNoCache(value:Number) : void
      {
         super.y = value;
      }
      
      public function get anchorY() : Number
      {
         var ge:GraphicElement = null;
         var ui:UiRootContainer = this.getUi();
         if(ui)
         {
            ge = ui.getElementById(name);
            if(ge && ui.ready)
            {
               return ge.location.getOffsetY();
            }
         }
         return NaN;
      }
      
      public function get anchorX() : Number
      {
         var ge:GraphicElement = null;
         var ui:UiRootContainer = this.getUi();
         if(ui)
         {
            ge = ui.getElementById(name);
            if(ge && ui.ready)
            {
               return ge.location.getOffsetX();
            }
         }
         return NaN;
      }
      
      public function set bgColor(nColor:*) : void
      {
         this.setColorVar(nColor);
         graphics.clear();
         if(!this.width || !this.height)
         {
            return;
         }
         if(this._borderColor != -1)
         {
            graphics.lineStyle(1,this._borderColor);
         }
         graphics.beginFill(this.bgColor,this.bgColor == -1 ? Number(0) : Number(this._bgAlpha));
         if(!this._bgCornerRadius)
         {
            graphics.drawRect(0,0,this.width,this.height);
         }
         else
         {
            graphics.drawRoundRect(0,0,this.width,this.height,this._bgCornerRadius,this._bgCornerRadius);
         }
         graphics.endFill();
      }
      
      protected function setColorVar(nColor:*) : void
      {
         var base:uint = 0;
         if(nColor is String)
         {
            base = String(nColor).substr(0,2) == "0x" ? uint(16) : uint(10);
            this._bgColor = parseInt(nColor,base);
            this._bgColor = this._bgColor < 0 ? int(this._bgColor) : this._bgColor & 16777215;
            if(nColor.length > 8)
            {
               this._bgAlpha = ((parseInt(nColor,base) & 4278190080) >> 24) / 255;
            }
         }
         else if(nColor is int || nColor is uint || nColor is Number)
         {
            this._bgColor = nColor;
            this._bgColor = this._bgColor < 0 ? int(this._bgColor) : this._bgColor & 16777215;
            if(nColor & 4278190080 && this._bgColor != -1)
            {
               this._bgAlpha = ((nColor & 4278190080) >> 24) / 255;
            }
         }
         else
         {
            this._bgColor = -1;
         }
      }
      
      public function get bgColor() : *
      {
         return this._bgColor;
      }
      
      public function set bgAlpha(nAlpha:Number) : void
      {
         this._bgAlpha = nAlpha;
         this.bgColor = this.bgColor;
      }
      
      public function get bgAlpha() : Number
      {
         return this._bgAlpha;
      }
      
      public function set bgMargin(nMargin:Number) : void
      {
         this._bgMargin = nMargin;
      }
      
      public function get bgMargin() : Number
      {
         return this._bgMargin;
      }
      
      public function set borderColor(color:int) : void
      {
         this._borderColor = color;
         this.bgColor = this.bgColor;
      }
      
      public function get borderColor() : int
      {
         return this._borderColor;
      }
      
      public function set bgCornerRadius(value:uint) : void
      {
         this._bgCornerRadius = value;
         this.bgColor = this.bgColor;
      }
      
      public function get bgCornerRadius() : uint
      {
         return this._bgCornerRadius;
      }
      
      public function set luminosity(nColor:Number) : void
      {
         this._luminosity = nColor;
         filters = [new ColorMatrixFilter([nColor,0,0,0,0,0,nColor,0,0,0,0,0,nColor,0,0,0,0,0,1,0])];
      }
      
      public function get luminosity() : Number
      {
         return this._luminosity;
      }
      
      public function set linkedTo(sUiComponent:String) : void
      {
         this._sLinkedTo = sUiComponent;
      }
      
      public function get linkedTo() : String
      {
         return this._sLinkedTo;
      }
      
      public function set shadowColor(nColor:int) : void
      {
         if(nColor >= 0)
         {
            this._shadow = new DropShadowFilter(3,90,nColor,1,10,10,0.61,BitmapFilterQuality.HIGH);
            filters = [this._shadow];
         }
         else if(nColor == -1 && this._shadow)
         {
            this._shadow = null;
            filters = [];
         }
      }
      
      public function get shadowColor() : int
      {
         return !!this._shadow ? int(this._shadow.color) : -1;
      }
      
      public function get topParent() : DisplayObject
      {
         return this.getTopParent(this);
      }
      
      public function getStrata(nStrata:int) : Sprite
      {
         var nIndex:uint = 0;
         var i:uint = 0;
         if(this._aStrata[nStrata] != null)
         {
            return this._aStrata[nStrata];
         }
         this._aStrata[nStrata] = new Sprite();
         this._aStrata[nStrata].name = "strata_" + nStrata;
         this._aStrata[nStrata].mouseEnabled = false;
         this._aStrata[nStrata].doubleClickEnabled = true;
         nIndex = 0;
         for(i = 0; i < this._aStrata.length; i++)
         {
            if(this._aStrata[i] != null)
            {
               addChildAt(this._aStrata[i],nIndex++);
            }
         }
         return this._aStrata[nStrata];
      }
      
      public function set dynamicPosition(bool:Boolean) : void
      {
         this._bDynamicPosition = bool;
      }
      
      public function get dynamicPosition() : Boolean
      {
         return this._bDynamicPosition;
      }
      
      public function set disabled(bool:Boolean) : void
      {
         if(bool)
         {
            transform.colorTransform = COLOR_TRANSFORM_DISABLED;
            this.handCursor = false;
            this.mouseEnabled = false;
            mouseChildren = false;
         }
         else
         {
            if(!this.greyedOut)
            {
               transform.colorTransform = COLOR_TRANSFORM_DEFAULT;
            }
            this.handCursor = true;
            this.mouseEnabled = true;
            mouseChildren = true;
         }
         this._bDisabled = bool;
      }
      
      public function set disabledExceptHandCursor(bool:Boolean) : void
      {
         if(bool)
         {
            transform.colorTransform = COLOR_TRANSFORM_DISABLED;
            this.mouseEnabled = false;
            mouseChildren = false;
         }
         else
         {
            if(!this.greyedOut)
            {
               transform.colorTransform = COLOR_TRANSFORM_DEFAULT;
            }
            this.mouseEnabled = true;
            mouseChildren = true;
         }
         this._bDisabled = bool;
      }
      
      public function get disabled() : Boolean
      {
         return this._bDisabled;
      }
      
      public function set softDisabled(bool:Boolean) : void
      {
         if(this._bSoftDisabled != bool)
         {
            if(bool)
            {
               transform.colorTransform = COLOR_TRANSFORM_DISABLED;
            }
            else
            {
               transform.colorTransform = COLOR_TRANSFORM_DEFAULT;
            }
         }
         this._bSoftDisabled = bool;
      }
      
      public function get softDisabled() : Boolean
      {
         return this._bSoftDisabled;
      }
      
      public function set greyedOut(bool:Boolean) : void
      {
         if(this._bGreyedOut != bool)
         {
            if(bool)
            {
               transform.colorTransform = COLOR_TRANSFORM_DISABLED;
            }
            else if(!this.disabled)
            {
               transform.colorTransform = COLOR_TRANSFORM_DEFAULT;
            }
         }
         this._bGreyedOut = bool;
      }
      
      public function get greyedOut() : Boolean
      {
         return this._bGreyedOut;
      }
      
      public function set handCursor(bValue:Boolean) : void
      {
         this.buttonMode = bValue;
         this.mouseChildren = !bValue;
      }
      
      public function get handCursor() : Boolean
      {
         return this.buttonMode && !this.mouseChildren;
      }
      
      override public function set mouseEnabled(v:Boolean) : void
      {
         var ctr:DisplayObjectContainer = null;
         super.mouseEnabled = v;
         for each(ctr in this._aStrata)
         {
            ctr.mouseEnabled = v;
         }
      }
      
      public function process(msg:Message) : Boolean
      {
         var uirc:UiRootContainer = null;
         var newMsg:MouseClickMessage = null;
         if(this._resizeController)
         {
            this._resizeController.process(msg);
         }
         if(this._dragController)
         {
            this._dragController.process(msg);
         }
         if(!this.canProcessMessage(msg))
         {
            return true;
         }
         var ui:UiRootContainer = this.getUi();
         if(msg is MouseDownMessage)
         {
            if(ui != null)
            {
               if(ui.strata == StrataEnum.STRATA_MEDIUM && ui.setOnTopOnClick)
               {
                  for each(uirc in ui.setOnTopBeforeMe)
                  {
                     Berilia.getInstance().setUiOnTop(uirc);
                  }
                  Berilia.getInstance().setUiOnTop(ui);
                  for each(uirc in ui.setOnTopAfterMe)
                  {
                     Berilia.getInstance().setUiOnTop(uirc);
                  }
               }
            }
         }
         if(msg is MouseClickMessage)
         {
            if(ui != null)
            {
               if(this._sLinkedTo)
               {
                  newMsg = GenericPool.get(MouseClickMessage,ui.getElement(this._sLinkedTo),MouseClickMessage(msg).mouseEvent);
                  ui.getElement(this._sLinkedTo).process(newMsg);
               }
            }
         }
         return false;
      }
      
      override public function stopDrag() : void
      {
         super.stopDrag();
         this.x = x;
         this.y = y;
      }
      
      public function getStageRect() : Rectangle
      {
         return this.getRect(stage);
      }
      
      public function remove() : void
      {
         if(this._dragController)
         {
            this._dragController.destroy();
         }
         if(this._resizeController)
         {
            this._resizeController.destroy();
         }
         var ui:UiRootContainer = this.getUi();
         if(ui)
         {
            ui.deleteId(name);
         }
         this.destroy(this);
         SecureCenter.destroy(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         this.__removed = true;
      }
      
      public function addContent(child:GraphicContainer, index:int = -1) : GraphicContainer
      {
         if(index == -1)
         {
            this.getStrata(0).addChild(child);
         }
         else
         {
            this.getStrata(0).addChildAt(child,index);
         }
         return child;
      }
      
      public function removeFromParent() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function getParent() : GraphicContainer
      {
         if(this.parent == null || this is UiRootContainer)
         {
            return null;
         }
         var doCurrent:DisplayObjectContainer = DisplayObjectContainer(this.parent);
         while(!(doCurrent is GraphicContainer))
         {
            doCurrent = DisplayObjectContainer(doCurrent.parent);
         }
         return GraphicContainer(doCurrent);
      }
      
      public function getUi() : UiRootContainer
      {
         if(this is UiRootContainer)
         {
            return this as UiRootContainer;
         }
         if(this._uiRootContainer)
         {
            return this._uiRootContainer;
         }
         if(this.parent == null)
         {
            return null;
         }
         var doCurrent:Sprite = Sprite(this.parent);
         while(!(doCurrent is UiRootContainer) && doCurrent != null)
         {
            if(doCurrent is GraphicContainer && GraphicContainer(doCurrent)._uiRootContainer)
            {
               doCurrent = GraphicContainer(doCurrent)._uiRootContainer;
            }
            else if(doCurrent.parent is Sprite)
            {
               doCurrent = Sprite(doCurrent.parent);
            }
            else
            {
               doCurrent = null;
            }
         }
         if(doCurrent == null)
         {
            return null;
         }
         this._uiRootContainer = UiRootContainer(doCurrent);
         return UiRootContainer(doCurrent);
      }
      
      public function setUi(ui:UiRootContainer, key:Object) : void
      {
         if(key != SecureCenter.ACCESS_KEY)
         {
            throw new SecurityError();
         }
         this._uiRootContainer = ui;
      }
      
      public function getTopParent(d:DisplayObject) : DisplayObject
      {
         if(d.parent != null)
         {
            return this.getTopParent(d.parent);
         }
         return d;
      }
      
      public function slide(endX:int, endY:int, time:int, inAndOut:Boolean = false, bezierX:int = 0, bezierY:int = 0) : void
      {
         var ease:Function = Strong.easeOut;
         if(inAndOut)
         {
            ease = Strong.easeInOut;
         }
         TweenLite.to(this,time / 1000,{
            "bezier":[{
               "x":bezierX,
               "y":bezierY
            }],
            "x":endX,
            "y":endY,
            "ease":ease,
            "onComplete":this.moveComplete
         });
      }
      
      public function alphaFade(endValue:Number, time:int) : void
      {
         var ease:Function = Circ.easeOut;
         TweenLite.to(this,time / 1000,{
            "alpha":endValue,
            "ease":ease
         });
      }
      
      public function colorSlide(endValue:Number, time:int, yoyo:Boolean) : void
      {
         var repeat:int = 0;
         var repeatDelay:int = 0.5;
         if(yoyo)
         {
            repeat = 1;
            repeatDelay = 0.5;
         }
         TweenMax.to(this,time / 1000,{
            "repeat":repeat,
            "repeatDelay":repeatDelay,
            "yoyo":yoyo,
            "ease":Expo.easeIn,
            "colorTransform":{"exposure":endValue}
         });
      }
      
      private function sKeyIsOutdated(sKey:String) : Boolean
      {
         var ui:UiRootContainer = this.getUi();
         return !sKey || sKey.indexOf(ui.name) != 0 || sKey.indexOf(DOUBLE_SHARP) != ui.name.length || sKey.indexOf(Berilia.getInstance().uiSavedModificationPresetName) != sKey.lastIndexOf(DOUBLE_SHARP) + 2;
      }
      
      public function getPosSKey() : String
      {
         if(this.sKeyIsOutdated(this._posSKey))
         {
            this._posSKey = this.getUi().name + POS_SKEY_STRING + name + DOUBLE_SHARP + Berilia.getInstance().uiSavedModificationPresetName;
         }
         return this._posSKey;
      }
      
      public function getSizeSKey() : String
      {
         if(this.sKeyIsOutdated(this._sizeSKey))
         {
            this._sizeSKey = this.getUi().name + SIZE_SKEY_STRING + name + DOUBLE_SHARP + Berilia.getInstance().uiSavedModificationPresetName;
         }
         return this._sizeSKey;
      }
      
      public function getSavedPosition() : Point
      {
         var data:* = StoreDataManager.getInstance().getData(BeriliaConstants.DATASTORE_UI_POSITIONS,this.getPosSKey());
         if(data && !(data is Point))
         {
            data = new Point(data.x,data.y);
         }
         return data;
      }
      
      public function setSavedPosition(x:Number, y:Number) : void
      {
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_POSITIONS,this.getPosSKey(),isNaN(x) && isNaN(y) ? null : new Point(x,y));
         if(this.getUi())
         {
            this.getUi().processLocation(this.getUi().getElementById(this.name));
         }
      }
      
      public function getSavedDimension() : Point
      {
         var data:* = StoreDataManager.getInstance().getData(BeriliaConstants.DATASTORE_UI_POSITIONS,this.getSizeSKey());
         if(data && !(data is Point))
         {
            data = new Point(data.x,data.y);
         }
         return data;
      }
      
      public function setSavedDimension(x:Number, y:Number) : void
      {
         if(this.getUi())
         {
            this.getUi().addDynamicSizeElement(this.getUi().getElementById(name));
         }
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_POSITIONS,this.getSizeSKey(),isNaN(x) && isNaN(y) ? null : new Point(x,y));
      }
      
      public function resetSavedInformations(deleteInfo:Boolean = true) : void
      {
         var ge:GraphicElement = null;
         var size:* = this.getSavedDimension() != null;
         var pos:* = this.getSavedPosition() != null;
         if(deleteInfo && size)
         {
            this.setSavedDimension(NaN,NaN);
         }
         if(deleteInfo && size)
         {
            this.setSavedPosition(NaN,NaN);
         }
         if(size)
         {
            ge = this.getUi().getElementById(name);
            if(ge && ge.size)
            {
               if(ge.size.xUnit == SizeElement.SIZE_PIXEL)
               {
                  this.widthNoCache = ge.size.x;
               }
               if(ge.size.yUnit == SizeElement.SIZE_PIXEL)
               {
                  this.heightNoCache = ge.size.y;
               }
            }
         }
         if(pos)
         {
            this.xNoCache = this.anchorX;
            this.yNoCache = this.anchorY;
         }
      }
      
      private function moveComplete() : void
      {
         KernelEventsManager.getInstance().processCallback(BeriliaHookList.SlideComplete,this);
      }
      
      private function defaultDropValidatorFunction(target:*, data:*, source:*) : Boolean
      {
         var parent:DisplayObject = this;
         do
         {
            parent = parent.parent;
         }
         while(!(parent is IDragAndDropHandler) && parent.parent);
         
         if(parent is IDragAndDropHandler)
         {
            return (parent as IDragAndDropHandler).dropValidator(target,data,source);
         }
         return false;
      }
      
      private function defaultProcessDropFunction(target:*, data:*, source:*) : void
      {
         var parent:DisplayObject = this;
         do
         {
            parent = parent.parent;
         }
         while(!(parent is IDragAndDropHandler) && parent.parent);
         
         if(parent is IDragAndDropHandler)
         {
            (parent as IDragAndDropHandler).processDrop(target,data,source);
         }
      }
      
      private function defaultRemoveDropSourceFunction(target:*) : void
      {
         var parent:DisplayObject = this;
         do
         {
            parent = parent.parent;
         }
         while(!(parent is IDragAndDropHandler) && parent.parent);
         
         if(parent is IDragAndDropHandler)
         {
            (parent as IDragAndDropHandler).removeDropSource(target);
         }
      }
      
      override public function localToGlobal(point:Point) : Point
      {
         var target:DisplayObject = this;
         var coord:Point = point;
         while(target && target.parent)
         {
            coord.x += target.parent.x;
            coord.y += target.parent.y;
            target = target.parent;
         }
         return coord;
      }
      
      protected function destroy(target:DisplayObjectContainer) : void
      {
         var item:DisplayObject = null;
         if(!target || target is MovieClip && MovieClip(target).totalFrames > 1)
         {
            return;
         }
         if(this._dragController && this.getUi())
         {
            delete this.getUi()._dragControllers[this._dragController];
         }
         while(target.numChildren)
         {
            item = target.removeChildAt(0);
            if(item is TiphonSprite)
            {
               (item as TiphonSprite).destroy();
            }
            else
            {
               if(item is GraphicContainer)
               {
                  (item as GraphicContainer).remove();
               }
               if(item is DisplayObjectContainer)
               {
                  this.destroy(item as DisplayObjectContainer);
               }
            }
         }
      }
      
      public function free() : void
      {
         this.__width = 0;
         this.__widthNoScale = 0;
         this.__height = 0;
         this.__heightNoScale = 0;
         this.__removed = false;
         this._bgColor = -1;
         this._bgAlpha = 1;
         this.minSize = null;
         this.maxSize = null;
         this._scale = 1;
         this._sLinkedTo = null;
         this._bDisabled = false;
         this._shadow = null;
         this._luminosity = 1;
         this._bgCornerRadius = 0;
         this._uiRootContainer = null;
         if(this._resizeController)
         {
            this._resizeController.destroy();
         }
         this._resizeController = null;
      }
      
      override public function contains(child:DisplayObject) : Boolean
      {
         return super.contains(child);
      }
      
      protected function canProcessMessage(pMsg:Message) : Boolean
      {
         if(this._bSoftDisabled)
         {
            if(!(pMsg is ItemRollOutMessage || pMsg is ItemRollOverMessage || pMsg is MouseOverMessage || pMsg is MouseOutMessage || pMsg is MouseWheelMessage))
            {
               return false;
            }
         }
         return true;
      }
   }
}
