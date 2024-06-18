package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TreasureHuntRequestAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7470;
       
      
      private var _isInitialized:Boolean = false;
      
      public var questType:uint = 0;
      
      public var result:uint = 0;
      
      public function TreasureHuntRequestAnswerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7470;
      }
      
      public function initTreasureHuntRequestAnswerMessage(questType:uint = 0, result:uint = 0) : TreasureHuntRequestAnswerMessage
      {
         this.questType = questType;
         this.result = result;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.questType = 0;
         this.result = 0;
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
         this.serializeAs_TreasureHuntRequestAnswerMessage(output);
      }
      
      public function serializeAs_TreasureHuntRequestAnswerMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.questType);
         output.writeByte(this.result);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TreasureHuntRequestAnswerMessage(input);
      }
      
      public function deserializeAs_TreasureHuntRequestAnswerMessage(input:ICustomDataInput) : void
      {
         this._questTypeFunc(input);
         this._resultFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TreasureHuntRequestAnswerMessage(tree);
      }
      
      public function deserializeAsyncAs_TreasureHuntRequestAnswerMessage(tree:FuncTree) : void
      {
         tree.addChild(this._questTypeFunc);
         tree.addChild(this._resultFunc);
      }
      
      private function _questTypeFunc(input:ICustomDataInput) : void
      {
         this.questType = input.readByte();
         if(this.questType < 0)
         {
            throw new Error("Forbidden value (" + this.questType + ") on element of TreasureHuntRequestAnswerMessage.questType.");
         }
      }
      
      private function _resultFunc(input:ICustomDataInput) : void
      {
         this.result = input.readByte();
         if(this.result < 0)
         {
            throw new Error("Forbidden value (" + this.result + ") on element of TreasureHuntRequestAnswerMessage.result.");
         }
      }
   }
}
