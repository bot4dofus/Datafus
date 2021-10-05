package haxe.ds._IntMap
{
   import flash.utils.Dictionary;
   
   public class IntMapValuesIterator
   {
       
      
      public var nextIndex:int;
      
      public var index:int;
      
      public var h:Dictionary;
      
      public function IntMapValuesIterator(param1:Dictionary)
      {
         h = param1;
         index = 0;
         var _loc2_:Dictionary = h;
         var _loc3_:int = index;
         var _loc4_:Boolean = §§hasnext(_loc2_,_loc3_);
         nextIndex = _loc3_;
      }
      
      public function next() : Object
      {
         var _loc1_:Object = §§nextvalue(nextIndex,h);
         index = nextIndex;
         return _loc1_;
      }
      
      public function hasNext() : Boolean
      {
         var _loc1_:Dictionary = h;
         var _loc2_:int = index;
         var _loc3_:Boolean = §§hasnext(_loc1_,_loc2_);
         nextIndex = _loc2_;
         return _loc3_;
      }
   }
}
