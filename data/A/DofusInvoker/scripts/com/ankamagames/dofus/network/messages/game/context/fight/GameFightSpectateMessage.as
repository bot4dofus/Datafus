package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.action.fight.FightDispellableEffectExtendedInformations;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMark;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightEffectTriggerCount;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightSpectateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6788;
       
      
      private var _isInitialized:Boolean = false;
      
      public var effects:Vector.<FightDispellableEffectExtendedInformations>;
      
      public var marks:Vector.<GameActionMark>;
      
      public var gameTurn:uint = 0;
      
      public var fightStart:uint = 0;
      
      public var fxTriggerCounts:Vector.<GameFightEffectTriggerCount>;
      
      private var _effectstree:FuncTree;
      
      private var _markstree:FuncTree;
      
      private var _fxTriggerCountstree:FuncTree;
      
      public function GameFightSpectateMessage()
      {
         this.effects = new Vector.<FightDispellableEffectExtendedInformations>();
         this.marks = new Vector.<GameActionMark>();
         this.fxTriggerCounts = new Vector.<GameFightEffectTriggerCount>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6788;
      }
      
      public function initGameFightSpectateMessage(effects:Vector.<FightDispellableEffectExtendedInformations> = null, marks:Vector.<GameActionMark> = null, gameTurn:uint = 0, fightStart:uint = 0, fxTriggerCounts:Vector.<GameFightEffectTriggerCount> = null) : GameFightSpectateMessage
      {
         this.effects = effects;
         this.marks = marks;
         this.gameTurn = gameTurn;
         this.fightStart = fightStart;
         this.fxTriggerCounts = fxTriggerCounts;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.effects = new Vector.<FightDispellableEffectExtendedInformations>();
         this.marks = new Vector.<GameActionMark>();
         this.gameTurn = 0;
         this.fightStart = 0;
         this.fxTriggerCounts = new Vector.<GameFightEffectTriggerCount>();
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
         this.serializeAs_GameFightSpectateMessage(output);
      }
      
      public function serializeAs_GameFightSpectateMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.effects.length);
         for(var _i1:uint = 0; _i1 < this.effects.length; _i1++)
         {
            (this.effects[_i1] as FightDispellableEffectExtendedInformations).serializeAs_FightDispellableEffectExtendedInformations(output);
         }
         output.writeShort(this.marks.length);
         for(var _i2:uint = 0; _i2 < this.marks.length; _i2++)
         {
            (this.marks[_i2] as GameActionMark).serializeAs_GameActionMark(output);
         }
         if(this.gameTurn < 0)
         {
            throw new Error("Forbidden value (" + this.gameTurn + ") on element gameTurn.");
         }
         output.writeVarShort(this.gameTurn);
         if(this.fightStart < 0)
         {
            throw new Error("Forbidden value (" + this.fightStart + ") on element fightStart.");
         }
         output.writeInt(this.fightStart);
         output.writeShort(this.fxTriggerCounts.length);
         for(var _i5:uint = 0; _i5 < this.fxTriggerCounts.length; _i5++)
         {
            (this.fxTriggerCounts[_i5] as GameFightEffectTriggerCount).serializeAs_GameFightEffectTriggerCount(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightSpectateMessage(input);
      }
      
      public function deserializeAs_GameFightSpectateMessage(input:ICustomDataInput) : void
      {
         var _item1:FightDispellableEffectExtendedInformations = null;
         var _item2:GameActionMark = null;
         var _item5:GameFightEffectTriggerCount = null;
         var _effectsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _effectsLen; _i1++)
         {
            _item1 = new FightDispellableEffectExtendedInformations();
            _item1.deserialize(input);
            this.effects.push(_item1);
         }
         var _marksLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _marksLen; _i2++)
         {
            _item2 = new GameActionMark();
            _item2.deserialize(input);
            this.marks.push(_item2);
         }
         this._gameTurnFunc(input);
         this._fightStartFunc(input);
         var _fxTriggerCountsLen:uint = input.readUnsignedShort();
         for(var _i5:uint = 0; _i5 < _fxTriggerCountsLen; _i5++)
         {
            _item5 = new GameFightEffectTriggerCount();
            _item5.deserialize(input);
            this.fxTriggerCounts.push(_item5);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightSpectateMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightSpectateMessage(tree:FuncTree) : void
      {
         this._effectstree = tree.addChild(this._effectstreeFunc);
         this._markstree = tree.addChild(this._markstreeFunc);
         tree.addChild(this._gameTurnFunc);
         tree.addChild(this._fightStartFunc);
         this._fxTriggerCountstree = tree.addChild(this._fxTriggerCountstreeFunc);
      }
      
      private function _effectstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._effectstree.addChild(this._effectsFunc);
         }
      }
      
      private function _effectsFunc(input:ICustomDataInput) : void
      {
         var _item:FightDispellableEffectExtendedInformations = new FightDispellableEffectExtendedInformations();
         _item.deserialize(input);
         this.effects.push(_item);
      }
      
      private function _markstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._markstree.addChild(this._marksFunc);
         }
      }
      
      private function _marksFunc(input:ICustomDataInput) : void
      {
         var _item:GameActionMark = new GameActionMark();
         _item.deserialize(input);
         this.marks.push(_item);
      }
      
      private function _gameTurnFunc(input:ICustomDataInput) : void
      {
         this.gameTurn = input.readVarUhShort();
         if(this.gameTurn < 0)
         {
            throw new Error("Forbidden value (" + this.gameTurn + ") on element of GameFightSpectateMessage.gameTurn.");
         }
      }
      
      private function _fightStartFunc(input:ICustomDataInput) : void
      {
         this.fightStart = input.readInt();
         if(this.fightStart < 0)
         {
            throw new Error("Forbidden value (" + this.fightStart + ") on element of GameFightSpectateMessage.fightStart.");
         }
      }
      
      private function _fxTriggerCountstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._fxTriggerCountstree.addChild(this._fxTriggerCountsFunc);
         }
      }
      
      private function _fxTriggerCountsFunc(input:ICustomDataInput) : void
      {
         var _item:GameFightEffectTriggerCount = new GameFightEffectTriggerCount();
         _item.deserialize(input);
         this.fxTriggerCounts.push(_item);
      }
   }
}
