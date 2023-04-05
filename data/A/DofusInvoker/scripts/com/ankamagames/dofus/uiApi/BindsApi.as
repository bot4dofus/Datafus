package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.enums.ShortcutsEnum;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.shortcut.Bind;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   
   [InstanciedApi]
   public class BindsApi implements IApi
   {
       
      
      private var _module:UiModule;
      
      public function BindsApi()
      {
         super();
      }
      
      [ApiData(name="module")]
      public function set module(value:UiModule) : void
      {
         this._module = value;
      }
      
      public function destroy() : void
      {
         this._module = null;
      }
      
      public function getBindList() : Array
      {
         return BindsManager.getInstance().binds;
      }
      
      public function getShortcut() : Array
      {
         var s:Shortcut = null;
         var copy:Array = new Array();
         var ss:Array = Shortcut.getShortcuts();
         for each(s in ss)
         {
            if(s.visible)
            {
               copy.push(s);
            }
         }
         return copy;
      }
      
      public function getShortcutBind(shortcutName:String, returnDisabled:Boolean = false) : Bind
      {
         return BindsManager.getInstance().getBindFromShortcut(shortcutName,returnDisabled);
      }
      
      public function getShortcutsFromKeyCode(pKeyCode:uint) : Shortcut
      {
         var shortcut:Shortcut = null;
         var charCode:uint = 0;
         var b:Bind = null;
         var shortcutStr:String = ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[pKeyCode];
         if(!shortcutStr)
         {
            if(pKeyCode >= 48 && pKeyCode <= 57)
            {
               charCode = pKeyCode;
            }
            else if(pKeyCode >= 65 && pKeyCode <= 90)
            {
               charCode = pKeyCode;
               if(!ShortcutsFrame.shiftKey && !ShortcutsFrame.shiftKeyDown)
               {
                  charCode += 32;
               }
            }
            shortcutStr = String.fromCharCode(charCode);
         }
         var bind:Bind = BindsManager.getInstance().getBind(new Bind(shortcutStr,"",ShortcutsFrame.altKey && ShortcutsFrame.altKeyDown,ShortcutsFrame.ctrlKey && ShortcutsFrame.ctrlKeyDown,ShortcutsFrame.shiftKey && ShortcutsFrame.shiftKeyDown));
         if(bind)
         {
            for each(b in BindsManager.getInstance().binds)
            {
               if(b.equals(bind))
               {
                  return Shortcut.getShortcutByName(b.targetedShortcut);
               }
            }
         }
         return null;
      }
      
      public function setShortcutBind(targetedShorcut:String, key:String, alt:Boolean, ctrl:Boolean, shift:Boolean) : void
      {
         BindsManager.getInstance().addBind(new Bind(key,targetedShorcut,alt,ctrl,shift));
      }
      
      public function removeShortcutBind(targetedBind:String) : void
      {
         BindsManager.getInstance().removeBind(BindsManager.getInstance().getBindFromShortcut(targetedBind));
      }
      
      public function getShortcutBindStr(shortcutName:String, returnDisabled:Boolean = false) : String
      {
         var bind:Bind = this.getShortcutBind(shortcutName,returnDisabled);
         if(bind != null && bind.key != null)
         {
            return bind.toString();
         }
         return "";
      }
      
      public function resetAllBinds() : void
      {
         BindsManager.getInstance().reset();
      }
      
      public function availableKeyboards() : Array
      {
         return BindsManager.getInstance().availableKeyboards.concat();
      }
      
      public function changeKeyboard(locale:String) : void
      {
         BindsManager.getInstance().changeKeyboard(locale,true);
      }
      
      public function getCurrentLocale() : String
      {
         return BindsManager.getInstance().currentLocale;
      }
      
      public function bindIsRegister(bind:Bind) : Boolean
      {
         return BindsManager.getInstance().isRegister(bind);
      }
      
      public function bindIsPermanent(bind:Bind) : Boolean
      {
         return BindsManager.getInstance().isPermanent(bind);
      }
      
      public function bindIsDisabled(bind:Bind) : Boolean
      {
         return BindsManager.getInstance().isDisabled(bind);
      }
      
      public function setBindDisabled(bind:Bind, disabled:Boolean) : void
      {
         BindsManager.getInstance().setDisabled(bind,disabled);
      }
      
      public function getRegisteredBind(bind:Bind) : Bind
      {
         return BindsManager.getInstance().getRegisteredBind(bind);
      }
      
      public function getShortcutByName(name:String) : Shortcut
      {
         return Shortcut.getShortcutByName(name);
      }
      
      public function setShortcutEnabled(enabled:Boolean) : void
      {
         ShortcutsFrame.shortcutsEnabled = enabled;
      }
      
      public function getIsShortcutEnabled() : Boolean
      {
         return ShortcutsFrame.shortcutsEnabled;
      }
      
      public function disableShortcut(name:String, val:Boolean) : void
      {
         var shortcut:Shortcut = Shortcut.getShortcutByName(name);
         if(shortcut != null)
         {
            shortcut.disable = val;
         }
      }
      
      public function enableShortcutKey(keyCode:uint, charCode:uint, enabled:Boolean) : void
      {
         BindsManager.getInstance().setDisabled(new Bind(BindsManager.getInstance().getShortcutString(keyCode,charCode)),!enabled);
      }
   }
}
