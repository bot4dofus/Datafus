package mx.messaging.events
{
   import flash.events.Event;
   import mx.messaging.Channel;
   import mx.messaging.messages.ErrorMessage;
   
   public class ChannelFaultEvent extends ChannelEvent
   {
      
      public static const FAULT:String = "channelFault";
       
      
      public var faultCode:String;
      
      public var faultDetail:String;
      
      public var faultString:String;
      
      public var rootCause:Object;
      
      public function ChannelFaultEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, channel:Channel = null, reconnecting:Boolean = false, code:String = null, level:String = null, description:String = null, rejected:Boolean = false, connected:Boolean = false)
      {
         super(type,bubbles,cancelable,channel,reconnecting,rejected,connected);
         this.faultCode = code;
         this.faultString = level;
         this.faultDetail = description;
      }
      
      public static function createEvent(channel:Channel, reconnecting:Boolean = false, code:String = null, level:String = null, description:String = null, rejected:Boolean = false, connected:Boolean = false) : ChannelFaultEvent
      {
         return new ChannelFaultEvent(ChannelFaultEvent.FAULT,false,false,channel,reconnecting,code,level,description,rejected,connected);
      }
      
      override public function clone() : Event
      {
         var faultEvent:ChannelFaultEvent = new ChannelFaultEvent(type,bubbles,cancelable,channel,reconnecting,this.faultCode,this.faultString,this.faultDetail,rejected,connected);
         faultEvent.rootCause = this.rootCause;
         return faultEvent;
      }
      
      override public function toString() : String
      {
         return formatToString("ChannelFaultEvent","faultCode","faultString","faultDetail","channelId","type","bubbles","cancelable","eventPhase");
      }
      
      public function createErrorMessage() : ErrorMessage
      {
         var result:ErrorMessage = new ErrorMessage();
         result.faultCode = this.faultCode;
         result.faultString = this.faultString;
         result.faultDetail = this.faultDetail;
         result.rootCause = this.rootCause;
         return result;
      }
   }
}
