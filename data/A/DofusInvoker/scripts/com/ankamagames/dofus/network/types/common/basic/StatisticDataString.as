package com.ankamagames.dofus.network.types.common.basic
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class StatisticDataString extends StatisticData implements INetworkType
   {
      
      public static const protocolId:uint = 4102;
       
      
      public var value:String = "";
      
      public function StatisticDataString()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4102;
      }
      
      public function initStatisticDataString(value:String = "") : StatisticDataString
      {
         this.value = value;
         return this;
      }
      
      override public function reset() : void
      {
         this.value = "";
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_StatisticDataString(output);
      }
      
      public function serializeAs_StatisticDataString(output:ICustomDataOutput) : void
      {
         super.serializeAs_StatisticData(output);
         output.writeUTF(this.value);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StatisticDataString(input);
      }
      
      public function deserializeAs_StatisticDataString(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._valueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StatisticDataString(tree);
      }
      
      public function deserializeAsyncAs_StatisticDataString(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._valueFunc);
      }
      
      private function _valueFunc(input:ICustomDataInput) : void
      {
         this.value = input.readUTF();
      }
   }
}
