package chat.protocol.friendinvite.commands
{
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.friendinvite.data.RecipientUserNameAndTag;
   
   public class CreateFriendInviteWithNameAndTagCmd extends JsonifiedMessage
   {
       
      
      public var inviterUserId:String;
      
      public var recipientUserNameAndTag:RecipientUserNameAndTag;
      
      public function CreateFriendInviteWithNameAndTagCmd(inviterUserId:String, recipientUserNameAndTag:RecipientUserNameAndTag)
      {
         super();
         this.inviterUserId = inviterUserId;
         this.recipientUserNameAndTag = recipientUserNameAndTag;
      }
   }
}
