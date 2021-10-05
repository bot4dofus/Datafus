package mx.messaging.messages
{
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class CommandMessageExt extends CommandMessage implements IExternalizable
   {
       
      
      private var _message:CommandMessage;
      
      public function CommandMessageExt(message:CommandMessage = null)
      {
         super();
         this._message = message;
      }
      
      override public function writeExternal(output:IDataOutput) : void
      {
         if(this._message != null)
         {
            this._message.writeExternal(output);
         }
         else
         {
            super.writeExternal(output);
         }
      }
      
      override public function get messageId() : String
      {
         if(this._message != null)
         {
            return this._message.messageId;
         }
         return super.messageId;
      }
   }
}
