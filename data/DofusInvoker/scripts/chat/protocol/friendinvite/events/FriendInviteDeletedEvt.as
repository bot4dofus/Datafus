package chat.protocol.friendinvite.events
{
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.friendinvite.data.FriendInvite;
   
   public class FriendInviteDeletedEvt extends JsonifiedMessage
   {
       
      
      public var invite:FriendInvite;
      
      public var reason:String;
      
      public function FriendInviteDeletedEvt(invite:FriendInvite, reason:String)
      {
         super();
         this.invite = invite;
         this.reason = reason;
      }
   }
}
