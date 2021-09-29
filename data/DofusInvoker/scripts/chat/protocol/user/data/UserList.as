package chat.protocol.user.data
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class UserList extends JsonifiedMessage
   {
       
      
      public var values:Vector.<User>;
      
      public function UserList(values:Array)
      {
         super();
         this.values = Vector.<User>(values);
      }
      
      public function toString() : String
      {
         var result:* = null;
         for(var i:int = 0; i < this.values.length; i++)
         {
            result += this.values[i].toString();
            if(i + 1 < this.values.length)
            {
               result += ", ";
            }
         }
         return result;
      }
   }
}
