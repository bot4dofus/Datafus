package com.ankamagames.jerakine.utils.memory
{
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class SoftReference
   {
       
      
      private var value;
      
      private var keptTime:uint;
      
      private var timeout:uint;
      
      public function SoftReference(obj:*, keptTime:uint = 10000)
      {
         super();
         this.value = obj;
         this.keptTime = keptTime;
         this.resetTimeout();
      }
      
      public function get object() : *
      {
         this.resetTimeout();
         return this.value;
      }
      
      private function resetTimeout() : void
      {
         clearTimeout(this.timeout);
         if(this.value)
         {
            this.timeout = setTimeout(this.clearReference,this.keptTime);
         }
      }
      
      private function clearReference() : void
      {
         this.value = null;
      }
   }
}
