package chat.protocol.user.commands
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class DeleteUserFriendGroupCmd extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var name:String;
      
      public function DeleteUserFriendGroupCmd(userId:String, name:String)
      {
         super();
         this.userId = userId;
         this.name = name;
      }
   }
}
