package com.ankama.haapi.client.model
{
   public class AlmanaxZodiac
   {
       
      
      public var id:Number = 0;
      
      public var begin:Date = null;
      
      public var end:Date = null;
      
      public var color:String = null;
      
      public var background:Boolean = false;
      
      public var background_url:String = null;
      
      public var name:String = null;
      
      public var description:String = null;
      
      public var image_url:String = null;
      
      public function AlmanaxZodiac()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "AlmanaxZodiac: ";
         str += " (id: " + this.id + ")";
         str += " (begin: " + this.begin + ")";
         str += " (end: " + this.end + ")";
         str += " (color: " + this.color + ")";
         str += " (background: " + this.background + ")";
         str += " (background_url: " + this.background_url + ")";
         str += " (name: " + this.name + ")";
         str += " (description: " + this.description + ")";
         return str + (" (image_url: " + this.image_url + ")");
      }
   }
}
