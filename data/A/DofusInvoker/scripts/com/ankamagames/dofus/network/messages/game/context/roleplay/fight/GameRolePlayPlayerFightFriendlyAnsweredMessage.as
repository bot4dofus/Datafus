package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayPlayerFightFriendlyAnsweredMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8608;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fightId:uint = 0;
      
      public var sourceId:Number = 0;
      
      public var targetId:Number = 0;
      
      public var accept:Boolean = false;
      
      public function GameRolePlayPlayerFightFriendlyAnsweredMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8608;
      }
      
      public function initGameRolePlayPlayerFightFriendlyAnsweredMessage(fightId:uint = 0, sourceId:Number = 0, targetId:Number = 0, accept:Boolean = false) : GameRolePlayPlayerFightFriendlyAnsweredMessage
      {
         this.fightId = fightId;
         this.sourceId = sourceId;
         this.targetId = targetId;
         this.accept = accept;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightId = 0;
         this.sourceId = 0;
         this.targetId = 0;
         this.accept = false;
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
         this.serializeAs_GameRolePlayPlayerFightFriendlyAnsweredMessage(output);
      }
      
      public function serializeAs_GameRolePlayPlayerFightFriendlyAnsweredMessage(output:ICustomDataOutput) : void
      {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
         if(this.sourceId < 0 || this.sourceId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sourceId + ") on element sourceId.");
         }
         output.writeVarLong(this.sourceId);
         if(this.targetId < 0 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeVarLong(this.targetId);
         output.writeBoolean(this.accept);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayPlayerFightFriendlyAnsweredMessage(input);
      }
      
      public function deserializeAs_GameRolePlayPlayerFightFriendlyAnsweredMessage(input:ICustomDataInput) : void
      {
         this._fightIdFunc(input);
         this._sourceIdFunc(input);
         this._targetIdFunc(input);
         this._acceptFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayPlayerFightFriendlyAnsweredMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayPlayerFightFriendlyAnsweredMessage(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
         tree.addChild(this._sourceIdFunc);
         tree.addChild(this._targetIdFunc);
         tree.addChild(this._acceptFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameRolePlayPlayerFightFriendlyAnsweredMessage.fightId.");
         }
      }
      
      private function _sourceIdFunc(input:ICustomDataInput) : void
      {
         this.sourceId = input.readVarUhLong();
         if(this.sourceId < 0 || this.sourceId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sourceId + ") on element of GameRolePlayPlayerFightFriendlyAnsweredMessage.sourceId.");
         }
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readVarUhLong();
         if(this.targetId < 0 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of GameRolePlayPlayerFightFriendlyAnsweredMessage.targetId.");
         }
      }
      
      private function _acceptFunc(input:ICustomDataInput) : void
      {
         this.accept = input.readBoolean();
      }
   }
}
