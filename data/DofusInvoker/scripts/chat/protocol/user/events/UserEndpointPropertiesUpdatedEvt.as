package chat.protocol.user.events
{
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.user.data.EndpointProperties;
   
   public class UserEndpointPropertiesUpdatedEvt extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var properties:Vector.<EndpointProperties>;
      
      public function UserEndpointPropertiesUpdatedEvt(userId:String, properties:Array)
      {
         super();
         this.userId = userId;
         this.properties = Vector.<EndpointProperties>(properties);
      }
   }
}
