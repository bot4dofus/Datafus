package com.ankamagames.jerakine.logger
{
   public final class ModuleLogger
   {
      
      public static var active:Boolean = false;
      
      private static var _callbacks:Vector.<Function> = new Vector.<Function>(0);
       
      
      public function ModuleLogger()
      {
         super();
      }
      
      public static function log(... args) : void
      {
         var f:Function = null;
         if(active)
         {
            for each(f in _callbacks)
            {
               f.apply(f,args);
            }
         }
      }
      
      public static function addCallback(callBack:Function) : void
      {
         _callbacks.push(callBack);
      }
      
      public static function removeCallback(callBack:Function) : void
      {
         var index:int = _callbacks.indexOf(callBack);
         if(index != -1)
         {
            _callbacks.splice(index,1);
         }
      }
   }
}
