package com.ankamagames.berilia.types.data
{
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class LinkedCursorData
   {
       
      
      public var sprite:Sprite;
      
      public var lockX:Boolean = false;
      
      public var lockY:Boolean = false;
      
      public var offset:Point;
      
      public var data;
      
      public function LinkedCursorData()
      {
         super();
      }
   }
}
