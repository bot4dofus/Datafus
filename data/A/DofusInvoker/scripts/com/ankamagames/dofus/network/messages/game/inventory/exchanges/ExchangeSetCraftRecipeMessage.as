package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeSetCraftRecipeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3981;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectGID:uint = 0;
      
      public function ExchangeSetCraftRecipeMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3981;
      }
      
      public function initExchangeSetCraftRecipeMessage(objectGID:uint = 0) : ExchangeSetCraftRecipeMessage
      {
         this.objectGID = objectGID;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectGID = 0;
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
         this.serializeAs_ExchangeSetCraftRecipeMessage(output);
      }
      
      public function serializeAs_ExchangeSetCraftRecipeMessage(output:ICustomDataOutput) : void
      {
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         output.writeVarInt(this.objectGID);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeSetCraftRecipeMessage(input);
      }
      
      public function deserializeAs_ExchangeSetCraftRecipeMessage(input:ICustomDataInput) : void
      {
         this._objectGIDFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeSetCraftRecipeMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeSetCraftRecipeMessage(tree:FuncTree) : void
      {
         tree.addChild(this._objectGIDFunc);
      }
      
      private function _objectGIDFunc(input:ICustomDataInput) : void
      {
         this.objectGID = input.readVarUhInt();
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element of ExchangeSetCraftRecipeMessage.objectGID.");
         }
      }
   }
}
