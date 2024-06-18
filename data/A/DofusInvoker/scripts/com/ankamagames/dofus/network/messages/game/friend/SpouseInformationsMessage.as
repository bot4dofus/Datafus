package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.friend.FriendSpouseInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SpouseInformationsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7779;
       
      
      private var _isInitialized:Boolean = false;
      
      public var spouse:FriendSpouseInformations;
      
      private var _spousetree:FuncTree;
      
      public function SpouseInformationsMessage()
      {
         this.spouse = new FriendSpouseInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7779;
      }
      
      public function initSpouseInformationsMessage(spouse:FriendSpouseInformations = null) : SpouseInformationsMessage
      {
         this.spouse = spouse;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.spouse = new FriendSpouseInformations();
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
         this.serializeAs_SpouseInformationsMessage(output);
      }
      
      public function serializeAs_SpouseInformationsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.spouse.getTypeId());
         this.spouse.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SpouseInformationsMessage(input);
      }
      
      public function deserializeAs_SpouseInformationsMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = input.readUnsignedShort();
         this.spouse = ProtocolTypeManager.getInstance(FriendSpouseInformations,_id1);
         this.spouse.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SpouseInformationsMessage(tree);
      }
      
      public function deserializeAsyncAs_SpouseInformationsMessage(tree:FuncTree) : void
      {
         this._spousetree = tree.addChild(this._spousetreeFunc);
      }
      
      private function _spousetreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.spouse = ProtocolTypeManager.getInstance(FriendSpouseInformations,_id);
         this.spouse.deserializeAsync(this._spousetree);
      }
   }
}
