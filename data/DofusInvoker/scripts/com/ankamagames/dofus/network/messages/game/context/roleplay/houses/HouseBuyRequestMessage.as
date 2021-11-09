package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HouseBuyRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2433;
       
      
      private var _isInitialized:Boolean = false;
      
      public var proposedPrice:Number = 0;
      
      public function HouseBuyRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2433;
      }
      
      public function initHouseBuyRequestMessage(proposedPrice:Number = 0) : HouseBuyRequestMessage
      {
         this.proposedPrice = proposedPrice;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.proposedPrice = 0;
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
         this.serializeAs_HouseBuyRequestMessage(output);
      }
      
      public function serializeAs_HouseBuyRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.proposedPrice < 0 || this.proposedPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.proposedPrice + ") on element proposedPrice.");
         }
         output.writeVarLong(this.proposedPrice);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseBuyRequestMessage(input);
      }
      
      public function deserializeAs_HouseBuyRequestMessage(input:ICustomDataInput) : void
      {
         this._proposedPriceFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseBuyRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_HouseBuyRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._proposedPriceFunc);
      }
      
      private function _proposedPriceFunc(input:ICustomDataInput) : void
      {
         this.proposedPrice = input.readVarUhLong();
         if(this.proposedPrice < 0 || this.proposedPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.proposedPrice + ") on element of HouseBuyRequestMessage.proposedPrice.");
         }
      }
   }
}
