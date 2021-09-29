package chat.auth
{
   import chat.protocol.common.JsonifiedMessage;
   import clientspecs.ClientType;
   import clientspecs.Device;
   import clientspecs.OS;
   import com.ankamagames.jerakine.utils.misc.DeviceUtils;
   import flash.system.Capabilities;
   
   public class AuthRequest extends JsonifiedMessage
   {
       
      
      public var token:String;
      
      public var clientType:uint;
      
      public var osType:uint;
      
      public var deviceType:uint;
      
      public var deviceId:String;
      
      public function AuthRequest(haapiToken:String)
      {
         super();
         this.token = haapiToken;
         this.clientType = ClientType.STANDALONE;
         this.deviceType = Device.PC;
         this.deviceId = DeviceUtils.deviceUniqueIdentifier;
         if(Capabilities.os.indexOf("Linux") != -1)
         {
            this.osType = OS.LINUX;
         }
         else if(Capabilities.os.indexOf("Mac OS") != -1)
         {
            this.osType = OS.MACOS;
         }
         else
         {
            this.osType = OS.WINDOWS;
         }
      }
   }
}
