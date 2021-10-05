package haxe.ds
{
   import haxe.ds._List.ListNode;
   
   public class List
   {
       
      
      public var q:ListNode;
      
      public var length:int;
      
      public var h:ListNode;
      
      public function List()
      {
         length = 0;
      }
      
      public function remove(param1:Object) : Boolean
      {
         var _loc2_:ListNode = null;
         var _loc3_:ListNode = h;
         while(_loc3_ != null)
         {
            if(_loc3_.item == param1)
            {
               if(_loc2_ == null)
               {
                  h = _loc3_.next;
               }
               else
               {
                  _loc2_.next = _loc3_.next;
               }
               if(q == _loc3_)
               {
                  q = _loc2_;
               }
               length = length - 1;
               return true;
            }
            _loc2_ = _loc3_;
            _loc3_ = _loc3_.next;
         }
         return false;
      }
      
      public function map(param1:Function) : List
      {
         var _loc4_:* = null as Object;
         var _loc2_:List = new List();
         var _loc3_:ListNode = h;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.item;
            _loc3_ = _loc3_.next;
            _loc2_.add(param1(_loc4_));
         }
         return _loc2_;
      }
      
      public function isEmpty() : Boolean
      {
         return h == null;
      }
      
      public function filter(param1:Function) : List
      {
         var _loc4_:* = null as Object;
         var _loc2_:List = new List();
         var _loc3_:ListNode = h;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.item;
            _loc3_ = _loc3_.next;
            if(param1(_loc4_))
            {
               _loc2_.add(_loc4_);
            }
         }
         return _loc2_;
      }
      
      public function add(param1:Object) : void
      {
         var _loc2_:ListNode = new ListNode(param1,null);
         if(h == null)
         {
            h = _loc2_;
         }
         else
         {
            q.next = _loc2_;
         }
         q = _loc2_;
         length = length + 1;
      }
   }
}
