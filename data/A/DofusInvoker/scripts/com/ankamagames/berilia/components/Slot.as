package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.components.messages.DropMessage;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.berilia.interfaces.ICustomSlotData;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.berilia.types.data.SlotDragAndDropData;
   import com.ankamagames.berilia.types.event.TextureLoadFailedEvent;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.GraphicElement;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.EmbedIcons;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.interfaces.IDragAndDropHandler;
   import com.ankamagames.jerakine.interfaces.IInterfaceListener;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.ColorUtils;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import gs.events.TweenEvent;
   
   public class Slot extends ButtonContainer implements ISlotDataHolder, FinalizableUIComponent, IDragAndDropHandler
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Slot));
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      public static const DRAG_AND_DROP_CURSOR_NAME:String = "DragAndDrop";
      
      public static const NEED_CACHE_AS_BITMAP:String = "needCacheAsBitmap";
      
      private static var _unicID:uint = 0;
       
      
      private var _data:ISlotData;
      
      private var _dropValidator:Function;
      
      private var _unboxedDropValidator:Function;
      
      private var _topLabel:Label;
      
      private var _middleLabel:Label;
      
      private var _bottomLabel:Label;
      
      private var _backgroundIcon:Texture;
      
      private var _icon:Texture;
      
      private var _effect:Texture;
      
      private var _tx_timerForeground:Texture;
      
      private var _allowDrag:Boolean = true;
      
      private var _dragStartPoint:Point;
      
      private var _displayBackgroundIcon:Boolean = true;
      
      private var _dragging:Boolean = false;
      
      private var _selected:Boolean;
      
      private var _isButton:Boolean = false;
      
      private var _isTimerRunning:Boolean = false;
      
      private var _timerMaxDuration:int;
      
      private var _timerStartTime:int;
      
      private var _css:Uri;
      
      private var _cssClass:String = "quantity";
      
      private var _removeDropSource:Function;
      
      private var _unboxedRemoveDropSource:Function;
      
      private var _processDrop:Function;
      
      private var _unboxedProcessDrop:Function;
      
      private var _hideTopLabel:Boolean = false;
      
      public var _emptyTexture:Uri;
      
      public var _customTexture:Uri;
      
      public var _forcedBackGroundIconUri:Uri;
      
      private var _widthHeightMax:uint = 65;
      
      private var _targetUri:Uri;
      
      private var _useTextureCache:Boolean = true;
      
      private var _isActiveFunction:Function;
      
      private var _customColorTransform:ColorTransform;
      
      [Uri]
      public var highlightTexture:Uri;
      
      [Uri]
      public var selectedTexture:Uri;
      
      [Uri]
      public var timerTexture:Uri;
      
      [Uri]
      public var acceptDragTexture:Uri;
      
      [Uri]
      public var refuseDragTexture:Uri;
      
      private var _quantitySprite:Sprite;
      
      private var _quantityText:TextField;
      
      private const _quantityTextFormat:TextFormat = new TextFormat("Tahoma",15,16777215);
      
      public function Slot()
      {
         super();
         MEMORY_LOG[this] = 1;
      }
      
      public function set data(o:*) : void
      {
         if(!o is ISlotData)
         {
            throw new TypeError("data must implement ISlotData interface.");
         }
         this._data = o as ISlotData;
         if(this._data)
         {
            this._data.addHolder(this);
         }
         if(o != null && o.hasOwnProperty("customTextureUri"))
         {
            this.customTexture = o.customTextureUri;
         }
         else
         {
            this.customTexture = null;
         }
         if(this._isButton)
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
         this.refresh();
      }
      
      public function get icon() : Texture
      {
         return this._icon;
      }
      
      public function set iconColorTransform(pColorTransform:ColorTransform) : void
      {
         this._customColorTransform = pColorTransform;
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      override public function get finalized() : Boolean
      {
         return _finalized;
      }
      
      override public function set finalized(b:Boolean) : void
      {
         _finalized = b;
      }
      
      override public function set selected(b:Boolean) : void
      {
         this._selected = b;
         if(this._effect)
         {
            if(b)
            {
               if(this.selectedTexture || !this.highlightTexture || this._effect.uri != this.highlightTexture)
               {
                  this._effect.uri = this.selectedTexture;
               }
            }
            else if(this._customTexture)
            {
               this._effect.uri = this._customTexture;
            }
            else
            {
               this._effect.uri = null;
            }
         }
         super.selected = b;
      }
      
      public function get allowDrag() : Boolean
      {
         return this._allowDrag;
      }
      
      public function set allowDrag(bool:Boolean) : void
      {
         if(this._allowDrag != bool)
         {
            if(!bool && StageShareManager.stage.hasEventListener(MouseEvent.MOUSE_MOVE))
            {
               StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragAndDropStart);
            }
            this._allowDrag = bool;
         }
      }
      
      [Uri]
      public function set css(uri:Uri) : void
      {
         this._css = uri;
         if(this._topLabel)
         {
            this._topLabel.css = this._css;
         }
         if(this._middleLabel)
         {
            this._middleLabel.css = this._css;
         }
         if(this._bottomLabel)
         {
            this._bottomLabel.css = this._css;
         }
      }
      
      public function set cssClass(cssclass:String) : void
      {
         this._cssClass = cssclass;
         if(this._topLabel)
         {
            this._topLabel.cssClass = this._cssClass;
         }
         if(this._middleLabel)
         {
            this._middleLabel.cssClass = this._cssClass;
         }
         if(this._bottomLabel)
         {
            this._bottomLabel.cssClass = this._cssClass;
         }
      }
      
      override public function set dropValidator(dv:Function) : void
      {
         this._dropValidator = dv;
         this._unboxedDropValidator = null;
      }
      
      override public function get dropValidator() : Function
      {
         if(this._dropValidator == null)
         {
            return super.dropValidator;
         }
         if(this._unboxedDropValidator == null)
         {
            this._unboxedDropValidator = this._dropValidator;
         }
         return this._unboxedDropValidator;
      }
      
      override public function set removeDropSource(rds:Function) : void
      {
         this._removeDropSource = rds;
         this._unboxedRemoveDropSource = null;
      }
      
      override public function get removeDropSource() : Function
      {
         if(this._removeDropSource == null)
         {
            return super.removeDropSource;
         }
         if(this._unboxedRemoveDropSource == null)
         {
            this._unboxedRemoveDropSource = this._removeDropSource;
         }
         return this._unboxedRemoveDropSource;
      }
      
      override public function set processDrop(pd:Function) : void
      {
         this._processDrop = pd;
         this._unboxedProcessDrop = null;
      }
      
      override public function get processDrop() : Function
      {
         if(this._processDrop == null)
         {
            return super.processDrop;
         }
         if(this._unboxedProcessDrop == null)
         {
            this._unboxedProcessDrop = this._processDrop;
         }
         return this._unboxedProcessDrop;
      }
      
      [Uri]
      public function get emptyTexture() : Uri
      {
         return this._emptyTexture;
      }
      
      [Uri]
      public function set emptyTexture(uri:Uri) : void
      {
         this._emptyTexture = uri;
         if(this.icon != null)
         {
            this.icon.uri = this._emptyTexture;
         }
      }
      
      public function get customTexture() : Uri
      {
         return this._customTexture;
      }
      
      public function set customTexture(uri:Uri) : void
      {
         this._customTexture = uri;
         if(this._effect)
         {
            this._effect.uri = this._customTexture;
         }
      }
      
      [Uri]
      public function get forcedBackGroundIconUri() : Uri
      {
         return this._forcedBackGroundIconUri;
      }
      
      [Uri]
      public function set forcedBackGroundIconUri(uri:Uri) : void
      {
         this._forcedBackGroundIconUri = uri;
         if(this._backgroundIcon)
         {
            this._backgroundIcon.uri = this._forcedBackGroundIconUri;
         }
      }
      
      public function get hideTopLabel() : Boolean
      {
         return this._hideTopLabel;
      }
      
      public function set hideTopLabel(b:Boolean) : void
      {
         this._hideTopLabel = b;
         if(this._topLabel != null)
         {
            this._topLabel.visible = !b;
         }
      }
      
      public function get displayBackgroundIcon() : Boolean
      {
         return this._displayBackgroundIcon;
      }
      
      public function set displayBackgroundIcon(visible:Boolean) : void
      {
         this._displayBackgroundIcon = visible;
         if(this._backgroundIcon)
         {
            this._backgroundIcon.visible = visible;
         }
      }
      
      public function set isButton(b:Boolean) : void
      {
         this._isButton = b;
         if(!b)
         {
            buttonMode = false;
            useHandCursor = false;
         }
         else
         {
            buttonMode = true;
            useHandCursor = true;
         }
      }
      
      public function set useTextureCache(pUseCache:Boolean) : void
      {
         this._useTextureCache = pUseCache;
      }
      
      public function get useTextureCache() : Boolean
      {
         return this._useTextureCache;
      }
      
      public function set isActiveFunction(pFunction:Function) : void
      {
         this._isActiveFunction = pFunction;
      }
      
      public function get isActiveFunction() : Function
      {
         return this._isActiveFunction;
      }
      
      public function refresh() : void
      {
         var customSlotData:ICustomSlotData = null;
         this.finalize();
         if(this._data && this._data.info1 && !this._hideTopLabel)
         {
            this.updateQuantity(int(this._data.info1));
         }
         else
         {
            this.updateQuantity(0);
         }
         if(this._isTimerRunning)
         {
            if(!this._data || this._data.timer == 0)
            {
               this.updateTimer(0);
            }
         }
         else if(this._data && this._data.timer)
         {
            this.updateTimer(this._data.timer);
         }
         if(this._data)
         {
            if(width <= this._widthHeightMax && height <= this._widthHeightMax)
            {
               this._targetUri = this._data.iconUri;
            }
            else
            {
               this._targetUri = this._data.fullSizeIconUri;
            }
         }
         else
         {
            this._targetUri = this._emptyTexture;
         }
         var iconGreyedOut:Boolean = this._data && this._isActiveFunction != null ? !this.isActiveFunction.call(null,this._data) : (!!this._data ? !this._data.active : false);
         this.icon.transform.colorTransform = !!iconGreyedOut ? GraphicContainer.COLOR_TRANSFORM_DISABLED : (!!this._customColorTransform ? this._customColorTransform : GraphicContainer.COLOR_TRANSFORM_DEFAULT);
         this.icon.greyedOut = iconGreyedOut;
         if(this._data is ICustomSlotData)
         {
            customSlotData = this._data as ICustomSlotData;
            if(customSlotData.colorTransform)
            {
               if(iconGreyedOut)
               {
                  this.icon.transform.colorTransform = ColorUtils.mixColorTransforms(customSlotData.colorTransform,GraphicContainer.COLOR_TRANSFORM_DISABLED);
               }
               else
               {
                  this.icon.transform.colorTransform = customSlotData.colorTransform;
               }
            }
            if(customSlotData.size.x >= customSlotData.size.y && customSlotData.size.x >= width)
            {
               this.icon.width = width;
               this.icon.height = width * (customSlotData.size.y / customSlotData.size.x);
               this.icon.x = 0;
               this.icon.y = height - this.icon.height;
            }
            else if(customSlotData.size.y >= customSlotData.size.x && customSlotData.size.y >= height)
            {
               this.icon.width = height * (customSlotData.size.x / customSlotData.size.y);
               this.icon.height = height;
               this.icon.x = (width - this.icon.width) / 2;
               this.icon.y = 0;
            }
            else
            {
               this.icon.width = customSlotData.size.x;
               this.icon.height = customSlotData.size.y;
               this.icon.x = (width - this.icon.width) / 2;
               this.icon.y = height - this.icon.height;
            }
         }
         else
         {
            this.icon.width = width;
            this.icon.height = height;
            this.icon.x = 0;
            this.icon.y = 0;
         }
         this.icon.finalized = true;
         EnterFrameDispatcher.addEventListener(this.loadTargetUri,EnterFrameConst.LOAD_URI_SLOT);
         this.icon.cacheAsBitmap = this.icon.uri && this.icon.uri.tag == NEED_CACHE_AS_BITMAP;
         if(this._backgroundIcon)
         {
            if(this._data && Object(this._data).hasOwnProperty("forcedBackGroundIconUri") && Object(this._data).forcedBackGroundIconUri)
            {
               this._backgroundIcon.uri = Object(this._data).forcedBackGroundIconUri;
            }
            else if(this._forcedBackGroundIconUri)
            {
               this._backgroundIcon.uri = this._forcedBackGroundIconUri;
            }
            else if(this._data && Object(this._data).hasOwnProperty("backGroundIconUri") && Object(this._data).backGroundIconUri)
            {
               this._backgroundIcon.uri = Object(this._data).backGroundIconUri;
            }
            else
            {
               this._backgroundIcon.uri = null;
            }
         }
      }
      
      override public function finalize() : void
      {
         var stateChangingProperties:Array = null;
         if(!this.icon)
         {
            ++_unicID;
            this._icon = new Texture();
            this.icon.useCache = this._useTextureCache;
            if(EmbedIcons.SLOT_DEFAULT_ICON != null)
            {
               this.icon.defaultBitmapData = EmbedIcons.SLOT_DEFAULT_ICON;
            }
            this.icon.name = "tx_slotUnicIcon" + _unicID;
            this.icon.addEventListener(TextureLoadFailedEvent.EVENT_TEXTURE_LOAD_FAILED,this.onSlotTextureFailed);
            this.icon.forceReload = true;
            this.icon.mouseEnabled = false;
            this.icon.width = width;
            this.icon.height = height;
            if(width <= this._widthHeightMax && height <= this._widthHeightMax)
            {
               this._targetUri = !!this._data ? this._data.iconUri : this._emptyTexture;
            }
            else
            {
               this._targetUri = !!this._data ? this._data.fullSizeIconUri : this._emptyTexture;
            }
            this.icon.cacheAsBitmap = this.icon.uri && this.icon.uri.tag == NEED_CACHE_AS_BITMAP;
            this.icon.finalized = this._targetUri == null;
            this.icon.finalize();
            addChild(this.icon);
            EnterFrameDispatcher.addEventListener(this.loadTargetUri,EnterFrameConst.LOAD_URI_SLOT);
         }
         if(!this._tx_timerForeground)
         {
            this._tx_timerForeground = new Texture();
            this._tx_timerForeground.addEventListener(TextureLoadFailedEvent.EVENT_TEXTURE_LOAD_FAILED,this.onSlotTextureFailed);
            this._tx_timerForeground.forceReload = true;
            this._tx_timerForeground.uri = this.timerTexture;
            this._tx_timerForeground.mouseEnabled = false;
            this._tx_timerForeground.width = width;
            this._tx_timerForeground.height = height;
            this._tx_timerForeground.finalized = true;
            this._tx_timerForeground.finalize();
            this._tx_timerForeground.visible = false;
            addChild(this._tx_timerForeground);
         }
         try
         {
            if(!this._backgroundIcon && (this._forcedBackGroundIconUri || this._data && Object(this._data).hasOwnProperty("backGroundIconUri") && Object(this._data).backGroundIconUri))
            {
               this._backgroundIcon = new Texture();
               this._backgroundIcon.mouseEnabled = false;
               this._backgroundIcon.width = width;
               this._backgroundIcon.height = height;
               this._backgroundIcon.uri = !!this._forcedBackGroundIconUri ? this._forcedBackGroundIconUri : Object(this._data).backGroundIconUri;
               this._backgroundIcon.finalized = true;
               this._backgroundIcon.finalize();
               this._backgroundIcon.visible = this._displayBackgroundIcon;
               addChildAt(this._backgroundIcon,0);
            }
         }
         catch(e:Error)
         {
            _log.warn("C\'est mal de pas implémenter les fonction de base sur " + getQualifiedClassName(_data));
         }
         if(this._data && this._data.info1 && !this._hideTopLabel)
         {
            this.updateQuantity(int(this._data.info1));
         }
         if(this._isTimerRunning)
         {
            if(!this._data || this._data.timer == 0)
            {
               this.updateTimer(0);
            }
         }
         else if(this._data && this._data.timer)
         {
            this.updateTimer(this._data.timer);
         }
         if(!this._effect)
         {
            this._effect = new Texture();
            this._effect.mouseEnabled = false;
            this._effect.width = width;
            this._effect.height = height;
            if(this._selected)
            {
               this._effect.uri = this.selectedTexture;
            }
            else if(this._customTexture)
            {
               this._effect.uri = this._customTexture;
            }
            this._effect.finalize();
            this._effect.finalized = true;
            addChild(this._effect);
         }
         if(this._isButton && (!changingStateData || changingStateData.length == 0))
         {
            stateChangingProperties = new Array();
            stateChangingProperties[StatesEnum.STATE_NORMAL] = new Array();
            stateChangingProperties[StatesEnum.STATE_NORMAL][this.icon.name] = new Array();
            stateChangingProperties[StatesEnum.STATE_NORMAL][this.icon.name]["gotoAndStop"] = "normal";
            stateChangingProperties[StatesEnum.STATE_OVER] = new Array();
            stateChangingProperties[StatesEnum.STATE_OVER][this.icon.name] = new Array();
            stateChangingProperties[StatesEnum.STATE_OVER][this.icon.name]["gotoAndStop"] = "over";
            stateChangingProperties[StatesEnum.STATE_CLICKED] = new Array();
            stateChangingProperties[StatesEnum.STATE_CLICKED][this.icon.name] = new Array();
            stateChangingProperties[StatesEnum.STATE_CLICKED][this.icon.name]["gotoAndStop"] = "pressed";
            stateChangingProperties[StatesEnum.STATE_SELECTED] = new Array();
            stateChangingProperties[StatesEnum.STATE_SELECTED][this.icon.name] = new Array();
            stateChangingProperties[StatesEnum.STATE_SELECTED][this.icon.name]["gotoAndStop"] = "selected";
            stateChangingProperties[StatesEnum.STATE_SELECTED_OVER] = new Array();
            stateChangingProperties[StatesEnum.STATE_SELECTED_OVER][this.icon.name] = new Array();
            stateChangingProperties[StatesEnum.STATE_SELECTED_OVER][this.icon.name]["gotoAndStop"] = "selected_over";
            stateChangingProperties[StatesEnum.STATE_SELECTED_CLICKED] = new Array();
            stateChangingProperties[StatesEnum.STATE_SELECTED_CLICKED][this.icon.name] = new Array();
            stateChangingProperties[StatesEnum.STATE_SELECTED_CLICKED][this.icon.name]["gotoAndStop"] = "selected_pressed";
            changingStateData = stateChangingProperties;
         }
         _finalized = true;
         if(getUi())
         {
            getUi().iAmFinalized(this);
         }
      }
      
      public function updateQuantity(num:int) : void
      {
         if(num == 0)
         {
            if(this._quantitySprite && this._quantitySprite.parent)
            {
               removeChild(this._quantitySprite);
            }
            return;
         }
         if(!this._quantitySprite)
         {
            this._quantitySprite = new Sprite();
            this._quantitySprite.mouseChildren = false;
            this._quantitySprite.mouseEnabled = false;
            this._quantityText = new TextField();
            this._quantityText.defaultTextFormat = this._quantityTextFormat;
            this._quantityText.height = 25;
            this._quantityText.x = 1;
            this._quantityText.y = -3;
            this._quantityText.autoSize = TextFieldAutoSize.LEFT;
            this._quantitySprite.addChild(this._quantityText);
         }
         addChild(this._quantitySprite);
         this._quantityText.text = String(num);
         this._quantitySprite.graphics.clear();
         this._quantitySprite.graphics.beginFill(3355443,0.6);
         this._quantitySprite.graphics.drawRoundRectComplex(0,0,this._quantityText.width,18,10,0,0,0);
         this._quantitySprite.graphics.endFill();
      }
      
      private function updateTimer(t:int) : void
      {
         var val:int = 0;
         this._timerMaxDuration = t;
         if(this._timerMaxDuration == 0)
         {
            this._tx_timerForeground.visible = false;
            this._isTimerRunning = false;
            return;
         }
         var currentTime:int = getTimer();
         if(!this._data.endTime)
         {
            this._data.endTime = currentTime + this._timerMaxDuration;
            this._timerStartTime = this._data.startTime;
            this._tx_timerForeground.gotoAndStop = 100;
         }
         else
         {
            this._timerMaxDuration = this._data.endTime - this._data.startTime;
            this._timerStartTime = this._data.startTime;
            val = Math.round((currentTime - this._timerStartTime) / this._timerMaxDuration * 100);
            val = 100 - val;
            this._tx_timerForeground.gotoAndStop = val;
         }
         this._tx_timerForeground.visible = true;
         this._isTimerRunning = true;
         EnterFrameDispatcher.addEventListener(this.onEnterFrame,EnterFrameConst.TIMER_EVENT);
      }
      
      override public function process(msg:Message) : Boolean
      {
         var linkCursor:LinkedCursorData = null;
         var tmpState:uint = 0;
         var listener:IInterfaceListener = null;
         var soundToPLay:String = null;
         var dropTarget:* = undefined;
         var holder:* = undefined;
         var dropTargetHandler:IDragAndDropHandler = null;
         var dragData:SlotDragAndDropData = null;
         var currentHolder:ISlotDataHolder = null;
         var listener2:IInterfaceListener = null;
         var listener3:IInterfaceListener = null;
         if(this._isButton)
         {
            tmpState = 9999;
            if(!super.canProcessMessage(msg))
            {
               return true;
            }
            if(!_disabled)
            {
               switch(true)
               {
                  case msg is MouseDownMessage:
                     _mousePressed = true;
                     break;
                  case msg is MouseDoubleClickMessage:
                  case msg is MouseClickMessage:
                     _mousePressed = false;
                     if(!isMute)
                     {
                        for each(listener in Berilia.getInstance().UISoundListeners)
                        {
                           soundToPLay = super.selectSound();
                           if(int(soundToPLay) != -1)
                           {
                              listener.playUISound(soundToPLay);
                           }
                        }
                     }
                     break;
                  default:
                     super.process(msg);
               }
            }
         }
         switch(true)
         {
            case msg is MouseDownMessage:
               if(ShortcutsFrame.shiftKey)
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseShiftClick,this);
               }
               else if(this._allowDrag)
               {
                  if(!this._data)
                  {
                     return false;
                  }
                  this._dragging = true;
                  stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onDragAndDropStart);
                  this._dragStartPoint = new Point(-MouseDownMessage(msg).mouseEvent.localX,-MouseDownMessage(msg).mouseEvent.localY);
               }
               break;
            case msg is MouseOverMessage:
               if(this._allowDrag)
               {
                  linkCursor = LinkedCursorSpriteManager.getInstance().getItem(DRAG_AND_DROP_CURSOR_NAME);
                  if(linkCursor && linkCursor.data is SlotDragAndDropData && SlotDragAndDropData(linkCursor.data).slotData != this._data)
                  {
                     holder = SlotDragAndDropData(linkCursor.data).currentHolder;
                     if(this.dropValidator != null && this.dropValidator(this,SlotDragAndDropData(linkCursor.data).slotData,holder))
                     {
                        this._effect.uri = this.acceptDragTexture;
                     }
                     else
                     {
                        this._effect.uri = this.refuseDragTexture;
                     }
                  }
                  else if(this._effect != null)
                  {
                     this._effect.uri = this.highlightTexture;
                  }
               }
               else if(this._effect != null)
               {
                  this._effect.uri = this.highlightTexture;
               }
               break;
            case msg is MouseOutMessage:
               if(this._effect)
               {
                  if(this._selected)
                  {
                     this._effect.uri = this.selectedTexture;
                  }
                  else if(this._customTexture)
                  {
                     this._effect.uri = this._customTexture;
                  }
                  else
                  {
                     this._effect.uri = null;
                  }
               }
               break;
            case msg is MouseReleaseOutsideMessage:
               dropTarget = MouseReleaseOutsideMessage(msg).mouseEvent.target;
               linkCursor = LinkedCursorSpriteManager.getInstance().getItem(DRAG_AND_DROP_CURSOR_NAME);
               if(linkCursor && this._dragging && !(dropTarget is ISlotDataHolder))
               {
                  holder = SlotDragAndDropData(linkCursor.data).currentHolder;
                  if(dropTarget.parent is GraphicContainer && dropTarget.parent.getUi().name == "chat")
                  {
                     dropTarget = dropTarget.parent;
                  }
                  switch(true)
                  {
                     case dropTarget is IDragAndDropHandler:
                        if((dropTarget as IDragAndDropHandler).dropValidator != null)
                        {
                           dropTargetHandler = dropTarget as IDragAndDropHandler;
                           dragData = linkCursor.data;
                           currentHolder = null;
                           if(dragData)
                           {
                              currentHolder = dragData.currentHolder;
                           }
                           if(dropTargetHandler.dropValidator(this,this.data,currentHolder))
                           {
                              dropTargetHandler.processDrop(this,this.data,currentHolder);
                           }
                           for each(listener2 in Berilia.getInstance().UISoundListeners)
                           {
                              listener2.playUISound("16053");
                           }
                        }
                        break;
                     case dropTarget is MovieClip:
                     case dropTarget is TextField:
                     case dropTarget is Stage:
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.SlotDropedNorBeriliaNorWorld,holder);
                        break;
                     case getQualifiedClassName(dropTarget.parent).indexOf("com.ankamagames.berilia") >= 0:
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.SlotDropedOnBerilia,holder,dropTarget);
                        break;
                     case Boolean(dropTarget.parent && dropTarget.parent.parent is MapViewer):
                     case Boolean(dropTarget.parent && getQualifiedClassName(dropTarget.parent).indexOf("Dofus") >= 0):
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.SlotDropedNorBeriliaNorWorld,holder,dropTarget);
                        break;
                     default:
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.SlotDropedOnWorld,holder,dropTarget);
                  }
                  LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME,true);
                  if(linkCursor != null)
                  {
                     KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd,SlotDragAndDropData(linkCursor.data).currentHolder,dropTarget);
                  }
               }
               else if(dropTarget is Slot)
               {
                  if((dropTarget as Slot).allowDrag == false)
                  {
                     LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
                     if(linkCursor != null)
                     {
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd,SlotDragAndDropData(linkCursor.data).currentHolder,dropTarget);
                     }
                  }
               }
               this.removeDrag();
               break;
            case msg is MouseClickMessage:
            case msg is MouseDoubleClickMessage:
               linkCursor = LinkedCursorSpriteManager.getInstance().getItem(DRAG_AND_DROP_CURSOR_NAME);
               if(linkCursor && linkCursor.data is SlotDragAndDropData)
               {
                  LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd,SlotDragAndDropData(linkCursor.data).currentHolder,MouseDoubleClickMessage(msg).mouseEvent.target);
               }
               if(this._dragging)
               {
                  this.removeDrag();
               }
               if(ShortcutsFrame.ctrlKey && msg is MouseDoubleClickMessage)
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseCtrlDoubleClick,this);
               }
               else if(ShortcutsFrame.altKey && msg is MouseDoubleClickMessage)
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseAltDoubleClick,this);
               }
               break;
            case msg is MouseUpMessage:
               linkCursor = LinkedCursorSpriteManager.getInstance().getItem(DRAG_AND_DROP_CURSOR_NAME);
               if(linkCursor && linkCursor.data is SlotDragAndDropData)
               {
                  dragData = linkCursor.data;
                  if(dragData.slotData != this._data && this.dropValidator(this,SlotDragAndDropData(linkCursor.data).slotData,dragData.currentHolder))
                  {
                     if(dragData.currentHolder)
                     {
                        dragData.currentHolder.removeDropSource(dragData.currentHolder);
                     }
                     this.processDrop(this,dragData.slotData,dragData.currentHolder);
                     for each(listener3 in Berilia.getInstance().UISoundListeners)
                     {
                        listener3.playUISound("16053");
                     }
                     LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
                  }
                  else
                  {
                     LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
                  }
                  Berilia.getInstance().handler.process(new DropMessage(this,dragData.currentHolder));
                  if(this._allowDrag)
                  {
                     KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd,dragData.currentHolder,MouseUpMessage(msg).mouseEvent.target);
                  }
               }
               if(this._dragging)
               {
                  this.removeDrag();
               }
               break;
            case msg is MouseRightClickOutsideMessage:
               linkCursor = LinkedCursorSpriteManager.getInstance().getItem(DRAG_AND_DROP_CURSOR_NAME);
               if(linkCursor && linkCursor.data is SlotDragAndDropData)
               {
                  LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd,SlotDragAndDropData(linkCursor.data).currentHolder,MouseRightClickOutsideMessage(msg).mouseEvent.target);
               }
               if(this._dragging)
               {
                  this.removeDrag();
               }
         }
         return false;
      }
      
      override public function remove() : void
      {
         if(!__removed)
         {
            this._dropValidator = null;
            this._unboxedDropValidator = null;
            this._removeDropSource = null;
            this._unboxedRemoveDropSource = null;
            this._processDrop = null;
            this._unboxedProcessDrop = null;
            removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
            if(this._topLabel)
            {
               this._topLabel.remove();
            }
            if(this._middleLabel)
            {
               this._middleLabel.remove();
            }
            if(this._bottomLabel)
            {
               this._bottomLabel.remove();
            }
            if(this.icon)
            {
               this.icon.remove();
               this.icon.removeEventListener(TextureLoadFailedEvent.EVENT_TEXTURE_LOAD_FAILED,this.onSlotTextureFailed);
            }
            if(this._effect)
            {
               this._effect.remove();
            }
            if(this._backgroundIcon)
            {
               this._backgroundIcon.remove();
            }
            if(this._tx_timerForeground)
            {
               this._tx_timerForeground.remove();
               this._tx_timerForeground.removeEventListener(TextureLoadFailedEvent.EVENT_TEXTURE_LOAD_FAILED,this.onSlotTextureFailed);
            }
            if(this._data)
            {
               this._data.removeHolder(this);
            }
            this._data = null;
            this._topLabel = null;
            this._middleLabel = null;
            this._bottomLabel = null;
            this._icon = null;
            this._effect = null;
            this._backgroundIcon = null;
            this._tx_timerForeground = null;
            if(parent)
            {
               parent.removeChild(this);
            }
            if(this._quantitySprite)
            {
               if(this._quantitySprite.parent)
               {
                  removeChild(this._quantitySprite);
               }
               this._quantitySprite = null;
            }
         }
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         EnterFrameDispatcher.removeEventListener(this.loadTargetUri);
         if(stage)
         {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragAndDropStart);
         }
         super.remove();
      }
      
      private function removeDrag() : void
      {
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragAndDropStart);
         if(this.icon)
         {
            this.icon.filters = [];
         }
         this._dragStartPoint = null;
         this._dragging = false;
      }
      
      private function emptyFunction(... args) : *
      {
         return null;
      }
      
      private function onEnterFrame(pEvt:Event) : void
      {
         var val:int = 0;
         var currentTime:int = getTimer();
         if(currentTime > this._timerStartTime + this._timerMaxDuration)
         {
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            this._timerMaxDuration = 0;
            this._timerStartTime = 0;
            this._tx_timerForeground.visible = false;
            this._isTimerRunning = false;
            if(this._data)
            {
               this._data.endTime = 0;
            }
         }
         else
         {
            val = Math.round((currentTime - this._timerStartTime) / this._timerMaxDuration * 100);
            val = 100 - val;
            this._tx_timerForeground.gotoAndStop = val;
         }
      }
      
      private function loadTargetUri(e:Event) : void
      {
         EnterFrameDispatcher.removeEventListener(this.loadTargetUri);
         if(this.icon)
         {
            this.icon.uri = this._targetUri;
            this.icon.finalized = true;
         }
         else
         {
            _log.error("Impossible de donner au slot l\'icone : " + this._targetUri);
         }
      }
      
      private function onTweenEnd(e:TweenEvent) : void
      {
         LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
      }
      
      private function onSlotTextureFailed(e:TextureLoadFailedEvent) : void
      {
         if(this._data && this._data.errorIconUri)
         {
            e.behavior.cancel = true;
            if(this.icon.uri != this._data.errorIconUri)
            {
               this.icon.uri = this._data.errorIconUri;
            }
         }
      }
      
      private function onDragAndDropStart(e:Event) : void
      {
         var listener:IInterfaceListener = null;
         var d:LinkedCursorData = null;
         var bd:BitmapData = null;
         var dragData:SlotDragAndDropData = null;
         if(!stage)
         {
            return;
         }
         for each(listener in Berilia.getInstance().UISoundListeners)
         {
            listener.playUISound("16059");
         }
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragAndDropStart);
         d = new LinkedCursorData();
         bd = new BitmapData(width,height,true,0);
         this._effect.visible = false;
         bd.draw(this.icon);
         this._effect.visible = true;
         d.sprite = new DragSprite(bd);
         d.offset = new Point(-bd.width / 2,-bd.height / 2);
         dragData = new SlotDragAndDropData(this,this._data);
         d.data = dragData;
         LinkedCursorSpriteManager.getInstance().addItem(DRAG_AND_DROP_CURSOR_NAME,d);
         KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropStart,this);
      }
      
      private function onAddedToStage(e:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         var ui:Object = getUi();
         if(ui && this.icon)
         {
            ui.registerId(this.icon.name,new GraphicElement(this.icon,null,this.icon.name));
         }
      }
   }
}

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

class DragSprite extends Sprite
{
    
   
   function DragSprite(bitmapData:BitmapData)
   {
      super();
      addChild(new Bitmap(bitmapData));
   }
}
