package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameFightFighterNamedInformations extends GameFightFighterInformations implements INetworkType
   {
      
      public static const protocolId:uint = 4176;
       
      
      public var name:String = "";
      
      public var status:PlayerStatus;
      
      public var leagueId:int = 0;
      
      public var ladderPosition:int = 0;
      
      public var hiddenInPrefight:Boolean = false;
      
      private var _statustree:FuncTree;
      
      public function GameFightFighterNamedInformations()
      {
         this.status = new PlayerStatus();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4176;
      }
      
      public function initGameFightFighterNamedInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, spawnInfo:GameContextBasicSpawnInformation = null, wave:uint = 0, stats:GameFightCharacteristics = null, previousPositions:Vector.<uint> = null, name:String = "", status:PlayerStatus = null, leagueId:int = 0, ladderPosition:int = 0, hiddenInPrefight:Boolean = false) : GameFightFighterNamedInformations
      {
         super.initGameFightFighterInformations(contextualId,disposition,look,spawnInfo,wave,stats,previousPositions);
         this.name = name;
         this.status = status;
         this.leagueId = leagueId;
         this.ladderPosition = ladderPosition;
         this.hiddenInPrefight = hiddenInPrefight;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.name = "";
         this.status = new PlayerStatus();
         this.ladderPosition = 0;
         this.hiddenInPrefight = false;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightFighterNamedInformations(output);
      }
      
      public function serializeAs_GameFightFighterNamedInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightFighterInformations(output);
         output.writeUTF(this.name);
         this.status.serializeAs_PlayerStatus(output);
         output.writeVarShort(this.leagueId);
         output.writeInt(this.ladderPosition);
         output.writeBoolean(this.hiddenInPrefight);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightFighterNamedInformations(input);
      }
      
      public function deserializeAs_GameFightFighterNamedInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._nameFunc(input);
         this.status = new PlayerStatus();
         this.status.deserialize(input);
         this._leagueIdFunc(input);
         this._ladderPositionFunc(input);
         this._hiddenInPrefightFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightFighterNamedInformations(tree);
      }
      
      public function deserializeAsyncAs_GameFightFighterNamedInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._nameFunc);
         this._statustree = tree.addChild(this._statustreeFunc);
         tree.addChild(this._leagueIdFunc);
         tree.addChild(this._ladderPositionFunc);
         tree.addChild(this._hiddenInPrefightFunc);
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
      
      private function _statustreeFunc(input:ICustomDataInput) : void
      {
         this.status = new PlayerStatus();
         this.status.deserializeAsync(this._statustree);
      }
      
      private function _leagueIdFunc(input:ICustomDataInput) : void
      {
         this.leagueId = input.readVarShort();
      }
      
      private function _ladderPositionFunc(input:ICustomDataInput) : void
      {
         this.ladderPosition = input.readInt();
      }
      
      private function _hiddenInPrefightFunc(input:ICustomDataInput) : void
      {
         this.hiddenInPrefight = input.readBoolean();
      }
   }
}
