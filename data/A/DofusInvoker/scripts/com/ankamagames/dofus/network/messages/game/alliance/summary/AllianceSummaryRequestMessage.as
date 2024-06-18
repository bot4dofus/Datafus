package com.ankamagames.dofus.network.messages.game.alliance.summary
{
   import com.ankamagames.dofus.network.messages.game.PaginationRequestAbstractMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceSummaryRequestMessage extends PaginationRequestAbstractMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4007;
       
      
      private var _isInitialized:Boolean = false;
      
      public var filterType:int = 0;
      
      public var textFilter:String = "";
      
      public var hideFullFilter:Boolean = false;
      
      public var followingAllianceCriteria:Boolean = false;
      
      public var criterionFilter:Vector.<uint>;
      
      public var sortType:uint = 0;
      
      public var sortDescending:Boolean = false;
      
      public var languagesFilter:Vector.<uint>;
      
      public var recruitmentTypeFilter:Vector.<uint>;
      
      public var minPlayerLevelFilter:uint = 0;
      
      public var maxPlayerLevelFilter:uint = 0;
      
      private var _criterionFiltertree:FuncTree;
      
      private var _languagesFiltertree:FuncTree;
      
      private var _recruitmentTypeFiltertree:FuncTree;
      
      public function AllianceSummaryRequestMessage()
      {
         this.criterionFilter = new Vector.<uint>();
         this.languagesFilter = new Vector.<uint>();
         this.recruitmentTypeFilter = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4007;
      }
      
      public function initAllianceSummaryRequestMessage(offset:Number = 0, count:uint = 0, filterType:int = 0, textFilter:String = "", hideFullFilter:Boolean = false, followingAllianceCriteria:Boolean = false, criterionFilter:Vector.<uint> = null, sortType:uint = 0, sortDescending:Boolean = false, languagesFilter:Vector.<uint> = null, recruitmentTypeFilter:Vector.<uint> = null, minPlayerLevelFilter:uint = 0, maxPlayerLevelFilter:uint = 0) : AllianceSummaryRequestMessage
      {
         super.initPaginationRequestAbstractMessage(offset,count);
         this.filterType = filterType;
         this.textFilter = textFilter;
         this.hideFullFilter = hideFullFilter;
         this.followingAllianceCriteria = followingAllianceCriteria;
         this.criterionFilter = criterionFilter;
         this.sortType = sortType;
         this.sortDescending = sortDescending;
         this.languagesFilter = languagesFilter;
         this.recruitmentTypeFilter = recruitmentTypeFilter;
         this.minPlayerLevelFilter = minPlayerLevelFilter;
         this.maxPlayerLevelFilter = maxPlayerLevelFilter;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.filterType = 0;
         this.textFilter = "";
         this.hideFullFilter = false;
         this.followingAllianceCriteria = false;
         this.criterionFilter = new Vector.<uint>();
         this.sortType = 0;
         this.sortDescending = false;
         this.languagesFilter = new Vector.<uint>();
         this.recruitmentTypeFilter = new Vector.<uint>();
         this.minPlayerLevelFilter = 0;
         this.maxPlayerLevelFilter = 0;
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
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.hideFullFilter);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.followingAllianceCriteria);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.sortDescending);
         output.writeByte(_box0);
         output.writeInt(this.filterType);
         output.writeUTF(this.textFilter);
         output.writeShort(this.criterionFilter.length);
         for(var _i5:uint = 0; _i5 < this.criterionFilter.length; _i5++)
         {
            if(this.criterionFilter[_i5] < 0)
            {
               throw new Error("Forbidden value (" + this.criterionFilter[_i5] + ") on element 5 (starting at 1) of criterionFilter.");
            }
            output.writeVarInt(this.criterionFilter[_i5]);
         }
         output.writeByte(this.sortType);
         output.writeShort(this.languagesFilter.length);
         for(var _i8:uint = 0; _i8 < this.languagesFilter.length; _i8++)
         {
            if(this.languagesFilter[_i8] < 0)
            {
               throw new Error("Forbidden value (" + this.languagesFilter[_i8] + ") on element 8 (starting at 1) of languagesFilter.");
            }
            output.writeVarInt(this.languagesFilter[_i8]);
         }
         output.writeShort(this.recruitmentTypeFilter.length);
         for(var _i9:uint = 0; _i9 < this.recruitmentTypeFilter.length; _i9++)
         {
            output.writeByte(this.recruitmentTypeFilter[_i9]);
         }
         if(this.minPlayerLevelFilter < 0)
         {
            throw new Error("Forbidden value (" + this.minPlayerLevelFilter + ") on element minPlayerLevelFilter.");
         }
         output.writeShort(this.minPlayerLevelFilter);
         if(this.maxPlayerLevelFilter < 0)
         {
            throw new Error("Forbidden value (" + this.maxPlayerLevelFilter + ") on element maxPlayerLevelFilter.");
         }
         output.writeShort(this.maxPlayerLevelFilter);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceSummaryRequestMessage(input);
      }
      
      public function deserializeAs_AllianceSummaryRequestMessage(input:ICustomDataInput) : void
      {
         var _val5:uint = 0;
         var _val8:uint = 0;
         var _val9:uint = 0;
         super.deserialize(input);
         this.deserializeByteBoxes(input);
         this._filterTypeFunc(input);
         this._textFilterFunc(input);
         var _criterionFilterLen:uint = input.readUnsignedShort();
         for(var _i5:uint = 0; _i5 < _criterionFilterLen; _i5++)
         {
            _val5 = input.readVarUhInt();
            if(_val5 < 0)
            {
               throw new Error("Forbidden value (" + _val5 + ") on elements of criterionFilter.");
            }
            this.criterionFilter.push(_val5);
         }
         this._sortTypeFunc(input);
         var _languagesFilterLen:uint = input.readUnsignedShort();
         for(var _i8:uint = 0; _i8 < _languagesFilterLen; _i8++)
         {
            _val8 = input.readVarUhInt();
            if(_val8 < 0)
            {
               throw new Error("Forbidden value (" + _val8 + ") on elements of languagesFilter.");
            }
            this.languagesFilter.push(_val8);
         }
         var _recruitmentTypeFilterLen:uint = input.readUnsignedShort();
         for(var _i9:uint = 0; _i9 < _recruitmentTypeFilterLen; _i9++)
         {
            _val9 = input.readByte();
            if(_val9 < 0)
            {
               throw new Error("Forbidden value (" + _val9 + ") on elements of recruitmentTypeFilter.");
            }
            this.recruitmentTypeFilter.push(_val9);
         }
         this._minPlayerLevelFilterFunc(input);
         this._maxPlayerLevelFilterFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceSummaryRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceSummaryRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._filterTypeFunc);
         tree.addChild(this._textFilterFunc);
         this._criterionFiltertree = tree.addChild(this._criterionFiltertreeFunc);
         tree.addChild(this._sortTypeFunc);
         this._languagesFiltertree = tree.addChild(this._languagesFiltertreeFunc);
         this._recruitmentTypeFiltertree = tree.addChild(this._recruitmentTypeFiltertreeFunc);
         tree.addChild(this._minPlayerLevelFilterFunc);
         tree.addChild(this._maxPlayerLevelFilterFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.hideFullFilter = BooleanByteWrapper.getFlag(_box0,0);
         this.followingAllianceCriteria = BooleanByteWrapper.getFlag(_box0,1);
         this.sortDescending = BooleanByteWrapper.getFlag(_box0,2);
      }
      
      private function _filterTypeFunc(input:ICustomDataInput) : void
      {
         this.filterType = input.readInt();
      }
      
      private function _textFilterFunc(input:ICustomDataInput) : void
      {
         this.textFilter = input.readUTF();
      }
      
      private function _criterionFiltertreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._criterionFiltertree.addChild(this._criterionFilterFunc);
         }
      }
      
      private function _criterionFilterFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of criterionFilter.");
         }
         this.criterionFilter.push(_val);
      }
      
      private function _sortTypeFunc(input:ICustomDataInput) : void
      {
         this.sortType = input.readByte();
         if(this.sortType < 0)
         {
            throw new Error("Forbidden value (" + this.sortType + ") on element of AllianceSummaryRequestMessage.sortType.");
         }
      }
      
      private function _languagesFiltertreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._languagesFiltertree.addChild(this._languagesFilterFunc);
         }
      }
      
      private function _languagesFilterFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of languagesFilter.");
         }
         this.languagesFilter.push(_val);
      }
      
      private function _recruitmentTypeFiltertreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._recruitmentTypeFiltertree.addChild(this._recruitmentTypeFilterFunc);
         }
      }
      
      private function _recruitmentTypeFilterFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readByte();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of recruitmentTypeFilter.");
         }
         this.recruitmentTypeFilter.push(_val);
      }
      
      private function _minPlayerLevelFilterFunc(input:ICustomDataInput) : void
      {
         this.minPlayerLevelFilter = input.readShort();
         if(this.minPlayerLevelFilter < 0)
         {
            throw new Error("Forbidden value (" + this.minPlayerLevelFilter + ") on element of AllianceSummaryRequestMessage.minPlayerLevelFilter.");
         }
      }
      
      private function _maxPlayerLevelFilterFunc(input:ICustomDataInput) : void
      {
         this.maxPlayerLevelFilter = input.readShort();
         if(this.maxPlayerLevelFilter < 0)
         {
            throw new Error("Forbidden value (" + this.maxPlayerLevelFilter + ") on element of AllianceSummaryRequestMessage.maxPlayerLevelFilter.");
         }
      }
   }
}
