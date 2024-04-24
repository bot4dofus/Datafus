package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.components.messages.ChangeMessage;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.TextEvent;
   import flash.text.TextFieldType;
   import flash.ui.Keyboard;
   
   public class TextAreaInput extends TextArea implements FinalizableUIComponent
   {
      
      private static const UNDO_MAX_SIZE:uint = 10;
       
      
      private var _nMaxChars:int;
      
      private var _sRestrictChars:String;
      
      private var _bNumberAutoFormat:Boolean = false;
      
      private var _nSelectionStart:int;
      
      private var _nSelectionEnd:int;
      
      private var _isNumericInput:Boolean;
      
      private var _lastTextOnInput:String;
      
      private var _sendingText:Boolean;
      
      private var _chatHistoryText:Boolean;
      
      private var _inputHistory:Vector.<InputEntry>;
      
      private var _historyEntryHyperlinkCodes:Vector.<String>;
      
      private var _currentHyperlinkCodes:Vector.<String>;
      
      private var _historyCurrentIndex:int;
      
      private var _undoing:Boolean;
      
      private var _redoing:Boolean;
      
      private var _deleting:Boolean;
      
      private var _scrollBeforeChange:int;
      
      private var _placeholderText:String;
      
      public var focusEventHandlerPriority:Boolean = true;
      
      public function TextAreaInput()
      {
         super();
         _tText.selectable = true;
         _tText.type = TextFieldType.INPUT;
         _tText.maxChars = this._nMaxChars;
         _tText.restrict = this._sRestrictChars;
         _tText.mouseEnabled = true;
         _tText.multiline = true;
         _tText.wordWrap = true;
         _tText.addEventListener(Event.CHANGE,this.onTextChange);
         _tText.addEventListener(TextEvent.TEXT_INPUT,this.onTextInput);
         _tText.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         _tText.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,1,true);
         this._inputHistory = new Vector.<InputEntry>(0);
         this._currentHyperlinkCodes = new Vector.<String>(0);
      }
      
      public function get lastTextOnInput() : String
      {
         return this._lastTextOnInput;
      }
      
      public function get maxChars() : uint
      {
         return this._nMaxChars;
      }
      
      public function set maxChars(nValue:uint) : void
      {
         this._nMaxChars = nValue;
         _tText.maxChars = this._nMaxChars;
      }
      
      public function get restrictChars() : String
      {
         return this._sRestrictChars;
      }
      
      public function set restrictChars(sValue:String) : void
      {
         this._sRestrictChars = sValue;
         _tText.restrict = this._sRestrictChars;
         this._isNumericInput = this._sRestrictChars == "0-9" || this._sRestrictChars == "0-9  ";
      }
      
      public function get haveFocus() : Boolean
      {
         return Berilia.getInstance().docMain.stage.focus == _tText;
      }
      
      override public function set text(sValue:String) : void
      {
         this.removePlaceholderText();
         this._lastTextOnInput = null;
         super.text = sValue;
         _tText.text = sValue;
         this.onTextChange(null);
      }
      
      override public function appendText(sTxt:String, style:String = null) : void
      {
         super.appendText(sTxt,style);
         this.checkClearHistory();
         this._undoing = this._redoing = this._deleting = this._chatHistoryText = false;
         this.onTextChange(null);
      }
      
      public function get placeholderText() : String
      {
         return this._placeholderText;
      }
      
      public function set placeholderText(sValue:String) : void
      {
         this._placeholderText = sValue;
         this.text = this._placeholderText;
         this.alpha = 0.5;
      }
      
      public function get placeholderActivated() : Boolean
      {
         return this.alpha == 0.5;
      }
      
      override public function remove() : void
      {
         _tText.removeEventListener(Event.CHANGE,this.onTextChange);
         _tText.removeEventListener(TextEvent.TEXT_INPUT,this.onTextInput);
         _tText.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         _tText.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this._inputHistory.length = 0;
         this._currentHyperlinkCodes.length = 0;
         super.remove();
      }
      
      override public function free() : void
      {
         super.free();
      }
      
      private function undo() : void
      {
         if(this._deleting && _tText.text.length == 0)
         {
            this._inputHistory.pop();
         }
         if(this._chatHistoryText)
         {
            return;
         }
         if(this._inputHistory.length > 0)
         {
            if(!this._undoing && !this._redoing)
            {
               this._historyCurrentIndex = this._inputHistory.length - 1;
            }
            else
            {
               if(this._historyCurrentIndex <= 0)
               {
                  this._historyCurrentIndex = -1;
                  _tText.text = !!this._isNumericInput ? "0" : "";
                  this._historyEntryHyperlinkCodes = null;
                  this._undoing = true;
                  this._redoing = false;
                  this._deleting = false;
                  this.onTextChange(null);
                  return;
               }
               --this._historyCurrentIndex;
            }
            if(this._historyCurrentIndex + 1 > this._inputHistory.length - 1 && !this.wasHistoryText())
            {
               this.addHistory(_tText.text);
            }
            _tText.text = this._inputHistory[this._historyCurrentIndex].text;
            this._historyEntryHyperlinkCodes = this._inputHistory[this._historyCurrentIndex].hyperlinkCodes;
            this._currentHyperlinkCodes.length = 0;
         }
         else
         {
            if(_tText.text.length > 0)
            {
               this.addHistory(_tText.text);
            }
            this._historyCurrentIndex = -1;
            _tText.text = !!this._isNumericInput ? "0" : "";
            this._historyEntryHyperlinkCodes = null;
         }
         caretIndex = -1;
         this._undoing = true;
         this._redoing = false;
         this._deleting = false;
         this.onTextChange(null);
      }
      
      private function redo() : void
      {
         if(this._chatHistoryText)
         {
            return;
         }
         if(this._inputHistory.length > 0 && this._historyCurrentIndex < this._inputHistory.length - 1)
         {
            _tText.text = this._inputHistory[++this._historyCurrentIndex].text;
            this._historyEntryHyperlinkCodes = this._inputHistory[this._historyCurrentIndex].hyperlinkCodes;
            this._currentHyperlinkCodes.length = 0;
            caretIndex = -1;
            this._redoing = true;
            this._undoing = false;
            this._deleting = false;
            this.onTextChange(null);
         }
      }
      
      private function addHistory(pText:String) : void
      {
         if(pText == this._placeholderText)
         {
            return;
         }
         var hyperlinkCodes:Vector.<String> = this.getHyperLinkCodes();
         var entry:InputEntry = new InputEntry(pText,hyperlinkCodes);
         if(this._inputHistory.length < UNDO_MAX_SIZE)
         {
            this._inputHistory.push(entry);
         }
         else
         {
            this._inputHistory.shift();
            this._inputHistory.push(entry);
            if(this._historyCurrentIndex > 0)
            {
               --this._historyCurrentIndex;
            }
         }
         this._historyEntryHyperlinkCodes = null;
         this._currentHyperlinkCodes.length = 0;
      }
      
      private function checkClearHistory() : Boolean
      {
         var nextIndex:int = 0;
         if((this._undoing || this._redoing) && this.wasHistoryText())
         {
            nextIndex = this._historyCurrentIndex + 1;
            this._inputHistory.splice(nextIndex,this._inputHistory.length - nextIndex);
            this._historyCurrentIndex = this._inputHistory.length - 1;
            return true;
         }
         return false;
      }
      
      private function wasHistoryText() : Boolean
      {
         return this._inputHistory.length > 0 && (this._historyCurrentIndex != -1 && this._historyCurrentIndex <= this._inputHistory.length - 1 && this._lastTextOnInput == this._inputHistory[this._historyCurrentIndex].text || this._historyCurrentIndex == -1 && (this._lastTextOnInput == "" || this._lastTextOnInput == "0"));
      }
      
      private function deletePreviousWord() : void
      {
         var s:Array = _tText.text.split(" ");
         s.pop();
         _tText.text = s.join(" ");
         if(this.checkClearHistory())
         {
            this._inputHistory.pop();
         }
         this._undoing = this._deleting = this._redoing = this._chatHistoryText = false;
         this.onTextChange(null);
      }
      
      override public function focus() : void
      {
         Berilia.getInstance().docMain.stage.focus = _tText;
         FocusHandler.getInstance().setFocus(_tText);
      }
      
      public function blur() : void
      {
         Berilia.getInstance().docMain.stage.focus = null;
         FocusHandler.getInstance().setFocus(null);
      }
      
      override public function process(msg:Message) : Boolean
      {
         var kdmsg:KeyboardKeyDownMessage = null;
         if(msg is MouseClickMessage && MouseClickMessage(msg).target == this)
         {
            this.focus();
         }
         if(this.haveFocus)
         {
            if(msg is KeyboardKeyDownMessage)
            {
               kdmsg = msg as KeyboardKeyDownMessage;
               if(kdmsg.keyboardEvent.ctrlKey && kdmsg.keyboardEvent.keyCode == Keyboard.Z && !kdmsg.keyboardEvent.shiftKey)
               {
                  this.undo();
               }
               else if(kdmsg.keyboardEvent.shiftKey && kdmsg.keyboardEvent.ctrlKey && kdmsg.keyboardEvent.keyCode == Keyboard.Z)
               {
                  this.redo();
               }
               else if(kdmsg.keyboardEvent.keyCode != Keyboard.ENTER && kdmsg.keyboardEvent.keyCode != Keyboard.BACKSPACE && !kdmsg.keyboardEvent.ctrlKey && !(kdmsg.keyboardEvent.shiftKey && kdmsg.keyboardEvent.keyCode == Keyboard.SHIFT) && kdmsg.keyboardEvent.keyCode != Keyboard.UP && kdmsg.keyboardEvent.keyCode != Keyboard.DOWN)
               {
                  this._undoing = this._deleting = this._redoing = this._chatHistoryText = false;
               }
            }
         }
         return super.process(msg);
      }
      
      public function setSelection(start:int, end:int) : void
      {
         this._nSelectionStart = start;
         this._nSelectionEnd = end;
         _tText.setSelection(this._nSelectionStart,this._nSelectionEnd);
      }
      
      public function addHyperLinkCode(pHyperlinkCode:String) : void
      {
         this._currentHyperlinkCodes.push(pHyperlinkCode);
      }
      
      public function getHyperLinkCodes() : Vector.<String>
      {
         var hyperlinkCodes:Vector.<String> = null;
         if(!this._historyEntryHyperlinkCodes)
         {
            hyperlinkCodes = this._currentHyperlinkCodes.concat();
         }
         else
         {
            hyperlinkCodes = this._historyEntryHyperlinkCodes.concat(this._currentHyperlinkCodes);
         }
         return hyperlinkCodes;
      }
      
      private function onTextChange(e:Event) : void
      {
         var sameText:* = false;
         if(this._lastTextOnInput != null)
         {
            if(this._isNumericInput)
            {
               sameText = StringUtils.kamasToString(StringUtils.stringToKamas(this._lastTextOnInput,""),"") == StringUtils.kamasToString(StringUtils.stringToKamas(_tText.text,""),"");
            }
            else
            {
               sameText = this._lastTextOnInput == _tText.text;
            }
            this._scrollBeforeChange = scrollV;
         }
         else
         {
            this._scrollBeforeChange = -1;
         }
         if(!sameText)
         {
            if(!this._sendingText && !this._chatHistoryText)
            {
               this.checkClearHistory();
               if(this._lastTextOnInput && !this._deleting && !this._redoing && !this._undoing && this._lastTextOnInput.length > _tText.text.length)
               {
                  this.addHistory(this._lastTextOnInput);
               }
               if(this._deleting && _tText.text.length == 0)
               {
                  this.addHistory(!!this._isNumericInput ? "0" : "");
                  this._historyCurrentIndex = this._inputHistory.length - 1;
                  this._historyEntryHyperlinkCodes = null;
               }
            }
         }
         this._lastTextOnInput = _tText.text;
         this._sendingText = false;
         this._nSelectionStart = 0;
         this._nSelectionEnd = 0;
         Berilia.getInstance().handler.process(new ChangeMessage(InteractiveObject(this)));
         updateScrollBarPos();
         updateScrollBar();
         if(text.length == 0)
         {
            this.addPlaceholder();
         }
         if(this._scrollBeforeChange >= 0)
         {
            scrollV = this._scrollBeforeChange;
            _tText.scrollV = this._scrollBeforeChange;
            scrollBarValue = this._scrollBeforeChange;
         }
      }
      
      private function onTextInput(pEvent:TextEvent) : void
      {
         this.removePlaceholderText();
         if(pEvent.text.length > 1)
         {
            this.checkClearHistory();
            if(!this._undoing && !this._redoing && !this._deleting && this._lastTextOnInput != null && _tText.text.length + pEvent.text.length > this._lastTextOnInput.length)
            {
               this.addHistory(this._lastTextOnInput);
            }
            this._undoing = this._deleting = this._redoing = this._chatHistoryText = false;
         }
      }
      
      private function onKeyUp(pEvent:KeyboardEvent) : void
      {
         if(pEvent.keyCode == Keyboard.ENTER && XmlConfig.getInstance().getEntry("config.lang.current") != "ja" && !(pEvent.altKey || pEvent.shiftKey || pEvent.ctrlKey || pEvent.hasOwnProperty("controlKey") && pEvent.controlKey || pEvent.hasOwnProperty("commandKey") && pEvent.commandKey))
         {
            this._sendingText = true;
            this._inputHistory.length = 0;
            this._historyCurrentIndex = 0;
         }
      }
      
      private function onKeyDown(pEvent:KeyboardEvent) : void
      {
         if(!pEvent.altKey && !pEvent.shiftKey && pEvent.ctrlKey && pEvent.keyCode == Keyboard.Y)
         {
            pEvent.preventDefault();
            pEvent.stopImmediatePropagation();
            this.redo();
         }
         else if(!pEvent.altKey && !pEvent.shiftKey && pEvent.ctrlKey && pEvent.keyCode == Keyboard.BACKSPACE)
         {
            pEvent.preventDefault();
            pEvent.stopImmediatePropagation();
            this.deletePreviousWord();
         }
         else if(pEvent.keyCode == Keyboard.UP || pEvent.keyCode == Keyboard.DOWN)
         {
            this._chatHistoryText = true;
            this._undoing = this._redoing = this._deleting = false;
            this._inputHistory.length = 0;
            this._historyCurrentIndex = 0;
         }
         else if(pEvent.keyCode == Keyboard.BACKSPACE)
         {
            this._chatHistoryText = false;
            if(!this._deleting)
            {
               this._deleting = true;
               this._undoing = this._redoing = false;
               if(this._lastTextOnInput)
               {
                  this.addHistory(this._lastTextOnInput);
               }
            }
         }
         else if(!pEvent.altKey && pEvent.shiftKey && !pEvent.ctrlKey && pEvent.keyCode == Keyboard.ENTER)
         {
            _log.debug("shift entrée");
         }
      }
      
      private function removePlaceholderText() : void
      {
         this.alpha = 1;
         if(this._placeholderText && _tText.text == this._placeholderText)
         {
            _tText.text = "";
         }
      }
      
      private function addPlaceholder() : void
      {
         if(this._placeholderText)
         {
            this.placeholderText = this._placeholderText;
         }
      }
   }
}

class InputEntry
{
    
   
   private var _text:String;
   
   private var _hyperlinkCodes:Vector.<String>;
   
   function InputEntry(pText:String, pHyperlinkCodes:Vector.<String>)
   {
      super();
      this._text = pText;
      this._hyperlinkCodes = pHyperlinkCodes;
   }
   
   public function get text() : String
   {
      return this._text;
   }
   
   public function get hyperlinkCodes() : Vector.<String>
   {
      return this._hyperlinkCodes;
   }
}
