package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PrismSetSabotagedRefusedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 305;
       
      
      private var _isInitialized:Boolean = false;
      
      public var subAreaId:uint = 0;
      
      public var reason:int = 0;
      
      public function PrismSetSabotagedRefusedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 305;
      }
      
      public function initPrismSetSabotagedRefusedMessage(subAreaId:uint = 0, reason:int = 0) : PrismSetSabotagedRefusedMessage
      {
         this.subAreaId = subAreaId;
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.subAreaId = 0;
         this.reason = 0;
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
         this.serializeAs_PrismSetSabotagedRefusedMessage(output);
      }
      
      public function serializeAs_PrismSetSabotagedRefusedMessage(output:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         output.writeByte(this.reason);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismSetSabotagedRefusedMessage(input);
      }
      
      public function deserializeAs_PrismSetSabotagedRefusedMessage(input:ICustomDataInput) : void
      {
         this._subAreaIdFunc(input);
         this._reasonFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismSetSabotagedRefusedMessage(tree);
      }
      
      public function deserializeAsyncAs_PrismSetSabotagedRefusedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._reasonFunc);
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismSetSabotagedRefusedMessage.subAreaId.");
         }
      }
      
      private function _reasonFunc(input:ICustomDataInput) : void
      {
         this.reason = input.readByte();
      }
   }
}
