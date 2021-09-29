package haxe.ds._List
{
   public class ListNode
   {
       
      
      public var next:ListNode;
      
      public var item:Object;
      
      public function ListNode(param1:Object, param2:ListNode)
      {
         item = param1;
         next = param2;
      }
   }
}
