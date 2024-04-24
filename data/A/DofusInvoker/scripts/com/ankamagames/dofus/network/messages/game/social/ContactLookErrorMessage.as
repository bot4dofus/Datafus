package com.ankamagames.dofus.network.messages.game.social
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ContactLookErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2452;
       
      
      private var _isInitialized:Boolean = false;
      
      public var requestId:uint = 0;
      
      public function ContactLookErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2452;
      }
      
      public function initContactLookErrorMessage(requestId:uint = 0) : ContactLookErrorMessage
      {
         this.requestId = requestId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.requestId = 0;
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
         this.serializeAs_ContactLookErrorMessage(output);
      }
      
      public function serializeAs_ContactLookErrorMessage(output:ICustomDataOutput) : void
      {
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
         }
         output.writeVarInt(this.requestId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ContactLookErrorMessage(input);
      }
      
      public function deserializeAs_ContactLookErrorMessage(input:ICustomDataInput) : void
      {
         this._requestIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ContactLookErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_ContactLookErrorMessage(tree:FuncTree) : void
      {
         tree.addChild(this._requestIdFunc);
      }
      
      private function _requestIdFunc(input:ICustomDataInput) : void
      {
         this.requestId = input.readVarUhInt();
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element of ContactLookErrorMessage.requestId.");
         }
      }
   }
}
