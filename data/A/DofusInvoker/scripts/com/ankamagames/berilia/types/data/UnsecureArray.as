package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.interfaces.Secure;
   
   public dynamic class UnsecureArray extends Array implements Secure
   {
       
      
      public function UnsecureArray()
      {
         super();
      }
      
      public function getObject(accessKey:Object) : *
      {
         return this;
      }
   }
}
