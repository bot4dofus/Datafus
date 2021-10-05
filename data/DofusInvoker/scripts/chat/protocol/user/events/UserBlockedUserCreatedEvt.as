package chat.protocol.user.events
{
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.user.data.User;
   
   public class UserBlockedUserCreatedEvt extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var blockedUser:User;
      
      public function UserBlockedUserCreatedEvt(userId:String, blockedUser:User)
      {
         super();
         this.userId = userId;
         this.blockedUser = blockedUser;
      }
   }
}
