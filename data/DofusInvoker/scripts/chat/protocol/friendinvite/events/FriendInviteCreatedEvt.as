package chat.protocol.friendinvite.events
{
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.friendinvite.data.FriendInvite;
   
   public class FriendInviteCreatedEvt extends JsonifiedMessage
   {
       
      
      public var invite:FriendInvite;
      
      public function FriendInviteCreatedEvt(invite:FriendInvite)
      {
         super();
         this.invite = invite;
      }
   }
}
