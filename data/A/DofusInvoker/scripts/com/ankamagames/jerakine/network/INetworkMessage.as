package com.ankamagames.jerakine.network
{
   import com.ankamagames.jerakine.messages.IdentifiedMessage;
   import com.ankamagames.jerakine.messages.QueueableMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public interface INetworkMessage extends IdentifiedMessage, QueueableMessage
   {
       
      
      function pack(param1:ICustomDataOutput) : void;
      
      function unpack(param1:ICustomDataInput, param2:uint) : void;
      
      function unpackAsync(param1:ICustomDataInput, param2:uint) : FuncTree;
      
      function get isInitialized() : Boolean;
      
      function get unpacked() : Boolean;
      
      function set unpacked(param1:Boolean) : void;
   }
}
