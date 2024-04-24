package com.ankamagames.dofus.network.messages.game.surrender
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.surrender.SurrenderResponse;
   import com.ankamagames.dofus.network.types.game.surrender.vote.SurrenderVoteResponse;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SurrenderInfoResponseMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1727;
       
      
      private var _isInitialized:Boolean = false;
      
      public var hasSanction:Boolean = false;
      
      public var surrenderResponse:SurrenderResponse;
      
      public var surrenderVoteResponse:SurrenderVoteResponse;
      
      private var _surrenderResponsetree:FuncTree;
      
      private var _surrenderVoteResponsetree:FuncTree;
      
      public function SurrenderInfoResponseMessage()
      {
         this.surrenderResponse = new SurrenderResponse();
         this.surrenderVoteResponse = new SurrenderVoteResponse();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1727;
      }
      
      public function initSurrenderInfoResponseMessage(hasSanction:Boolean = false, surrenderResponse:SurrenderResponse = null, surrenderVoteResponse:SurrenderVoteResponse = null) : SurrenderInfoResponseMessage
      {
         this.hasSanction = hasSanction;
         this.surrenderResponse = surrenderResponse;
         this.surrenderVoteResponse = surrenderVoteResponse;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.hasSanction = false;
         this.surrenderResponse = new SurrenderResponse();
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
         this.serializeAs_SurrenderInfoResponseMessage(output);
      }
      
      public function serializeAs_SurrenderInfoResponseMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.hasSanction);
         output.writeShort(this.surrenderResponse.getTypeId());
         this.surrenderResponse.serialize(output);
         output.writeShort(this.surrenderVoteResponse.getTypeId());
         this.surrenderVoteResponse.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SurrenderInfoResponseMessage(input);
      }
      
      public function deserializeAs_SurrenderInfoResponseMessage(input:ICustomDataInput) : void
      {
         this._hasSanctionFunc(input);
         var _id2:uint = input.readUnsignedShort();
         this.surrenderResponse = ProtocolTypeManager.getInstance(SurrenderResponse,_id2);
         this.surrenderResponse.deserialize(input);
         var _id3:uint = input.readUnsignedShort();
         this.surrenderVoteResponse = ProtocolTypeManager.getInstance(SurrenderVoteResponse,_id3);
         this.surrenderVoteResponse.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SurrenderInfoResponseMessage(tree);
      }
      
      public function deserializeAsyncAs_SurrenderInfoResponseMessage(tree:FuncTree) : void
      {
         tree.addChild(this._hasSanctionFunc);
         this._surrenderResponsetree = tree.addChild(this._surrenderResponsetreeFunc);
         this._surrenderVoteResponsetree = tree.addChild(this._surrenderVoteResponsetreeFunc);
      }
      
      private function _hasSanctionFunc(input:ICustomDataInput) : void
      {
         this.hasSanction = input.readBoolean();
      }
      
      private function _surrenderResponsetreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.surrenderResponse = ProtocolTypeManager.getInstance(SurrenderResponse,_id);
         this.surrenderResponse.deserializeAsync(this._surrenderResponsetree);
      }
      
      private function _surrenderVoteResponsetreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.surrenderVoteResponse = ProtocolTypeManager.getInstance(SurrenderVoteResponse,_id);
         this.surrenderVoteResponse.deserializeAsync(this._surrenderVoteResponsetree);
      }
   }
}
