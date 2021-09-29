package chat.protocol.user.events
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class UserStatusUpdatedEvt extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var status:String;
      
      public function UserStatusUpdatedEvt(userId:String, status:String)
      {
         super();
         this.userId = userId;
         this.status = status;
      }
   }
}
