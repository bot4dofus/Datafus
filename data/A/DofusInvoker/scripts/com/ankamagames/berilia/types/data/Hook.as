package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class Hook
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Hook));
      
      private static var _hookNameList:Array;
       
      
      public function Hook()
      {
         super();
      }
      
      public static function createHook(name:String) : void
      {
         if(!_hookNameList)
         {
            _hookNameList = [];
         }
         if(_hookNameList.indexOf(name) == -1)
         {
            _hookNameList.push(name);
         }
         else
         {
            _log.error("Hook " + name + " was already created before this, no need to recreate it");
         }
      }
      
      public static function checkIfHookExists(name:String) : Boolean
      {
         return _hookNameList.indexOf(name) != -1;
      }
   }
}
