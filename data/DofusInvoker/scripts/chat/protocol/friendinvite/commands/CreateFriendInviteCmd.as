package chat.protocol.friendinvite.commands
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class CreateFriendInviteCmd extends JsonifiedMessage
   {
       
      
      public var inviterUserId:String;
      
      public var recipientUserId:String;
      
      public function CreateFriendInviteCmd(inviterUserId:String, recipientUserId:String)
      {
         super();
         this.inviterUserId = inviterUserId;
         this.recipientUserId = recipientUserId;
      }
   }
}
