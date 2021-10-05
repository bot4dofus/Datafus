package mx.messaging.messages
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class AcknowledgeMessage extends AsyncMessage implements ISmallMessage
   {
      
      public static const ERROR_HINT_HEADER:String = "DSErrorHint";
       
      
      public function AcknowledgeMessage()
      {
         super();
      }
      
      override public function getSmallMessage() : IMessage
      {
         var o:Object = this;
         if(o.constructor == AcknowledgeMessage)
         {
            return new AcknowledgeMessageExt(this);
         }
         return null;
      }
      
      override public function readExternal(input:IDataInput) : void
      {
         var flags:uint = 0;
         var reservedPosition:uint = 0;
         var j:uint = 0;
         super.readExternal(input);
         var flagsArray:Array = readFlags(input);
         for(var i:uint = 0; i < flagsArray.length; i++)
         {
            flags = flagsArray[i] as uint;
            reservedPosition = 0;
            if(flags >> reservedPosition != 0)
            {
               for(j = reservedPosition; j < 6; j++)
               {
                  if((flags >> j & 1) != 0)
                  {
                     input.readObject();
                  }
               }
            }
         }
      }
      
      override public function writeExternal(output:IDataOutput) : void
      {
         super.writeExternal(output);
         var flags:uint = 0;
         output.writeByte(flags);
      }
   }
}
