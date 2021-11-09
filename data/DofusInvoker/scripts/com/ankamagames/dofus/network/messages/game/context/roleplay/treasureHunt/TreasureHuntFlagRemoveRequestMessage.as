package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TreasureHuntFlagRemoveRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3502;
       
      
      private var _isInitialized:Boolean = false;
      
      public var questType:uint = 0;
      
      public var index:uint = 0;
      
      public function TreasureHuntFlagRemoveRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3502;
      }
      
      public function initTreasureHuntFlagRemoveRequestMessage(questType:uint = 0, index:uint = 0) : TreasureHuntFlagRemoveRequestMessage
      {
         this.questType = questType;
         this.index = index;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.questType = 0;
         this.index = 0;
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
         this.serializeAs_TreasureHuntFlagRemoveRequestMessage(output);
      }
      
      public function serializeAs_TreasureHuntFlagRemoveRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.questType);
         if(this.index < 0)
         {
            throw new Error("Forbidden value (" + this.index + ") on element index.");
         }
         output.writeByte(this.index);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TreasureHuntFlagRemoveRequestMessage(input);
      }
      
      public function deserializeAs_TreasureHuntFlagRemoveRequestMessage(input:ICustomDataInput) : void
      {
         this._questTypeFunc(input);
         this._indexFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TreasureHuntFlagRemoveRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_TreasureHuntFlagRemoveRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._questTypeFunc);
         tree.addChild(this._indexFunc);
      }
      
      private function _questTypeFunc(input:ICustomDataInput) : void
      {
         this.questType = input.readByte();
         if(this.questType < 0)
         {
            throw new Error("Forbidden value (" + this.questType + ") on element of TreasureHuntFlagRemoveRequestMessage.questType.");
         }
      }
      
      private function _indexFunc(input:ICustomDataInput) : void
      {
         this.index = input.readByte();
         if(this.index < 0)
         {
            throw new Error("Forbidden value (" + this.index + ") on element of TreasureHuntFlagRemoveRequestMessage.index.");
         }
      }
   }
}
