package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class UpdateLifePointsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1814;
       
      
      private var _isInitialized:Boolean = false;
      
      public var lifePoints:uint = 0;
      
      public var maxLifePoints:uint = 0;
      
      public function UpdateLifePointsMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1814;
      }
      
      public function initUpdateLifePointsMessage(lifePoints:uint = 0, maxLifePoints:uint = 0) : UpdateLifePointsMessage
      {
         this.lifePoints = lifePoints;
         this.maxLifePoints = maxLifePoints;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.lifePoints = 0;
         this.maxLifePoints = 0;
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
         this.serializeAs_UpdateLifePointsMessage(output);
      }
      
      public function serializeAs_UpdateLifePointsMessage(output:ICustomDataOutput) : void
      {
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element lifePoints.");
         }
         output.writeVarInt(this.lifePoints);
         if(this.maxLifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.maxLifePoints + ") on element maxLifePoints.");
         }
         output.writeVarInt(this.maxLifePoints);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_UpdateLifePointsMessage(input);
      }
      
      public function deserializeAs_UpdateLifePointsMessage(input:ICustomDataInput) : void
      {
         this._lifePointsFunc(input);
         this._maxLifePointsFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_UpdateLifePointsMessage(tree);
      }
      
      public function deserializeAsyncAs_UpdateLifePointsMessage(tree:FuncTree) : void
      {
         tree.addChild(this._lifePointsFunc);
         tree.addChild(this._maxLifePointsFunc);
      }
      
      private function _lifePointsFunc(input:ICustomDataInput) : void
      {
         this.lifePoints = input.readVarUhInt();
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element of UpdateLifePointsMessage.lifePoints.");
         }
      }
      
      private function _maxLifePointsFunc(input:ICustomDataInput) : void
      {
         this.maxLifePoints = input.readVarUhInt();
         if(this.maxLifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.maxLifePoints + ") on element of UpdateLifePointsMessage.maxLifePoints.");
         }
      }
   }
}
