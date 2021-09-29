package chat.protocol.friendinvite.data
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class FriendInviteList extends JsonifiedMessage
   {
       
      
      public var values:Vector.<FriendInvite>;
      
      public function FriendInviteList(values:Array)
      {
         super();
         this.values = Vector.<FriendInvite>(values);
      }
   }
}
