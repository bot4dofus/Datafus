package chat.protocol.transport
{
   import chat.protocol.channel.data.ChannelMessage;
   import chat.protocol.channel.events.ChannelMessageCreatedEvt;
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.common.PayloadType;
   import chat.protocol.friendinvite.data.FriendInvite;
   import chat.protocol.friendinvite.data.FriendInviteList;
   import chat.protocol.friendinvite.events.FriendInviteCreatedEvt;
   import chat.protocol.friendinvite.events.FriendInviteDeletedEvt;
   import chat.protocol.user.data.EndpointProperties;
   import chat.protocol.user.data.Friend;
   import chat.protocol.user.data.FriendGroup;
   import chat.protocol.user.data.FriendGroupList;
   import chat.protocol.user.data.FriendList;
   import chat.protocol.user.data.User;
   import chat.protocol.user.data.UserList;
   import chat.protocol.user.events.UserBlockedUserCreatedEvt;
   import chat.protocol.user.events.UserBlockedUserDeletedEvt;
   import chat.protocol.user.events.UserEndpointPropertiesUpdatedEvt;
   import chat.protocol.user.events.UserFriendCreatedEvt;
   import chat.protocol.user.events.UserFriendDeletedEvt;
   import chat.protocol.user.events.UserFriendGroupCreatedEvt;
   import chat.protocol.user.events.UserFriendGroupDeletedEvt;
   import chat.protocol.user.events.UserFriendUpdatedEvt;
   import chat.protocol.user.events.UserPresenceUpdatedEvt;
   import chat.protocol.user.events.UserStatusUpdatedEvt;
   import flash.utils.Dictionary;
   import pools.PoolablePayload;
   import pools.PoolsManager;
   
   public class Payload extends JsonifiedMessage
   {
       
      
      public var id:int;
      
      public var data:JsonifiedMessage;
      
      public function Payload(payloadType:int, payload:JsonifiedMessage)
      {
         super();
         this.init(payloadType,payload);
      }
      
      public static function createFromReceivedJsonObject(payloadType:int, _data:Object) : Payload
      {
         var userActivities:Array = null;
         var friendInvites:Array = null;
         var friends:Array = null;
         var groups:Array = null;
         var property:Object = null;
         var map:Dictionary = null;
         var key:* = null;
         var fi:Object = null;
         var friend:Object = null;
         var group:Object = null;
         var processedContent:PoolablePayload = PoolsManager.getInstance().getPayloadPool().checkOut() as PoolablePayload;
         switch(payloadType)
         {
            case PayloadType.USER_EVT_UserPresenceUpdated:
               processedContent = processedContent.renew(payloadType,new UserPresenceUpdatedEvt(_data.userId,_data.presence));
               break;
            case PayloadType.USER_EVT_UserStatusUpdated:
               processedContent = processedContent.renew(payloadType,new UserStatusUpdatedEvt(_data.userId,_data.status));
               break;
            case PayloadType.USER_EVT_UserEndpointPropertiesUpdatedEvt:
               userActivities = [];
               for each(property in _data.properties)
               {
                  map = new Dictionary();
                  for(key in property.metadata)
                  {
                     map[key] = property.metadata[key];
                  }
                  userActivities.push(new EndpointProperties(property.applicationId,Vector.<String>(property.activities),map));
               }
               processedContent = processedContent.renew(payloadType,new UserEndpointPropertiesUpdatedEvt(_data.userId,userActivities));
               break;
            case PayloadType.USER_User:
               processedContent = processedContent.renew(payloadType,new User(_data.userId,_data.name,_data.tag));
               break;
            case PayloadType.FRIEND_INVITE_FriendInviteList:
               friendInvites = [];
               for each(fi in _data.values)
               {
                  friendInvites.push(new FriendInvite(new User(fi.inviter.userId,fi.inviter.name,fi.inviter.tag),new User(fi.recipient.userId,fi.recipient.name,fi.recipient.tag)));
               }
               processedContent = processedContent.renew(payloadType,new FriendInviteList(friendInvites));
               break;
            case PayloadType.CHANNEL_EVT_ChannelMessageCreatedEvt:
               processedContent = processedContent.renew(payloadType,new ChannelMessageCreatedEvt(new ChannelMessage(_data.message.messageId,_data.message.channelId,_data.message.createdTimestamp,_data.message.content,new User(_data.message.author.userId,_data.message.author.name,_data.message.author.tag))));
               break;
            case PayloadType.FRIEND_INVITE_EVT_FriendInviteCreated:
               processedContent = processedContent.renew(payloadType,new FriendInviteCreatedEvt(new FriendInvite(new User(_data.invite.inviter.userId,_data.invite.inviter.name,_data.invite.inviter.tag),new User(_data.invite.recipient.userId,_data.invite.recipient.name,_data.invite.recipient.tag))));
               break;
            case PayloadType.FRIEND_INVITE_EVT_FriendInviteDeleted:
               processedContent = processedContent.renew(payloadType,new FriendInviteDeletedEvt(new FriendInvite(new User(_data.invite.inviter.userId,_data.invite.inviter.name,_data.invite.inviter.tag),new User(_data.invite.recipient.userId,_data.invite.recipient.name,_data.invite.recipient.tag)),_data.reason));
               break;
            case PayloadType.USER_EVT_UserFriendCreated:
               processedContent = processedContent.renew(payloadType,new UserFriendCreatedEvt(_data.userId,new Friend(new User(_data.friend.user.userId,_data.friend.user.name,_data.friend.user.tag),null)));
               break;
            case PayloadType.USER_EVT_UserFriendUpdated:
               processedContent = processedContent.renew(payloadType,new UserFriendUpdatedEvt(_data.userId,new Friend(new User(_data.friend.user.userId,_data.friend.user.name,_data.friend.user.tag),new FriendGroup(_data.friend.group.name))));
               break;
            case PayloadType.USER_EVT_UserFriendDeleted:
               processedContent = processedContent.renew(payloadType,new UserFriendDeletedEvt(_data.userId,_data.friendUserId));
               break;
            case PayloadType.USER_EVT_UserFriendGroupCreated:
               processedContent = processedContent.renew(payloadType,new UserFriendGroupCreatedEvt(_data.userId,new FriendGroup(_data.group.name)));
               break;
            case PayloadType.USER_EVT_UserFriendGroupDeleted:
               processedContent = processedContent.renew(payloadType,new UserFriendGroupDeletedEvt(_data.userId,_data.name));
               break;
            case PayloadType.USER_FriendList:
               friends = [];
               for each(friend in _data.values)
               {
                  friends.push(new Friend(new User(friend.user.userId,friend.user.name,friend.user.tag),friend.group != null ? new FriendGroup(friend.group.name) : null));
               }
               processedContent = processedContent.renew(payloadType,new FriendList(friends));
               break;
            case PayloadType.USER_FriendGroupList:
               groups = [];
               for each(group in _data.values)
               {
                  groups.push(new FriendGroup(group.name));
               }
               processedContent = processedContent.renew(payloadType,new FriendGroupList(groups));
               break;
            case PayloadType.USER_EVT_UserBlockedUserCreatedEvt:
               processedContent = processedContent.renew(payloadType,new UserBlockedUserCreatedEvt(_data.userId,_data.blockedUserId));
               break;
            case PayloadType.USER_EVT_UserBlockedUserDeletedEvt:
               processedContent = processedContent.renew(payloadType,new UserBlockedUserDeletedEvt(_data.userId,_data.blockedUserId));
               break;
            case PayloadType.USER_UserList:
               processedContent = processedContent.renew(payloadType,new UserList(_data.values));
         }
         return processedContent;
      }
      
      protected function init(payloadType:int, payload:JsonifiedMessage) : void
      {
         this.id = payloadType;
         this.data = payload;
      }
   }
}
