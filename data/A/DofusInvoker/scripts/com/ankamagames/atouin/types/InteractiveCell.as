package com.ankamagames.atouin.types
{
   import flash.display.DisplayObjectContainer;
   
   public class InteractiveCell
   {
       
      
      public var cellId:uint;
      
      public var sprite:DisplayObjectContainer;
      
      public var x:Number;
      
      public var y:Number;
      
      public function InteractiveCell(_cellId:uint, _sprite:DisplayObjectContainer, _x:Number, _y:Number)
      {
         super();
         this.cellId = _cellId;
         this.sprite = _sprite;
         this.x = _x;
         this.y = _y;
      }
   }
}
