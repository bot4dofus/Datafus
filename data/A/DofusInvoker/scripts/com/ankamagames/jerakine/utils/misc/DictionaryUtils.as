package com.ankamagames.jerakine.utils.misc
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class DictionaryUtils
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StringUtils));
       
      
      public function DictionaryUtils()
      {
         super();
      }
      
      public static function getLength(d:Dictionary) : int
      {
         var length:int = 0;
         var key:* = null;
         for(key in d)
         {
            length++;
         }
         return length;
      }
   }
}
