package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.components.gridRenderer.LabelGridRenderer;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.berilia.types.event.TextureLoadFailedEvent;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.GraphicElement;
   import com.ankamagames.berilia.types.graphic.InternalComponentAccess;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.interfaces.IInterfaceListener;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.display.DisplayObject;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class ComboBox extends GraphicContainer implements FinalizableUIComponent
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const SEARCH_DELAY:int = 400;
       
      
      protected var _list:ComboBoxGrid;
      
      protected var _button:ButtonContainer;
      
      protected var _mainContainer:DisplayObject;
      
      protected var _bgTexture:TextureBase;
      
      protected var _listTexture:Texture;
      
      protected var _isIcon:Boolean = false;
      
      protected var _labelCssPath:String = null;
      
      protected var _useKeyboard:Boolean = true;
      
      protected var _closeOnClick:Boolean = true;
      
      protected var _maxListSize:uint = 300;
      
      protected var _slotWidth:uint;
      
      protected var _slotHeight:uint;
      
      protected var _previousState:Boolean = false;
      
      protected var _dataNameField:String = "label";
      
      protected var _dpString:String;
      
      protected var _separator:String = ";";
      
      protected var _lastKeyCode:uint;
      
      protected var _lastSearchTime:int;
      
      protected var _searchString:String;
      
      protected var _searchStringIndex:int;
      
      protected var _listWidth:Number;
      
      public var autoCenter:Boolean = true;
      
      public var mainContainerHeight:Number = 0;
      
      public function ComboBox()
      {
         super();
         this._button = new ButtonContainer();
         this._button.soundId = "0";
         this._listTexture = new Texture();
         this._list = new ComboBoxGrid();
         this.showList(false);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         StageShareManager.stage.nativeWindow.addEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         MEMORY_LOG[this] = 1;
      }
      
      public function set buttonTexture(tx:String) : void
      {
         if(tx.toLowerCase().indexOf(".swf") != -1)
         {
            if(!this._bgTexture)
            {
               this._bgTexture = new Texture();
            }
            (this._bgTexture as Texture).uri = new Uri(tx);
         }
         else if(tx is String)
         {
            if(!this._bgTexture)
            {
               this._bgTexture = new TextureBitmap();
               (this._bgTexture as TextureBitmap).smooth = true;
            }
            (this._bgTexture as TextureBitmap).themeDataId = tx + "_normal";
            if((this._bgTexture as TextureBitmap).themeDataId == null)
            {
               (this._bgTexture as TextureBitmap).finalize();
               (this._bgTexture as TextureBitmap).drawErrorTexture();
               if(_finalized)
               {
                  this.finalize();
               }
               return;
            }
            if(!this._bgTexture.finalized)
            {
               this._bgTexture.addEventListener(Event.COMPLETE,this.onLoaded);
               this._bgTexture.addEventListener(TextureLoadFailedEvent.EVENT_TEXTURE_LOAD_FAILED,this.onLoaded);
            }
            else if(_finalized)
            {
               this.finalize();
            }
         }
      }
      
      private function onLoaded(event:Event) : void
      {
         this._bgTexture.removeEventListener(Event.COMPLETE,this.onLoaded);
         this._bgTexture.removeEventListener(TextureLoadFailedEvent.EVENT_TEXTURE_LOAD_FAILED,this.onLoaded);
         this.finalize();
      }
      
      public function get buttonTexture() : *
      {
         if(this._bgTexture is Texture)
         {
            return (this._bgTexture as Texture).uri;
         }
         var themeDataId:String = (this._bgTexture as TextureBitmap).themeDataId;
         return themeDataId.substring(0,themeDataId.lastIndexOf("_"));
      }
      
      [Uri]
      public function set listTexture(uri:Uri) : void
      {
         this._listTexture.uri = uri;
      }
      
      [Uri]
      public function get listTexture() : Uri
      {
         return this._listTexture.uri;
      }
      
      public function set listWidth(v:Number) : void
      {
         this._listWidth = v;
      }
      
      public function get listWidth() : Number
      {
         return this._listWidth;
      }
      
      public function get maxHeight() : uint
      {
         return this._maxListSize;
      }
      
      public function set maxHeight(v:uint) : void
      {
         this._maxListSize = v;
      }
      
      public function get slotWidth() : uint
      {
         return this._slotWidth;
      }
      
      public function set slotWidth(value:uint) : void
      {
         this._slotWidth = value;
         if(finalized)
         {
            this.finalize();
         }
      }
      
      public function get slotHeight() : uint
      {
         return this._slotHeight;
      }
      
      public function set slotHeight(value:uint) : void
      {
         this._slotHeight = value;
         if(finalized)
         {
            this.finalize();
         }
      }
      
      public function set dataProvider(data:*) : void
      {
         var nbSlot:uint = this._maxListSize / this._list.slotHeight;
         this._list.finalized = false;
         if(isNaN(this._listWidth) || this._listWidth <= 0)
         {
            this._listWidth = width;
         }
         if(data)
         {
            if(data.length > nbSlot)
            {
               this._list.width = this._listWidth;
               this._list.height = this._maxListSize;
               this._list.slotWidth = !!this.slotWidth ? uint(this.slotWidth - this._list.scrollBarSize) : uint(this._list.width - this._list.scrollBarSize);
            }
            else
            {
               this._list.width = this._listWidth;
               this._list.height = this._list.slotHeight * data.length;
               this._list.slotWidth = !!this.slotWidth ? uint(this.slotWidth) : uint(this._list.width);
            }
         }
         else
         {
            this._list.width = this._listWidth;
            this._list.height = this._list.slotHeight;
            this._list.slotWidth = !!this.slotWidth ? uint(this.slotWidth) : uint(this._list.width);
         }
         this._listTexture.height = this._list.height;
         this._listTexture.width = this._list.width;
         this._list.dataProvider = data;
         if(this._list.renderer is LabelGridRenderer)
         {
            (this._list.renderer as LabelGridRenderer).isIcon = this._isIcon;
            this.setButtonLabel();
         }
         this._dpString = this.getDpString();
      }
      
      public function get dataProvider() : *
      {
         return this._list.dataProvider;
      }
      
      [Uri]
      public function set scrollBarCss(uri:Uri) : void
      {
         this._list.verticalScrollbarCss = uri;
      }
      
      [Uri]
      public function get scrollBarCss() : Uri
      {
         return this._list.verticalScrollbarCss;
      }
      
      public function set rendererName(name:String) : void
      {
         this._list.rendererName = name;
      }
      
      public function get rendererName() : String
      {
         return this._list.rendererName;
      }
      
      public function set rendererArgs(args:String) : void
      {
         this._list.rendererArgs = args;
      }
      
      public function get rendererArgs() : String
      {
         return this._list.rendererArgs;
      }
      
      public function get value() : *
      {
         return this._list.selectedItem;
      }
      
      public function set value(o:*) : void
      {
         this._list.selectedItem = o;
      }
      
      public function set autoSelect(b:Boolean) : void
      {
         this._list.autoSelect = b;
      }
      
      public function get autoSelect() : Boolean
      {
         return this._list.autoSelect;
      }
      
      public function set autoSelectMode(n:int) : void
      {
         this._list.autoSelectMode = n;
      }
      
      public function get autoSelectMode() : int
      {
         return this._list.autoSelectMode;
      }
      
      public function set isIcon(b:Boolean) : void
      {
         this._isIcon = b;
         if(this._list.renderer is LabelGridRenderer)
         {
            (this._list.renderer as LabelGridRenderer).isIcon = this._isIcon;
         }
      }
      
      public function set labelCss(labelCssPath:String) : void
      {
         this._labelCssPath = labelCssPath;
      }
      
      public function set useKeyboard(b:Boolean) : void
      {
         this._useKeyboard = b;
      }
      
      public function get useKeyboard() : Boolean
      {
         return this._useKeyboard;
      }
      
      public function set closeOnClick(b:Boolean) : void
      {
         this._closeOnClick = b;
      }
      
      public function get closeOnClick() : Boolean
      {
         return this._closeOnClick;
      }
      
      public function set selectedItem(v:Object) : void
      {
         this._list.selectedItem = v;
      }
      
      public function get selectedItem() : Object
      {
         return this._list.selectedItem;
      }
      
      public function get selectedIndex() : uint
      {
         return this._list.selectedIndex;
      }
      
      public function set selectedIndex(v:uint) : void
      {
         this._list.selectedIndex = v;
      }
      
      public function get container() : *
      {
         return this._mainContainer;
      }
      
      public function set dataNameField(value:String) : void
      {
         this._dataNameField = value;
         this._dpString = this.getDpString();
      }
      
      public function renderModificator(childs:Array, accessKey:Object) : Array
      {
         if(accessKey != SecureCenter.ACCESS_KEY)
         {
            throw new IllegalOperationError();
         }
         this._list.rendererName = !!this._list.rendererName ? this._list.rendererName : "LabelGridRenderer";
         this._list.rendererArgs = !!this._list.rendererArgs ? this._list.rendererArgs : ",0xFFFFFF,0xEEEEFF,0xC0E272,0x99D321";
         this._list.width = width;
         this._list.slotWidth = !!this.slotWidth ? uint(this.slotWidth) : uint(this._list.width);
         this._list.slotHeight = !!this.slotHeight ? uint(this.slotHeight) : uint(height - 4);
         InternalComponentAccess.setProperty(this._list,"_uiRootContainer",InternalComponentAccess.getProperty(this,"_uiRootContainer"));
         return this._list.renderModificator(childs,accessKey);
      }
      
      override public function finalize() : void
      {
         if(this._bgTexture is TextureBitmap && !this._bgTexture.finalized)
         {
            return;
         }
         this.finalizeBaseComponents();
         if(this._list.renderer is LabelGridRenderer)
         {
            (this._list.renderer as LabelGridRenderer).buttonWidth = this._bgTexture.width;
            (this._list.renderer as LabelGridRenderer).isIcon = this._isIcon;
         }
         this._mainContainer = this._list.renderer.render(null,0,false);
         this._mainContainer.height = !!this.mainContainerHeight ? Number(this.mainContainerHeight) : Number(this._list.slotHeight);
         this._mainContainer.x = this._list.x;
         if(this.autoCenter)
         {
            this._mainContainer.y = (height - this._mainContainer.height) / 2;
         }
         this._button.addChild(this._mainContainer);
         this.setButtonLabel();
         super.finalize();
         _finalized = true;
         getUi().iAmFinalized(this);
      }
      
      protected function finalizeBaseComponents() : void
      {
         var ui:UiRootContainer = getUi();
         if(!ui.getElementById(this._bgTexture.name))
         {
            ui.registerId(this._bgTexture.name,new GraphicElement(this._bgTexture,null,this._bgTexture.name));
         }
         this._button.width = width;
         this._button.height = height;
         this._bgTexture.finalized = false;
         if(this._bgTexture is TextureBitmap)
         {
            this._bgTexture.x = width - this._bgTexture.width;
            this._bgTexture.y = Math.ceil(height - this._bgTexture.height) / 2 + 1;
         }
         else if(this._bgTexture is Texture)
         {
            this._bgTexture.width = width;
            this._bgTexture.height = height;
            (this._bgTexture as Texture).autoGrid = true;
         }
         this._bgTexture.finalize();
         this._button.addChildAt(this._bgTexture,0);
         var stateChangingProperties:Array = new Array();
         stateChangingProperties[StatesEnum.STATE_OVER] = new Array();
         stateChangingProperties[StatesEnum.STATE_OVER][this._bgTexture.name] = new Array();
         if(this._bgTexture is TextureBitmap)
         {
            if(this._bgTexture.themeDataId)
            {
               stateChangingProperties[StatesEnum.STATE_OVER][this._bgTexture.name]["themeDataId"] = this._bgTexture.themeDataId.replace("_normal","_" + StatesEnum.STATE_OVER_STRING.toLocaleLowerCase());
            }
         }
         else
         {
            stateChangingProperties[StatesEnum.STATE_OVER][this._bgTexture.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
         }
         stateChangingProperties[StatesEnum.STATE_CLICKED] = new Array();
         stateChangingProperties[StatesEnum.STATE_CLICKED][this._bgTexture.name] = new Array();
         if(this._bgTexture is TextureBitmap)
         {
            if(this._bgTexture.themeDataId)
            {
               stateChangingProperties[StatesEnum.STATE_CLICKED][this._bgTexture.name]["themeDataId"] = this._bgTexture.themeDataId.replace("_normal","_" + StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase());
            }
         }
         else
         {
            stateChangingProperties[StatesEnum.STATE_CLICKED][this._bgTexture.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
         }
         stateChangingProperties[StatesEnum.STATE_SELECTED] = new Array();
         stateChangingProperties[StatesEnum.STATE_SELECTED][this._bgTexture.name] = new Array();
         stateChangingProperties[StatesEnum.STATE_SELECTED][this._bgTexture.name]["scaleY"] = -1;
         stateChangingProperties[StatesEnum.STATE_SELECTED][this._bgTexture.name]["y"] = this._bgTexture.y + this._bgTexture.height;
         if(this._bgTexture is TextureBitmap)
         {
            if(this._bgTexture.themeDataId)
            {
               stateChangingProperties[StatesEnum.STATE_SELECTED][this._bgTexture.name]["themeDataId"] = this._bgTexture.themeDataId.replace("_normal","_" + StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase());
            }
         }
         else
         {
            stateChangingProperties[StatesEnum.STATE_SELECTED][this._bgTexture.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
         }
         this._button.lockedProperties = "x,width,height,selected,greyedOut";
         this._button.changingStateData = stateChangingProperties;
         this._button.name = "btn_" + name;
         this._button.finalize();
         this._list.name = "grid_" + name;
         this._list.width = width;
         this._list.slotWidth = !!this.slotWidth ? uint(this.slotWidth) : uint(this._list.width);
         this._list.slotHeight = !!this.slotHeight ? uint(this.slotHeight) : uint(height - 4);
         this._list.y = height + 2;
         this._list.finalize();
         this._listTexture.width = this._list.width;
         this._listTexture.autoGrid = true;
         this._listTexture.y = height + 2;
         this._listTexture.finalize();
         addChild(this._button);
         addChild(this._listTexture);
         addChild(this._list);
         this._listTexture.mouseEnabled = true;
         this._list.mouseEnabled = false;
      }
      
      override public function process(msg:Message) : Boolean
      {
         var input:TextField = null;
         var kkdmsg:KeyboardKeyDownMessage = null;
         var kkumsg:KeyboardKeyUpMessage = null;
         var kbmsg:KeyboardMessage = null;
         var char:String = null;
         var timeElapsed:int = 0;
         switch(true)
         {
            case msg is MouseReleaseOutsideMessage:
               this.showList(false);
               break;
            case msg is SelectItemMessage:
               this._list.renderer.update(this._list.selectedItem,0,this._mainContainer,true);
               switch(SelectItemMessage(msg).selectMethod)
               {
                  case SelectMethodEnum.UP_ARROW:
                  case SelectMethodEnum.DOWN_ARROW:
                  case SelectMethodEnum.RIGHT_ARROW:
                  case SelectMethodEnum.LEFT_ARROW:
                  case SelectMethodEnum.SEARCH:
                  case SelectMethodEnum.AUTO:
                  case SelectMethodEnum.MANUAL:
                  case SelectMethodEnum.FIRST_ITEM:
                  case SelectMethodEnum.LAST_ITEM:
                     break;
                  default:
                     this.showList(false);
               }
               break;
            case msg is MouseDownMessage:
               if(!this._list.visible)
               {
                  if(this._list.dataProvider && this._list.dataProvider.length > 0 || MouseDownMessage(msg).target == this._button)
                  {
                     this.showList(true);
                     this._list.moveTo(this._list.selectedIndex);
                  }
               }
               else if(MouseDownMessage(msg).target == this._button)
               {
                  this.showList(false);
               }
               break;
            case msg is MouseWheelMessage:
               if(this._list.visible)
               {
                  this._list.process(msg);
               }
               else
               {
                  this._list.setSelectedIndex(this._list.selectedIndex + MouseWheelMessage(msg).mouseEvent.delta / Math.abs(MouseWheelMessage(msg).mouseEvent.delta) * -1,SelectMethodEnum.WHEEL);
               }
               return true;
            case msg is KeyboardKeyDownMessage:
               input = FocusHandler.getInstance().getFocus() as TextField;
               kkdmsg = msg as KeyboardKeyDownMessage;
               if(kkdmsg.keyboardEvent.keyCode == Keyboard.ESCAPE)
               {
                  this.focusLost();
                  getParent().focus();
                  return true;
               }
               if(this._list.visible && (!input || input.type != TextFieldType.INPUT) && this.handleKey(kkdmsg.keyboardEvent.keyCode))
               {
                  char = String.fromCharCode(kkdmsg.keyboardEvent.charCode).toLowerCase();
                  timeElapsed = !!this._lastSearchTime ? int(getTimer() - this._lastSearchTime) : 0;
                  if(!this._lastKeyCode || this._searchStringIndex == -1 || kkdmsg.keyboardEvent.keyCode != this._lastKeyCode && timeElapsed > SEARCH_DELAY)
                  {
                     this._searchString = char;
                     this.search(this._searchString);
                  }
                  else if(this._searchString.length == 1 && kkdmsg.keyboardEvent.keyCode == this._lastKeyCode)
                  {
                     this.search(this._separator + char,this._searchStringIndex + 1);
                     if(this._searchStringIndex == -1)
                     {
                        this.search(this._searchString);
                     }
                  }
                  else
                  {
                     this._searchString += char;
                     this.search(this._searchString);
                  }
                  this._lastKeyCode = kkdmsg.keyboardEvent.keyCode;
                  this._lastSearchTime = getTimer();
                  return true;
               }
            case msg is KeyboardKeyUpMessage:
               kkumsg = msg as KeyboardKeyUpMessage;
               if(kkumsg && this.handleKey(kkumsg.keyboardEvent.keyCode))
               {
                  return true;
               }
            case msg is KeyboardMessage:
               kbmsg = msg as KeyboardMessage;
               if(!this._useKeyboard)
               {
                  break;
               }
               switch(kbmsg.keyboardEvent.keyCode)
               {
                  case Keyboard.PAGE_UP:
                  case Keyboard.HOME:
                     this._list.setSelectedIndex(0,SelectMethodEnum.FIRST_ITEM);
                     this._list.moveTo(this._list.selectedIndex);
                     return true;
                  case Keyboard.PAGE_DOWN:
                  case Keyboard.END:
                     this._list.setSelectedIndex(this._list.dataProvider.length - 1,SelectMethodEnum.LAST_ITEM);
                     this._list.moveTo(this._list.selectedIndex);
                     return true;
                  default:
                     return this._list.process(msg);
               }
         }
         return false;
      }
      
      override public function remove() : void
      {
         StageShareManager.stage.nativeWindow.removeEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         if(!__removed)
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
            StageShareManager.stage.removeEventListener(MouseEvent.CLICK,this.onClick);
            this._listTexture.remove();
            this._list.remove();
            this._button.remove();
            this._list.renderer.remove(this._mainContainer);
            SecureCenter.destroy(this._mainContainer);
            SecureCenter.destroy(this._list);
            if(this._bgTexture)
            {
               if(this._bgTexture.hasEventListener(Event.COMPLETE))
               {
                  this._bgTexture.removeEventListener(Event.COMPLETE,this.onLoaded);
               }
               if(this._bgTexture.hasEventListener(TextureLoadFailedEvent.EVENT_TEXTURE_LOAD_FAILED))
               {
                  this._bgTexture.removeEventListener(TextureLoadFailedEvent.EVENT_TEXTURE_LOAD_FAILED,this.onLoaded);
               }
               this._bgTexture.remove();
            }
            this._bgTexture = null;
            this._list = null;
            this._button = null;
            this._mainContainer = null;
            this._listTexture = null;
         }
         super.remove();
      }
      
      private function search(pSearchStr:String, pStartIndex:int = 0) : void
      {
         this._searchStringIndex = this._dpString.indexOf(pSearchStr,pStartIndex);
         if(pSearchStr.indexOf(this._separator) == -1 && this._searchStringIndex != 0)
         {
            this._searchStringIndex = this._dpString.indexOf(this._separator + this._searchString);
         }
         if(this._searchStringIndex != -1)
         {
            this._list.setSelectedIndex(this.getItemIndex(this._searchStringIndex == 0 ? int(this._searchStringIndex) : int(this._searchStringIndex + 1)),SelectMethodEnum.SEARCH);
         }
      }
      
      private function getItemIndex(pDpStringIndex:int) : int
      {
         var itemIndex:int = 0;
         var tmpIndex:int = 0;
         var startIndex:int = 0;
         var tmpStr:String = this._dpString.substring(0,pDpStringIndex);
         var strLen:int = tmpStr.length;
         var i:int = 0;
         for(i = 0; i < strLen; i++)
         {
            startIndex = tmpIndex == 0 ? 0 : int(tmpIndex + 1);
            if(startIndex == strLen || tmpIndex == -1)
            {
               break;
            }
            tmpIndex = tmpStr.indexOf(this._separator,startIndex);
            if(tmpIndex != -1)
            {
               itemIndex++;
            }
         }
         return itemIndex;
      }
      
      private function getDpString() : String
      {
         var i:int = 0;
         var itemValue:String = null;
         var dpString:String = "";
         var len:int = this._list.dataProvider.length;
         for(i = 0; i < len; i++)
         {
            itemValue = this._dataNameField && this._dataNameField.length > 0 && this._list.dataProvider[i].hasOwnProperty(this._dataNameField) ? this._list.dataProvider[i][this._dataNameField] : this._list.dataProvider[i];
            dpString += (i > 0 ? this._separator : "") + this.cleanString(itemValue.toLowerCase());
         }
         return dpString;
      }
      
      protected function handleKey(pKeyCode:uint) : Boolean
      {
         return pKeyCode != Keyboard.DOWN && pKeyCode != Keyboard.UP && pKeyCode != Keyboard.LEFT && pKeyCode != Keyboard.RIGHT && pKeyCode != Keyboard.ENTER && pKeyCode != Keyboard.PAGE_UP && pKeyCode != Keyboard.PAGE_DOWN && pKeyCode != Keyboard.HOME && pKeyCode != Keyboard.END;
      }
      
      protected function showList(show:Boolean) : void
      {
         var listener:IInterfaceListener = null;
         var listener2:IInterfaceListener = null;
         if(this._previousState != show)
         {
            if(show)
            {
               for each(listener in Berilia.getInstance().UISoundListeners)
               {
                  listener.playUISound("16012");
               }
            }
            else
            {
               for each(listener2 in Berilia.getInstance().UISoundListeners)
               {
                  listener2.playUISound("16013");
               }
            }
         }
         this._button.selected = show;
         this._listTexture.visible = show;
         this._list.visible = show;
         this._previousState = show;
      }
      
      private function setButtonLabel() : void
      {
         var container:GraphicContainer = null;
         var buttonLabel:Label = null;
         var buttonIcon:Texture = null;
         if(this._list.renderer is LabelGridRenderer && this._button !== null && this._button.numChildren > 0)
         {
            container = this._button.getChildAt(this._button.numChildren - 1) as GraphicContainer;
            if(container !== null && container.numChildren > 0)
            {
               buttonLabel = container.getChildAt(0) as Label;
               if((this._list.renderer as LabelGridRenderer).isIcon && buttonLabel !== null && container.numChildren > 1)
               {
                  buttonIcon = container.getChildAt(1) as Texture;
                  container.y = 0;
                  if(buttonIcon !== null)
                  {
                     buttonLabel.x = LabelGridRenderer.getLabelOffset(buttonIcon,this._list.dataProvider[this._list.selectedIndex]);
                  }
               }
               else if(buttonLabel !== null)
               {
                  buttonLabel.y = -2;
               }
               if(buttonLabel !== null && this._labelCssPath)
               {
                  buttonLabel.css = new Uri(this._labelCssPath);
               }
            }
         }
      }
      
      protected function cleanString(spaced:String) : String
      {
         var regSpace:RegExp = /\s/g;
         var numberSeparator:String = " ";
         var pattern1:RegExp = new RegExp(regSpace);
         var tempString:String = spaced.replace(pattern1,"");
         tempString = tempString.replace(numberSeparator,"");
         return StringUtils.noAccent(tempString);
      }
      
      private function focusLost() : void
      {
         this.showList(false);
      }
      
      private function onWindowDeactivate(pEvent:Event) : void
      {
         this.focusLost();
      }
      
      private function onClick(e:MouseEvent) : void
      {
         var p:DisplayObject = DisplayObject(e.target);
         while(p.parent)
         {
            if(p == this)
            {
               return;
            }
            p = p.parent;
         }
         this.focusLost();
      }
      
      private function onAddedToStage(e:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         StageShareManager.stage.addEventListener(MouseEvent.CLICK,this.onClick);
      }
   }
}
