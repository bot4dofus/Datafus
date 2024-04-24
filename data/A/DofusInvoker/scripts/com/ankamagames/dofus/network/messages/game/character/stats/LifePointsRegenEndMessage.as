package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class LifePointsRegenEndMessage extends UpdateLifePointsMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2274;
       
      
      private var _isInitialized:Boolean = false;
      
      public var lifePointsGained:uint = 0;
      
      public function LifePointsRegenEndMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2274;
      }
      
      public function initLifePointsRegenEndMessage(lifePoints:uint = 0, maxLifePoints:uint = 0, lifePointsGained:uint = 0) : LifePointsRegenEndMessage
      {
         super.initUpdateLifePointsMessage(lifePoints,maxLifePoints);
         this.lifePointsGained = lifePointsGained;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.lifePointsGained = 0;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_LifePointsRegenEndMessage(output);
      }
      
      public function serializeAs_LifePointsRegenEndMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_UpdateLifePointsMessage(output);
         if(this.lifePointsGained < 0)
         {
            throw new Error("Forbidden value (" + this.lifePointsGained + ") on element lifePointsGained.");
         }
         output.writeVarInt(this.lifePointsGained);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_LifePointsRegenEndMessage(input);
      }
      
      public function deserializeAs_LifePointsRegenEndMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._lifePointsGainedFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_LifePointsRegenEndMessage(tree);
      }
      
      public function deserializeAsyncAs_LifePointsRegenEndMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._lifePointsGainedFunc);
      }
      
      private function _lifePointsGainedFunc(input:ICustomDataInput) : void
      {
         this.lifePointsGained = input.readVarUhInt();
         if(this.lifePointsGained < 0)
         {
            throw new Error("Forbidden value (" + this.lifePointsGained + ") on element of LifePointsRegenEndMessage.lifePointsGained.");
         }
      }
   }
}
