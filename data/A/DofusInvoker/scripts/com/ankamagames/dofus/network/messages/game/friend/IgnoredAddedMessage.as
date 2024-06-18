package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.friend.IgnoredInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IgnoredAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3797;
       
      
      private var _isInitialized:Boolean = false;
      
      public var ignoreAdded:IgnoredInformations;
      
      public var session:Boolean = false;
      
      private var _ignoreAddedtree:FuncTree;
      
      public function IgnoredAddedMessage()
      {
         this.ignoreAdded = new IgnoredInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3797;
      }
      
      public function initIgnoredAddedMessage(ignoreAdded:IgnoredInformations = null, session:Boolean = false) : IgnoredAddedMessage
      {
         this.ignoreAdded = ignoreAdded;
         this.session = session;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.ignoreAdded = new IgnoredInformations();
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
         this.serializeAs_IgnoredAddedMessage(output);
      }
      
      public function serializeAs_IgnoredAddedMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.ignoreAdded.getTypeId());
         this.ignoreAdded.serialize(output);
         output.writeBoolean(this.session);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IgnoredAddedMessage(input);
      }
      
      public function deserializeAs_IgnoredAddedMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = input.readUnsignedShort();
         this.ignoreAdded = ProtocolTypeManager.getInstance(IgnoredInformations,_id1);
         this.ignoreAdded.deserialize(input);
         this._sessionFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IgnoredAddedMessage(tree);
      }
      
      public function deserializeAsyncAs_IgnoredAddedMessage(tree:FuncTree) : void
      {
         this._ignoreAddedtree = tree.addChild(this._ignoreAddedtreeFunc);
         tree.addChild(this._sessionFunc);
      }
      
      private function _ignoreAddedtreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.ignoreAdded = ProtocolTypeManager.getInstance(IgnoredInformations,_id);
         this.ignoreAdded.deserializeAsync(this._ignoreAddedtree);
      }
      
      private function _sessionFunc(input:ICustomDataInput) : void
      {
         this.session = input.readBoolean();
      }
   }
}
