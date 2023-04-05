package com.ankamagames.dofus.kernel.zaap.messages.impl
{
   import com.ankamagames.dofus.kernel.zaap.messages.IZaapOutputMessage;
   
   public class RequestZaapSettingMessage implements IZaapOutputMessage
   {
       
      
      private var _name:String;
      
      public function RequestZaapSettingMessage(name:String)
      {
         super();
         this._name = name;
      }
      
      public function get name() : String
      {
         return this._name;
      }
   }
}
