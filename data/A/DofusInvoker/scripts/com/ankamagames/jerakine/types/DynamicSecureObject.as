package com.ankamagames.jerakine.types
{
   import com.ankamagames.jerakine.interfaces.Secure;
   
   public dynamic class DynamicSecureObject implements Secure
   {
       
      
      public function DynamicSecureObject()
      {
         super();
      }
      
      public function getObject(accessKey:Object) : *
      {
         return this;
      }
   }
}
