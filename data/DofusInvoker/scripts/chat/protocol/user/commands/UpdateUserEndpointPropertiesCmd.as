package chat.protocol.user.commands
{
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.user.data.EndpointProperties;
   
   public class UpdateUserEndpointPropertiesCmd extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var properties:EndpointProperties;
      
      public function UpdateUserEndpointPropertiesCmd(userId:String, properties:EndpointProperties)
      {
         super();
         this.userId = userId;
         this.properties = properties;
      }
   }
}
