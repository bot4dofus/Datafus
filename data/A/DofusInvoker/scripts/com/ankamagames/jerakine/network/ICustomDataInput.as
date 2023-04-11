package com.ankamagames.jerakine.network
{
   import flash.utils.IDataInput;
   
   public interface ICustomDataInput extends IDataInput
   {
       
      
      function readVarInt() : int;
      
      function readVarUhInt() : uint;
      
      function readVarShort() : int;
      
      function readVarUhShort() : uint;
      
      function readVarLong() : Number;
      
      function readVarUhLong() : Number;
   }
}
