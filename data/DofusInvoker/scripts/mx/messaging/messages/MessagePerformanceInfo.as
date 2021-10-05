package mx.messaging.messages
{
   public class MessagePerformanceInfo
   {
       
      
      public var messageSize:int;
      
      public var sendTime:Number = 0;
      
      private var _receiveTime:Number;
      
      public var overheadTime:Number;
      
      private var _infoType:String;
      
      public var pushedFlag:Boolean;
      
      public var serverPrePushTime:Number;
      
      public var serverPreAdapterTime:Number;
      
      public var serverPostAdapterTime:Number;
      
      public var serverPreAdapterExternalTime:Number;
      
      public var serverPostAdapterExternalTime:Number;
      
      public var recordMessageTimes:Boolean;
      
      public var recordMessageSizes:Boolean;
      
      public function MessagePerformanceInfo()
      {
         super();
      }
      
      public function set infoType(type:String) : void
      {
         var curDate:Date = null;
         this._infoType = type;
         if(this._infoType == "OUT")
         {
            curDate = new Date();
            this._receiveTime = curDate.getTime();
         }
      }
      
      public function get infoType() : String
      {
         return this._infoType;
      }
      
      public function set receiveTime(time:Number) : void
      {
         if(this._infoType == null || this._infoType != "OUT")
         {
            this._receiveTime = time;
         }
      }
      
      public function get receiveTime() : Number
      {
         return this._receiveTime;
      }
   }
}
