package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChallengeFightJoinRefusedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2072;
       
      
      private var _isInitialized:Boolean = false;
      
      public var playerId:Number = 0;
      
      public var reason:int = 0;
      
      public function ChallengeFightJoinRefusedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2072;
      }
      
      public function initChallengeFightJoinRefusedMessage(playerId:Number = 0, reason:int = 0) : ChallengeFightJoinRefusedMessage
      {
         this.playerId = playerId;
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.playerId = 0;
         this.reason = 0;
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
         this.serializeAs_ChallengeFightJoinRefusedMessage(output);
      }
      
      public function serializeAs_ChallengeFightJoinRefusedMessage(output:ICustomDataOutput) : void
      {
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         output.writeByte(this.reason);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeFightJoinRefusedMessage(input);
      }
      
      public function deserializeAs_ChallengeFightJoinRefusedMessage(input:ICustomDataInput) : void
      {
         this._playerIdFunc(input);
         this._reasonFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChallengeFightJoinRefusedMessage(tree);
      }
      
      public function deserializeAsyncAs_ChallengeFightJoinRefusedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._reasonFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of ChallengeFightJoinRefusedMessage.playerId.");
         }
      }
      
      private function _reasonFunc(input:ICustomDataInput) : void
      {
         this.reason = input.readByte();
      }
   }
}
