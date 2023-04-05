package com.ankama.haapi.client.model
{
   public class KardTypeArticle
   {
       
      
      public var id:Number = 0;
      
      public var name:String = null;
      
      public var description:String = null;
      
      private var _references_obj_class:Array = null;
      
      public var references:Vector.<KardTypeReference>;
      
      private var _media_obj_class:Array = null;
      
      public var media:Vector.<KardTypeMedia>;
      
      public function KardTypeArticle()
      {
         this.references = new Vector.<KardTypeReference>();
         this.media = new Vector.<KardTypeMedia>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "KardTypeArticle: ";
         str += " (id: " + this.id + ")";
         str += " (name: " + this.name + ")";
         str += " (description: " + this.description + ")";
         str += " (references: " + this.references + ")";
         return str + (" (media: " + this.media + ")");
      }
   }
}
