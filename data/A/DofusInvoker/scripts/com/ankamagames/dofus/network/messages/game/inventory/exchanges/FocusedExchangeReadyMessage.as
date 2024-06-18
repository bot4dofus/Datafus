package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class FocusedExchangeReadyMessage extends ExchangeReadyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 885;
       
      
      private var _isInitialized:Boolean = false;
      
      public var focusActionId:uint = 0;
      
      public function FocusedExchangeReadyMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 885;
      }
      
      public function initFocusedExchangeReadyMessage(ready:Boolean = false, step:uint = 0, focusActionId:uint = 0) : FocusedExchangeReadyMessage
      {
         super.initExchangeReadyMessage(ready,step);
         this.focusActionId = focusActionId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.focusActionId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(data);
         }
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
         this.serializeAs_FocusedExchangeReadyMessage(output);
      }
      
      public function serializeAs_FocusedExchangeReadyMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeReadyMessage(output);
         if(this.focusActionId < 0)
         {
            throw new Error("Forbidden value (" + this.focusActionId + ") on element focusActionId.");
         }
         output.writeVarInt(this.focusActionId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FocusedExchangeReadyMessage(input);
      }
      
      public function deserializeAs_FocusedExchangeReadyMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._focusActionIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FocusedExchangeReadyMessage(tree);
      }
      
      public function deserializeAsyncAs_FocusedExchangeReadyMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._focusActionIdFunc);
      }
      
      private function _focusActionIdFunc(input:ICustomDataInput) : void
      {
         this.focusActionId = input.readVarUhInt();
         if(this.focusActionId < 0)
         {
            throw new Error("Forbidden value (" + this.focusActionId + ") on element of FocusedExchangeReadyMessage.focusActionId.");
         }
      }
   }
}
