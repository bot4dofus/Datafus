package com.ankama.haapi.client.model
{
   public class GameAdminRightWithApiKeyResponse
   {
       
      
      private var _rights_obj_class:Array = null;
      
      public var rights:Vector.<Number>;
      
      public function GameAdminRightWithApiKeyResponse()
      {
         this.rights = new Vector.<Number>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "GameAdminRightWithApiKeyResponse: ";
         return str + (" (rights: " + this.rights + ")");
      }
   }
}
