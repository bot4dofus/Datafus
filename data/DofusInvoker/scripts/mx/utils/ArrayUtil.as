package mx.utils
{
   import mx.collections.IList;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class ArrayUtil
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      public function ArrayUtil()
      {
         super();
      }
      
      public static function toArray(obj:Object) : Array
      {
         if(obj == null)
         {
            return [];
         }
         if(obj is Array)
         {
            return obj as Array;
         }
         if(obj is IList)
         {
            return (obj as IList).toArray();
         }
         return [obj];
      }
      
      public static function getItemIndex(item:Object, source:Array) : int
      {
         var n:int = source.length;
         for(var i:int = 0; i < n; i++)
         {
            if(source[i] === item)
            {
               return i;
            }
         }
         return -1;
      }
      
      public static function arraysMatch(a:Array, b:Array, strictEqualityCheck:Boolean = true) : Boolean
      {
         var index:String = null;
         if(!a || !b)
         {
            return false;
         }
         if(a.length != b.length)
         {
            return false;
         }
         var indexesA:Array = ObjectUtil.getEnumerableProperties(a);
         for(var i:int = 0; i < indexesA.length; i++)
         {
            index = indexesA[i];
            if(!b.hasOwnProperty(index))
            {
               return false;
            }
            if(strictEqualityCheck && a[index] !== b[index])
            {
               return false;
            }
            if(!strictEqualityCheck && a[index] != b[index])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function arrayValuesMatch(a:Array, b:Array, strictEqualityCheck:Boolean = true) : Boolean
      {
         if(!a || !b)
         {
            return false;
         }
         var valuesOfA:Array = getArrayValues(a);
         valuesOfA.sort();
         var valuesOfB:Array = getArrayValues(b);
         valuesOfB.sort();
         return arraysMatch(valuesOfA,valuesOfB,strictEqualityCheck);
      }
      
      public static function getArrayValues(value:Array) : Array
      {
         var index:String = null;
         var result:Array = [];
         if(!value)
         {
            return result;
         }
         var indexes:Array = ObjectUtil.getEnumerableProperties(value);
         for each(index in indexes)
         {
            result.push(value[index]);
         }
         return result;
      }
   }
}
