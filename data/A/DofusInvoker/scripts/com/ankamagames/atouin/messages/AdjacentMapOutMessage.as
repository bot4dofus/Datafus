package com.ankamagames.atouin.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import flash.display.DisplayObject;
   
   public class AdjacentMapOutMessage implements Message
   {
       
      
      private var _nDirection:uint;
      
      private var _spZone:DisplayObject;
      
      public function AdjacentMapOutMessage(nDirection:uint, zone:DisplayObject)
      {
         super();
         this._nDirection = nDirection;
         this._spZone = zone;
      }
      
      public function get direction() : uint
      {
         return this._nDirection;
      }
      
      public function get zone() : DisplayObject
      {
         return this._spZone;
      }
   }
}
