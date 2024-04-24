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
   
   public class FriendsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4516;
       
      
      private var _isInitialized:Boolean = false;
      
      public var friendsList:Vector.<FriendInformations>;
      
      private var _friendsListtree:FuncTree;
      
      public function FriendsListMessage()
      {
         this.friendsList = new Vector.<FriendInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4516;
      }
      
      public function initFriendsListMessage(friendsList:Vector.<FriendInformations> = null) : FriendsListMessage
      {
         this.friendsList = friendsList;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.friendsList = new Vector.<FriendInformations>();
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
         this.serializeAs_FriendsListMessage(output);
      }
      
      public function serializeAs_FriendsListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.friendsList.length);
         for(var _i1:uint = 0; _i1 < this.friendsList.length; _i1++)
         {
            output.writeShort((this.friendsList[_i1] as FriendInformations).getTypeId());
            (this.friendsList[_i1] as FriendInformations).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FriendsListMessage(input);
      }
      
      public function deserializeAs_FriendsListMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:FriendInformations = null;
         var _friendsListLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _friendsListLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(FriendInformations,_id1);
            _item1.deserialize(input);
            this.friendsList.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FriendsListMessage(tree);
      }
      
      public function deserializeAsyncAs_FriendsListMessage(tree:FuncTree) : void
      {
         this._friendsListtree = tree.addChild(this._friendsListtreeFunc);
      }
      
      private function _friendsListtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._friendsListtree.addChild(this._friendsListFunc);
         }
      }
      
      private function _friendsListFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:FriendInformations = ProtocolTypeManager.getInstance(FriendInformations,_id);
         _item.deserialize(input);
         this.friendsList.push(_item);
      }
   }
}
