package com.ankama.haapi.client.model
{
   public class GameActionsActionsContext
   {
       
      
      public var order:GameActionsActionsContextOrder = null;
      
      public var article:GameActionsActionsContextArticle = null;
      
      public function GameActionsActionsContext()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "GameActionsActionsContext: ";
         str += " (order: " + this.order + ")";
         return str + (" (article: " + this.article + ")");
      }
   }
}
