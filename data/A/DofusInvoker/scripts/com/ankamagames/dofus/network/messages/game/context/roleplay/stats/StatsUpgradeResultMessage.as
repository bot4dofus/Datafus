package com.ankamagames.dofus.network.messages.game.context.roleplay.stats
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class StatsUpgradeResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3065;
       
      
      private var _isInitialized:Boolean = false;
      
      public var result:int = 0;
      
      public var nbCharacBoost:uint = 0;
      
      public function StatsUpgradeResultMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3065;
      }
      
      public function initStatsUpgradeResultMessage(result:int = 0, nbCharacBoost:uint = 0) : StatsUpgradeResultMessage
      {
         this.result = result;
         this.nbCharacBoost = nbCharacBoost;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.result = 0;
         this.nbCharacBoost = 0;
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
         this.serializeAs_StatsUpgradeResultMessage(output);
      }
      
      public function serializeAs_StatsUpgradeResultMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.result);
         if(this.nbCharacBoost < 0)
         {
            throw new Error("Forbidden value (" + this.nbCharacBoost + ") on element nbCharacBoost.");
         }
         output.writeVarShort(this.nbCharacBoost);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StatsUpgradeResultMessage(input);
      }
      
      public function deserializeAs_StatsUpgradeResultMessage(input:ICustomDataInput) : void
      {
         this._resultFunc(input);
         this._nbCharacBoostFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StatsUpgradeResultMessage(tree);
      }
      
      public function deserializeAsyncAs_StatsUpgradeResultMessage(tree:FuncTree) : void
      {
         tree.addChild(this._resultFunc);
         tree.addChild(this._nbCharacBoostFunc);
      }
      
      private function _resultFunc(input:ICustomDataInput) : void
      {
         this.result = input.readByte();
      }
      
      private function _nbCharacBoostFunc(input:ICustomDataInput) : void
      {
         this.nbCharacBoost = input.readVarUhShort();
         if(this.nbCharacBoost < 0)
         {
            throw new Error("Forbidden value (" + this.nbCharacBoost + ") on element of StatsUpgradeResultMessage.nbCharacBoost.");
         }
      }
   }
}
