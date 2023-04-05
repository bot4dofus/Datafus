package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PrismSettingsRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9345;
       
      
      private var _isInitialized:Boolean = false;
      
      public var subAreaId:uint = 0;
      
      public var startDefenseTime:uint = 0;
      
      public function PrismSettingsRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9345;
      }
      
      public function initPrismSettingsRequestMessage(subAreaId:uint = 0, startDefenseTime:uint = 0) : PrismSettingsRequestMessage
      {
         this.subAreaId = subAreaId;
         this.startDefenseTime = startDefenseTime;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.subAreaId = 0;
         this.startDefenseTime = 0;
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
         this.serializeAs_PrismSettingsRequestMessage(output);
      }
      
      public function serializeAs_PrismSettingsRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         if(this.startDefenseTime < 0)
         {
            throw new Error("Forbidden value (" + this.startDefenseTime + ") on element startDefenseTime.");
         }
         output.writeByte(this.startDefenseTime);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismSettingsRequestMessage(input);
      }
      
      public function deserializeAs_PrismSettingsRequestMessage(input:ICustomDataInput) : void
      {
         this._subAreaIdFunc(input);
         this._startDefenseTimeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismSettingsRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_PrismSettingsRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._startDefenseTimeFunc);
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismSettingsRequestMessage.subAreaId.");
         }
      }
      
      private function _startDefenseTimeFunc(input:ICustomDataInput) : void
      {
         this.startDefenseTime = input.readByte();
         if(this.startDefenseTime < 0)
         {
            throw new Error("Forbidden value (" + this.startDefenseTime + ") on element of PrismSettingsRequestMessage.startDefenseTime.");
         }
      }
   }
}
