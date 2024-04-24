package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeCraftResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2633;
       
      
      private var _isInitialized:Boolean = false;
      
      public var craftResult:uint = 0;
      
      public function ExchangeCraftResultMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2633;
      }
      
      public function initExchangeCraftResultMessage(craftResult:uint = 0) : ExchangeCraftResultMessage
      {
         this.craftResult = craftResult;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.craftResult = 0;
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
         this.serializeAs_ExchangeCraftResultMessage(output);
      }
      
      public function serializeAs_ExchangeCraftResultMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.craftResult);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeCraftResultMessage(input);
      }
      
      public function deserializeAs_ExchangeCraftResultMessage(input:ICustomDataInput) : void
      {
         this._craftResultFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeCraftResultMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeCraftResultMessage(tree:FuncTree) : void
      {
         tree.addChild(this._craftResultFunc);
      }
      
      private function _craftResultFunc(input:ICustomDataInput) : void
      {
         this.craftResult = input.readByte();
         if(this.craftResult < 0)
         {
            throw new Error("Forbidden value (" + this.craftResult + ") on element of ExchangeCraftResultMessage.craftResult.");
         }
      }
   }
}
