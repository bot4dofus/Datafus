package com.ankamagames.jerakine.network
{
   public interface ILagometer
   {
       
      
      function ping(param1:INetworkMessage = null) : void;
      
      function pong(param1:INetworkMessage = null) : void;
      
      function stop() : void;
   }
}
