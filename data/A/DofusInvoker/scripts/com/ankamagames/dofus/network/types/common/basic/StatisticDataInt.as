package com.ankamagames.dofus.network.types.common.basic
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class StatisticDataInt extends StatisticData implements INetworkType
   {
      
      public static const protocolId:uint = 7834;
       
      
      public var value:int = 0;
      
      public function StatisticDataInt()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7834;
      }
      
      public function initStatisticDataInt(value:int = 0) : StatisticDataInt
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
         this.serializeAs_StatisticDataInt(output);
      }
      
      public function serializeAs_StatisticDataInt(output:ICustomDataOutput) : void
      {
         super.serializeAs_StatisticData(output);
         output.writeInt(this.value);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StatisticDataInt(input);
      }
      
      public function deserializeAs_StatisticDataInt(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._valueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StatisticDataInt(tree);
      }
      
      public function deserializeAsyncAs_StatisticDataInt(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._valueFunc);
      }
      
      private function _valueFunc(input:ICustomDataInput) : void
      {
         this.value = input.readInt();
      }
   }
}
