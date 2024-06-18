package com.ankamagames.dofus.network.messages.game.character.status
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PlayerStatusUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3675;
       
      
      private var _isInitialized:Boolean = false;
      
      public var accountId:uint = 0;
      
      public var playerId:Number = 0;
      
      public var status:PlayerStatus;
      
      private var _statustree:FuncTree;
      
      public function PlayerStatusUpdateMessage()
      {
         this.status = new PlayerStatus();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3675;
      }
      
      public function initPlayerStatusUpdateMessage(accountId:uint = 0, playerId:Number = 0, status:PlayerStatus = null) : PlayerStatusUpdateMessage
      {
         this.accountId = accountId;
         this.playerId = playerId;
         this.status = status;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.accountId = 0;
         this.playerId = 0;
         this.status = new PlayerStatus();
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
         this.serializeAs_PlayerStatusUpdateMessage(output);
      }
      
      public function serializeAs_PlayerStatusUpdateMessage(output:ICustomDataOutput) : void
      {
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         output.writeInt(this.accountId);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         output.writeShort(this.status.getTypeId());
         this.status.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PlayerStatusUpdateMessage(input);
      }
      
      public function deserializeAs_PlayerStatusUpdateMessage(input:ICustomDataInput) : void
      {
         this._accountIdFunc(input);
         this._playerIdFunc(input);
         var _id3:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id3);
         this.status.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PlayerStatusUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_PlayerStatusUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._accountIdFunc);
         tree.addChild(this._playerIdFunc);
         this._statustree = tree.addChild(this._statustreeFunc);
      }
      
      private function _accountIdFunc(input:ICustomDataInput) : void
      {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of PlayerStatusUpdateMessage.accountId.");
         }
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of PlayerStatusUpdateMessage.playerId.");
         }
      }
      
      private function _statustreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id);
         this.status.deserializeAsync(this._statustree);
      }
   }
}
