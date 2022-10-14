package com.ankamagames.jerakine.network
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public interface IConnectionProxy
   {
       
      
      function processAndSend(param1:INetworkMessage, param2:IDataOutput) : void;
      
      function processAndReceive(param1:IDataInput) : INetworkMessage;
   }
}
