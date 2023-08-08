package com.ankama.haapi.client.model
{
   public class GameActionsActionsContextArticle
   {
       
      
      public var type:String = null;
      
      public var name:String = null;
      
      public var id:Number = 0;
      
      public function GameActionsActionsContextArticle()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "GameActionsActionsContextArticle: ";
         str += " (type: " + this.type + ")";
         str += " (name: " + this.name + ")";
         return str + (" (id: " + this.id + ")");
      }
   }
}
