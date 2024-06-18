package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsForSell;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HouseToSellListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8317;
       
      
      private var _isInitialized:Boolean = false;
      
      public var pageIndex:uint = 0;
      
      public var totalPage:uint = 0;
      
      public var houseList:Vector.<HouseInformationsForSell>;
      
      private var _houseListtree:FuncTree;
      
      public function HouseToSellListMessage()
      {
         this.houseList = new Vector.<HouseInformationsForSell>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8317;
      }
      
      public function initHouseToSellListMessage(pageIndex:uint = 0, totalPage:uint = 0, houseList:Vector.<HouseInformationsForSell> = null) : HouseToSellListMessage
      {
         this.pageIndex = pageIndex;
         this.totalPage = totalPage;
         this.houseList = houseList;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.pageIndex = 0;
         this.totalPage = 0;
         this.houseList = new Vector.<HouseInformationsForSell>();
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
         this.serializeAs_HouseToSellListMessage(output);
      }
      
      public function serializeAs_HouseToSellListMessage(output:ICustomDataOutput) : void
      {
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element pageIndex.");
         }
         output.writeVarShort(this.pageIndex);
         if(this.totalPage < 0)
         {
            throw new Error("Forbidden value (" + this.totalPage + ") on element totalPage.");
         }
         output.writeVarShort(this.totalPage);
         output.writeShort(this.houseList.length);
         for(var _i3:uint = 0; _i3 < this.houseList.length; _i3++)
         {
            (this.houseList[_i3] as HouseInformationsForSell).serializeAs_HouseInformationsForSell(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseToSellListMessage(input);
      }
      
      public function deserializeAs_HouseToSellListMessage(input:ICustomDataInput) : void
      {
         var _item3:HouseInformationsForSell = null;
         this._pageIndexFunc(input);
         this._totalPageFunc(input);
         var _houseListLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _houseListLen; _i3++)
         {
            _item3 = new HouseInformationsForSell();
            _item3.deserialize(input);
            this.houseList.push(_item3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseToSellListMessage(tree);
      }
      
      public function deserializeAsyncAs_HouseToSellListMessage(tree:FuncTree) : void
      {
         tree.addChild(this._pageIndexFunc);
         tree.addChild(this._totalPageFunc);
         this._houseListtree = tree.addChild(this._houseListtreeFunc);
      }
      
      private function _pageIndexFunc(input:ICustomDataInput) : void
      {
         this.pageIndex = input.readVarUhShort();
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element of HouseToSellListMessage.pageIndex.");
         }
      }
      
      private function _totalPageFunc(input:ICustomDataInput) : void
      {
         this.totalPage = input.readVarUhShort();
         if(this.totalPage < 0)
         {
            throw new Error("Forbidden value (" + this.totalPage + ") on element of HouseToSellListMessage.totalPage.");
         }
      }
      
      private function _houseListtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._houseListtree.addChild(this._houseListFunc);
         }
      }
      
      private function _houseListFunc(input:ICustomDataInput) : void
      {
         var _item:HouseInformationsForSell = new HouseInformationsForSell();
         _item.deserialize(input);
         this.houseList.push(_item);
      }
   }
}
