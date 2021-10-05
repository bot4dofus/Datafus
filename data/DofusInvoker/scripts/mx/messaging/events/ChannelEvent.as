package mx.messaging.events
{
   import flash.events.Event;
   import mx.messaging.Channel;
   
   public class ChannelEvent extends Event
   {
      
      public static const CONNECT:String = "channelConnect";
      
      public static const DISCONNECT:String = "channelDisconnect";
       
      
      public var channel:Channel;
      
      public var connected:Boolean;
      
      public var reconnecting:Boolean;
      
      public var rejected:Boolean;
      
      public function ChannelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, channel:Channel = null, reconnecting:Boolean = false, rejected:Boolean = false, connected:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this.channel = channel;
         this.reconnecting = reconnecting;
         this.rejected = rejected;
         this.connected = connected;
      }
      
      public static function createEvent(type:String, channel:Channel = null, reconnecting:Boolean = false, rejected:Boolean = false, connected:Boolean = false) : ChannelEvent
      {
         return new ChannelEvent(type,false,false,channel,reconnecting,rejected,connected);
      }
      
      public function get channelId() : String
      {
         if(this.channel != null)
         {
            return this.channel.id;
         }
         return null;
      }
      
      override public function clone() : Event
      {
         return new ChannelEvent(type,bubbles,cancelable,this.channel,this.reconnecting,this.rejected,this.connected);
      }
      
      override public function toString() : String
      {
         return formatToString("ChannelEvent","channelId","reconnecting","rejected","type","bubbles","cancelable","eventPhase");
      }
   }
}
