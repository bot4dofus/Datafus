package com.ankamagames.dofus.network.types.common.basic
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class StatisticDataByte extends StatisticData implements INetworkType
   {
      
      public static const protocolId:uint = 4903;
       
      
      public var value:int = 0;
      
      public function StatisticDataByte()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4903;
      }
      
      public function initStatisticDataByte(value:int = 0) : StatisticDataByte
      {
         this.value = value;
         return this;
      }
      
      override public function reset() : void
      {
         this.value = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_StatisticDataByte(output);
      }
      
      public function serializeAs_StatisticDataByte(output:ICustomDataOutput) : void
      {
         super.serializeAs_StatisticData(output);
         output.writeByte(this.value);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StatisticDataByte(input);
      }
      
      public function deserializeAs_StatisticDataByte(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._valueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StatisticDataByte(tree);
      }
      
      public function deserializeAsyncAs_StatisticDataByte(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._valueFunc);
      }
      
      private function _valueFunc(input:ICustomDataInput) : void
      {
         this.value = input.readByte();
      }
   }
}
