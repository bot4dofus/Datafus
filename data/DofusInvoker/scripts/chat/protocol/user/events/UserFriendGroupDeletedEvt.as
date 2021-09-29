package chat.protocol.user.events
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class UserFriendGroupDeletedEvt extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var name:String;
      
      public function UserFriendGroupDeletedEvt(userId:String, name:String)
      {
         super();
         this.userId = userId;
         this.name = name;
      }
   }
}
