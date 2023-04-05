package com.demonsters.debugger
{
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   class MonsterDebuggerDescribeType
   {
      
      private static var cache:Object = {};
       
      
      function MonsterDebuggerDescribeType()
      {
         super();
      }
      
      static function get(object:*) : XML
      {
         var key:String = getQualifiedClassName(object);
         if(key in cache)
         {
            return cache[key];
         }
         var xml:XML = describeType(object);
         cache[key] = xml;
         return xml;
      }
   }
}
