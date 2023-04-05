package com.ankamagames.atouin.types
{
   import flash.display.Sprite;
   
   public class FrustumShape extends Sprite
   {
       
      
      private var _direction:uint;
      
      public function FrustumShape(direction:uint)
      {
         super();
         this._direction = direction;
         alpha = 0;
         buttonMode = true;
      }
      
      public function get direction() : uint
      {
         return this._direction;
      }
   }
}
