package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
   import com.ankamagames.dofus.network.types.game.paddock.PaddockInformationsForSell;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PaddockToSellListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5837;
       
      
      private var _isInitialized:Boolean = false;
      
      public var pageIndex:uint = 0;
      
      public var totalPage:uint = 0;
      
      public var paddockList:Vector.<PaddockInformationsForSell>;
      
      private var _paddockListtree:FuncTree;
      
      public function PaddockToSellListMessage()
      {
         this.paddockList = new Vector.<PaddockInformationsForSell>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5837;
      }
      
      public function initPaddockToSellListMessage(pageIndex:uint = 0, totalPage:uint = 0, paddockList:Vector.<PaddockInformationsForSell> = null) : PaddockToSellListMessage
      {
         this.pageIndex = pageIndex;
         this.totalPage = totalPage;
         this.paddockList = paddockList;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.pageIndex = 0;
         this.totalPage = 0;
         this.paddockList = new Vector.<PaddockInformationsForSell>();
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
         this.serializeAs_PaddockToSellListMessage(output);
      }
      
      public function serializeAs_PaddockToSellListMessage(output:ICustomDataOutput) : void
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
         output.writeShort(this.paddockList.length);
         for(var _i3:uint = 0; _i3 < this.paddockList.length; _i3++)
         {
            (this.paddockList[_i3] as PaddockInformationsForSell).serializeAs_PaddockInformationsForSell(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockToSellListMessage(input);
      }
      
      public function deserializeAs_PaddockToSellListMessage(input:ICustomDataInput) : void
      {
         var _item3:PaddockInformationsForSell = null;
         this._pageIndexFunc(input);
         this._totalPageFunc(input);
         var _paddockListLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _paddockListLen; _i3++)
         {
            _item3 = new PaddockInformationsForSell();
            _item3.deserialize(input);
            this.paddockList.push(_item3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PaddockToSellListMessage(tree);
      }
      
      public function deserializeAsyncAs_PaddockToSellListMessage(tree:FuncTree) : void
      {
         tree.addChild(this._pageIndexFunc);
         tree.addChild(this._totalPageFunc);
         this._paddockListtree = tree.addChild(this._paddockListtreeFunc);
      }
      
      private function _pageIndexFunc(input:ICustomDataInput) : void
      {
         this.pageIndex = input.readVarUhShort();
         if(this.pageIndex < 0)
         {
            throw new Error("Forbidden value (" + this.pageIndex + ") on element of PaddockToSellListMessage.pageIndex.");
         }
      }
      
      private function _totalPageFunc(input:ICustomDataInput) : void
      {
         this.totalPage = input.readVarUhShort();
         if(this.totalPage < 0)
         {
            throw new Error("Forbidden value (" + this.totalPage + ") on element of PaddockToSellListMessage.totalPage.");
         }
      }
      
      private function _paddockListtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._paddockListtree.addChild(this._paddockListFunc);
         }
      }
      
      private function _paddockListFunc(input:ICustomDataInput) : void
      {
         var _item:PaddockInformationsForSell = new PaddockInformationsForSell();
         _item.deserialize(input);
         this.paddockList.push(_item);
      }
   }
}
