package chat.protocol.user.commands
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class UpdateUserStatusCmd extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var status:String;
      
      public function UpdateUserStatusCmd(userId:String, status:String)
      {
         super();
         this.userId = userId;
         this.status = status;
      }
   }
}
