package Ankama_Admin.adminMenu.items
{
   import Ankama_Admin.Api;
   
   public class SendChatItem extends ExecItem
   {
       
      
      public var text:String;
      
      public function SendChatItem(text:String, delay:int = 0, repeat:int = 0)
      {
         this.text = text;
         super(delay,repeat);
      }
      
      override public function get callbackFunction() : Function
      {
         var chatUi:Object = Api.uiApi.getUi("chat");
         if(chatUi && chatUi.uiClass)
         {
            return chatUi.uiClass.sendMessage;
         }
         return null;
      }
      
      override public function getcallbackArgs(replaceParam:Object) : Array
      {
         return [replace(this.text,replaceParam)];
      }
   }
}
