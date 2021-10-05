package chat.protocol.user.events
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class UserPresenceUpdatedEvt extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var presence:String;
      
      public function UserPresenceUpdatedEvt(userId:String, presence:String)
      {
         super();
         this.userId = userId;
         this.presence = presence;
      }
   }
}
