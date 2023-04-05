package com.ankamagames.jerakine.network
{
   public interface RawDataParser
   {
       
      
      function parse(param1:ICustomDataInput, param2:uint, param3:uint) : INetworkMessage;
      
      function parseAsync(param1:ICustomDataInput, param2:uint, param3:uint, param4:Function) : INetworkMessage;
      
      function getUnpackMode(param1:uint) : uint;
   }
}
