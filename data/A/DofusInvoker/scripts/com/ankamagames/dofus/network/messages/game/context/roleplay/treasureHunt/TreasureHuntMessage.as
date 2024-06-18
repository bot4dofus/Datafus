package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntFlag;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStep;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TreasureHuntMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7235;
       
      
      private var _isInitialized:Boolean = false;
      
      public var questType:uint = 0;
      
      public var startMapId:Number = 0;
      
      public var knownStepsList:Vector.<TreasureHuntStep>;
      
      public var totalStepCount:uint = 0;
      
      public var checkPointCurrent:uint = 0;
      
      public var checkPointTotal:uint = 0;
      
      public var availableRetryCount:int = 0;
      
      public var flags:Vector.<TreasureHuntFlag>;
      
      private var _knownStepsListtree:FuncTree;
      
      private var _flagstree:FuncTree;
      
      public function TreasureHuntMessage()
      {
         this.knownStepsList = new Vector.<TreasureHuntStep>();
         this.flags = new Vector.<TreasureHuntFlag>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7235;
      }
      
      public function initTreasureHuntMessage(questType:uint = 0, startMapId:Number = 0, knownStepsList:Vector.<TreasureHuntStep> = null, totalStepCount:uint = 0, checkPointCurrent:uint = 0, checkPointTotal:uint = 0, availableRetryCount:int = 0, flags:Vector.<TreasureHuntFlag> = null) : TreasureHuntMessage
      {
         this.questType = questType;
         this.startMapId = startMapId;
         this.knownStepsList = knownStepsList;
         this.totalStepCount = totalStepCount;
         this.checkPointCurrent = checkPointCurrent;
         this.checkPointTotal = checkPointTotal;
         this.availableRetryCount = availableRetryCount;
         this.flags = flags;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.questType = 0;
         this.startMapId = 0;
         this.knownStepsList = new Vector.<TreasureHuntStep>();
         this.totalStepCount = 0;
         this.checkPointCurrent = 0;
         this.checkPointTotal = 0;
         this.availableRetryCount = 0;
         this.flags = new Vector.<TreasureHuntFlag>();
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
         this.serializeAs_TreasureHuntMessage(output);
      }
      
      public function serializeAs_TreasureHuntMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.questType);
         if(this.startMapId < 0 || this.startMapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.startMapId + ") on element startMapId.");
         }
         output.writeDouble(this.startMapId);
         output.writeShort(this.knownStepsList.length);
         for(var _i3:uint = 0; _i3 < this.knownStepsList.length; _i3++)
         {
            output.writeShort((this.knownStepsList[_i3] as TreasureHuntStep).getTypeId());
            (this.knownStepsList[_i3] as TreasureHuntStep).serialize(output);
         }
         if(this.totalStepCount < 0)
         {
            throw new Error("Forbidden value (" + this.totalStepCount + ") on element totalStepCount.");
         }
         output.writeByte(this.totalStepCount);
         if(this.checkPointCurrent < 0)
         {
            throw new Error("Forbidden value (" + this.checkPointCurrent + ") on element checkPointCurrent.");
         }
         output.writeVarInt(this.checkPointCurrent);
         if(this.checkPointTotal < 0)
         {
            throw new Error("Forbidden value (" + this.checkPointTotal + ") on element checkPointTotal.");
         }
         output.writeVarInt(this.checkPointTotal);
         output.writeInt(this.availableRetryCount);
         output.writeShort(this.flags.length);
         for(var _i8:uint = 0; _i8 < this.flags.length; _i8++)
         {
            (this.flags[_i8] as TreasureHuntFlag).serializeAs_TreasureHuntFlag(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TreasureHuntMessage(input);
      }
      
      public function deserializeAs_TreasureHuntMessage(input:ICustomDataInput) : void
      {
         var _id3:uint = 0;
         var _item3:TreasureHuntStep = null;
         var _item8:TreasureHuntFlag = null;
         this._questTypeFunc(input);
         this._startMapIdFunc(input);
         var _knownStepsListLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _knownStepsListLen; _i3++)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(TreasureHuntStep,_id3);
            _item3.deserialize(input);
            this.knownStepsList.push(_item3);
         }
         this._totalStepCountFunc(input);
         this._checkPointCurrentFunc(input);
         this._checkPointTotalFunc(input);
         this._availableRetryCountFunc(input);
         var _flagsLen:uint = input.readUnsignedShort();
         for(var _i8:uint = 0; _i8 < _flagsLen; _i8++)
         {
            _item8 = new TreasureHuntFlag();
            _item8.deserialize(input);
            this.flags.push(_item8);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TreasureHuntMessage(tree);
      }
      
      public function deserializeAsyncAs_TreasureHuntMessage(tree:FuncTree) : void
      {
         tree.addChild(this._questTypeFunc);
         tree.addChild(this._startMapIdFunc);
         this._knownStepsListtree = tree.addChild(this._knownStepsListtreeFunc);
         tree.addChild(this._totalStepCountFunc);
         tree.addChild(this._checkPointCurrentFunc);
         tree.addChild(this._checkPointTotalFunc);
         tree.addChild(this._availableRetryCountFunc);
         this._flagstree = tree.addChild(this._flagstreeFunc);
      }
      
      private function _questTypeFunc(input:ICustomDataInput) : void
      {
         this.questType = input.readByte();
         if(this.questType < 0)
         {
            throw new Error("Forbidden value (" + this.questType + ") on element of TreasureHuntMessage.questType.");
         }
      }
      
      private function _startMapIdFunc(input:ICustomDataInput) : void
      {
         this.startMapId = input.readDouble();
         if(this.startMapId < 0 || this.startMapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.startMapId + ") on element of TreasureHuntMessage.startMapId.");
         }
      }
      
      private function _knownStepsListtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._knownStepsListtree.addChild(this._knownStepsListFunc);
         }
      }
      
      private function _knownStepsListFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:TreasureHuntStep = ProtocolTypeManager.getInstance(TreasureHuntStep,_id);
         _item.deserialize(input);
         this.knownStepsList.push(_item);
      }
      
      private function _totalStepCountFunc(input:ICustomDataInput) : void
      {
         this.totalStepCount = input.readByte();
         if(this.totalStepCount < 0)
         {
            throw new Error("Forbidden value (" + this.totalStepCount + ") on element of TreasureHuntMessage.totalStepCount.");
         }
      }
      
      private function _checkPointCurrentFunc(input:ICustomDataInput) : void
      {
         this.checkPointCurrent = input.readVarUhInt();
         if(this.checkPointCurrent < 0)
         {
            throw new Error("Forbidden value (" + this.checkPointCurrent + ") on element of TreasureHuntMessage.checkPointCurrent.");
         }
      }
      
      private function _checkPointTotalFunc(input:ICustomDataInput) : void
      {
         this.checkPointTotal = input.readVarUhInt();
         if(this.checkPointTotal < 0)
         {
            throw new Error("Forbidden value (" + this.checkPointTotal + ") on element of TreasureHuntMessage.checkPointTotal.");
         }
      }
      
      private function _availableRetryCountFunc(input:ICustomDataInput) : void
      {
         this.availableRetryCount = input.readInt();
      }
      
      private function _flagstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._flagstree.addChild(this._flagsFunc);
         }
      }
      
      private function _flagsFunc(input:ICustomDataInput) : void
      {
         var _item:TreasureHuntFlag = new TreasureHuntFlag();
         _item.deserialize(input);
         this.flags.push(_item);
      }
   }
}
