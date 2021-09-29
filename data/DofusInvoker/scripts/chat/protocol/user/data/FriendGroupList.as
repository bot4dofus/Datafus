package chat.protocol.user.data
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class FriendGroupList extends JsonifiedMessage
   {
       
      
      public var values:Vector.<FriendGroup>;
      
      public function FriendGroupList(values:Array)
      {
         super();
         this.values = Vector.<FriendGroup>(values);
      }
   }
}
