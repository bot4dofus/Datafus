package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IgnoredDeleteRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7645;
       
      
      private var _isInitialized:Boolean = false;
      
      public var accountId:uint = 0;
      
      public var session:Boolean = false;
      
      public function IgnoredDeleteRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7645;
      }
      
      public function initIgnoredDeleteRequestMessage(accountId:uint = 0, session:Boolean = false) : IgnoredDeleteRequestMessage
      {
         this.accountId = accountId;
         this.session = session;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.accountId = 0;
         this.session = false;
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
         this.serializeAs_IgnoredDeleteRequestMessage(output);
      }
      
      public function serializeAs_IgnoredDeleteRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         output.writeInt(this.accountId);
         output.writeBoolean(this.session);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IgnoredDeleteRequestMessage(input);
      }
      
      public function deserializeAs_IgnoredDeleteRequestMessage(input:ICustomDataInput) : void
      {
         this._accountIdFunc(input);
         this._sessionFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IgnoredDeleteRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_IgnoredDeleteRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._accountIdFunc);
         tree.addChild(this._sessionFunc);
      }
      
      private function _accountIdFunc(input:ICustomDataInput) : void
      {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of IgnoredDeleteRequestMessage.accountId.");
         }
      }
      
      private function _sessionFunc(input:ICustomDataInput) : void
      {
         this.session = input.readBoolean();
      }
   }
}
