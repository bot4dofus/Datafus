package com.ankama.haapi.client.model
{
   public class Guild
   {
       
      
      public var id:Number = 0;
      
      public var name:String = null;
      
      public var level:Number = 0;
      
      public function Guild()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "Guild: ";
         str += " (id: " + this.id + ")";
         str += " (name: " + this.name + ")";
         return str + (" (level: " + this.level + ")");
      }
   }
}
