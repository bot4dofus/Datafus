package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PrismSetSabotagedRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 131;
       
      
      private var _isInitialized:Boolean = false;
      
      public var subAreaId:uint = 0;
      
      public function PrismSetSabotagedRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 131;
      }
      
      public function initPrismSetSabotagedRequestMessage(subAreaId:uint = 0) : PrismSetSabotagedRequestMessage
      {
         this.subAreaId = subAreaId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.subAreaId = 0;
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
         this.serializeAs_PrismSetSabotagedRequestMessage(output);
      }
      
      public function serializeAs_PrismSetSabotagedRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismSetSabotagedRequestMessage(input);
      }
      
      public function deserializeAs_PrismSetSabotagedRequestMessage(input:ICustomDataInput) : void
      {
         this._subAreaIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismSetSabotagedRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_PrismSetSabotagedRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._subAreaIdFunc);
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismSetSabotagedRequestMessage.subAreaId.");
         }
      }
   }
}
