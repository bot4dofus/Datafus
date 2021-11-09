package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TreasureHuntGiveUpRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 969;
       
      
      private var _isInitialized:Boolean = false;
      
      public var questType:uint = 0;
      
      public function TreasureHuntGiveUpRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 969;
      }
      
      public function initTreasureHuntGiveUpRequestMessage(questType:uint = 0) : TreasureHuntGiveUpRequestMessage
      {
         this.questType = questType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.questType = 0;
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
         this.serializeAs_TreasureHuntGiveUpRequestMessage(output);
      }
      
      public function serializeAs_TreasureHuntGiveUpRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.questType);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TreasureHuntGiveUpRequestMessage(input);
      }
      
      public function deserializeAs_TreasureHuntGiveUpRequestMessage(input:ICustomDataInput) : void
      {
         this._questTypeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TreasureHuntGiveUpRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_TreasureHuntGiveUpRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._questTypeFunc);
      }
      
      private function _questTypeFunc(input:ICustomDataInput) : void
      {
         this.questType = input.readByte();
         if(this.questType < 0)
         {
            throw new Error("Forbidden value (" + this.questType + ") on element of TreasureHuntGiveUpRequestMessage.questType.");
         }
      }
   }
}
