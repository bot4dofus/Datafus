package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class ChatServiceHookList
   {
      
      public static const ChatServiceUserConnected:String = "ChatServiceUserConnected";
      
      public static const ChatServiceUserDisconnected:String = "ChatServiceUserDisconnected";
      
      public static const ChatServiceUserUpdatedPresence:String = "ChatServiceUserUpdatedPresence";
      
      public static const ChatServiceUserUpdatedStatus:String = "ChatServiceUserUpdatedStatus";
      
      public static const ChatServiceUserUpdateHisActivity:String = "ChatServiceUserUpdateHisActivity";
      
      public static const ChatServiceUserUpdatedActivities:String = "ChatServiceUserUpdatedActivities";
      
      public static const ChatServiceChannelMessage:String = "ChatServiceChannelMessage";
      
      public static const ChatServiceChannelMessageListUpdated:String = "ChatServiceChannelMessageListUpdated";
      
      public static const ChatServiceFriendInviteListUpdated:String = "ChatServiceFriendInviteListUpdated";
      
      public static const ChatServiceFriendInviteCreated:String = "ChatServiceFriendInviteCreated";
      
      public static const ChatServiceFriendInviteProcessed:String = "ChatServiceFriendInviteProcessed";
      
      public static const ChatServiceUserFriendInviteResponse:String = "ChatServiceUserFriendInviteResponse";
      
      public static const ChatServiceUserFriendCreated:String = "ChatServiceUserFriendCreated";
      
      public static const ChatServiceUserFriendDeleted:String = "ChatServiceUserFriendDeleted";
      
      public static const ChatServiceUserFriendUpdated:String = "ChatServiceUserFriendUpdated";
      
      public static const ChatServiceFriendListUpdated:String = "ChatServiceFriendListUpdated";
      
      public static const ChatServiceFriendGroupsUpdated:String = "ChatServiceFriendGroupsUpdated";
      
      public static const ChatServiceFriendGroupCreated:String = "ChatServiceFriendGroupCreated";
      
      public static const ChatServiceFriendGroupDeleted:String = "ChatServiceFriendGroupDeleted";
      
      public static const ChatServiceUserBlockedCreated:String = "ChatServiceUserBlockedCreated";
      
      public static const ChatServiceUserBlockedDeleted:String = "ChatServiceUserBlockedDeleted";
      
      public static const ChatServiceUserBlockedList:String = "ChatServiceUserBlockedList";
       
      
      public function ChatServiceHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(ChatServiceUserConnected);
         Hook.createHook(ChatServiceUserDisconnected);
         Hook.createHook(ChatServiceUserUpdatedPresence);
         Hook.createHook(ChatServiceUserUpdatedStatus);
         Hook.createHook(ChatServiceUserUpdateHisActivity);
         Hook.createHook(ChatServiceUserUpdatedActivities);
         Hook.createHook(ChatServiceChannelMessage);
         Hook.createHook(ChatServiceChannelMessageListUpdated);
         Hook.createHook(ChatServiceFriendInviteListUpdated);
         Hook.createHook(ChatServiceFriendInviteCreated);
         Hook.createHook(ChatServiceFriendInviteProcessed);
         Hook.createHook(ChatServiceUserFriendInviteResponse);
         Hook.createHook(ChatServiceUserFriendCreated);
         Hook.createHook(ChatServiceUserFriendDeleted);
         Hook.createHook(ChatServiceUserFriendUpdated);
         Hook.createHook(ChatServiceFriendListUpdated);
         Hook.createHook(ChatServiceFriendGroupsUpdated);
         Hook.createHook(ChatServiceFriendGroupCreated);
         Hook.createHook(ChatServiceFriendGroupDeleted);
         Hook.createHook(ChatServiceUserBlockedCreated);
         Hook.createHook(ChatServiceUserBlockedDeleted);
         Hook.createHook(ChatServiceUserBlockedList);
      }
   }
}
