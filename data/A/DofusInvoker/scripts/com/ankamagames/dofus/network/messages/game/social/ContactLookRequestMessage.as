package com.ankamagames.dofus.network.messages.game.social
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ContactLookRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7562;
       
      
      private var _isInitialized:Boolean = false;
      
      public var requestId:uint = 0;
      
      public var contactType:uint = 0;
      
      public function ContactLookRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7562;
      }
      
      public function initContactLookRequestMessage(requestId:uint = 0, contactType:uint = 0) : ContactLookRequestMessage
      {
         this.requestId = requestId;
         this.contactType = contactType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.requestId = 0;
         this.contactType = 0;
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
         this.serializeAs_ContactLookRequestMessage(output);
      }
      
      public function serializeAs_ContactLookRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.requestId < 0 || this.requestId > 255)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
         }
         output.writeByte(this.requestId);
         output.writeByte(this.contactType);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ContactLookRequestMessage(input);
      }
      
      public function deserializeAs_ContactLookRequestMessage(input:ICustomDataInput) : void
      {
         this._requestIdFunc(input);
         this._contactTypeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ContactLookRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_ContactLookRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._requestIdFunc);
         tree.addChild(this._contactTypeFunc);
      }
      
      private function _requestIdFunc(input:ICustomDataInput) : void
      {
         this.requestId = input.readUnsignedByte();
         if(this.requestId < 0 || this.requestId > 255)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element of ContactLookRequestMessage.requestId.");
         }
      }
      
      private function _contactTypeFunc(input:ICustomDataInput) : void
      {
         this.contactType = input.readByte();
         if(this.contactType < 0)
         {
            throw new Error("Forbidden value (" + this.contactType + ") on element of ContactLookRequestMessage.contactType.");
         }
      }
   }
}
