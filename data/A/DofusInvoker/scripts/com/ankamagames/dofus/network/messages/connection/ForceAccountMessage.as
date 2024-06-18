package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ForceAccountMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5654;
       
      
      private var _isInitialized:Boolean = false;
      
      public var accountId:uint = 0;
      
      public function ForceAccountMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5654;
      }
      
      public function initForceAccountMessage(accountId:uint = 0) : ForceAccountMessage
      {
         this.accountId = accountId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.accountId = 0;
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
         this.serializeAs_ForceAccountMessage(output);
      }
      
      public function serializeAs_ForceAccountMessage(output:ICustomDataOutput) : void
      {
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         output.writeInt(this.accountId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ForceAccountMessage(input);
      }
      
      public function deserializeAs_ForceAccountMessage(input:ICustomDataInput) : void
      {
         this._accountIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ForceAccountMessage(tree);
      }
      
      public function deserializeAsyncAs_ForceAccountMessage(tree:FuncTree) : void
      {
         tree.addChild(this._accountIdFunc);
      }
      
      private function _accountIdFunc(input:ICustomDataInput) : void
      {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of ForceAccountMessage.accountId.");
         }
      }
   }
}
