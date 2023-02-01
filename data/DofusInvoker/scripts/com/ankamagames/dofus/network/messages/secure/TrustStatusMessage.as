package com.ankamagames.dofus.network.messages.secure
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TrustStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6065;
       
      
      private var _isInitialized:Boolean = false;
      
      public var trusted:Boolean = false;
      
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
         return 6065;
      }
      
      public function initTrustStatusMessage(trusted:Boolean = false, certified:Boolean = false) : TrustStatusMessage
      {
         this.trusted = trusted;
         this.certified = certified;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.trusted = false;
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
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.trusted);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.certified);
         output.writeByte(_box0);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TrustStatusMessage(input);
      }
      
      public function deserializeAs_TrustStatusMessage(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TrustStatusMessage(tree);
      }
      
      public function deserializeAsyncAs_TrustStatusMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.trusted = BooleanByteWrapper.getFlag(_box0,0);
         this.certified = BooleanByteWrapper.getFlag(_box0,1);
      }
   }
}
