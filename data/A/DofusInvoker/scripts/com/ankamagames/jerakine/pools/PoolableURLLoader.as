package com.ankamagames.jerakine.pools
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.errors.IOError;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.getQualifiedClassName;
   
   public class PoolableURLLoader extends URLLoader implements Poolable
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PoolableURLLoader));
       
      
      public function PoolableURLLoader(request:URLRequest = null)
      {
         super(request);
      }
      
      public function free() : void
      {
         try
         {
            close();
         }
         catch(ioe:IOError)
         {
         }
      }
   }
}
