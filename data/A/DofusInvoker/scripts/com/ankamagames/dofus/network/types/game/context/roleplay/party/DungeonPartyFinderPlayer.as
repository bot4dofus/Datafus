package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.enums.PlayableBreedEnum;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class DungeonPartyFinderPlayer implements INetworkType
   {
      
      public static const protocolId:uint = 1323;
       
      
      public var playerId:Number = 0;
      
      public var playerName:String = "";
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var level:uint = 0;
      
      public function DungeonPartyFinderPlayer()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1323;
      }
      
      public function initDungeonPartyFinderPlayer(playerId:Number = 0, playerName:String = "", breed:int = 0, sex:Boolean = false, level:uint = 0) : DungeonPartyFinderPlayer
      {
         this.playerId = playerId;
         this.playerName = playerName;
         this.breed = breed;
         this.sex = sex;
         this.level = level;
         return this;
      }
      
      public function reset() : void
      {
         this.playerId = 0;
         this.playerName = "";
         this.breed = 0;
         this.sex = false;
         this.level = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_DungeonPartyFinderPlayer(output);
      }
      
      public function serializeAs_DungeonPartyFinderPlayer(output:ICustomDataOutput) : void
      {
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         output.writeUTF(this.playerName);
         output.writeByte(this.breed);
         output.writeBoolean(this.sex);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_DungeonPartyFinderPlayer(input);
      }
      
      public function deserializeAs_DungeonPartyFinderPlayer(input:ICustomDataInput) : void
      {
         this._playerIdFunc(input);
         this._playerNameFunc(input);
         this._breedFunc(input);
         this._sexFunc(input);
         this._levelFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_DungeonPartyFinderPlayer(tree);
      }
      
      public function deserializeAsyncAs_DungeonPartyFinderPlayer(tree:FuncTree) : void
      {
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._playerNameFunc);
         tree.addChild(this._breedFunc);
         tree.addChild(this._sexFunc);
         tree.addChild(this._levelFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of DungeonPartyFinderPlayer.playerId.");
         }
      }
      
      private function _playerNameFunc(input:ICustomDataInput) : void
      {
         this.playerName = input.readUTF();
      }
      
      private function _breedFunc(input:ICustomDataInput) : void
      {
         this.breed = input.readByte();
         if(this.breed < PlayableBreedEnum.Feca || this.breed > PlayableBreedEnum.Forgelance)
         {
            throw new Error("Forbidden value (" + this.breed + ") on element of DungeonPartyFinderPlayer.breed.");
         }
      }
      
      private function _sexFunc(input:ICustomDataInput) : void
      {
         this.sex = input.readBoolean();
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of DungeonPartyFinderPlayer.level.");
         }
      }
   }
}
