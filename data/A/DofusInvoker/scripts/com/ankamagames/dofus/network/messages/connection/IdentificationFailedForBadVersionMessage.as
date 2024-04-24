package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.dofus.network.types.version.Version;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IdentificationFailedForBadVersionMessage extends IdentificationFailedMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8374;
       
      
      private var _isInitialized:Boolean = false;
      
      public var requiredVersion:Version;
      
      private var _requiredVersiontree:FuncTree;
      
      public function IdentificationFailedForBadVersionMessage()
      {
         this.requiredVersion = new Version();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8374;
      }
      
      public function initIdentificationFailedForBadVersionMessage(reason:uint = 99, requiredVersion:Version = null) : IdentificationFailedForBadVersionMessage
      {
         super.initIdentificationFailedMessage(reason);
         this.requiredVersion = requiredVersion;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.requiredVersion = new Version();
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
         this.serializeAs_IdentificationFailedForBadVersionMessage(output);
      }
      
      public function serializeAs_IdentificationFailedForBadVersionMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_IdentificationFailedMessage(output);
         this.requiredVersion.serializeAs_Version(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IdentificationFailedForBadVersionMessage(input);
      }
      
      public function deserializeAs_IdentificationFailedForBadVersionMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.requiredVersion = new Version();
         this.requiredVersion.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IdentificationFailedForBadVersionMessage(tree);
      }
      
      public function deserializeAsyncAs_IdentificationFailedForBadVersionMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._requiredVersiontree = tree.addChild(this._requiredVersiontreeFunc);
      }
      
      private function _requiredVersiontreeFunc(input:ICustomDataInput) : void
      {
         this.requiredVersion = new Version();
         this.requiredVersion.deserializeAsync(this._requiredVersiontree);
      }
   }
}
