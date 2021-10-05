package org.apache.thrift
{
   import flash.utils.Dictionary;
   
   public class Set
   {
       
      
      private var _elements:Dictionary;
      
      private var _size:int = 0;
      
      public function Set(... rest)
      {
         var _loc2_:* = undefined;
         this._elements = new Dictionary();
         super();
         for each(_loc2_ in rest)
         {
            this.add(_loc2_);
         }
      }
      
      public function add(param1:*) : Boolean
      {
         var _loc2_:Boolean = this._elements.hasOwnProperty(param1);
         if(!_loc2_)
         {
            ++this._size;
            this._elements[param1] = true;
         }
         return !_loc2_;
      }
      
      public function clear() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this._elements)
         {
            this.remove(_loc1_);
         }
      }
      
      public function contains(param1:Object) : Boolean
      {
         return this._elements.hasOwnProperty(param1);
      }
      
      public function isEmpty() : Boolean
      {
         return this._size == 0;
      }
      
      public function remove(param1:*) : Boolean
      {
         if(this.contains(param1))
         {
            delete this._elements[param1];
            --this._size;
            return true;
         }
         return false;
      }
      
      public function toArray() : Array
      {
         var _loc2_:* = undefined;
         var _loc1_:Array = new Array();
         for(_loc2_ in this._elements)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function get size() : int
      {
         return this._size;
      }
   }
}
