package com.ankamagames.jerakine.pools
{
   import mx.utils.LinkedListNode;
   
   public class PoolableLinkedListNode extends LinkedListNode implements Poolable
   {
       
      
      public function PoolableLinkedListNode(value:* = null)
      {
         super(value);
      }
      
      public function free() : void
      {
         value = null;
         prev = null;
         next = null;
      }
   }
}
