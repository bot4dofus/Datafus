package com.ankamagames.jerakine.network
{
   import flash.utils.ByteArray;
   
   public interface INetworkDataContainerMessage
   {
       
      
      function get content() : ByteArray;
      
      function set content(param1:ByteArray) : void;
   }
}
