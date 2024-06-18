package com.ankamagames.dofus.network.messages.subscription
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AccountSubscriptionElapsedDurationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5336;
       
      
      private var _isInitialized:Boolean = false;
      
      public var subscriptionElapsedDuration:Number = 0;
      
      public function AccountSubscriptionElapsedDurationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5336;
      }
      
      public function initAccountSubscriptionElapsedDurationMessage(subscriptionElapsedDuration:Number = 0) : AccountSubscriptionElapsedDurationMessage
      {
         this.subscriptionElapsedDuration = subscriptionElapsedDuration;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.subscriptionElapsedDuration = 0;
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
         this.serializeAs_AccountSubscriptionElapsedDurationMessage(output);
      }
      
      public function serializeAs_AccountSubscriptionElapsedDurationMessage(output:ICustomDataOutput) : void
      {
         if(this.subscriptionElapsedDuration < 0 || this.subscriptionElapsedDuration > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.subscriptionElapsedDuration + ") on element subscriptionElapsedDuration.");
         }
         output.writeDouble(this.subscriptionElapsedDuration);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AccountSubscriptionElapsedDurationMessage(input);
      }
      
      public function deserializeAs_AccountSubscriptionElapsedDurationMessage(input:ICustomDataInput) : void
      {
         this._subscriptionElapsedDurationFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AccountSubscriptionElapsedDurationMessage(tree);
      }
      
      public function deserializeAsyncAs_AccountSubscriptionElapsedDurationMessage(tree:FuncTree) : void
      {
         tree.addChild(this._subscriptionElapsedDurationFunc);
      }
      
      private function _subscriptionElapsedDurationFunc(input:ICustomDataInput) : void
      {
         this.subscriptionElapsedDuration = input.readDouble();
         if(this.subscriptionElapsedDuration < 0 || this.subscriptionElapsedDuration > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.subscriptionElapsedDuration + ") on element of AccountSubscriptionElapsedDurationMessage.subscriptionElapsedDuration.");
         }
      }
   }
}
