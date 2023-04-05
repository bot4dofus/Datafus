package com.ankamagames.berilia.managers
{
   import flash.errors.IllegalOperationError;
   
   public class SecureCenter
   {
      
      public static const ACCESS_KEY:Object = new Object();
       
      
      public function SecureCenter()
      {
         super();
      }
      
      public static function destroy(target:*) : void
      {
         if(target && "destroy" in target)
         {
            target.destroy();
         }
      }
      
      public static function checkAccessKey(accessKey:Object) : void
      {
         if(accessKey != ACCESS_KEY)
         {
            throw new IllegalOperationError("Wrong access key");
         }
      }
   }
}
