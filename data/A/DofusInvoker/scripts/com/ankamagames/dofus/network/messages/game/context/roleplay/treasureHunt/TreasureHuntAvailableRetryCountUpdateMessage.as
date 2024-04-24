package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TreasureHuntAvailableRetryCountUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7732;
       
      
      private var _isInitialized:Boolean = false;
      
      public var questType:uint = 0;
      
      public var availableRetryCount:int = 0;
      
      public function TreasureHuntAvailableRetryCountUpdateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7732;
      }
      
      public function initTreasureHuntAvailableRetryCountUpdateMessage(questType:uint = 0, availableRetryCount:int = 0) : TreasureHuntAvailableRetryCountUpdateMessage
      {
         this.questType = questType;
         this.availableRetryCount = availableRetryCount;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.questType = 0;
         this.availableRetryCount = 0;
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
         this.serializeAs_TreasureHuntAvailableRetryCountUpdateMessage(output);
      }
      
      public function serializeAs_TreasureHuntAvailableRetryCountUpdateMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.questType);
         output.writeInt(this.availableRetryCount);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TreasureHuntAvailableRetryCountUpdateMessage(input);
      }
      
      public function deserializeAs_TreasureHuntAvailableRetryCountUpdateMessage(input:ICustomDataInput) : void
      {
         this._questTypeFunc(input);
         this._availableRetryCountFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TreasureHuntAvailableRetryCountUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_TreasureHuntAvailableRetryCountUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._questTypeFunc);
         tree.addChild(this._availableRetryCountFunc);
      }
      
      private function _questTypeFunc(input:ICustomDataInput) : void
      {
         this.questType = input.readByte();
         if(this.questType < 0)
         {
            throw new Error("Forbidden value (" + this.questType + ") on element of TreasureHuntAvailableRetryCountUpdateMessage.questType.");
         }
      }
      
      private function _availableRetryCountFunc(input:ICustomDataInput) : void
      {
         this.availableRetryCount = input.readInt();
      }
   }
}
