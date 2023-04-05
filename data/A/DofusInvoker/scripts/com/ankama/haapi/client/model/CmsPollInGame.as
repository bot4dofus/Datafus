package com.ankama.haapi.client.model
{
   public class CmsPollInGame
   {
       
      
      public var item_id:Number = 0;
      
      public var title:String = null;
      
      public var description:String = null;
      
      public var url:String = null;
      
      public var criterion:String = null;
      
      public function CmsPollInGame()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "CmsPollInGame: ";
         str += " (item_id: " + this.item_id + ")";
         str += " (title: " + this.title + ")";
         str += " (description: " + this.description + ")";
         str += " (url: " + this.url + ")";
         return str + (" (criterion: " + this.criterion + ")");
      }
   }
}
