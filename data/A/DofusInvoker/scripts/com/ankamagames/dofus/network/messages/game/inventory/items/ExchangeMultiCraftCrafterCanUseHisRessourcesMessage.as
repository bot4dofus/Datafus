package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeMultiCraftCrafterCanUseHisRessourcesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1269;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allowed:Boolean = false;
      
      public function ExchangeMultiCraftCrafterCanUseHisRessourcesMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1269;
      }
      
      public function initExchangeMultiCraftCrafterCanUseHisRessourcesMessage(allowed:Boolean = false) : ExchangeMultiCraftCrafterCanUseHisRessourcesMessage
      {
         this.allowed = allowed;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allowed = false;
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
         this.serializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(output);
      }
      
      public function serializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.allowed);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(input);
      }
      
      public function deserializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(input:ICustomDataInput) : void
      {
         this._allowedFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(tree:FuncTree) : void
      {
         tree.addChild(this._allowedFunc);
      }
      
      private function _allowedFunc(input:ICustomDataInput) : void
      {
         this.allowed = input.readBoolean();
      }
   }
}
