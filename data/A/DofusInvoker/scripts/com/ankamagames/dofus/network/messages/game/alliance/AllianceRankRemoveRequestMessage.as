package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceRankRemoveRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3428;
       
      
      private var _isInitialized:Boolean = false;
      
      public var rankId:uint = 0;
      
      public var newRankId:uint = 0;
      
      public function AllianceRankRemoveRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3428;
      }
      
      public function initAllianceRankRemoveRequestMessage(rankId:uint = 0, newRankId:uint = 0) : AllianceRankRemoveRequestMessage
      {
         this.rankId = rankId;
         this.newRankId = newRankId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.rankId = 0;
         this.newRankId = 0;
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
         this.serializeAs_AllianceRankRemoveRequestMessage(output);
      }
      
      public function serializeAs_AllianceRankRemoveRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.rankId < 0)
         {
            throw new Error("Forbidden value (" + this.rankId + ") on element rankId.");
         }
         output.writeVarInt(this.rankId);
         if(this.newRankId < 0)
         {
            throw new Error("Forbidden value (" + this.newRankId + ") on element newRankId.");
         }
         output.writeVarInt(this.newRankId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceRankRemoveRequestMessage(input);
      }
      
      public function deserializeAs_AllianceRankRemoveRequestMessage(input:ICustomDataInput) : void
      {
         this._rankIdFunc(input);
         this._newRankIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceRankRemoveRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceRankRemoveRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._rankIdFunc);
         tree.addChild(this._newRankIdFunc);
      }
      
      private function _rankIdFunc(input:ICustomDataInput) : void
      {
         this.rankId = input.readVarUhInt();
         if(this.rankId < 0)
         {
            throw new Error("Forbidden value (" + this.rankId + ") on element of AllianceRankRemoveRequestMessage.rankId.");
         }
      }
      
      private function _newRankIdFunc(input:ICustomDataInput) : void
      {
         this.newRankId = input.readVarUhInt();
         if(this.newRankId < 0)
         {
            throw new Error("Forbidden value (" + this.newRankId + ") on element of AllianceRankRemoveRequestMessage.newRankId.");
         }
      }
   }
}
