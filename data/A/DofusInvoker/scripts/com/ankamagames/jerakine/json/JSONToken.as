package com.ankamagames.jerakine.json
{
   public class JSONToken
   {
       
      
      private var _type:int;
      
      private var _value:Object;
      
      public function JSONToken(type:int = -1, value:Object = null)
      {
         super();
         this._type = type;
         this._value = value;
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function set type(value:int) : void
      {
         this._type = value;
      }
      
      public function get value() : Object
      {
         return this._value;
      }
      
      public function set value(v:Object) : void
      {
         this._value = v;
      }
   }
}
