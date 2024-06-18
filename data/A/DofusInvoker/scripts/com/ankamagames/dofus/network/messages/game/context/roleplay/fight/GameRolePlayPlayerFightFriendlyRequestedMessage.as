package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayPlayerFightFriendlyRequestedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4626;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fightId:uint = 0;
      
      public var sourceId:Number = 0;
      
      public var targetId:Number = 0;
      
      public function GameRolePlayPlayerFightFriendlyRequestedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4626;
      }
      
      public function initGameRolePlayPlayerFightFriendlyRequestedMessage(fightId:uint = 0, sourceId:Number = 0, targetId:Number = 0) : GameRolePlayPlayerFightFriendlyRequestedMessage
      {
         this.fightId = fightId;
         this.sourceId = sourceId;
         this.targetId = targetId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightId = 0;
         this.sourceId = 0;
         this.targetId = 0;
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
         this.serializeAs_GameRolePlayPlayerFightFriendlyRequestedMessage(output);
      }
      
      public function serializeAs_GameRolePlayPlayerFightFriendlyRequestedMessage(output:ICustomDataOutput) : void
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
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayPlayerFightFriendlyRequestedMessage(input);
      }
      
      public function deserializeAs_GameRolePlayPlayerFightFriendlyRequestedMessage(input:ICustomDataInput) : void
      {
         this._fightIdFunc(input);
         this._sourceIdFunc(input);
         this._targetIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayPlayerFightFriendlyRequestedMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayPlayerFightFriendlyRequestedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
         tree.addChild(this._sourceIdFunc);
         tree.addChild(this._targetIdFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameRolePlayPlayerFightFriendlyRequestedMessage.fightId.");
         }
      }
      
      private function _sourceIdFunc(input:ICustomDataInput) : void
      {
         this.sourceId = input.readVarUhLong();
         if(this.sourceId < 0 || this.sourceId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sourceId + ") on element of GameRolePlayPlayerFightFriendlyRequestedMessage.sourceId.");
         }
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readVarUhLong();
         if(this.targetId < 0 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of GameRolePlayPlayerFightFriendlyRequestedMessage.targetId.");
         }
      }
   }
}
