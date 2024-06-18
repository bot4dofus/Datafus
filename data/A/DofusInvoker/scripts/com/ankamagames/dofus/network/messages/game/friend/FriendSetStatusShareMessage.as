package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class FriendSetStatusShareMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5816;
       
      
      private var _isInitialized:Boolean = false;
      
      public var share:Boolean = false;
      
      public function FriendSetStatusShareMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5816;
      }
      
      public function initFriendSetStatusShareMessage(share:Boolean = false) : FriendSetStatusShareMessage
      {
         this.share = share;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.share = false;
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
         this.serializeAs_FriendSetStatusShareMessage(output);
      }
      
      public function serializeAs_FriendSetStatusShareMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.share);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FriendSetStatusShareMessage(input);
      }
      
      public function deserializeAs_FriendSetStatusShareMessage(input:ICustomDataInput) : void
      {
         this._shareFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FriendSetStatusShareMessage(tree);
      }
      
      public function deserializeAsyncAs_FriendSetStatusShareMessage(tree:FuncTree) : void
      {
         tree.addChild(this._shareFunc);
      }
      
      private function _shareFunc(input:ICustomDataInput) : void
      {
         this.share = input.readBoolean();
      }
   }
}
