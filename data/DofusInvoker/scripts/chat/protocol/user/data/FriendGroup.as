package chat.protocol.user.data
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class FriendGroup extends JsonifiedMessage
   {
       
      
      public var name:String;
      
      public function FriendGroup(name:String)
      {
         super();
         this.name = name;
      }
      
      public function toString() : String
      {
         return this.name;
      }
   }
}
