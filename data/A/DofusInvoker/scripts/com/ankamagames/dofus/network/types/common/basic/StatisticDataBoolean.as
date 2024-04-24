package com.ankamagames.dofus.network.types.common.basic
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class StatisticDataBoolean extends StatisticData implements INetworkType
   {
      
      public static const protocolId:uint = 7132;
       
      
      public var value:Boolean = false;
      
      public function StatisticDataBoolean()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7132;
      }
      
      public function initStatisticDataBoolean(value:Boolean = false) : StatisticDataBoolean
      {
         this.value = value;
         return this;
      }
      
      override public function reset() : void
      {
         this.value = false;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_StatisticDataBoolean(output);
      }
      
      public function serializeAs_StatisticDataBoolean(output:ICustomDataOutput) : void
      {
         super.serializeAs_StatisticData(output);
         output.writeBoolean(this.value);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StatisticDataBoolean(input);
      }
      
      public function deserializeAs_StatisticDataBoolean(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._valueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StatisticDataBoolean(tree);
      }
      
      public function deserializeAsyncAs_StatisticDataBoolean(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._valueFunc);
      }
      
      private function _valueFunc(input:ICustomDataInput) : void
      {
         this.value = input.readBoolean();
      }
   }
}
