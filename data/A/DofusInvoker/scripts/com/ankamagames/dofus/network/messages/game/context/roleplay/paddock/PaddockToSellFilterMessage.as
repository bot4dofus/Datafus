package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PaddockToSellFilterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3852;
       
      
      private var _isInitialized:Boolean = false;
      
      public var areaId:int = 0;
      
      public var atLeastNbMount:int = 0;
      
      public var atLeastNbMachine:int = 0;
      
      public var maxPrice:Number = 0;
      
      public var orderBy:uint = 0;
      
      public function PaddockToSellFilterMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3852;
      }
      
      public function initPaddockToSellFilterMessage(areaId:int = 0, atLeastNbMount:int = 0, atLeastNbMachine:int = 0, maxPrice:Number = 0, orderBy:uint = 0) : PaddockToSellFilterMessage
      {
         this.areaId = areaId;
         this.atLeastNbMount = atLeastNbMount;
         this.atLeastNbMachine = atLeastNbMachine;
         this.maxPrice = maxPrice;
         this.orderBy = orderBy;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.areaId = 0;
         this.atLeastNbMount = 0;
         this.atLeastNbMachine = 0;
         this.maxPrice = 0;
         this.orderBy = 0;
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
         this.serializeAs_PaddockToSellFilterMessage(output);
      }
      
      public function serializeAs_PaddockToSellFilterMessage(output:ICustomDataOutput) : void
      {
         output.writeInt(this.areaId);
         output.writeByte(this.atLeastNbMount);
         output.writeByte(this.atLeastNbMachine);
         if(this.maxPrice < 0 || this.maxPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.maxPrice + ") on element maxPrice.");
         }
         output.writeVarLong(this.maxPrice);
         output.writeByte(this.orderBy);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockToSellFilterMessage(input);
      }
      
      public function deserializeAs_PaddockToSellFilterMessage(input:ICustomDataInput) : void
      {
         this._areaIdFunc(input);
         this._atLeastNbMountFunc(input);
         this._atLeastNbMachineFunc(input);
         this._maxPriceFunc(input);
         this._orderByFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PaddockToSellFilterMessage(tree);
      }
      
      public function deserializeAsyncAs_PaddockToSellFilterMessage(tree:FuncTree) : void
      {
         tree.addChild(this._areaIdFunc);
         tree.addChild(this._atLeastNbMountFunc);
         tree.addChild(this._atLeastNbMachineFunc);
         tree.addChild(this._maxPriceFunc);
         tree.addChild(this._orderByFunc);
      }
      
      private function _areaIdFunc(input:ICustomDataInput) : void
      {
         this.areaId = input.readInt();
      }
      
      private function _atLeastNbMountFunc(input:ICustomDataInput) : void
      {
         this.atLeastNbMount = input.readByte();
      }
      
      private function _atLeastNbMachineFunc(input:ICustomDataInput) : void
      {
         this.atLeastNbMachine = input.readByte();
      }
      
      private function _maxPriceFunc(input:ICustomDataInput) : void
      {
         this.maxPrice = input.readVarUhLong();
         if(this.maxPrice < 0 || this.maxPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.maxPrice + ") on element of PaddockToSellFilterMessage.maxPrice.");
         }
      }
      
      private function _orderByFunc(input:ICustomDataInput) : void
      {
         this.orderBy = input.readByte();
         if(this.orderBy < 0)
         {
            throw new Error("Forbidden value (" + this.orderBy + ") on element of PaddockToSellFilterMessage.orderBy.");
         }
      }
   }
}
