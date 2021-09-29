package com.ankamagames.berilia.frames
{
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.types.shortcut.Bind;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.ui.Keyboard;
   import flash.utils.getQualifiedClassName;
   
   public class ShortcutsFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ShortcutsFrame));
      
      public static var shiftKey:Boolean = false;
      
      public static var ctrlKey:Boolean = false;
      
      public static var altKey:Boolean = false;
      
      public static var shiftKeyDown:Boolean;
      
      public static var ctrlKeyDown:Boolean;
      
      public static var altKeyDown:Boolean;
      
      public static var shortcutsEnabled:Boolean = true;
       
      
      private var _lastCtrlKey:Boolean = false;
      
      private var _lastHeldShortcut:Boolean = false;
      
      private var _heldShortcuts:Vector.<String>;
      
      public function ShortcutsFrame()
      {
         super();
      }
      
      public function get heldShortcuts() : Vector.<String>
      {
         return this._heldShortcuts;
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function process(msg:Message) : Boolean
      {
         var kdmsg:KeyboardKeyDownMessage = null;
         var s:Shortcut = null;
         var kumsg:KeyboardKeyUpMessage = null;
         var bind:Bind = null;
         var cancelShortcut:Boolean = false;
         var focusAsTextField:TextField = null;
         var shortcutName:String = null;
         if(!shortcutsEnabled)
         {
            return false;
         }
         switch(true)
         {
            case msg is KeyboardKeyDownMessage:
               kdmsg = KeyboardKeyDownMessage(msg);
               shiftKey = kdmsg.keyboardEvent.shiftKey;
               ctrlKey = kdmsg.keyboardEvent.ctrlKey;
               altKey = kdmsg.keyboardEvent.altKey;
               this._lastCtrlKey = false;
               if(!shiftKeyDown)
               {
                  shiftKeyDown = kdmsg.keyboardEvent.keyCode == Keyboard.SHIFT;
               }
               if(!ctrlKeyDown)
               {
                  ctrlKeyDown = kdmsg.keyboardEvent.keyCode == Keyboard.CONTROL;
               }
               if(!altKeyDown)
               {
                  altKeyDown = kdmsg.keyboardEvent.keyCode == Keyboard.ALTERNATE;
               }
               s = this.getShortcut(kdmsg);
               if(s && s.holdKeys && this._heldShortcuts.indexOf(s.defaultBind.targetedShortcut) == -1)
               {
                  this.handleMessage(kdmsg);
                  focusAsTextField = StageShareManager.stage.focus as TextField;
                  if(!focusAsTextField || (s.textfieldEnabled || focusAsTextField.type != TextFieldType.INPUT))
                  {
                     this._heldShortcuts.push(s.defaultBind.targetedShortcut);
                     this._lastHeldShortcut = true;
                  }
               }
               return false;
            case msg is KeyboardKeyUpMessage:
               kumsg = KeyboardKeyUpMessage(msg);
               shiftKey = kumsg.keyboardEvent.shiftKey;
               ctrlKey = kumsg.keyboardEvent.ctrlKey;
               altKey = kumsg.keyboardEvent.altKey;
               switch(kumsg.keyboardEvent.keyCode)
               {
                  case Keyboard.SHIFT:
                     shiftKeyDown = false;
                     break;
                  case Keyboard.CONTROL:
                     ctrlKeyDown = false;
                     break;
                  case Keyboard.ALTERNATE:
                     altKeyDown = false;
               }
               cancelShortcut = false;
               for each(shortcutName in this._heldShortcuts)
               {
                  bind = BindsManager.getInstance().getBindFromShortcut(shortcutName).copy();
                  bind.shift = kumsg.keyboardEvent.keyCode == Keyboard.SHIFT && bind.shift;
                  bind.alt = kumsg.keyboardEvent.keyCode == Keyboard.ALTERNATE && bind.alt;
                  bind.ctrl = kumsg.keyboardEvent.keyCode == Keyboard.CONTROL && bind.ctrl;
                  if(String.fromCharCode(this.getCharCode(kumsg)) == bind.key || bind.shift || bind.alt || bind.ctrl)
                  {
                     cancelShortcut = true;
                     this.processShortcut(bind,Shortcut.getShortcutByName(shortcutName),bind,kumsg);
                  }
               }
               return !!cancelShortcut ? false : Boolean(this.handleMessage(kumsg));
            default:
               return false;
         }
      }
      
      private function processShortcut(bind:Bind, sh:Shortcut, shortcut:Bind, pKeyboardMessage:KeyboardMessage) : void
      {
         var focusAsTextField:TextField = null;
         var heldShortcutIndex:int = 0;
         if(BindsManager.getInstance().canBind(bind) && (sh != null && !sh.disable || sh == null))
         {
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.KeyboardShortcut,bind,pKeyboardMessage.keyboardEvent.keyCode);
         }
         if(shortcut != null && sh && !sh.disable)
         {
            if(!Shortcut.getShortcutByName(shortcut.targetedShortcut))
            {
               return;
            }
            if(sh.holdKeys)
            {
               heldShortcutIndex = this._heldShortcuts.indexOf(sh.defaultBind.targetedShortcut);
               if(heldShortcutIndex != -1)
               {
                  this._heldShortcuts.splice(heldShortcutIndex,1);
                  this._lastHeldShortcut = false;
               }
            }
            focusAsTextField = StageShareManager.stage.focus as TextField;
            if(focusAsTextField && focusAsTextField.type == TextFieldType.INPUT)
            {
               if(!Shortcut.getShortcutByName(shortcut.targetedShortcut).textfieldEnabled)
               {
                  return;
               }
            }
            BindsManager.getInstance().processCallback(shortcut,shortcut.targetedShortcut);
            if(!sh.holdKeys || pKeyboardMessage is KeyboardKeyDownMessage)
            {
               UiStatsFrame.addStat("shortcut_" + shortcut.targetedShortcut.toLowerCase());
            }
         }
      }
      
      private function handleMessage(pKeyboardMessage:KeyboardMessage) : Boolean
      {
         var sh:Shortcut = null;
         var b:Bind = null;
         var keyCode:int = pKeyboardMessage.keyboardEvent.keyCode;
         if(!this._lastHeldShortcut)
         {
            if(keyCode == Keyboard.CONTROL)
            {
               this._lastCtrlKey = true;
            }
            else if(this._lastCtrlKey)
            {
               this._lastCtrlKey = false;
               return false;
            }
         }
         var sShortcut:String = BindsManager.getInstance().getShortcutString(pKeyboardMessage.keyboardEvent.keyCode,this.getCharCode(pKeyboardMessage));
         if(sShortcut == null)
         {
            return true;
         }
         var bind:Bind = new Bind(sShortcut,"",pKeyboardMessage.keyboardEvent.altKey,pKeyboardMessage.keyboardEvent.ctrlKey,pKeyboardMessage.keyboardEvent.shiftKey);
         var shortcut:Bind = BindsManager.getInstance().getBind(bind);
         if(shortcut != null)
         {
            sh = Shortcut.getShortcutByName(shortcut.targetedShortcut);
         }
         else
         {
            b = bind.copy();
            b.alt = b.ctrl = b.shift = false;
            shortcut = BindsManager.getInstance().getBind(b);
            if(shortcut && this._heldShortcuts.indexOf(shortcut.targetedShortcut) != -1)
            {
               sh = Shortcut.getShortcutByName(shortcut.targetedShortcut);
            }
         }
         this.processShortcut(bind,sh,shortcut,pKeyboardMessage);
         return false;
      }
      
      private function getShortcut(pKeyboardMessage:KeyboardMessage) : Shortcut
      {
         var sShortcut:String = BindsManager.getInstance().getShortcutString(pKeyboardMessage.keyboardEvent.keyCode,this.getCharCode(pKeyboardMessage));
         var bind:Bind = BindsManager.getInstance().getBind(new Bind(sShortcut,"",pKeyboardMessage.keyboardEvent.altKey,pKeyboardMessage.keyboardEvent.ctrlKey,pKeyboardMessage.keyboardEvent.shiftKey));
         return !!bind ? Shortcut.getShortcutByName(bind.targetedShortcut) : null;
      }
      
      private function getCharCode(pKeyboardMessage:KeyboardMessage) : int
      {
         var charCode:int = 0;
         if(SystemManager.getSingleton().os == OperatingSystem.WINDOWS)
         {
            if(BindsManager.getInstance().currentLocale == "frFR" || BindsManager.getInstance().currentLocale == "frBE")
            {
               switch(pKeyboardMessage.keyboardEvent.keyCode)
               {
                  case 48:
                     charCode = 192;
                     break;
                  case 49:
                     charCode = 38;
                     break;
                  case 50:
                     charCode = 201;
                     break;
                  case 51:
                     charCode = 34;
                     break;
                  case 52:
                     charCode = 39;
                     break;
                  case 53:
                     charCode = 40;
                     break;
                  case 54:
                     charCode = 45;
                     break;
                  case 55:
                     charCode = 200;
                     break;
                  case 56:
                     charCode = 95;
                     break;
                  case 57:
                     charCode = 199;
                     break;
                  case 219:
                     charCode = 41;
                     break;
                  case 187:
                     charCode = 43;
                     break;
                  case 221:
                     charCode = 94;
                     break;
                  case 186:
                     charCode = 36;
                     break;
                  case 192:
                     charCode = 249;
                     break;
                  case 220:
                     charCode = 42;
                     break;
                  case 188:
                     charCode = 44;
                     break;
                  case 190:
                     charCode = 59;
                     break;
                  case 191:
                     charCode = 58;
                     break;
                  case 223:
                     charCode = 33;
                     break;
                  case 226:
                     charCode = 60;
                     break;
                  case 222:
                     charCode = 178;
               }
            }
            else if(BindsManager.getInstance().currentLocale == "enUS")
            {
               if(pKeyboardMessage.keyboardEvent.keyCode == 188)
               {
                  if(pKeyboardMessage.keyboardEvent.shiftKey)
                  {
                     charCode = 60;
                     pKeyboardMessage.keyboardEvent.shiftKey = false;
                  }
                  else
                  {
                     charCode = 44;
                  }
               }
               else if(pKeyboardMessage.keyboardEvent.keyCode == 190)
               {
                  if(pKeyboardMessage.keyboardEvent.shiftKey)
                  {
                     charCode = 62;
                     pKeyboardMessage.keyboardEvent.shiftKey = false;
                  }
                  else
                  {
                     charCode = 46;
                  }
               }
            }
         }
         if(!charCode)
         {
            charCode = pKeyboardMessage.keyboardEvent.charCode;
         }
         return charCode;
      }
      
      private function onWindowDeactivate(pEvent:Event) : void
      {
         this._heldShortcuts.length = 0;
         shiftKey = ctrlKey = altKey = false;
         shiftKeyDown = false;
         ctrlKeyDown = false;
         altKeyDown = false;
      }
      
      public function pushed() : Boolean
      {
         this._heldShortcuts = new Vector.<String>(0);
         StageShareManager.stage.nativeWindow.addEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         return true;
      }
      
      public function pulled() : Boolean
      {
         StageShareManager.stage.nativeWindow.removeEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         return true;
      }
   }
}
