package chat.protocol.common
{
   public final class PayloadType
   {
      
      public static const FRIEND_INVITE_CMD_CreateFriendInvite:int = -666416802;
      
      public static const FRIEND_INVITE_CMD_DeleteFriendInvite:int = 1707706475;
      
      public static const FRIEND_INVITE_FriendInvite:int = 1982397216;
      
      public static const FRIEND_INVITE_EVT_FriendInviteCreated:int = 775219117;
      
      public static const FRIEND_INVITE_EVT_FriendInviteDeleted:int = -280368044;
      
      public static const FRIEND_INVITE_FriendInviteList:int = 425860746;
      
      public static const USER_CMD_CreateUserFriendGroup:int = 2103632902;
      
      public static const USER_CMD_DeleteUserFriend:int = 926307863;
      
      public static const USER_CMD_DeleteUserFriendGroup:int = -2027713560;
      
      public static const USER_Friend:int = 2098162165;
      
      public static const USER_FriendGroup:int = 862990330;
      
      public static const USER_FriendGroupList:int = -87853131;
      
      public static const USER_FriendList:int = -1150791598;
      
      public static const USER_CMD_ListUserFriendGroups:int = 1348064163;
      
      public static const USER_CMD_ListUserFriendInvites:int = 669955095;
      
      public static const USER_CMD_ListUserFriends:int = -1933682604;
      
      public static const USER_CMD_UpdateUserEndpointPropertiesCmd:int = -73350898;
      
      public static const USER_CMD_UpdateUserFriend:int = 200201123;
      
      public static const USER_CMD_UpdateUserStatus:int = 172854262;
      
      public static const USER_User:int = -1819083583;
      
      public static const USER_EVT_UserEndpointPropertiesUpdatedEvt:int = 1572432262;
      
      public static const USER_EndpointProperties:int = 340427268;
      
      public static const USER_EVT_UserFriendCreated:int = 1611743244;
      
      public static const USER_EVT_UserFriendDeleted:int = -1586738187;
      
      public static const USER_EVT_UserFriendGroupCreated:int = -1805159704;
      
      public static const USER_EVT_UserFriendGroupDeleted:int = 1427798289;
      
      public static const USER_EVT_UserFriendUpdated:int = -1459775045;
      
      public static const USER_EVT_UserPresenceUpdated:int = -128858966;
      
      public static const USER_EVT_UserStatusUpdated:int = -1225369838;
      
      public static const USER_CMD_CreateUserBlockedUserCmd:int = 535531165;
      
      public static const USER_CMD_DeleteUserBlockedUserCmd:int = -441785997;
      
      public static const USER_CMD_ListUserBlockedUsersCmd:int = 937824261;
      
      public static const USER_EVT_UserBlockedUserCreatedEvt:int = -48328327;
      
      public static const USER_EVT_UserBlockedUserDeletedEvt:int = 1013160576;
      
      public static const USER_UserList:int = -1130070377;
      
      public static const CHANNEL_CMD_ListChannelMessagesCmd:int = -882050982;
      
      public static const CHANNEL_EVT_ChannelMessageCreatedEvt:int = 804239649;
      
      public static const CHANNEL_ChannelMessage:int = -1069660172;
      
      public static const CHANNEL_ChannelMessageList:int = 1116378206;
      
      public static const CHANNEL_CMD_CreateChannelMessageCmd:int = 1835442294;
       
      
      public function PayloadType()
      {
         super();
      }
      
      public static function getPayloadType(type:int) : String
      {
         var toReturn:String = null;
         switch(type)
         {
            case FRIEND_INVITE_CMD_CreateFriendInvite:
               toReturn = "FRIEND_INVITE_CMD_CreateFriendInvite";
               break;
            case FRIEND_INVITE_CMD_DeleteFriendInvite:
               toReturn = "FRIEND_INVITE_CMD_DeleteFriendInvite";
               break;
            case FRIEND_INVITE_FriendInvite:
               toReturn = "FRIEND_INVITE_FriendInvite";
               break;
            case FRIEND_INVITE_EVT_FriendInviteCreated:
               toReturn = "FRIEND_INVITE_EVT_FriendInviteCreated";
               break;
            case FRIEND_INVITE_EVT_FriendInviteDeleted:
               toReturn = "FRIEND_INVITE_EVT_FriendInviteDeleted";
               break;
            case FRIEND_INVITE_FriendInviteList:
               toReturn = "FRIEND_INVITE_FriendInviteList";
               break;
            case USER_CMD_CreateUserFriendGroup:
               toReturn = "USER_CMD_CreateUserFriendGroup";
               break;
            case USER_CMD_DeleteUserFriend:
               toReturn = "USER_CMD_DeleteUserFriend";
               break;
            case USER_CMD_DeleteUserFriendGroup:
               toReturn = "USER_CMD_DeleteUserFriendGroup";
               break;
            case USER_Friend:
               toReturn = "USER_Friend";
               break;
            case USER_FriendGroup:
               toReturn = "USER_FriendGroup";
               break;
            case USER_FriendGroupList:
               toReturn = "USER_FriendGroupList";
               break;
            case USER_FriendList:
               toReturn = "USER_FriendList";
               break;
            case USER_CMD_ListUserFriendGroups:
               toReturn = "USER_CMD_ListUserFriendGroups";
               break;
            case USER_CMD_ListUserFriendInvites:
               toReturn = "USER_CMD_ListUserFriendInvites";
               break;
            case USER_CMD_ListUserFriends:
               toReturn = "USER_CMD_ListUserFriends";
               break;
            case USER_CMD_UpdateUserEndpointPropertiesCmd:
               toReturn = "USER_CMD_UpdateUserEndpointPropertiesCmd";
               break;
            case USER_CMD_UpdateUserFriend:
               toReturn = "USER_CMD_UpdateUserFriend";
               break;
            case USER_CMD_UpdateUserStatus:
               toReturn = "USER_CMD_UpdateUserStatus";
               break;
            case USER_User:
               toReturn = "USER_User";
               break;
            case USER_EVT_UserEndpointPropertiesUpdatedEvt:
               toReturn = "USER_EVT_UserEndpointPropertiesUpdatedEvt";
               break;
            case USER_EndpointProperties:
               toReturn = "USER_EndpointProperties";
               break;
            case USER_EVT_UserFriendCreated:
               toReturn = "USER_EVT_UserFriendCreated";
               break;
            case USER_EVT_UserFriendDeleted:
               toReturn = "USER_EVT_UserFriendDeleted";
               break;
            case USER_EVT_UserFriendGroupCreated:
               toReturn = "USER_EVT_UserFriendGroupCreated";
               break;
            case USER_EVT_UserFriendGroupDeleted:
               toReturn = "USER_EVT_UserFriendGroupDeleted";
               break;
            case USER_EVT_UserFriendUpdated:
               toReturn = "USER_EVT_UserFriendUpdated";
               break;
            case USER_EVT_UserPresenceUpdated:
               toReturn = "USER_EVT_UserPresenceUpdated";
               break;
            case USER_EVT_UserStatusUpdated:
               toReturn = "USER_EVT_UserStatusUpdated";
               break;
            case CHANNEL_CMD_ListChannelMessagesCmd:
               toReturn = "CHANNEL_EVT_ChannelMessageCreatedEvt";
               break;
            case CHANNEL_CMD_CreateChannelMessageCmd:
               toReturn = "CHANNEL_CMD_CreateChannelMessageCmd";
               break;
            case CHANNEL_EVT_ChannelMessageCreatedEvt:
               toReturn = "CHANNEL_EVT_ChannelMessageCreatedEvt";
               break;
            case CHANNEL_ChannelMessage:
               toReturn = "CHANNEL_ChannelMessage";
               break;
            case CHANNEL_ChannelMessageList:
               toReturn = "CHANNEL_ChannelMessageList";
               break;
            case USER_CMD_CreateUserBlockedUserCmd:
               toReturn = "USER_CMD_CreateUserBlockedUserCmd";
               break;
            case USER_CMD_DeleteUserBlockedUserCmd:
               toReturn = "USER_CMD_DeleteUserBlockedUserCmd";
               break;
            case USER_CMD_ListUserBlockedUsersCmd:
               toReturn = "USER_CMD_ListUserBlockedUsersCmd";
               break;
            case USER_EVT_UserBlockedUserCreatedEvt:
               toReturn = "USER_EVT_UserBlockedUserCreatedEvt";
               break;
            case USER_EVT_UserBlockedUserDeletedEvt:
               toReturn = "USER_EVT_UserBlockedUserDeletedEvt";
         }
         return toReturn;
      }
   }
}
