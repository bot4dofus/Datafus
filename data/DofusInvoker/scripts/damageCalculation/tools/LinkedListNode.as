package damageCalculation.tools
{
   public class LinkedListNode
   {
       
      
      public var previous:LinkedListNode;
      
      public var next:LinkedListNode;
      
      public var item:Object;
      
      public function LinkedListNode(param1:Object)
      {
         next = null;
         previous = null;
         item = param1;
      }
   }
}
