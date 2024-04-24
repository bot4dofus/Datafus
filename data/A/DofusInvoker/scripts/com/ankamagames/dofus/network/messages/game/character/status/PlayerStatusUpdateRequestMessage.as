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
   
   public class PlayerStatusUpdateRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8545;
       
      
      private var _isInitialized:Boolean = false;
      
      public var status:PlayerStatus;
      
      private var _statustree:FuncTree;
      
      public function PlayerStatusUpdateRequestMessage()
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
         return 8545;
      }
      
      public function initPlayerStatusUpdateRequestMessage(status:PlayerStatus = null) : PlayerStatusUpdateRequestMessage
      {
         this.status = status;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
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
         this.serializeAs_PlayerStatusUpdateRequestMessage(output);
      }
      
      public function serializeAs_PlayerStatusUpdateRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.status.getTypeId());
         this.status.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PlayerStatusUpdateRequestMessage(input);
      }
      
      public function deserializeAs_PlayerStatusUpdateRequestMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id1);
         this.status.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PlayerStatusUpdateRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_PlayerStatusUpdateRequestMessage(tree:FuncTree) : void
      {
         this._statustree = tree.addChild(this._statustreeFunc);
      }
      
      private function _statustreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id);
         this.status.deserializeAsync(this._statustree);
      }
   }
}
