package chat.protocol.user.data
{
   import chat.protocol.common.JsonifiedMessage;
   import flash.utils.Dictionary;
   
   public class EndpointProperties extends JsonifiedMessage
   {
       
      
      public var applicationId:int;
      
      public var activities:Vector.<String>;
      
      public var metadata:Dictionary;
      
      public function EndpointProperties(applicationId:int, activities:Vector.<String>, metadata:Dictionary)
      {
         super();
         this.applicationId = applicationId;
         this.activities = activities;
         this.metadata = metadata;
      }
   }
}
