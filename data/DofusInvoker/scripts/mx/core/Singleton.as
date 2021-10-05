package mx.core
{
   use namespace mx_internal;
   
   [ExcludeClass]
   public class Singleton
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      private static var classMap:Object = {};
       
      
      public function Singleton()
      {
         super();
      }
      
      public static function registerClass(interfaceName:String, clazz:Class) : void
      {
         var c:Class = classMap[interfaceName];
         if(!c)
         {
            classMap[interfaceName] = clazz;
         }
      }
      
      public static function getClass(interfaceName:String) : Class
      {
         return classMap[interfaceName];
      }
      
      public static function getInstance(interfaceName:String) : Object
      {
         var c:Class = classMap[interfaceName];
         if(!c)
         {
            throw new Error("No class registered for interface \'" + interfaceName + "\'.");
         }
         return c["getInstance"]();
      }
   }
}
