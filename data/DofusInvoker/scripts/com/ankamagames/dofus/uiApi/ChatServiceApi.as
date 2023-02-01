package com.ankamagames.dofus.uiApi
{
   import chat.protocol.channel.data.ChannelMessage;
   import chat.protocol.friendinvite.data.DeleteFriendInviteReason;
   import chat.protocol.friendinvite.data.FriendInvite;
   import chat.protocol.user.data.Friend;
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.dofus.logic.game.spin2.chat.ChatService;
   import com.ankamagames.dofus.logic.game.spin2.chat.ChatServiceManager;
   
   [InstanciedApi]
   public class ChatServiceApi implements IApi
   {
       
      
      public function ChatServiceApi()
      {
         super();
      }
      
      public function get service() : ChatService
      {
         return ChatServiceManager.getInstance().chatService;
      }
      
      public function getFriendsList() : Vector.<Friend>
      {
         return this.service === null || this.service.friendList === null ? new Vector.<Friend>() : this.service.friendList.values;
      }
      
      public function getWaitingList() : Vector.<FriendInvite>
      {
         return this.service === null || this.service.pendingFriendInvitesList === null ? new Vector.<FriendInvite>() : this.service.pendingFriendInvitesList.values;
      }
      
      public function getMessages() : Vector.<ChannelMessage>
      {
         return this.service.messageBuffer;
      }
      
      public function acceptInvite(invite:FriendInvite) : void
      {
         if(this.service !== null)
         {
            this.service.processUserFriendInvite(invite.inviter.userId,invite.recipient.userId,DeleteFriendInviteReason.ACCEPTED);
         }
      }
      
      public function rejectInvite(invite:FriendInvite) : void
      {
         if(this.service !== null)
         {
            this.service.processUserFriendInvite(invite.inviter.userId,invite.recipient.userId,DeleteFriendInviteReason.REJECTED);
         }
      }
      
      public function cancelInvite(invite:FriendInvite) : void
      {
         if(this.service !== null)
         {
            this.service.processUserFriendInvite(invite.inviter.userId,invite.recipient.userId,DeleteFriendInviteReason.CANCELED);
         }
      }
   }
}
