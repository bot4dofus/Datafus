package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CreateGuildRankRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1740;
       
      
      private var _isInitialized:Boolean = false;
      
      public var parentRankId:uint = 0;
      
      public var gfxId:uint = 0;
      
      public var name:String = "";
      
      public function CreateGuildRankRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1740;
      }
      
      public function initCreateGuildRankRequestMessage(parentRankId:uint = 0, gfxId:uint = 0, name:String = "") : CreateGuildRankRequestMessage
      {
         this.parentRankId = parentRankId;
         this.gfxId = gfxId;
         this.name = name;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.parentRankId = 0;
         this.gfxId = 0;
         this.name = "";
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
         this.serializeAs_CreateGuildRankRequestMessage(output);
      }
      
      public function serializeAs_CreateGuildRankRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.parentRankId < 0)
         {
            throw new Error("Forbidden value (" + this.parentRankId + ") on element parentRankId.");
         }
         output.writeVarInt(this.parentRankId);
         if(this.gfxId < 0)
         {
            throw new Error("Forbidden value (" + this.gfxId + ") on element gfxId.");
         }
         output.writeVarInt(this.gfxId);
         output.writeUTF(this.name);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CreateGuildRankRequestMessage(input);
      }
      
      public function deserializeAs_CreateGuildRankRequestMessage(input:ICustomDataInput) : void
      {
         this._parentRankIdFunc(input);
         this._gfxIdFunc(input);
         this._nameFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CreateGuildRankRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_CreateGuildRankRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._parentRankIdFunc);
         tree.addChild(this._gfxIdFunc);
         tree.addChild(this._nameFunc);
      }
      
      private function _parentRankIdFunc(input:ICustomDataInput) : void
      {
         this.parentRankId = input.readVarUhInt();
         if(this.parentRankId < 0)
         {
            throw new Error("Forbidden value (" + this.parentRankId + ") on element of CreateGuildRankRequestMessage.parentRankId.");
         }
      }
      
      private function _gfxIdFunc(input:ICustomDataInput) : void
      {
         this.gfxId = input.readVarUhInt();
         if(this.gfxId < 0)
         {
            throw new Error("Forbidden value (" + this.gfxId + ") on element of CreateGuildRankRequestMessage.gfxId.");
         }
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
   }
}
