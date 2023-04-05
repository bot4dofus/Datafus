package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.dofus.logic.shield.SecureModeManager;
   
   public class SecurityApi implements IApi
   {
       
      
      public function SecurityApi()
      {
         super();
      }
      
      public function askSecureModeCode() : void
      {
         SecureModeManager.getInstance().askCode();
      }
      
      public function sendSecureModeCode(code:String, callback:Function, errorCallback:Function, computerName:String = null) : void
      {
         SecureModeManager.getInstance().sendCode(code,callback,errorCallback,computerName);
      }
      
      public function SecureModeisActive() : Boolean
      {
         return SecureModeManager.getInstance().active;
      }
      
      public function setShieldLevel(level:uint) : void
      {
         SecureModeManager.getInstance().shieldLevel = level;
      }
      
      public function getShieldLevel() : uint
      {
         return SecureModeManager.getInstance().shieldLevel;
      }
   }
}
