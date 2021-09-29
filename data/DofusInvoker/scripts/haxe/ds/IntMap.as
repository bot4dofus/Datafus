package haxe.ds
{
   import flash.utils.Dictionary;
   import haxe.IMap;
   
   public class IntMap implements IMap
   {
       
      
      public var h:Dictionary;
      
      public function IntMap()
      {
         h = new Dictionary();
      }
   }
}
