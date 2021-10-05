package chat.protocol.user.data
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class User extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var name:String;
      
      public var tag:String;
      
      public function User(id:String, userName:String, _tag:String = "")
      {
         super();
         this.userId = id;
         this.name = userName;
         this.tag = !_tag ? "" : _tag;
      }
      
      public function toString() : String
      {
         return "(" + this.name + ":" + this.userId + ")";
      }
   }
}
