package com.ankamagames.dofus.network.messages.game.context.roleplay.stats
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class StatsUpgradeRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7474;
       
      
      private var _isInitialized:Boolean = false;
      
      public var useAdditionnal:Boolean = false;
      
      public var statId:uint = 11;
      
      public var boostPoint:uint = 0;
      
      public function StatsUpgradeRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7474;
      }
      
      public function initStatsUpgradeRequestMessage(useAdditionnal:Boolean = false, statId:uint = 11, boostPoint:uint = 0) : StatsUpgradeRequestMessage
      {
         this.useAdditionnal = useAdditionnal;
         this.statId = statId;
         this.boostPoint = boostPoint;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.useAdditionnal = false;
         this.statId = 11;
         this.boostPoint = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_StatsUpgradeRequestMessage(output);
      }
      
      public function serializeAs_StatsUpgradeRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.useAdditionnal);
         output.writeByte(this.statId);
         if(this.boostPoint < 0)
         {
            throw new Error("Forbidden value (" + this.boostPoint + ") on element boostPoint.");
         }
         output.writeVarShort(this.boostPoint);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StatsUpgradeRequestMessage(input);
      }
      
      public function deserializeAs_StatsUpgradeRequestMessage(input:ICustomDataInput) : void
      {
         this._useAdditionnalFunc(input);
         this._statIdFunc(input);
         this._boostPointFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StatsUpgradeRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_StatsUpgradeRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._useAdditionnalFunc);
         tree.addChild(this._statIdFunc);
         tree.addChild(this._boostPointFunc);
      }
      
      private function _useAdditionnalFunc(input:ICustomDataInput) : void
      {
         this.useAdditionnal = input.readBoolean();
      }
      
      private function _statIdFunc(input:ICustomDataInput) : void
      {
         this.statId = input.readByte();
         if(this.statId < 0)
         {
            throw new Error("Forbidden value (" + this.statId + ") on element of StatsUpgradeRequestMessage.statId.");
         }
      }
      
      private function _boostPointFunc(input:ICustomDataInput) : void
      {
         this.boostPoint = input.readVarUhShort();
         if(this.boostPoint < 0)
         {
            throw new Error("Forbidden value (" + this.boostPoint + ") on element of StatsUpgradeRequestMessage.boostPoint.");
         }
      }
   }
}
