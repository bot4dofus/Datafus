package chat.protocol.user.events
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class UserBlockedUserDeletedEvt extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var blockedUserId:String;
      
      public function UserBlockedUserDeletedEvt(userId:String, blockedUserId:String)
      {
         super();
         this.userId = userId;
         this.blockedUserId = blockedUserId;
      }
   }
}
