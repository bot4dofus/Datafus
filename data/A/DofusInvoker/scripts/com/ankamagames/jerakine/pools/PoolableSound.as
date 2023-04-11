package com.ankamagames.jerakine.pools
{
   import flash.media.Sound;
   
   public class PoolableSound extends Sound implements Poolable
   {
       
      
      public function PoolableSound()
      {
         super();
      }
      
      public function renew() : Sound
      {
         return this;
      }
      
      public function free() : void
      {
      }
   }
}
