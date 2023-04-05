package com.ankamagames.atouin.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class MapMessage implements Message
   {
       
      
      private var _id:Number;
      
      private var _transitionType:String;
      
      public var renderRequestId:uint;
      
      public function MapMessage()
      {
         super();
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function set id(nValue:Number) : void
      {
         this._id = nValue;
      }
      
      public function get transitionType() : String
      {
         return this._transitionType;
      }
      
      public function set transitionType(sValue:String) : void
      {
         this._transitionType = sValue;
      }
   }
}
