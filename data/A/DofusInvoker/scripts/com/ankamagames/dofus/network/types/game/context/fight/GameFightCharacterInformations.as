package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.character.alignment.ActorAlignmentInformations;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameFightCharacterInformations extends GameFightFighterNamedInformations implements INetworkType
   {
      
      public static const protocolId:uint = 3578;
       
      
      public var level:uint = 0;
      
      public var alignmentInfos:ActorAlignmentInformations;
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      private var _alignmentInfostree:FuncTree;
      
      public function GameFightCharacterInformations()
      {
         this.alignmentInfos = new ActorAlignmentInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3578;
      }
      
      public function initGameFightCharacterInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, spawnInfo:GameContextBasicSpawnInformation = null, wave:uint = 0, stats:GameFightCharacteristics = null, previousPositions:Vector.<uint> = null, name:String = "", status:PlayerStatus = null, leagueId:int = 0, ladderPosition:int = 0, hiddenInPrefight:Boolean = false, level:uint = 0, alignmentInfos:ActorAlignmentInformations = null, breed:int = 0, sex:Boolean = false) : GameFightCharacterInformations
      {
         super.initGameFightFighterNamedInformations(contextualId,disposition,look,spawnInfo,wave,stats,previousPositions,name,status,leagueId,ladderPosition,hiddenInPrefight);
         this.level = level;
         this.alignmentInfos = alignmentInfos;
         this.breed = breed;
         this.sex = sex;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.level = 0;
         this.alignmentInfos = new ActorAlignmentInformations();
         this.sex = false;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightCharacterInformations(output);
      }
      
      public function serializeAs_GameFightCharacterInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightFighterNamedInformations(output);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
         this.alignmentInfos.serializeAs_ActorAlignmentInformations(output);
         output.writeByte(this.breed);
         output.writeBoolean(this.sex);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightCharacterInformations(input);
      }
      
      public function deserializeAs_GameFightCharacterInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._levelFunc(input);
         this.alignmentInfos = new ActorAlignmentInformations();
         this.alignmentInfos.deserialize(input);
         this._breedFunc(input);
         this._sexFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightCharacterInformations(tree);
      }
      
      public function deserializeAsyncAs_GameFightCharacterInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._levelFunc);
         this._alignmentInfostree = tree.addChild(this._alignmentInfostreeFunc);
         tree.addChild(this._breedFunc);
         tree.addChild(this._sexFunc);
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of GameFightCharacterInformations.level.");
         }
      }
      
      private function _alignmentInfostreeFunc(input:ICustomDataInput) : void
      {
         this.alignmentInfos = new ActorAlignmentInformations();
         this.alignmentInfos.deserializeAsync(this._alignmentInfostree);
      }
      
      private function _breedFunc(input:ICustomDataInput) : void
      {
         this.breed = input.readByte();
      }
      
      private function _sexFunc(input:ICustomDataInput) : void
      {
         this.sex = input.readBoolean();
      }
   }
}
