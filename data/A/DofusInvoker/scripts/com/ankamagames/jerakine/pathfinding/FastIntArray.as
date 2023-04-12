package com.ankamagames.jerakine.pathfinding
{
   public class FastIntArray
   {
       
      
      public var data:Vector.<int>;
      
      public var length:int = 0;
      
      public function FastIntArray(size:int = 0)
      {
         super();
         this.data = new Vector.<int>(size);
      }
      
      public function at(i:uint) : int
      {
         return this.data[i];
      }
      
      public function push(val:int) : void
      {
         if(this.length == this.data.length)
         {
            this.data.push(val);
         }
         else
         {
            this.data[this.length] = val;
         }
         ++this.length;
      }
      
      public function removeAt(index:int) : int
      {
         var previous:int = this.data[index];
         this.data[index] = this.data[this.length - 1];
         --this.length;
         return previous;
      }
      
      public function indexOf(val:int) : int
      {
         for(var i:int = 0; i < this.length; i++)
         {
            if(this.data[i] == val)
            {
               return i;
            }
         }
         return -1;
      }
      
      public function clear() : void
      {
         this.length = 0;
      }
   }
}
