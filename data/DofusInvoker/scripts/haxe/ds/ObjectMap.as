package haxe.ds
{
   import flash.utils.Dictionary;
   import haxe.IMap;
   import haxe.ds._ObjectMap.NativePropertyIterator;
   
   public dynamic class ObjectMap extends Dictionary implements IMap
   {
       
      
      public function ObjectMap()
      {
         super(false);
      }
      
      public function keys() : Object
      {
         var _loc1_:NativePropertyIterator = new NativePropertyIterator();
         _loc1_.collection = this;
         return _loc1_;
      }
   }
}
