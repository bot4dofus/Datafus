package chat.protocol.friendinvite.data
{
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.user.data.User;
   
   public class FriendInvite extends JsonifiedMessage
   {
       
      
      public var inviter:User;
      
      public var recipient:User;
      
      public function FriendInvite(inviter:User, recipient:User)
      {
         super();
         this.inviter = inviter;
         this.recipient = recipient;
      }
      
      public function toString() : String
      {
         return this.inviter.toString() + " - invites - " + this.recipient.toString();
      }
   }
}
