package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.messages.game.PaginationRequestAbstractMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildSummaryRequestMessage extends PaginationRequestAbstractMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4368;
       
      
      private var _isInitialized:Boolean = false;
      
      public var nameFilter:String = "";
      
      public var hideFullFilter:Boolean = false;
      
      public var followingGuildCriteria:Boolean = false;
      
      public var criterionFilter:Vector.<uint>;
      
      public var languagesFilter:Vector.<uint>;
      
      public var recruitmentTypeFilter:Vector.<uint>;
      
      public var minLevelFilter:uint = 0;
      
      public var maxLevelFilter:uint = 0;
      
      public var minPlayerLevelFilter:uint = 0;
      
      public var maxPlayerLevelFilter:uint = 0;
      
      public var minSuccessFilter:uint = 0;
      
      public var maxSuccessFilter:uint = 0;
      
      public var sortType:uint = 0;
      
      public var sortDescending:Boolean = false;
      
      private var _criterionFiltertree:FuncTree;
      
      private var _languagesFiltertree:FuncTree;
      
      private var _recruitmentTypeFiltertree:FuncTree;
      
      public function GuildSummaryRequestMessage()
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
         return 4368;
      }
      
      public function initGuildSummaryRequestMessage(offset:Number = 0, count:uint = 0, nameFilter:String = "", hideFullFilter:Boolean = false, followingGuildCriteria:Boolean = false, criterionFilter:Vector.<uint> = null, languagesFilter:Vector.<uint> = null, recruitmentTypeFilter:Vector.<uint> = null, minLevelFilter:uint = 0, maxLevelFilter:uint = 0, minPlayerLevelFilter:uint = 0, maxPlayerLevelFilter:uint = 0, minSuccessFilter:uint = 0, maxSuccessFilter:uint = 0, sortType:uint = 0, sortDescending:Boolean = false) : GuildSummaryRequestMessage
      {
         super.initPaginationRequestAbstractMessage(offset,count);
         this.nameFilter = nameFilter;
         this.hideFullFilter = hideFullFilter;
         this.followingGuildCriteria = followingGuildCriteria;
         this.criterionFilter = criterionFilter;
         this.languagesFilter = languagesFilter;
         this.recruitmentTypeFilter = recruitmentTypeFilter;
         this.minLevelFilter = minLevelFilter;
         this.maxLevelFilter = maxLevelFilter;
         this.minPlayerLevelFilter = minPlayerLevelFilter;
         this.maxPlayerLevelFilter = maxPlayerLevelFilter;
         this.minSuccessFilter = minSuccessFilter;
         this.maxSuccessFilter = maxSuccessFilter;
         this.sortType = sortType;
         this.sortDescending = sortDescending;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.nameFilter = "";
         this.hideFullFilter = false;
         this.followingGuildCriteria = false;
         this.criterionFilter = new Vector.<uint>();
         this.languagesFilter = new Vector.<uint>();
         this.recruitmentTypeFilter = new Vector.<uint>();
         this.minLevelFilter = 0;
         this.maxLevelFilter = 0;
         this.minPlayerLevelFilter = 0;
         this.maxPlayerLevelFilter = 0;
         this.minSuccessFilter = 0;
         this.maxSuccessFilter = 0;
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
         this.serializeAs_GuildSummaryRequestMessage(output);
      }
      
      public function serializeAs_GuildSummaryRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_PaginationRequestAbstractMessage(output);
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.hideFullFilter);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.followingGuildCriteria);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.sortDescending);
         output.writeByte(_box0);
         output.writeUTF(this.nameFilter);
         output.writeShort(this.criterionFilter.length);
         for(var _i4:uint = 0; _i4 < this.criterionFilter.length; _i4++)
         {
            if(this.criterionFilter[_i4] < 0)
            {
               throw new Error("Forbidden value (" + this.criterionFilter[_i4] + ") on element 4 (starting at 1) of criterionFilter.");
            }
            output.writeVarInt(this.criterionFilter[_i4]);
         }
         output.writeShort(this.languagesFilter.length);
         for(var _i5:uint = 0; _i5 < this.languagesFilter.length; _i5++)
         {
            if(this.languagesFilter[_i5] < 0)
            {
               throw new Error("Forbidden value (" + this.languagesFilter[_i5] + ") on element 5 (starting at 1) of languagesFilter.");
            }
            output.writeVarInt(this.languagesFilter[_i5]);
         }
         output.writeShort(this.recruitmentTypeFilter.length);
         for(var _i6:uint = 0; _i6 < this.recruitmentTypeFilter.length; _i6++)
         {
            output.writeByte(this.recruitmentTypeFilter[_i6]);
         }
         if(this.minLevelFilter < 0)
         {
            throw new Error("Forbidden value (" + this.minLevelFilter + ") on element minLevelFilter.");
         }
         output.writeShort(this.minLevelFilter);
         if(this.maxLevelFilter < 0)
         {
            throw new Error("Forbidden value (" + this.maxLevelFilter + ") on element maxLevelFilter.");
         }
         output.writeShort(this.maxLevelFilter);
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
         if(this.minSuccessFilter < 0)
         {
            throw new Error("Forbidden value (" + this.minSuccessFilter + ") on element minSuccessFilter.");
         }
         output.writeVarInt(this.minSuccessFilter);
         if(this.maxSuccessFilter < 0)
         {
            throw new Error("Forbidden value (" + this.maxSuccessFilter + ") on element maxSuccessFilter.");
         }
         output.writeVarInt(this.maxSuccessFilter);
         output.writeByte(this.sortType);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildSummaryRequestMessage(input);
      }
      
      public function deserializeAs_GuildSummaryRequestMessage(input:ICustomDataInput) : void
      {
         var _val4:uint = 0;
         var _val5:uint = 0;
         var _val6:uint = 0;
         super.deserialize(input);
         this.deserializeByteBoxes(input);
         this._nameFilterFunc(input);
         var _criterionFilterLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _criterionFilterLen; _i4++)
         {
            _val4 = input.readVarUhInt();
            if(_val4 < 0)
            {
               throw new Error("Forbidden value (" + _val4 + ") on elements of criterionFilter.");
            }
            this.criterionFilter.push(_val4);
         }
         var _languagesFilterLen:uint = input.readUnsignedShort();
         for(var _i5:uint = 0; _i5 < _languagesFilterLen; _i5++)
         {
            _val5 = input.readVarUhInt();
            if(_val5 < 0)
            {
               throw new Error("Forbidden value (" + _val5 + ") on elements of languagesFilter.");
            }
            this.languagesFilter.push(_val5);
         }
         var _recruitmentTypeFilterLen:uint = input.readUnsignedShort();
         for(var _i6:uint = 0; _i6 < _recruitmentTypeFilterLen; _i6++)
         {
            _val6 = input.readByte();
            if(_val6 < 0)
            {
               throw new Error("Forbidden value (" + _val6 + ") on elements of recruitmentTypeFilter.");
            }
            this.recruitmentTypeFilter.push(_val6);
         }
         this._minLevelFilterFunc(input);
         this._maxLevelFilterFunc(input);
         this._minPlayerLevelFilterFunc(input);
         this._maxPlayerLevelFilterFunc(input);
         this._minSuccessFilterFunc(input);
         this._maxSuccessFilterFunc(input);
         this._sortTypeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildSummaryRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildSummaryRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._nameFilterFunc);
         this._criterionFiltertree = tree.addChild(this._criterionFiltertreeFunc);
         this._languagesFiltertree = tree.addChild(this._languagesFiltertreeFunc);
         this._recruitmentTypeFiltertree = tree.addChild(this._recruitmentTypeFiltertreeFunc);
         tree.addChild(this._minLevelFilterFunc);
         tree.addChild(this._maxLevelFilterFunc);
         tree.addChild(this._minPlayerLevelFilterFunc);
         tree.addChild(this._maxPlayerLevelFilterFunc);
         tree.addChild(this._minSuccessFilterFunc);
         tree.addChild(this._maxSuccessFilterFunc);
         tree.addChild(this._sortTypeFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.hideFullFilter = BooleanByteWrapper.getFlag(_box0,0);
         this.followingGuildCriteria = BooleanByteWrapper.getFlag(_box0,1);
         this.sortDescending = BooleanByteWrapper.getFlag(_box0,2);
      }
      
      private function _nameFilterFunc(input:ICustomDataInput) : void
      {
         this.nameFilter = input.readUTF();
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
      
      private function _minLevelFilterFunc(input:ICustomDataInput) : void
      {
         this.minLevelFilter = input.readShort();
         if(this.minLevelFilter < 0)
         {
            throw new Error("Forbidden value (" + this.minLevelFilter + ") on element of GuildSummaryRequestMessage.minLevelFilter.");
         }
      }
      
      private function _maxLevelFilterFunc(input:ICustomDataInput) : void
      {
         this.maxLevelFilter = input.readShort();
         if(this.maxLevelFilter < 0)
         {
            throw new Error("Forbidden value (" + this.maxLevelFilter + ") on element of GuildSummaryRequestMessage.maxLevelFilter.");
         }
      }
      
      private function _minPlayerLevelFilterFunc(input:ICustomDataInput) : void
      {
         this.minPlayerLevelFilter = input.readShort();
         if(this.minPlayerLevelFilter < 0)
         {
            throw new Error("Forbidden value (" + this.minPlayerLevelFilter + ") on element of GuildSummaryRequestMessage.minPlayerLevelFilter.");
         }
      }
      
      private function _maxPlayerLevelFilterFunc(input:ICustomDataInput) : void
      {
         this.maxPlayerLevelFilter = input.readShort();
         if(this.maxPlayerLevelFilter < 0)
         {
            throw new Error("Forbidden value (" + this.maxPlayerLevelFilter + ") on element of GuildSummaryRequestMessage.maxPlayerLevelFilter.");
         }
      }
      
      private function _minSuccessFilterFunc(input:ICustomDataInput) : void
      {
         this.minSuccessFilter = input.readVarUhInt();
         if(this.minSuccessFilter < 0)
         {
            throw new Error("Forbidden value (" + this.minSuccessFilter + ") on element of GuildSummaryRequestMessage.minSuccessFilter.");
         }
      }
      
      private function _maxSuccessFilterFunc(input:ICustomDataInput) : void
      {
         this.maxSuccessFilter = input.readVarUhInt();
         if(this.maxSuccessFilter < 0)
         {
            throw new Error("Forbidden value (" + this.maxSuccessFilter + ") on element of GuildSummaryRequestMessage.maxSuccessFilter.");
         }
      }
      
      private function _sortTypeFunc(input:ICustomDataInput) : void
      {
         this.sortType = input.readByte();
         if(this.sortType < 0)
         {
            throw new Error("Forbidden value (" + this.sortType + ") on element of GuildSummaryRequestMessage.sortType.");
         }
      }
   }
}
