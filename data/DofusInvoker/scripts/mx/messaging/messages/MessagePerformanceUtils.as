package mx.messaging.messages
{
   public class MessagePerformanceUtils
   {
      
      public static const MPI_HEADER_IN:String = "DSMPII";
      
      public static const MPI_HEADER_OUT:String = "DSMPIO";
      
      public static const MPI_HEADER_PUSH:String = "DSMPIP";
       
      
      public var mpii:MessagePerformanceInfo;
      
      public var mpio:MessagePerformanceInfo;
      
      public var mpip:MessagePerformanceInfo;
      
      public function MessagePerformanceUtils(message:Object)
      {
         super();
         this.mpii = message.headers[MPI_HEADER_IN] as MessagePerformanceInfo;
         this.mpio = message.headers[MPI_HEADER_OUT] as MessagePerformanceInfo;
         if(this.mpio == null || this.mpii == null && message.headers[MPI_HEADER_PUSH] == null)
         {
            throw new Error("Message is missing MPI headers.  Verify that all participants have it enabled.");
         }
         if(this.pushedMessageFlag)
         {
            this.mpip = message.headers[MPI_HEADER_PUSH] as MessagePerformanceInfo;
         }
      }
      
      public function get totalTime() : Number
      {
         if(this.mpii == null)
         {
            return 0;
         }
         return this.mpio.receiveTime - this.mpii.sendTime;
      }
      
      public function get serverProcessingTime() : Number
      {
         if(this.pushedMessageFlag)
         {
            return this.mpip.serverPrePushTime - this.mpip.receiveTime;
         }
         return this.mpio.sendTime - this.mpii.receiveTime;
      }
      
      public function get serverPrePushTime() : Number
      {
         if(this.mpii == null)
         {
            return 0;
         }
         if(this.mpii.serverPrePushTime == 0)
         {
            return this.serverProcessingTime;
         }
         return this.mpii.serverPrePushTime - this.mpii.receiveTime;
      }
      
      public function get serverAdapterTime() : Number
      {
         if(this.pushedMessageFlag)
         {
            if(this.mpip == null)
            {
               return 0;
            }
            if(this.mpip.serverPreAdapterTime == 0 || this.mpip.serverPostAdapterTime == 0)
            {
               return 0;
            }
            return this.mpip.serverPostAdapterTime - this.mpip.serverPreAdapterTime;
         }
         if(this.mpii == null)
         {
            return 0;
         }
         if(this.mpii.serverPreAdapterTime == 0 || this.mpii.serverPostAdapterTime == 0)
         {
            return 0;
         }
         return this.mpii.serverPostAdapterTime - this.mpii.serverPreAdapterTime;
      }
      
      public function get serverAdapterExternalTime() : Number
      {
         if(this.pushedMessageFlag)
         {
            if(this.mpip == null)
            {
               return 0;
            }
            if(this.mpip.serverPreAdapterExternalTime == 0 || this.mpip.serverPostAdapterExternalTime == 0)
            {
               return 0;
            }
            return this.mpip.serverPostAdapterExternalTime - this.mpip.serverPreAdapterExternalTime;
         }
         if(this.mpii == null)
         {
            return 0;
         }
         if(this.mpii.serverPreAdapterExternalTime == 0 || this.mpii.serverPostAdapterExternalTime == 0)
         {
            return 0;
         }
         return this.mpii.serverPostAdapterExternalTime - this.mpii.serverPreAdapterExternalTime;
      }
      
      public function get serverPollDelay() : Number
      {
         if(this.mpip == null)
         {
            return 0;
         }
         if(this.mpip.serverPrePushTime == 0 || this.mpio.sendTime == 0)
         {
            return 0;
         }
         return this.mpio.sendTime - this.mpip.serverPrePushTime;
      }
      
      public function get serverNonAdapterTime() : Number
      {
         return this.serverProcessingTime - this.serverAdapterTime;
      }
      
      public function get networkRTT() : Number
      {
         if(!this.pushedMessageFlag)
         {
            return this.totalTime - this.serverProcessingTime;
         }
         return 0;
      }
      
      public function get serverSendTime() : Number
      {
         return this.mpio.sendTime;
      }
      
      public function get clientReceiveTime() : Number
      {
         return this.mpio.receiveTime;
      }
      
      public function get messageSize() : int
      {
         if(this.mpii == null)
         {
            return 0;
         }
         return this.mpii.messageSize;
      }
      
      public function get responseMessageSize() : int
      {
         return this.mpio.messageSize;
      }
      
      public function get pushedMessageFlag() : Boolean
      {
         return this.mpio.pushedFlag;
      }
      
      public function get totalPushTime() : Number
      {
         return this.clientReceiveTime - this.originatingMessageSentTime - this.pushedOverheadTime;
      }
      
      public function get pushOneWayTime() : Number
      {
         return this.clientReceiveTime - this.serverSendTime;
      }
      
      public function get originatingMessageSentTime() : Number
      {
         return this.mpip.sendTime;
      }
      
      public function get originatingMessageSize() : Number
      {
         return this.mpip.messageSize;
      }
      
      public function prettyPrint() : String
      {
         var alertString:* = new String("");
         if(this.messageSize != 0)
         {
            alertString += "Original message size(B): " + this.messageSize + "\n";
         }
         if(this.responseMessageSize != 0)
         {
            alertString += "Response message size(B): " + this.responseMessageSize + "\n";
         }
         if(this.totalTime != 0)
         {
            alertString += "Total time (s): " + this.totalTime / 1000 + "\n";
         }
         if(this.networkRTT != 0)
         {
            alertString += "Network Roundtrip time (s): " + this.networkRTT / 1000 + "\n";
         }
         if(this.serverProcessingTime != 0)
         {
            alertString += "Server processing time (s): " + this.serverProcessingTime / 1000 + "\n";
         }
         if(this.serverAdapterTime != 0)
         {
            alertString += "Server adapter time (s): " + this.serverAdapterTime / 1000 + "\n";
         }
         if(this.serverNonAdapterTime != 0)
         {
            alertString += "Server non-adapter time (s): " + this.serverNonAdapterTime / 1000 + "\n";
         }
         if(this.serverAdapterExternalTime != 0)
         {
            alertString += "Server adapter external time (s): " + this.serverAdapterExternalTime / 1000 + "\n";
         }
         if(this.pushedMessageFlag)
         {
            alertString += "PUSHED MESSAGE INFORMATION:\n";
            if(this.totalPushTime != 0)
            {
               alertString += "Total push time (s): " + this.totalPushTime / 1000 + "\n";
            }
            if(this.pushOneWayTime != 0)
            {
               alertString += "Push one way time (s): " + this.pushOneWayTime / 1000 + "\n";
            }
            if(this.originatingMessageSize != 0)
            {
               alertString += "Originating Message size (B): " + this.originatingMessageSize + "\n";
            }
            if(this.serverPollDelay != 0)
            {
               alertString += "Server poll delay (s): " + this.serverPollDelay / 1000 + "\n";
            }
         }
         return alertString;
      }
      
      private function get pushedOverheadTime() : Number
      {
         return this.mpip.overheadTime;
      }
   }
}
