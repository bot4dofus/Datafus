package cmodule.lua_wrapper
{
   import flash.utils.ByteArray;
   
   class GLEByteArrayProvider
   {
       
      
      function GLEByteArrayProvider()
      {
         super();
      }
      
      public static function get() : ByteArray
      {
         var result:ByteArray = null;
         try
         {
            result = gdomainClass.currentDomain.domainMemory;
         }
         catch(e:*)
         {
         }
         if(!result)
         {
            result = new LEByteArray();
            try
            {
               result.length = gdomainClass.MIN_DOMAIN_MEMORY_LENGTH;
               gdomainClass.currentDomain.domainMemory = result;
            }
            catch(e:*)
            {
               log(3,"Not using domain memory");
            }
         }
         return result;
      }
   }
}
