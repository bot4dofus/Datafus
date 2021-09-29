package chat.protocol.user.commands
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class CreateUserBlockedUserCmd extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var blockedUserId:String;
      
      public function CreateUserBlockedUserCmd(userId:String, blockedUserId:String)
      {
         super();
         this.userId = userId;
         this.blockedUserId = blockedUserId;
      }
   }
}
