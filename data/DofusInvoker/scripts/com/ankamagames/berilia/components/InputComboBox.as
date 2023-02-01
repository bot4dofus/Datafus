package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardMessage;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   import flash.ui.Keyboard;
   
   public class InputComboBox extends ComboBox implements FinalizableUIComponent
   {
       
      
      private var _origDataProvider;
      
      public function InputComboBox()
      {
         super();
         _mainContainer = new Input();
         _dataNameField = "";
      }
      
      public function get input() : Input
      {
         if(!_mainContainer)
         {
            return null;
         }
         return _mainContainer as Input;
      }
      
      public function set maxChars(nValue:uint) : void
      {
         (_mainContainer as Input).maxChars = nValue;
      }
      
      public function set restrictChars(sValue:String) : void
      {
         (_mainContainer as Input).restrictChars = sValue;
      }
      
      public function get restrictChars() : String
      {
         return (_mainContainer as Input).restrictChars;
      }
      
      public function set cssClass(c:String) : void
      {
         (_mainContainer as Input).cssClass = c;
      }
      
      public function get cssClass() : String
      {
         return (_mainContainer as Input).cssClass;
      }
      
      [Uri]
      public function get css() : Uri
      {
         return (_mainContainer as Input).css;
      }
      
      [Uri]
      public function set css(sFile:Uri) : void
      {
         (_mainContainer as Input).css = sFile;
      }
      
      override public function get dataProvider() : *
      {
         return _list.dataProvider;
      }
      
      override public function set dataProvider(data:*) : void
      {
         this._origDataProvider = data;
         super.dataProvider = data;
         if(!this._origDataProvider || this._origDataProvider.length == 0)
         {
            this.showList(false);
            _button.visible = false;
         }
         else
         {
            _button.visible = true;
         }
      }
      
      override public function finalize() : void
      {
         if(_bgTexture is TextureBitmap && !_bgTexture.finalized)
         {
            return;
         }
         finalizeBaseComponents();
         _button.visible = false;
         _mainContainer.x = _list.x;
         _mainContainer.width = _list.width - _bgTexture.width;
         _mainContainer.height = !!mainContainerHeight ? Number(mainContainerHeight) : Number(_list.slotHeight);
         if(autoCenter)
         {
            _mainContainer.y = (height - _mainContainer.height) / 2;
         }
         addChild(_mainContainer);
         _finalized = true;
         getUi().iAmFinalized(this);
      }
      
      override public function process(msg:Message) : Boolean
      {
         var keyCode:uint = 0;
         var index:int = 0;
         var inputText:String = null;
         var entry:String = null;
         var searchDataProvider:Array = null;
         var selectedData:* = undefined;
         switch(true)
         {
            case msg is KeyboardKeyUpMessage:
               keyCode = KeyboardMessage(msg).keyboardEvent.keyCode;
               if(keyCode == Keyboard.ENTER)
               {
                  if(_list.visible)
                  {
                     index = _list.selectedIndex;
                     _list.setSelectedIndex(index,SelectMethodEnum.AUTO);
                     this.input.text = _list.selectedItem;
                     this.input.setSelection(this.input.text.length,this.input.text.length);
                     this.showList(false);
                     return true;
                  }
               }
               else if(keyCode == Keyboard.TAB)
               {
                  this.showList(false);
               }
               else if(handleKey(keyCode) && FocusHandler.getInstance().getFocus() == this.input.textfield)
               {
                  inputText = this.cleanString(this.input.text);
                  if(inputText != "")
                  {
                     if(_dpString.indexOf(inputText) == -1)
                     {
                        this.showList(false);
                     }
                     else
                     {
                        searchDataProvider = new Array();
                        for each(entry in this._origDataProvider)
                        {
                           if(entry.indexOf(inputText) == 0)
                           {
                              searchDataProvider.push(entry);
                           }
                        }
                        super.dataProvider = searchDataProvider;
                        if(!_list.visible)
                        {
                           super.showList(true);
                        }
                     }
                  }
                  else if(inputText != "\b" && this._origDataProvider && this._origDataProvider.length > 0)
                  {
                     this.showList(true);
                  }
               }
               break;
            case msg is SelectItemMessage:
               switch(SelectItemMessage(msg).selectMethod)
               {
                  case SelectMethodEnum.CLICK:
                     selectedData = _list.selectedItem;
                     if(!(selectedData is String) && selectedData != null)
                     {
                        selectedData = selectedData[_dataNameField];
                     }
                     (_mainContainer as Input).text = selectedData;
                     if(closeOnClick)
                     {
                        this.showList(false);
                     }
                     break;
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
            default:
               super.process(msg);
         }
         return false;
      }
      
      override protected function showList(show:Boolean) : void
      {
         super.dataProvider = this._origDataProvider;
         super.showList(show);
      }
      
      override protected function cleanString(spaced:String) : String
      {
         var unwantedChar:RegExp = /\b/g;
         if(spaced.search(unwantedChar) != -1)
         {
            return "";
         }
         return spaced;
      }
   }
}
