package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultListEntry;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.NamedPartyTeamWithOutcome;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightEndMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9470;
       
      
      private var _isInitialized:Boolean = false;
      
      public var duration:uint = 0;
      
      public var rewardRate:int = 0;
      
      public var lootShareLimitMalus:int = 0;
      
      public var results:Vector.<FightResultListEntry>;
      
      public var namedPartyTeamsOutcomes:Vector.<NamedPartyTeamWithOutcome>;
      
      private var _resultstree:FuncTree;
      
      private var _namedPartyTeamsOutcomestree:FuncTree;
      
      public function GameFightEndMessage()
      {
         this.results = new Vector.<FightResultListEntry>();
         this.namedPartyTeamsOutcomes = new Vector.<NamedPartyTeamWithOutcome>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9470;
      }
      
      public function initGameFightEndMessage(duration:uint = 0, rewardRate:int = 0, lootShareLimitMalus:int = 0, results:Vector.<FightResultListEntry> = null, namedPartyTeamsOutcomes:Vector.<NamedPartyTeamWithOutcome> = null) : GameFightEndMessage
      {
         this.duration = duration;
         this.rewardRate = rewardRate;
         this.lootShareLimitMalus = lootShareLimitMalus;
         this.results = results;
         this.namedPartyTeamsOutcomes = namedPartyTeamsOutcomes;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.duration = 0;
         this.rewardRate = 0;
         this.lootShareLimitMalus = 0;
         this.results = new Vector.<FightResultListEntry>();
         this.namedPartyTeamsOutcomes = new Vector.<NamedPartyTeamWithOutcome>();
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
         this.serializeAs_GameFightEndMessage(output);
      }
      
      public function serializeAs_GameFightEndMessage(output:ICustomDataOutput) : void
      {
         if(this.duration < 0)
         {
            throw new Error("Forbidden value (" + this.duration + ") on element duration.");
         }
         output.writeInt(this.duration);
         output.writeVarShort(this.rewardRate);
         output.writeShort(this.lootShareLimitMalus);
         output.writeShort(this.results.length);
         for(var _i4:uint = 0; _i4 < this.results.length; _i4++)
         {
            output.writeShort((this.results[_i4] as FightResultListEntry).getTypeId());
            (this.results[_i4] as FightResultListEntry).serialize(output);
         }
         output.writeShort(this.namedPartyTeamsOutcomes.length);
         for(var _i5:uint = 0; _i5 < this.namedPartyTeamsOutcomes.length; _i5++)
         {
            (this.namedPartyTeamsOutcomes[_i5] as NamedPartyTeamWithOutcome).serializeAs_NamedPartyTeamWithOutcome(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightEndMessage(input);
      }
      
      public function deserializeAs_GameFightEndMessage(input:ICustomDataInput) : void
      {
         var _id4:uint = 0;
         var _item4:FightResultListEntry = null;
         var _item5:NamedPartyTeamWithOutcome = null;
         this._durationFunc(input);
         this._rewardRateFunc(input);
         this._lootShareLimitMalusFunc(input);
         var _resultsLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _resultsLen; _i4++)
         {
            _id4 = input.readUnsignedShort();
            _item4 = ProtocolTypeManager.getInstance(FightResultListEntry,_id4);
            _item4.deserialize(input);
            this.results.push(_item4);
         }
         var _namedPartyTeamsOutcomesLen:uint = input.readUnsignedShort();
         for(var _i5:uint = 0; _i5 < _namedPartyTeamsOutcomesLen; _i5++)
         {
            _item5 = new NamedPartyTeamWithOutcome();
            _item5.deserialize(input);
            this.namedPartyTeamsOutcomes.push(_item5);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightEndMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightEndMessage(tree:FuncTree) : void
      {
         tree.addChild(this._durationFunc);
         tree.addChild(this._rewardRateFunc);
         tree.addChild(this._lootShareLimitMalusFunc);
         this._resultstree = tree.addChild(this._resultstreeFunc);
         this._namedPartyTeamsOutcomestree = tree.addChild(this._namedPartyTeamsOutcomestreeFunc);
      }
      
      private function _durationFunc(input:ICustomDataInput) : void
      {
         this.duration = input.readInt();
         if(this.duration < 0)
         {
            throw new Error("Forbidden value (" + this.duration + ") on element of GameFightEndMessage.duration.");
         }
      }
      
      private function _rewardRateFunc(input:ICustomDataInput) : void
      {
         this.rewardRate = input.readVarShort();
      }
      
      private function _lootShareLimitMalusFunc(input:ICustomDataInput) : void
      {
         this.lootShareLimitMalus = input.readShort();
      }
      
      private function _resultstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._resultstree.addChild(this._resultsFunc);
         }
      }
      
      private function _resultsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:FightResultListEntry = ProtocolTypeManager.getInstance(FightResultListEntry,_id);
         _item.deserialize(input);
         this.results.push(_item);
      }
      
      private function _namedPartyTeamsOutcomestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._namedPartyTeamsOutcomestree.addChild(this._namedPartyTeamsOutcomesFunc);
         }
      }
      
      private function _namedPartyTeamsOutcomesFunc(input:ICustomDataInput) : void
      {
         var _item:NamedPartyTeamWithOutcome = new NamedPartyTeamWithOutcome();
         _item.deserialize(input);
         this.namedPartyTeamsOutcomes.push(_item);
      }
   }
}
