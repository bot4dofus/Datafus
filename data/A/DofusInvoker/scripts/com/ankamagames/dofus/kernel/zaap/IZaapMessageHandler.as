package com.ankamagames.dofus.kernel.zaap
{
   import com.ankamagames.dofus.kernel.zaap.messages.IZaapInputMessage;
   
   public interface IZaapMessageHandler
   {
       
      
      function handleConnectionOpened() : void;
      
      function handleMessage(param1:IZaapInputMessage) : void;
      
      function handleConnectionClosed() : void;
   }
}
