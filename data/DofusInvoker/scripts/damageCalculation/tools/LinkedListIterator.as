package damageCalculation.tools
{
   public class LinkedListIterator
   {
       
      
      public var cursor:LinkedListNode;
      
      public function LinkedListIterator(param1:LinkedListNode)
      {
         cursor = param1;
      }
      
      public function next() : LinkedListNode
      {
         var _loc1_:LinkedListNode = cursor;
         cursor = cursor.next;
         return _loc1_;
      }
      
      public function hasNext() : Boolean
      {
         return cursor != null;
      }
   }
}
