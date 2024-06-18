package com.ankamagames.dofus.network.types.common.basic
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class StatisticDataShort extends StatisticData implements INetworkType
   {
      
      public static const protocolId:uint = 1762;
       
      
      public var value:int = 0;
      
      public function StatisticDataShort()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1762;
      }
      
      public function initStatisticDataShort(value:int = 0) : StatisticDataShort
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
         this.serializeAs_StatisticDataShort(output);
      }
      
      public function serializeAs_StatisticDataShort(output:ICustomDataOutput) : void
      {
         super.serializeAs_StatisticData(output);
         output.writeShort(this.value);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StatisticDataShort(input);
      }
      
      public function deserializeAs_StatisticDataShort(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._valueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StatisticDataShort(tree);
      }
      
      public function deserializeAsyncAs_StatisticDataShort(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._valueFunc);
      }
      
      private function _valueFunc(input:ICustomDataInput) : void
      {
         this.value = input.readShort();
      }
   }
}
