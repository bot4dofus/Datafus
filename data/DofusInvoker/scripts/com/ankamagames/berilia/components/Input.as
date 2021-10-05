package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.berilia.components.messages.ChangeMessage;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.text.TextFieldType;
   import flash.ui.Keyboard;
   
   public class Input extends Label implements UIComponent
   {
      
      private static const UNDO_MAX_SIZE:uint = 10;
      
      private static var regSpace:RegExp = /\s/g;
      
      public static var numberStrSeparator:String;
       
      
      private var _nMaxChars:int;
      
      private var _nNumberMax:Number = 0;
      
      private var _bPassword:Boolean = false;
      
      private var _sRestrictChars:String;
      
      private var _bNumberAutoFormat:Boolean = false;
      
      private var _numberSeparator:String = " ";
      
      private var _nSelectionStart:int;
      
      private var _nSelectionEnd:int;
      
      private var _isNumericInput:Boolean;
      
      private var _lastTextOnInput:String;
      
      public var imeActive:Boolean;
      
      private var _timerFormatDelay:BenchmarkTimer;
      
      private var _sendingText:Boolean;
      
      private var _chatHistoryText:Boolean;
      
      private var _inputHistory:Vector.<InputEntry>;
      
      private var _historyEntryHyperlinkCodes:Vector.<String>;
      
      private var _currentHyperlinkCodes:Vector.<String>;
      
      private var _historyCurrentIndex:int;
      
      private var _undoing:Boolean;
      
      private var _redoing:Boolean;
      
      private var _deleting:Boolean;
      
      private var _placeholderText:String;
      
      public var focusEventHandlerPriority:Boolean = true;
      
      public function Input()
      {
         super();
         _bHtmlAllowed = false;
         _tText.selectable = true;
         _tText.type = TextFieldType.INPUT;
         _tText.restrict = this._sRestrictChars;
         _tText.maxChars = this._nMaxChars;
         _tText.mouseEnabled = true;
         _autoResize = false;
         this.numberSeparator = numberStrSeparator;
         _tText.addEventListener(Event.CHANGE,this.onTextChange);
         _tText.addEventListener(TextEvent.TEXT_INPUT,this.onTextInput);
         _tText.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         _tText.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,1,true);
         this._inputHistory = new Vector.<InputEntry>(0);
         this._currentHyperlinkCodes = new Vector.<String>(0);
      }
      
      public function get placeholderText() : String
      {
         return this._placeholderText;
      }
      
      public function get selectionStart() : uint
      {
         return _tText.selectionBeginIndex;
      }
      
      public function set placeholderText(sValue:String) : void
      {
         this._placeholderText = sValue;
         this.text = this._placeholderText;
         this.alpha = 0.5;
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
      
      public function set numberMax(nValue:Number) : void
      {
         this._nNumberMax = nValue;
      }
      
      public function get password() : Boolean
      {
         return this._bPassword;
      }
      
      public function set password(bValue:Boolean) : void
      {
         this._bPassword = bValue;
         if(this._bPassword)
         {
            _tText.displayAsPassword = true;
         }
      }
      
      public function get numberAutoFormat() : Boolean
      {
         return this._bNumberAutoFormat;
      }
      
      public function set numberAutoFormat(bValue:Boolean) : void
      {
         this._bNumberAutoFormat = bValue;
         if(!bValue)
         {
            if(this._timerFormatDelay)
            {
               this._timerFormatDelay.stop();
               this._timerFormatDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerFormatDelay);
            }
         }
         else
         {
            this._timerFormatDelay = new BenchmarkTimer(1000,1,"Input._timerFormatDelay");
            this._timerFormatDelay.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerFormatDelay);
         }
      }
      
      public function get numberSeparator() : String
      {
         return this._numberSeparator;
      }
      
      public function set numberSeparator(bValue:String) : void
      {
         this._numberSeparator = bValue;
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
         super.text = sValue;
         if(!_bHtmlAllowed)
         {
            height = __height;
         }
         this.onTextChange(null);
      }
      
      override public function appendText(sTxt:String, style:String = null) : void
      {
         super.appendText(sTxt,style);
         this.checkClearHistory();
         this._undoing = this._redoing = this._deleting = this._chatHistoryText = false;
         this.onTextChange(null);
      }
      
      override public function remove() : void
      {
         _tText.removeEventListener(Event.CHANGE,this.onTextChange);
         _tText.removeEventListener(TextEvent.TEXT_INPUT,this.onTextInput);
         _tText.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         _tText.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this._inputHistory.length = 0;
         this._currentHyperlinkCodes.length = 0;
         if(this._timerFormatDelay)
         {
            this._timerFormatDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerFormatDelay);
         }
         super.remove();
      }
      
      override public function free() : void
      {
         if(this._timerFormatDelay)
         {
            this._timerFormatDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerFormatDelay);
         }
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
      
      private function removePlaceholderText() : void
      {
         this.alpha = 1;
         if(this._placeholderText && _tText.text == this._placeholderText)
         {
            _tText.text = "";
            this._placeholderText = null;
         }
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
         var delta:int = 0;
         var inc:int = 0;
         var newValue:int = 0;
         var kdmsg:KeyboardKeyDownMessage = null;
         if(msg is MouseClickMessage && MouseClickMessage(msg).target == _tText)
         {
            this.focus();
            this.removePlaceholderText();
         }
         var tfIntValue:int = parseInt(text.split(" ").join("").split(" ").join("").split(this._numberSeparator).join(""));
         if(msg is MouseWheelMessage && !disabled && tfIntValue.toString(10) == text.split(" ").join("").split(" ").join("").split(this._numberSeparator).join(""))
         {
            delta = (msg as MouseWheelMessage).mouseEvent.delta > 0 ? 1 : -1;
            inc = Math.abs(tfIntValue) > 99 ? int(Math.pow(10,(tfIntValue + delta).toString(10).length - 2)) : 1;
            if(ShortcutsFrame.ctrlKey)
            {
               inc = 1;
            }
            newValue = tfIntValue + delta * inc;
            newValue = newValue < 0 ? 0 : int(newValue);
            if(this._nNumberMax > 0 && newValue > this._nNumberMax)
            {
               newValue = this._nNumberMax;
            }
            this.text = newValue.toString();
            return true;
         }
         if(!this.password && this.haveFocus)
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
         var pattern0:RegExp = null;
         var tempString:String = null;
         var toInt:Number = NaN;
         if(this._nNumberMax > 0)
         {
            pattern0 = /[0-9 ]+/g;
            tempString = this.removeSpace(_tText.text);
            toInt = parseFloat(tempString);
            if(!isNaN(toInt) && pattern0.test(_tText.text))
            {
               if(toInt > this._nNumberMax)
               {
                  _tText.text = this._nNumberMax + "";
               }
            }
         }
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
         if(this._timerFormatDelay)
         {
            this._timerFormatDelay.reset();
            this._timerFormatDelay.start();
         }
         this._nSelectionStart = 0;
         this._nSelectionEnd = 0;
         Berilia.getInstance().handler.process(new ChangeMessage(InteractiveObject(this)));
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
         else if(!_tText.multiline && pEvent.ctrlKey && pEvent.keyCode == Keyboard.ENTER)
         {
            pEvent.preventDefault();
            pEvent.stopImmediatePropagation();
         }
      }
      
      public function removeSpace(spaced:String) : String
      {
         var str2:String = null;
         var tmp:String = spaced;
         var pattern1:RegExp = new RegExp(regSpace);
         do
         {
            str2 = tmp;
            tmp = str2.replace(pattern1,"");
         }
         while(str2 != tmp);
         
         do
         {
            str2 = tmp;
            tmp = str2.replace(this._numberSeparator,"");
         }
         while(str2 != tmp);
         
         return str2;
      }
      
      private function onTimerFormatDelay(e:TimerEvent) : void
      {
         var newStringWithSpaces:String = null;
         this._timerFormatDelay.removeEventListener(TimerEvent.TIMER,this.onTimerFormatDelay);
         var caret:int = caretIndex;
         var startText:String = _tText.text;
         var i:int = 0;
         this._nSelectionStart = _tText.selectionBeginIndex;
         this._nSelectionEnd = _tText.selectionEndIndex;
         for(i = 0; i < _tText.length - 1; i++)
         {
            if(startText.charAt(i) == this._numberSeparator || startText.charAt(i) == " ")
            {
               if(i < caret)
               {
                  caret--;
               }
               if(i < this._nSelectionStart)
               {
                  --this._nSelectionStart;
               }
               if(i < this._nSelectionEnd)
               {
                  --this._nSelectionEnd;
               }
            }
         }
         var tempString:String = this.removeSpace(startText);
         var toInt:Number = parseFloat(tempString);
         if(toInt && !isNaN(toInt))
         {
            newStringWithSpaces = StringUtils.formateIntToString(toInt);
            for(i = 0; i < newStringWithSpaces.length - 1; i++)
            {
               if(newStringWithSpaces.charAt(i) == this._numberSeparator)
               {
                  if(i < caret)
                  {
                     caret++;
                  }
                  if(i < this._nSelectionStart)
                  {
                     ++this._nSelectionStart;
                  }
                  if(i < this._nSelectionEnd)
                  {
                     ++this._nSelectionEnd;
                  }
               }
            }
            super.text = newStringWithSpaces;
            caretIndex = caret;
         }
         if(this._nSelectionStart != this._nSelectionEnd)
         {
            _tText.setSelection(this._nSelectionStart,this._nSelectionEnd);
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
