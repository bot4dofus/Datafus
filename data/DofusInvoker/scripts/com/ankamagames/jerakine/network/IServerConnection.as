package com.ankamagames.jerakine.network
{
   import com.ankamagames.jerakine.messages.MessageHandler;
   
   public interface IServerConnection
   {
       
      
      function get rawParser() : RawDataParser;
      
      function set rawParser(param1:RawDataParser) : void;
      
      function get handler() : MessageHandler;
      
      function set handler(param1:MessageHandler) : void;
      
      function get pauseBuffer() : Array;
      
      function get connected() : Boolean;
      
      function get connecting() : Boolean;
      
      function get latencyAvg() : uint;
      
      function get latencySamplesCount() : uint;
      
      function get latencySamplesMax() : uint;
      
      function get lagometer() : ILagometer;
      
      function set lagometer(param1:ILagometer) : void;
      
      function connect(param1:String, param2:int) : void;
      
      function close() : void;
      
      function pause() : void;
      
      function resume() : void;
      
      function send(param1:INetworkMessage, param2:String = "") : void;
   }
}
