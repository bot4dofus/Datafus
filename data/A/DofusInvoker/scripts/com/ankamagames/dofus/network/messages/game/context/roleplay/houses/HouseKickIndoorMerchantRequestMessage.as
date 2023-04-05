package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HouseKickIndoorMerchantRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2460;
       
      
      private var _isInitialized:Boolean = false;
      
      public var cellId:uint = 0;
      
      public function HouseKickIndoorMerchantRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2460;
      }
      
      public function initHouseKickIndoorMerchantRequestMessage(cellId:uint = 0) : HouseKickIndoorMerchantRequestMessage
      {
         this.cellId = cellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.cellId = 0;
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
         this.serializeAs_HouseKickIndoorMerchantRequestMessage(output);
      }
      
      public function serializeAs_HouseKickIndoorMerchantRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         output.writeVarShort(this.cellId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseKickIndoorMerchantRequestMessage(input);
      }
      
      public function deserializeAs_HouseKickIndoorMerchantRequestMessage(input:ICustomDataInput) : void
      {
         this._cellIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseKickIndoorMerchantRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_HouseKickIndoorMerchantRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._cellIdFunc);
      }
      
      private function _cellIdFunc(input:ICustomDataInput) : void
      {
         this.cellId = input.readVarUhShort();
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of HouseKickIndoorMerchantRequestMessage.cellId.");
         }
      }
   }
}
