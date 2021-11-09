package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightStartingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9577;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fightType:uint = 0;
      
      public var fightId:uint = 0;
      
      public var attackerId:Number = 0;
      
      public var defenderId:Number = 0;
      
      public var containsBoss:Boolean = false;
      
      public function GameFightStartingMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9577;
      }
      
      public function initGameFightStartingMessage(fightType:uint = 0, fightId:uint = 0, attackerId:Number = 0, defenderId:Number = 0, containsBoss:Boolean = false) : GameFightStartingMessage
      {
         this.fightType = fightType;
         this.fightId = fightId;
         this.attackerId = attackerId;
         this.defenderId = defenderId;
         this.containsBoss = containsBoss;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightType = 0;
         this.fightId = 0;
         this.attackerId = 0;
         this.defenderId = 0;
         this.containsBoss = false;
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
         this.serializeAs_GameFightStartingMessage(output);
      }
      
      public function serializeAs_GameFightStartingMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.fightType);
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
         if(this.attackerId < -9007199254740992 || this.attackerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.attackerId + ") on element attackerId.");
         }
         output.writeDouble(this.attackerId);
         if(this.defenderId < -9007199254740992 || this.defenderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.defenderId + ") on element defenderId.");
         }
         output.writeDouble(this.defenderId);
         output.writeBoolean(this.containsBoss);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightStartingMessage(input);
      }
      
      public function deserializeAs_GameFightStartingMessage(input:ICustomDataInput) : void
      {
         this._fightTypeFunc(input);
         this._fightIdFunc(input);
         this._attackerIdFunc(input);
         this._defenderIdFunc(input);
         this._containsBossFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightStartingMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightStartingMessage(tree:FuncTree) : void
      {
         tree.addChild(this._fightTypeFunc);
         tree.addChild(this._fightIdFunc);
         tree.addChild(this._attackerIdFunc);
         tree.addChild(this._defenderIdFunc);
         tree.addChild(this._containsBossFunc);
      }
      
      private function _fightTypeFunc(input:ICustomDataInput) : void
      {
         this.fightType = input.readByte();
         if(this.fightType < 0)
         {
            throw new Error("Forbidden value (" + this.fightType + ") on element of GameFightStartingMessage.fightType.");
         }
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameFightStartingMessage.fightId.");
         }
      }
      
      private function _attackerIdFunc(input:ICustomDataInput) : void
      {
         this.attackerId = input.readDouble();
         if(this.attackerId < -9007199254740992 || this.attackerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.attackerId + ") on element of GameFightStartingMessage.attackerId.");
         }
      }
      
      private function _defenderIdFunc(input:ICustomDataInput) : void
      {
         this.defenderId = input.readDouble();
         if(this.defenderId < -9007199254740992 || this.defenderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.defenderId + ") on element of GameFightStartingMessage.defenderId.");
         }
      }
      
      private function _containsBossFunc(input:ICustomDataInput) : void
      {
         this.containsBoss = input.readBoolean();
      }
   }
}
