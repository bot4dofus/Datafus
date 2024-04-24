package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeStartOkCraftWithInformationMessage extends ExchangeStartOkCraftMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6872;
       
      
      private var _isInitialized:Boolean = false;
      
      public var skillId:uint = 0;
      
      public function ExchangeStartOkCraftWithInformationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6872;
      }
      
      public function initExchangeStartOkCraftWithInformationMessage(skillId:uint = 0) : ExchangeStartOkCraftWithInformationMessage
      {
         this.skillId = skillId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.skillId = 0;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeStartOkCraftWithInformationMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkCraftWithInformationMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeStartOkCraftMessage(output);
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
         }
         output.writeVarInt(this.skillId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStartOkCraftWithInformationMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkCraftWithInformationMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._skillIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeStartOkCraftWithInformationMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeStartOkCraftWithInformationMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._skillIdFunc);
      }
      
      private function _skillIdFunc(input:ICustomDataInput) : void
      {
         this.skillId = input.readVarUhInt();
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element of ExchangeStartOkCraftWithInformationMessage.skillId.");
         }
      }
   }
}
