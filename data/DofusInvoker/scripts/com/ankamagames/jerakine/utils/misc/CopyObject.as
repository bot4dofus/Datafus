package com.ankamagames.jerakine.utils.misc
{
   public class CopyObject
   {
       
      
      public function CopyObject()
      {
         super();
      }
      
      public static function copyObject(o:Object, exclude:Array = null, output:Object = null) : Object
      {
         var propertyName:String = null;
         if(!output)
         {
            var output:Object = {};
         }
         var properties:Vector.<String> = DescribeTypeCache.getVariables(o);
         for each(propertyName in properties)
         {
            if(!(exclude && exclude.indexOf(propertyName) != -1 || propertyName == "prototype"))
            {
               try
               {
                  output[propertyName] = o[propertyName];
               }
               catch(e:SecurityError)
               {
               }
            }
         }
         return output;
      }
   }
}
