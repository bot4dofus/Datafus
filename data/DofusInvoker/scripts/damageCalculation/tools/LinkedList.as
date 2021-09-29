package damageCalculation.tools
{
   public class LinkedList
   {
       
      
      public var tail:LinkedListNode;
      
      public var head:LinkedListNode;
      
      public function LinkedList()
      {
         tail = null;
         head = null;
      }
      
      public function remove(param1:LinkedListNode) : void
      {
         if(param1.previous != null)
         {
            param1.previous.next = param1.next;
         }
         if(param1.next != null)
         {
            param1.next.previous = param1.previous;
         }
         if(param1 == head)
         {
            head = param1.next;
         }
         if(param1 == tail)
         {
            tail = param1.previous;
         }
      }
      
      public function iterator() : LinkedListIterator
      {
         return new LinkedListIterator(head);
      }
      
      public function copy() : LinkedList
      {
         var _loc3_:* = null as LinkedListNode;
         var _loc4_:* = null as LinkedListNode;
         var _loc1_:LinkedList = new LinkedList();
         var _loc2_:LinkedListNode = head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_;
            _loc2_ = _loc2_.next;
            _loc4_ = _loc3_;
            _loc1_.add(_loc4_.item);
         }
         return _loc1_;
      }
      
      public function clear() : void
      {
         head = null;
         tail = null;
      }
      
      public function append(param1:LinkedList) : LinkedList
      {
         var _loc3_:* = null as LinkedListNode;
         var _loc4_:* = null as LinkedListNode;
         var _loc2_:LinkedListNode = param1.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_;
            _loc2_ = _loc2_.next;
            _loc4_ = _loc3_;
            add(_loc4_.item);
         }
         return this;
      }
      
      public function add(param1:Object) : LinkedListNode
      {
         var _loc2_:LinkedListNode = new LinkedListNode(param1);
         if(head == null)
         {
            head = _loc2_;
         }
         if(tail == null)
         {
            tail = _loc2_;
         }
         else
         {
            _loc2_.previous = tail;
            tail.next = _loc2_;
            tail = _loc2_;
         }
         return _loc2_;
      }
   }
}
