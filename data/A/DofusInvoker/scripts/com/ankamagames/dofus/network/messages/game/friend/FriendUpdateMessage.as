package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.friend.FriendInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class FriendUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7293;
       
      
      private var _isInitialized:Boolean = false;
      
      public var friendUpdated:FriendInformations;
      
      private var _friendUpdatedtree:FuncTree;
      
      public function FriendUpdateMessage()
      {
         this.friendUpdated = new FriendInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7293;
      }
      
      public function initFriendUpdateMessage(friendUpdated:FriendInformations = null) : FriendUpdateMessage
      {
         this.friendUpdated = friendUpdated;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.friendUpdated = new FriendInformations();
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
         this.serializeAs_FriendUpdateMessage(output);
      }
      
      public function serializeAs_FriendUpdateMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.friendUpdated.getTypeId());
         this.friendUpdated.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FriendUpdateMessage(input);
      }
      
      public function deserializeAs_FriendUpdateMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = input.readUnsignedShort();
         this.friendUpdated = ProtocolTypeManager.getInstance(FriendInformations,_id1);
         this.friendUpdated.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FriendUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_FriendUpdateMessage(tree:FuncTree) : void
      {
         this._friendUpdatedtree = tree.addChild(this._friendUpdatedtreeFunc);
      }
      
      private function _friendUpdatedtreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.friendUpdated = ProtocolTypeManager.getInstance(FriendInformations,_id);
         this.friendUpdated.deserializeAsync(this._friendUpdatedtree);
      }
   }
}
