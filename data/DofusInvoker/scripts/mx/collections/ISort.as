package mx.collections
{
   public interface ISort
   {
       
      
      function get compareFunction() : Function;
      
      function set compareFunction(param1:Function) : void;
      
      function get fields() : Array;
      
      function set fields(param1:Array) : void;
      
      function get unique() : Boolean;
      
      function set unique(param1:Boolean) : void;
      
      function findItem(param1:Array, param2:Object, param3:String, param4:Boolean = false, param5:Function = null) : int;
      
      function propertyAffectsSort(param1:String) : Boolean;
      
      function reverse() : void;
      
      function sort(param1:Array) : void;
   }
}
