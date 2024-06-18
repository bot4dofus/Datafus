package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.action.fight.FightDispellableEffectExtendedInformations;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMark;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightEffectTriggerCount;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightResumeMessage extends GameFightSpectateMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2675;
       
      
      private var _isInitialized:Boolean = false;
      
      public var spellCooldowns:Vector.<GameFightSpellCooldown>;
      
      public var summonCount:uint = 0;
      
      public var bombCount:uint = 0;
      
      private var _spellCooldownstree:FuncTree;
      
      public function GameFightResumeMessage()
      {
         this.spellCooldowns = new Vector.<GameFightSpellCooldown>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2675;
      }
      
      public function initGameFightResumeMessage(effects:Vector.<FightDispellableEffectExtendedInformations> = null, marks:Vector.<GameActionMark> = null, gameTurn:uint = 0, fightStart:uint = 0, fxTriggerCounts:Vector.<GameFightEffectTriggerCount> = null, spellCooldowns:Vector.<GameFightSpellCooldown> = null, summonCount:uint = 0, bombCount:uint = 0) : GameFightResumeMessage
      {
         super.initGameFightSpectateMessage(effects,marks,gameTurn,fightStart,fxTriggerCounts);
         this.spellCooldowns = spellCooldowns;
         this.summonCount = summonCount;
         this.bombCount = bombCount;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.spellCooldowns = new Vector.<GameFightSpellCooldown>();
         this.summonCount = 0;
         this.bombCount = 0;
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
         this.serializeAs_GameFightResumeMessage(output);
      }
      
      public function serializeAs_GameFightResumeMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightSpectateMessage(output);
         output.writeShort(this.spellCooldowns.length);
         for(var _i1:uint = 0; _i1 < this.spellCooldowns.length; _i1++)
         {
            (this.spellCooldowns[_i1] as GameFightSpellCooldown).serializeAs_GameFightSpellCooldown(output);
         }
         if(this.summonCount < 0)
         {
            throw new Error("Forbidden value (" + this.summonCount + ") on element summonCount.");
         }
         output.writeByte(this.summonCount);
         if(this.bombCount < 0)
         {
            throw new Error("Forbidden value (" + this.bombCount + ") on element bombCount.");
         }
         output.writeByte(this.bombCount);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightResumeMessage(input);
      }
      
      public function deserializeAs_GameFightResumeMessage(input:ICustomDataInput) : void
      {
         var _item1:GameFightSpellCooldown = null;
         super.deserialize(input);
         var _spellCooldownsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _spellCooldownsLen; _i1++)
         {
            _item1 = new GameFightSpellCooldown();
            _item1.deserialize(input);
            this.spellCooldowns.push(_item1);
         }
         this._summonCountFunc(input);
         this._bombCountFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightResumeMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightResumeMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._spellCooldownstree = tree.addChild(this._spellCooldownstreeFunc);
         tree.addChild(this._summonCountFunc);
         tree.addChild(this._bombCountFunc);
      }
      
      private function _spellCooldownstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._spellCooldownstree.addChild(this._spellCooldownsFunc);
         }
      }
      
      private function _spellCooldownsFunc(input:ICustomDataInput) : void
      {
         var _item:GameFightSpellCooldown = new GameFightSpellCooldown();
         _item.deserialize(input);
         this.spellCooldowns.push(_item);
      }
      
      private function _summonCountFunc(input:ICustomDataInput) : void
      {
         this.summonCount = input.readByte();
         if(this.summonCount < 0)
         {
            throw new Error("Forbidden value (" + this.summonCount + ") on element of GameFightResumeMessage.summonCount.");
         }
      }
      
      private function _bombCountFunc(input:ICustomDataInput) : void
      {
         this.bombCount = input.readByte();
         if(this.bombCount < 0)
         {
            throw new Error("Forbidden value (" + this.bombCount + ") on element of GameFightResumeMessage.bombCount.");
         }
      }
   }
}
