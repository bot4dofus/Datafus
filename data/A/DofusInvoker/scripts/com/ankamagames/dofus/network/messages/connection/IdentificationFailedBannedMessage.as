package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IdentificationFailedBannedMessage extends IdentificationFailedMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8668;
       
      
      private var _isInitialized:Boolean = false;
      
      public var banEndDate:Number = 0;
      
      public function IdentificationFailedBannedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8668;
      }
      
      public function initIdentificationFailedBannedMessage(reason:uint = 99, banEndDate:Number = 0) : IdentificationFailedBannedMessage
      {
         super.initIdentificationFailedMessage(reason);
         this.banEndDate = banEndDate;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.banEndDate = 0;
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
         this.serializeAs_IdentificationFailedBannedMessage(output);
      }
      
      public function serializeAs_IdentificationFailedBannedMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_IdentificationFailedMessage(output);
         if(this.banEndDate < 0 || this.banEndDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.banEndDate + ") on element banEndDate.");
         }
         output.writeDouble(this.banEndDate);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IdentificationFailedBannedMessage(input);
      }
      
      public function deserializeAs_IdentificationFailedBannedMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._banEndDateFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IdentificationFailedBannedMessage(tree);
      }
      
      public function deserializeAsyncAs_IdentificationFailedBannedMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._banEndDateFunc);
      }
      
      private function _banEndDateFunc(input:ICustomDataInput) : void
      {
         this.banEndDate = input.readDouble();
         if(this.banEndDate < 0 || this.banEndDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.banEndDate + ") on element of IdentificationFailedBannedMessage.banEndDate.");
         }
      }
   }
}
