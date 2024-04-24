package com.ankamagames.dofus.network.messages.secure
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TrustStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3397;
       
      
      private var _isInitialized:Boolean = false;
      
      public var certified:Boolean = false;
      
      public function TrustStatusMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3397;
      }
      
      public function initTrustStatusMessage(certified:Boolean = false) : TrustStatusMessage
      {
         this.certified = certified;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.certified = false;
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
         this.serializeAs_TrustStatusMessage(output);
      }
      
      public function serializeAs_TrustStatusMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.certified);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TrustStatusMessage(input);
      }
      
      public function deserializeAs_TrustStatusMessage(input:ICustomDataInput) : void
      {
         this._certifiedFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TrustStatusMessage(tree);
      }
      
      public function deserializeAsyncAs_TrustStatusMessage(tree:FuncTree) : void
      {
         tree.addChild(this._certifiedFunc);
      }
      
      private function _certifiedFunc(input:ICustomDataInput) : void
      {
         this.certified = input.readBoolean();
      }
   }
}
