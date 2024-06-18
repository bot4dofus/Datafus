package com.ankamagames.dofus.network.types.game.social.application
{
   import com.ankamagames.dofus.network.enums.PlayableBreedEnum;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ApplicationPlayerInformation implements INetworkType
   {
      
      public static const protocolId:uint = 9959;
       
      
      public var playerId:Number = 0;
      
      public var playerName:String = "";
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var level:uint = 0;
      
      public var accountId:uint = 0;
      
      public var accountTag:String = "";
      
      public var accountNickname:String = "";
      
      public var status:PlayerStatus;
      
      private var _statustree:FuncTree;
      
      public function ApplicationPlayerInformation()
      {
         this.status = new PlayerStatus();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9959;
      }
      
      public function initApplicationPlayerInformation(playerId:Number = 0, playerName:String = "", breed:int = 0, sex:Boolean = false, level:uint = 0, accountId:uint = 0, accountTag:String = "", accountNickname:String = "", status:PlayerStatus = null) : ApplicationPlayerInformation
      {
         this.playerId = playerId;
         this.playerName = playerName;
         this.breed = breed;
         this.sex = sex;
         this.level = level;
         this.accountId = accountId;
         this.accountTag = accountTag;
         this.accountNickname = accountNickname;
         this.status = status;
         return this;
      }
      
      public function reset() : void
      {
         this.playerId = 0;
         this.playerName = "";
         this.breed = 0;
         this.sex = false;
         this.level = 0;
         this.accountId = 0;
         this.accountTag = "";
         this.accountNickname = "";
         this.status = new PlayerStatus();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ApplicationPlayerInformation(output);
      }
      
      public function serializeAs_ApplicationPlayerInformation(output:ICustomDataOutput) : void
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
         output.writeVarInt(this.level);
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         output.writeVarInt(this.accountId);
         output.writeUTF(this.accountTag);
         output.writeUTF(this.accountNickname);
         this.status.serializeAs_PlayerStatus(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ApplicationPlayerInformation(input);
      }
      
      public function deserializeAs_ApplicationPlayerInformation(input:ICustomDataInput) : void
      {
         this._playerIdFunc(input);
         this._playerNameFunc(input);
         this._breedFunc(input);
         this._sexFunc(input);
         this._levelFunc(input);
         this._accountIdFunc(input);
         this._accountTagFunc(input);
         this._accountNicknameFunc(input);
         this.status = new PlayerStatus();
         this.status.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ApplicationPlayerInformation(tree);
      }
      
      public function deserializeAsyncAs_ApplicationPlayerInformation(tree:FuncTree) : void
      {
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._playerNameFunc);
         tree.addChild(this._breedFunc);
         tree.addChild(this._sexFunc);
         tree.addChild(this._levelFunc);
         tree.addChild(this._accountIdFunc);
         tree.addChild(this._accountTagFunc);
         tree.addChild(this._accountNicknameFunc);
         this._statustree = tree.addChild(this._statustreeFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of ApplicationPlayerInformation.playerId.");
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
            throw new Error("Forbidden value (" + this.breed + ") on element of ApplicationPlayerInformation.breed.");
         }
      }
      
      private function _sexFunc(input:ICustomDataInput) : void
      {
         this.sex = input.readBoolean();
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhInt();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of ApplicationPlayerInformation.level.");
         }
      }
      
      private function _accountIdFunc(input:ICustomDataInput) : void
      {
         this.accountId = input.readVarUhInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of ApplicationPlayerInformation.accountId.");
         }
      }
      
      private function _accountTagFunc(input:ICustomDataInput) : void
      {
         this.accountTag = input.readUTF();
      }
      
      private function _accountNicknameFunc(input:ICustomDataInput) : void
      {
         this.accountNickname = input.readUTF();
      }
      
      private function _statustreeFunc(input:ICustomDataInput) : void
      {
         this.status = new PlayerStatus();
         this.status.deserializeAsync(this._statustree);
      }
   }
}
