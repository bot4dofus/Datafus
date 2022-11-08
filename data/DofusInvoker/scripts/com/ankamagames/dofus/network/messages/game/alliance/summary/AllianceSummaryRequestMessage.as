package com.ankamagames.dofus.network.messages.game.alliance.summary
{
   import com.ankamagames.dofus.network.messages.game.PaginationRequestAbstractMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceSummaryRequestMessage extends PaginationRequestAbstractMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8746;
       
      
      private var _isInitialized:Boolean = false;
      
      public var nameFilter:String = "";
      
      public var tagFilter:String = "";
      
      public var playerNameFilter:String = "";
      
      public var sortType:uint = 0;
      
      public var sortDescending:Boolean = false;
      
      public function AllianceSummaryRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8746;
      }
      
      public function initAllianceSummaryRequestMessage(offset:Number = 0, count:uint = 0, nameFilter:String = "", tagFilter:String = "", playerNameFilter:String = "", sortType:uint = 0, sortDescending:Boolean = false) : AllianceSummaryRequestMessage
      {
         super.initPaginationRequestAbstractMessage(offset,count);
         this.nameFilter = nameFilter;
         this.tagFilter = tagFilter;
         this.playerNameFilter = playerNameFilter;
         this.sortType = sortType;
         this.sortDescending = sortDescending;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.nameFilter = "";
         this.tagFilter = "";
         this.playerNameFilter = "";
         this.sortType = 0;
         this.sortDescending = false;
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
         this.serializeAs_AllianceSummaryRequestMessage(output);
      }
      
      public function serializeAs_AllianceSummaryRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_PaginationRequestAbstractMessage(output);
         output.writeUTF(this.nameFilter);
         output.writeUTF(this.tagFilter);
         output.writeUTF(this.playerNameFilter);
         output.writeByte(this.sortType);
         output.writeBoolean(this.sortDescending);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceSummaryRequestMessage(input);
      }
      
      public function deserializeAs_AllianceSummaryRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._nameFilterFunc(input);
         this._tagFilterFunc(input);
         this._playerNameFilterFunc(input);
         this._sortTypeFunc(input);
         this._sortDescendingFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceSummaryRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceSummaryRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._nameFilterFunc);
         tree.addChild(this._tagFilterFunc);
         tree.addChild(this._playerNameFilterFunc);
         tree.addChild(this._sortTypeFunc);
         tree.addChild(this._sortDescendingFunc);
      }
      
      private function _nameFilterFunc(input:ICustomDataInput) : void
      {
         this.nameFilter = input.readUTF();
      }
      
      private function _tagFilterFunc(input:ICustomDataInput) : void
      {
         this.tagFilter = input.readUTF();
      }
      
      private function _playerNameFilterFunc(input:ICustomDataInput) : void
      {
         this.playerNameFilter = input.readUTF();
      }
      
      private function _sortTypeFunc(input:ICustomDataInput) : void
      {
         this.sortType = input.readByte();
         if(this.sortType < 0)
         {
            throw new Error("Forbidden value (" + this.sortType + ") on element of AllianceSummaryRequestMessage.sortType.");
         }
      }
      
      private function _sortDescendingFunc(input:ICustomDataInput) : void
      {
         this.sortDescending = input.readBoolean();
      }
   }
}
