package mx.utils
{
   public class LinkedList
   {
       
      
      private var _head:LinkedListNode;
      
      private var _tail:LinkedListNode;
      
      private var _length:Number = 0;
      
      public function LinkedList()
      {
         super();
         this._head = new LinkedListNode();
         this._tail = new LinkedListNode();
         this._head.next = this._tail;
         this._tail.prev = this._head;
      }
      
      public function get head() : LinkedListNode
      {
         return this._head.next == this._tail ? null : this._head.next;
      }
      
      public function get length() : Number
      {
         return this._length;
      }
      
      public function get tail() : LinkedListNode
      {
         return this._tail.prev == this._head ? null : this._tail.prev;
      }
      
      public function insertAfter(value:*, prev:LinkedListNode) : LinkedListNode
      {
         var node:LinkedListNode = this.makeNode(value);
         node.prev = prev;
         node.next = prev.next;
         node.prev.next = node;
         node.next.prev = node;
         ++this._length;
         return node;
      }
      
      public function insertBefore(value:*, next:LinkedListNode) : LinkedListNode
      {
         var node:LinkedListNode = this.makeNode(value);
         node.prev = next.prev;
         node.next = next;
         node.prev.next = node;
         node.next.prev = node;
         ++this._length;
         return node;
      }
      
      public function find(value:*) : LinkedListNode
      {
         var cur:LinkedListNode = this._head;
         while(cur.value != value && cur != this._tail)
         {
            cur = cur.next;
         }
         return cur == this._tail ? null : cur;
      }
      
      public function remove(value:*) : LinkedListNode
      {
         var node:LinkedListNode = this.getNode(value);
         if(node)
         {
            node.prev.next = node.next;
            node.next.prev = node.prev;
            node.next = node.prev = null;
            --this._length;
         }
         return node;
      }
      
      public function push(value:*) : LinkedListNode
      {
         return this.insertAfter(value,this._tail.prev);
      }
      
      public function pop() : LinkedListNode
      {
         return this._length == 0 ? null : this.remove(this._tail.prev);
      }
      
      public function unshift(value:*) : LinkedListNode
      {
         return this.insertAfter(value,this._head);
      }
      
      public function shift() : LinkedListNode
      {
         return this._length == 0 ? null : this.remove(this._head.next);
      }
      
      protected function getNode(value:*) : LinkedListNode
      {
         return value is LinkedListNode ? value : this.find(value);
      }
      
      protected function makeNode(value:*) : LinkedListNode
      {
         return value is LinkedListNode ? value : new LinkedListNode(value);
      }
   }
}
