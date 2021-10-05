package mx.utils
{
   public class LinkedListNode
   {
       
      
      public var next:LinkedListNode;
      
      public var prev:LinkedListNode;
      
      public var value;
      
      public function LinkedListNode(value:* = null)
      {
         super();
         this.value = value;
      }
   }
}
