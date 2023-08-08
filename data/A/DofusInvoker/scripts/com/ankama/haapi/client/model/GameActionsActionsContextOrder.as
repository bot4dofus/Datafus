package com.ankama.haapi.client.model
{
   public class GameActionsActionsContextOrder
   {
       
      
      public var type:String = null;
      
      public var typeName:String = null;
      
      public var id:Number = 0;
      
      public function GameActionsActionsContextOrder()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "GameActionsActionsContextOrder: ";
         str += " (type: " + this.type + ")";
         str += " (typeName: " + this.typeName + ")";
         return str + (" (id: " + this.id + ")");
      }
   }
}
