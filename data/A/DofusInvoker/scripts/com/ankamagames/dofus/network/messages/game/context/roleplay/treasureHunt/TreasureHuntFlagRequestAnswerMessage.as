package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TreasureHuntFlagRequestAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6871;
       
      
      private var _isInitialized:Boolean = false;
      
      public var questType:uint = 0;
      
      public var result:uint = 0;
      
      public var index:uint = 0;
      
      public function TreasureHuntFlagRequestAnswerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6871;
      }
      
      public function initTreasureHuntFlagRequestAnswerMessage(questType:uint = 0, result:uint = 0, index:uint = 0) : TreasureHuntFlagRequestAnswerMessage
      {
         this.questType = questType;
         this.result = result;
         this.index = index;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.questType = 0;
         this.result = 0;
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
         this.serializeAs_TreasureHuntFlagRequestAnswerMessage(output);
      }
      
      public function serializeAs_TreasureHuntFlagRequestAnswerMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.questType);
         output.writeByte(this.result);
         if(this.index < 0)
         {
            throw new Error("Forbidden value (" + this.index + ") on element index.");
         }
         output.writeByte(this.index);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TreasureHuntFlagRequestAnswerMessage(input);
      }
      
      public function deserializeAs_TreasureHuntFlagRequestAnswerMessage(input:ICustomDataInput) : void
      {
         this._questTypeFunc(input);
         this._resultFunc(input);
         this._indexFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TreasureHuntFlagRequestAnswerMessage(tree);
      }
      
      public function deserializeAsyncAs_TreasureHuntFlagRequestAnswerMessage(tree:FuncTree) : void
      {
         tree.addChild(this._questTypeFunc);
         tree.addChild(this._resultFunc);
         tree.addChild(this._indexFunc);
      }
      
      private function _questTypeFunc(input:ICustomDataInput) : void
      {
         this.questType = input.readByte();
         if(this.questType < 0)
         {
            throw new Error("Forbidden value (" + this.questType + ") on element of TreasureHuntFlagRequestAnswerMessage.questType.");
         }
      }
      
      private function _resultFunc(input:ICustomDataInput) : void
      {
         this.result = input.readByte();
         if(this.result < 0)
         {
            throw new Error("Forbidden value (" + this.result + ") on element of TreasureHuntFlagRequestAnswerMessage.result.");
         }
      }
      
      private function _indexFunc(input:ICustomDataInput) : void
      {
         this.index = input.readByte();
         if(this.index < 0)
         {
            throw new Error("Forbidden value (" + this.index + ") on element of TreasureHuntFlagRequestAnswerMessage.index.");
         }
      }
   }
}
