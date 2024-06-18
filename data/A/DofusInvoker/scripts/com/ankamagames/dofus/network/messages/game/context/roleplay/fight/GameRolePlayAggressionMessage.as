package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayAggressionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6235;
       
      
      private var _isInitialized:Boolean = false;
      
      public var attackerId:Number = 0;
      
      public var defenderId:Number = 0;
      
      public function GameRolePlayAggressionMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6235;
      }
      
      public function initGameRolePlayAggressionMessage(attackerId:Number = 0, defenderId:Number = 0) : GameRolePlayAggressionMessage
      {
         this.attackerId = attackerId;
         this.defenderId = defenderId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.attackerId = 0;
         this.defenderId = 0;
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
         this.serializeAs_GameRolePlayAggressionMessage(output);
      }
      
      public function serializeAs_GameRolePlayAggressionMessage(output:ICustomDataOutput) : void
      {
         if(this.attackerId < 0 || this.attackerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.attackerId + ") on element attackerId.");
         }
         output.writeVarLong(this.attackerId);
         if(this.defenderId < 0 || this.defenderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.defenderId + ") on element defenderId.");
         }
         output.writeVarLong(this.defenderId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayAggressionMessage(input);
      }
      
      public function deserializeAs_GameRolePlayAggressionMessage(input:ICustomDataInput) : void
      {
         this._attackerIdFunc(input);
         this._defenderIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayAggressionMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayAggressionMessage(tree:FuncTree) : void
      {
         tree.addChild(this._attackerIdFunc);
         tree.addChild(this._defenderIdFunc);
      }
      
      private function _attackerIdFunc(input:ICustomDataInput) : void
      {
         this.attackerId = input.readVarUhLong();
         if(this.attackerId < 0 || this.attackerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.attackerId + ") on element of GameRolePlayAggressionMessage.attackerId.");
         }
      }
      
      private function _defenderIdFunc(input:ICustomDataInput) : void
      {
         this.defenderId = input.readVarUhLong();
         if(this.defenderId < 0 || this.defenderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.defenderId + ") on element of GameRolePlayAggressionMessage.defenderId.");
         }
      }
   }
}
