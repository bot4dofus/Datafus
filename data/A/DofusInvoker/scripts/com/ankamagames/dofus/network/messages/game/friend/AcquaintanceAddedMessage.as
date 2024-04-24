package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.friend.AcquaintanceInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AcquaintanceAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1512;
       
      
      private var _isInitialized:Boolean = false;
      
      public var acquaintanceAdded:AcquaintanceInformation;
      
      private var _acquaintanceAddedtree:FuncTree;
      
      public function AcquaintanceAddedMessage()
      {
         this.acquaintanceAdded = new AcquaintanceInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1512;
      }
      
      public function initAcquaintanceAddedMessage(acquaintanceAdded:AcquaintanceInformation = null) : AcquaintanceAddedMessage
      {
         this.acquaintanceAdded = acquaintanceAdded;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.acquaintanceAdded = new AcquaintanceInformation();
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
         this.serializeAs_AcquaintanceAddedMessage(output);
      }
      
      public function serializeAs_AcquaintanceAddedMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.acquaintanceAdded.getTypeId());
         this.acquaintanceAdded.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AcquaintanceAddedMessage(input);
      }
      
      public function deserializeAs_AcquaintanceAddedMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = input.readUnsignedShort();
         this.acquaintanceAdded = ProtocolTypeManager.getInstance(AcquaintanceInformation,_id1);
         this.acquaintanceAdded.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AcquaintanceAddedMessage(tree);
      }
      
      public function deserializeAsyncAs_AcquaintanceAddedMessage(tree:FuncTree) : void
      {
         this._acquaintanceAddedtree = tree.addChild(this._acquaintanceAddedtreeFunc);
      }
      
      private function _acquaintanceAddedtreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.acquaintanceAdded = ProtocolTypeManager.getInstance(AcquaintanceInformation,_id);
         this.acquaintanceAdded.deserializeAsync(this._acquaintanceAddedtree);
      }
   }
}
