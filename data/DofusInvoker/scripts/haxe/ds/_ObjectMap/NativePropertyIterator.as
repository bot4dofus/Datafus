package haxe.ds._ObjectMap
{
   public class NativePropertyIterator
   {
       
      
      public var index:int;
      
      public var collection;
      
      public function NativePropertyIterator()
      {
         index = 0;
      }
      
      public function next() : *
      {
         var _loc1_:int = index;
         var _loc2_:* = §§nextname(_loc1_,collection);
         index = _loc1_;
         return _loc2_;
      }
      
      public function hasNext() : Boolean
      {
         var _loc1_:* = collection;
         var _loc2_:int = index;
         var _loc3_:Boolean = §§hasnext(_loc1_,_loc2_);
         collection = _loc1_;
         index = _loc2_;
         return _loc3_;
      }
   }
}
