package org.flintparticles.common.utils
{
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   public class PriorityArray extends Proxy
   {
       
      
      private var _values:Array;
      
      public function PriorityArray()
      {
         super();
         this._values = new Array();
      }
      
      override flash_proxy function getProperty(name:*) : *
      {
         var index:int = int(name);
         if(index == name && index < this._values.length && this._values[index])
         {
            return this._values[index].value;
         }
         return undefined;
      }
      
      override flash_proxy function setProperty(name:*, value:*) : void
      {
         var index:uint = uint(name);
         if(index == name && index < this._values.length)
         {
            this._values[index].value = value;
         }
      }
      
      override flash_proxy function nextNameIndex(index:int) : int
      {
         if(index < this._values.length)
         {
            return index + 1;
         }
         return 0;
      }
      
      override flash_proxy function nextName(index:int) : String
      {
         return (index - 1).toString();
      }
      
      override flash_proxy function nextValue(index:int) : *
      {
         return this._values[index - 1];
      }
      
      public function add(value:*, priority:Number) : uint
      {
         var len:uint = this._values.length;
         for(var i:uint = 0; i < len; i++)
         {
            if(this._values[i].priority < priority)
            {
               break;
            }
         }
         this._values.splice(i,0,new Pair(priority,value));
         return this._values.length;
      }
      
      public function remove(value:*) : Boolean
      {
         var i:uint = this._values.length;
         while(i--)
         {
            if(this._values[i].value == value)
            {
               this._values.splice(i,1);
               return true;
            }
         }
         return false;
      }
      
      public function contains(value:*) : Boolean
      {
         var i:uint = this._values.length;
         while(i--)
         {
            if(this._values[i].value == value)
            {
               return true;
            }
         }
         return false;
      }
      
      public function removeAt(index:uint) : *
      {
         var temp:* = this._values[index].value;
         this._values.splice(index,1);
         return temp;
      }
      
      public function clear() : void
      {
         this._values.length = 0;
      }
      
      public function get length() : uint
      {
         return this._values.length;
      }
   }
}

class Pair
{
    
   
   private var priority:Number;
   
   private var value;
   
   function Pair(priority:Number, value:*)
   {
      super();
      this.priority = priority;
      this.value = value;
   }
}
