package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeStartOkMulticraftCrafterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7458;
       
      
      private var _isInitialized:Boolean = false;
      
      public var skillId:uint = 0;
      
      public function ExchangeStartOkMulticraftCrafterMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7458;
      }
      
      public function initExchangeStartOkMulticraftCrafterMessage(skillId:uint = 0) : ExchangeStartOkMulticraftCrafterMessage
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
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeStartOkMulticraftCrafterMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkMulticraftCrafterMessage(output:ICustomDataOutput) : void
      {
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
         }
         output.writeVarInt(this.skillId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStartOkMulticraftCrafterMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkMulticraftCrafterMessage(input:ICustomDataInput) : void
      {
         this._skillIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeStartOkMulticraftCrafterMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeStartOkMulticraftCrafterMessage(tree:FuncTree) : void
      {
         tree.addChild(this._skillIdFunc);
      }
      
      private function _skillIdFunc(input:ICustomDataInput) : void
      {
         this.skillId = input.readVarUhInt();
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element of ExchangeStartOkMulticraftCrafterMessage.skillId.");
         }
      }
   }
}
