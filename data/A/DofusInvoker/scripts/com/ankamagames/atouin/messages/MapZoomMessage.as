package com.ankamagames.atouin.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class MapZoomMessage implements Message
   {
       
      
      private var _value:Number;
      
      private var _posX:int;
      
      private var _posY:int;
      
      public function MapZoomMessage(value:Number, posX:int, posY:int)
      {
         super();
         this._value = value;
         this._posX = posX;
         this._posY = posY;
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function get posX() : int
      {
         return this._posX;
      }
      
      public function get posY() : int
      {
         return this._posY;
      }
   }
}
