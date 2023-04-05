package com.ankamagames.jerakine.utils.misc
{
   import flash.net.SharedObject;
   import mx.utils.UIDUtil;
   
   public class DeviceUtils
   {
       
      
      public function DeviceUtils()
      {
         super();
      }
      
      public static function get deviceUniqueIdentifier() : String
      {
         var soUid:SharedObject = SharedObject.getLocal("device_uid");
         if(!UIDUtil.isUID(soUid.data.uid))
         {
            soUid.data.uid = UIDUtil.createUID();
            soUid.flush();
         }
         return soUid.data.uid;
      }
   }
}
