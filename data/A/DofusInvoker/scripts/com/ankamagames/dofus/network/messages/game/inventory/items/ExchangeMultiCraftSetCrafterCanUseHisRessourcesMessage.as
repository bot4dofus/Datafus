package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6299;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allow:Boolean = false;
      
      public function ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6299;
      }
      
      public function initExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(allow:Boolean = false) : ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage
      {
         this.allow = allow;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allow = false;
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
         this.serializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(output);
      }
      
      public function serializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.allow);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(input);
      }
      
      public function deserializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(input:ICustomDataInput) : void
      {
         this._allowFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(tree:FuncTree) : void
      {
         tree.addChild(this._allowFunc);
      }
      
      private function _allowFunc(input:ICustomDataInput) : void
      {
         this.allow = input.readBoolean();
      }
   }
}
