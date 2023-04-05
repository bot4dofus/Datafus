package com.ankamagames.berilia.types.uiDefinition
{
   public class BasicElement
   {
      
      public static var ID:uint = 10000;
       
      
      public var name:String;
      
      public var strata:uint = 1;
      
      public var size:SizeElement;
      
      public var minSize:SizeElement;
      
      public var maxSize:SizeElement;
      
      public var anchors:Array;
      
      public var event:Array;
      
      public var properties:Array;
      
      public var className:String;
      
      public var cachedWidth:int = 2147483647;
      
      public var cachedHeight:int = 2147483647;
      
      public var cachedX:int = 2147483647;
      
      public var cachedY:int = 2147483647;
      
      public function BasicElement()
      {
         this.event = new Array();
         this.properties = new Array();
         super();
      }
      
      public function setName(sName:String) : void
      {
         this.name = sName;
         this.properties["name"] = sName;
      }
      
      public function copy(target:BasicElement) : void
      {
         var key:* = null;
         target.strata = this.strata;
         target.size = this.size;
         target.minSize = this.minSize;
         target.maxSize = this.maxSize;
         target.anchors = this.anchors;
         target.event = this.event;
         target.properties = [];
         for(key in this.properties)
         {
            target.properties[key] = this.properties[key];
         }
         target.className = this.className;
         target.cachedWidth = this.cachedWidth;
         target.cachedHeight = this.cachedHeight;
         target.cachedX = this.cachedX;
         target.cachedY = this.cachedY;
         target.setName(this.name);
      }
   }
}
