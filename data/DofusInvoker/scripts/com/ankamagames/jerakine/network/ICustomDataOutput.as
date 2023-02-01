package com.ankamagames.jerakine.network
{
   import flash.utils.IDataOutput;
   
   public interface ICustomDataOutput extends IDataOutput
   {
       
      
      function writeVarInt(param1:int) : void;
      
      function writeVarShort(param1:int) : void;
      
      function writeVarLong(param1:Number) : void;
   }
}
