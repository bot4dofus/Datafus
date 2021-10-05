package chat.protocol.friendinvite.commands
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class DeleteFriendInviteCmd extends JsonifiedMessage
   {
       
      
      public var inviterUserId:String;
      
      public var recipientUserId:String;
      
      public var reason:String;
      
      public function DeleteFriendInviteCmd(inviterUserId:String, recipientUserId:String, reason:String)
      {
         super();
         this.inviterUserId = inviterUserId;
         this.recipientUserId = recipientUserId;
         this.reason = reason;
      }
   }
}
