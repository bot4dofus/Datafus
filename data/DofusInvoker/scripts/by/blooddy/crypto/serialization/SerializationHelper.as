package by.blooddy.crypto.serialization
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   [ExcludeClass]
   public final class SerializationHelper
   {
      
      private static const _EMPTY_ARR:Array = new Array();
      
      private static const _HASH_CLASS:Dictionary = new Dictionary(true);
      
      private static const _HASH_INSTANCE:Dictionary = new Dictionary(true);
       
      
      public function SerializationHelper()
      {
         super();
         Error.throwError(ArgumentError,2012,getQualifiedClassName(this));
      }
      
      public static function getPropertyNames(o:Object) : Array
      {
         var arr:Array = null;
         var c:Object = null;
         var n:String = null;
         var list:XMLList = null;
         var x:XML = null;
         if(typeof o != "object" || !o)
         {
            Error.throwError(TypeError,2007,"o");
         }
         var isClass:Boolean = o is Class;
         if(isClass)
         {
            c = o as Class;
            arr = _HASH_CLASS[c];
         }
         else
         {
            c = o.constructor as Class;
            arr = _HASH_CLASS[c];
         }
         if(!arr)
         {
            arr = new Array();
            for each(x in describeType(o).*)
            {
               n = x.name();
               if((n == "accessor" && x.@access.charAt(0) == "r" || n == "variable" || n == "constant") && x.@uri.length() <= 0)
               {
                  list = x.metadata;
                  if(list.length() <= 0 || list.(@name == "Transient").length() <= 0)
                  {
                     arr.push(x.@name.toString());
                  }
               }
            }
            if(isClass)
            {
               _HASH_CLASS[c] = arr;
            }
            else
            {
               _HASH_INSTANCE[c] = arr;
            }
         }
         return arr.slice();
      }
   }
}
