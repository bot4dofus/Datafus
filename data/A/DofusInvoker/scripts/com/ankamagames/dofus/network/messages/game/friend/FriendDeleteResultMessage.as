package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class FriendDeleteResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4930;
       
      
      private var _isInitialized:Boolean = false;
      
      public var success:Boolean = false;
      
      public var tag:AccountTagInformation;
      
      private var _tagtree:FuncTree;
      
      public function FriendDeleteResultMessage()
      {
         this.tag = new AccountTagInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4930;
      }
      
      public function initFriendDeleteResultMessage(success:Boolean = false, tag:AccountTagInformation = null) : FriendDeleteResultMessage
      {
         this.success = success;
         this.tag = tag;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.success = false;
         this.tag = new AccountTagInformation();
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
         this.serializeAs_FriendDeleteResultMessage(output);
      }
      
      public function serializeAs_FriendDeleteResultMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.success);
         this.tag.serializeAs_AccountTagInformation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FriendDeleteResultMessage(input);
      }
      
      public function deserializeAs_FriendDeleteResultMessage(input:ICustomDataInput) : void
      {
         this._successFunc(input);
         this.tag = new AccountTagInformation();
         this.tag.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FriendDeleteResultMessage(tree);
      }
      
      public function deserializeAsyncAs_FriendDeleteResultMessage(tree:FuncTree) : void
      {
         tree.addChild(this._successFunc);
         this._tagtree = tree.addChild(this._tagtreeFunc);
      }
      
      private function _successFunc(input:ICustomDataInput) : void
      {
         this.success = input.readBoolean();
      }
      
      private function _tagtreeFunc(input:ICustomDataInput) : void
      {
         this.tag = new AccountTagInformation();
         this.tag.deserializeAsync(this._tagtree);
      }
   }
}
