package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.common.AbstractPlayerSearchInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BasicWhoIsRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6759;
       
      
      private var _isInitialized:Boolean = false;
      
      public var verbose:Boolean = false;
      
      public var target:AbstractPlayerSearchInformation;
      
      private var _targettree:FuncTree;
      
      public function BasicWhoIsRequestMessage()
      {
         this.target = new AbstractPlayerSearchInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6759;
      }
      
      public function initBasicWhoIsRequestMessage(verbose:Boolean = false, target:AbstractPlayerSearchInformation = null) : BasicWhoIsRequestMessage
      {
         this.verbose = verbose;
         this.target = target;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.verbose = false;
         this.target = new AbstractPlayerSearchInformation();
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(data);
         }
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
         this.serializeAs_BasicWhoIsRequestMessage(output);
      }
      
      public function serializeAs_BasicWhoIsRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.verbose);
         output.writeShort(this.target.getTypeId());
         this.target.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BasicWhoIsRequestMessage(input);
      }
      
      public function deserializeAs_BasicWhoIsRequestMessage(input:ICustomDataInput) : void
      {
         this._verboseFunc(input);
         var _id2:uint = input.readUnsignedShort();
         this.target = ProtocolTypeManager.getInstance(AbstractPlayerSearchInformation,_id2);
         this.target.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BasicWhoIsRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_BasicWhoIsRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._verboseFunc);
         this._targettree = tree.addChild(this._targettreeFunc);
      }
      
      private function _verboseFunc(input:ICustomDataInput) : void
      {
         this.verbose = input.readBoolean();
      }
      
      private function _targettreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.target = ProtocolTypeManager.getInstance(AbstractPlayerSearchInformation,_id);
         this.target.deserializeAsync(this._targettree);
      }
   }
}
