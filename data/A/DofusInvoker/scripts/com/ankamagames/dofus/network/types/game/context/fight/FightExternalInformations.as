package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightExternalInformations implements INetworkType
   {
      
      public static const protocolId:uint = 3630;
       
      
      public var fightId:uint = 0;
      
      public var fightType:uint = 0;
      
      public var fightStart:uint = 0;
      
      public var fightSpectatorLocked:Boolean = false;
      
      public var fightTeams:Vector.<FightTeamLightInformations>;
      
      public var fightTeamsOptions:Vector.<FightOptionsInformations>;
      
      private var _fightTeamstree:FuncTree;
      
      private var _fightTeamsindex:uint = 0;
      
      private var _fightTeamsOptionstree:FuncTree;
      
      private var _fightTeamsOptionsindex:uint = 0;
      
      public function FightExternalInformations()
      {
         this.fightTeams = new Vector.<FightTeamLightInformations>(2,true);
         this.fightTeamsOptions = new Vector.<FightOptionsInformations>(2,true);
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3630;
      }
      
      public function initFightExternalInformations(fightId:uint = 0, fightType:uint = 0, fightStart:uint = 0, fightSpectatorLocked:Boolean = false, fightTeams:Vector.<FightTeamLightInformations> = null, fightTeamsOptions:Vector.<FightOptionsInformations> = null) : FightExternalInformations
      {
         this.fightId = fightId;
         this.fightType = fightType;
         this.fightStart = fightStart;
         this.fightSpectatorLocked = fightSpectatorLocked;
         this.fightTeams = fightTeams;
         this.fightTeamsOptions = fightTeamsOptions;
         return this;
      }
      
      public function reset() : void
      {
         this.fightId = 0;
         this.fightType = 0;
         this.fightStart = 0;
         this.fightSpectatorLocked = false;
         this.fightTeams = new Vector.<FightTeamLightInformations>(2,true);
         this.fightTeamsOptions = new Vector.<FightOptionsInformations>(2,true);
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightExternalInformations(output);
      }
      
      public function serializeAs_FightExternalInformations(output:ICustomDataOutput) : void
      {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
         output.writeByte(this.fightType);
         if(this.fightStart < 0)
         {
            throw new Error("Forbidden value (" + this.fightStart + ") on element fightStart.");
         }
         output.writeInt(this.fightStart);
         output.writeBoolean(this.fightSpectatorLocked);
         for(var _i5:uint = 0; _i5 < 2; _i5++)
         {
            this.fightTeams[_i5].serializeAs_FightTeamLightInformations(output);
         }
         for(var _i6:uint = 0; _i6 < 2; _i6++)
         {
            this.fightTeamsOptions[_i6].serializeAs_FightOptionsInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightExternalInformations(input);
      }
      
      public function deserializeAs_FightExternalInformations(input:ICustomDataInput) : void
      {
         this._fightIdFunc(input);
         this._fightTypeFunc(input);
         this._fightStartFunc(input);
         this._fightSpectatorLockedFunc(input);
         for(var _i5:uint = 0; _i5 < 2; _i5++)
         {
            this.fightTeams[_i5] = new FightTeamLightInformations();
            this.fightTeams[_i5].deserialize(input);
         }
         for(var _i6:uint = 0; _i6 < 2; _i6++)
         {
            this.fightTeamsOptions[_i6] = new FightOptionsInformations();
            this.fightTeamsOptions[_i6].deserialize(input);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightExternalInformations(tree);
      }
      
      public function deserializeAsyncAs_FightExternalInformations(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
         tree.addChild(this._fightTypeFunc);
         tree.addChild(this._fightStartFunc);
         tree.addChild(this._fightSpectatorLockedFunc);
         this._fightTeamstree = tree.addChild(this._fightTeamstreeFunc);
         this._fightTeamsOptionstree = tree.addChild(this._fightTeamsOptionstreeFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of FightExternalInformations.fightId.");
         }
      }
      
      private function _fightTypeFunc(input:ICustomDataInput) : void
      {
         this.fightType = input.readByte();
         if(this.fightType < 0)
         {
            throw new Error("Forbidden value (" + this.fightType + ") on element of FightExternalInformations.fightType.");
         }
      }
      
      private function _fightStartFunc(input:ICustomDataInput) : void
      {
         this.fightStart = input.readInt();
         if(this.fightStart < 0)
         {
            throw new Error("Forbidden value (" + this.fightStart + ") on element of FightExternalInformations.fightStart.");
         }
      }
      
      private function _fightSpectatorLockedFunc(input:ICustomDataInput) : void
      {
         this.fightSpectatorLocked = input.readBoolean();
      }
      
      private function _fightTeamstreeFunc(input:ICustomDataInput) : void
      {
         for(var i:uint = 0; i < 2; i++)
         {
            this._fightTeamstree.addChild(this._fightTeamsFunc);
         }
      }
      
      private function _fightTeamsFunc(input:ICustomDataInput) : void
      {
         this.fightTeams[this._fightTeamsindex] = new FightTeamLightInformations();
         this.fightTeams[this._fightTeamsindex].deserializeAsync(this._fightTeamstree.children[this._fightTeamsindex]);
         ++this._fightTeamsindex;
      }
      
      private function _fightTeamsOptionstreeFunc(input:ICustomDataInput) : void
      {
         for(var i:uint = 0; i < 2; i++)
         {
            this._fightTeamsOptionstree.addChild(this._fightTeamsOptionsFunc);
         }
      }
      
      private function _fightTeamsOptionsFunc(input:ICustomDataInput) : void
      {
         this.fightTeamsOptions[this._fightTeamsOptionsindex] = new FightOptionsInformations();
         this.fightTeamsOptions[this._fightTeamsOptionsindex].deserializeAsync(this._fightTeamsOptionstree.children[this._fightTeamsOptionsindex]);
         ++this._fightTeamsOptionsindex;
      }
   }
}
