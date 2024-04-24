package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.action.fight.FightDispellableEffectExtendedInformations;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMark;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightEffectTriggerCount;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightResumeSlaveInfo;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightResumeWithSlavesMessage extends GameFightResumeMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4166;
       
      
      private var _isInitialized:Boolean = false;
      
      public var slavesInfo:Vector.<GameFightResumeSlaveInfo>;
      
      private var _slavesInfotree:FuncTree;
      
      public function GameFightResumeWithSlavesMessage()
      {
         this.slavesInfo = new Vector.<GameFightResumeSlaveInfo>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4166;
      }
      
      public function initGameFightResumeWithSlavesMessage(effects:Vector.<FightDispellableEffectExtendedInformations> = null, marks:Vector.<GameActionMark> = null, gameTurn:uint = 0, fightStart:uint = 0, fxTriggerCounts:Vector.<GameFightEffectTriggerCount> = null, spellCooldowns:Vector.<GameFightSpellCooldown> = null, summonCount:uint = 0, bombCount:uint = 0, slavesInfo:Vector.<GameFightResumeSlaveInfo> = null) : GameFightResumeWithSlavesMessage
      {
         super.initGameFightResumeMessage(effects,marks,gameTurn,fightStart,fxTriggerCounts,spellCooldowns,summonCount,bombCount);
         this.slavesInfo = slavesInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.slavesInfo = new Vector.<GameFightResumeSlaveInfo>();
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
         this.serializeAs_GameFightResumeWithSlavesMessage(output);
      }
      
      public function serializeAs_GameFightResumeWithSlavesMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightResumeMessage(output);
         output.writeShort(this.slavesInfo.length);
         for(var _i1:uint = 0; _i1 < this.slavesInfo.length; _i1++)
         {
            (this.slavesInfo[_i1] as GameFightResumeSlaveInfo).serializeAs_GameFightResumeSlaveInfo(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightResumeWithSlavesMessage(input);
      }
      
      public function deserializeAs_GameFightResumeWithSlavesMessage(input:ICustomDataInput) : void
      {
         var _item1:GameFightResumeSlaveInfo = null;
         super.deserialize(input);
         var _slavesInfoLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _slavesInfoLen; _i1++)
         {
            _item1 = new GameFightResumeSlaveInfo();
            _item1.deserialize(input);
            this.slavesInfo.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightResumeWithSlavesMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightResumeWithSlavesMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._slavesInfotree = tree.addChild(this._slavesInfotreeFunc);
      }
      
      private function _slavesInfotreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._slavesInfotree.addChild(this._slavesInfoFunc);
         }
      }
      
      private function _slavesInfoFunc(input:ICustomDataInput) : void
      {
         var _item:GameFightResumeSlaveInfo = new GameFightResumeSlaveInfo();
         _item.deserialize(input);
         this.slavesInfo.push(_item);
      }
   }
}
