package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.enums.PlayableBreedEnum;
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FriendOnlineInformations extends FriendInformations implements INetworkType
   {
      
      public static const protocolId:uint = 476;
       
      
      public var playerId:Number = 0;
      
      public var playerName:String = "";
      
      public var level:uint = 0;
      
      public var alignmentSide:int = 0;
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var guildInfo:GuildInformations;
      
      public var moodSmileyId:uint = 0;
      
      public var status:PlayerStatus;
      
      public var havenBagShared:Boolean = false;
      
      private var _guildInfotree:FuncTree;
      
      private var _statustree:FuncTree;
      
      public function FriendOnlineInformations()
      {
         this.guildInfo = new GuildInformations();
         this.status = new PlayerStatus();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 476;
      }
      
      public function initFriendOnlineInformations(accountId:uint = 0, accountTag:AccountTagInformation = null, playerState:uint = 99, lastConnection:uint = 0, achievementPoints:int = 0, leagueId:int = 0, ladderPosition:int = 0, playerId:Number = 0, playerName:String = "", level:uint = 0, alignmentSide:int = 0, breed:int = 0, sex:Boolean = false, guildInfo:GuildInformations = null, moodSmileyId:uint = 0, status:PlayerStatus = null, havenBagShared:Boolean = false) : FriendOnlineInformations
      {
         super.initFriendInformations(accountId,accountTag,playerState,lastConnection,achievementPoints,leagueId,ladderPosition);
         this.playerId = playerId;
         this.playerName = playerName;
         this.level = level;
         this.alignmentSide = alignmentSide;
         this.breed = breed;
         this.sex = sex;
         this.guildInfo = guildInfo;
         this.moodSmileyId = moodSmileyId;
         this.status = status;
         this.havenBagShared = havenBagShared;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.playerId = 0;
         this.playerName = "";
         this.level = 0;
         this.alignmentSide = 0;
         this.breed = 0;
         this.sex = false;
         this.guildInfo = new GuildInformations();
         this.status = new PlayerStatus();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FriendOnlineInformations(output);
      }
      
      public function serializeAs_FriendOnlineInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_FriendInformations(output);
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.sex);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.havenBagShared);
         output.writeByte(_box0);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         output.writeUTF(this.playerName);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
         output.writeByte(this.alignmentSide);
         output.writeByte(this.breed);
         this.guildInfo.serializeAs_GuildInformations(output);
         if(this.moodSmileyId < 0)
         {
            throw new Error("Forbidden value (" + this.moodSmileyId + ") on element moodSmileyId.");
         }
         output.writeVarShort(this.moodSmileyId);
         output.writeShort(this.status.getTypeId());
         this.status.serialize(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FriendOnlineInformations(input);
      }
      
      public function deserializeAs_FriendOnlineInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.deserializeByteBoxes(input);
         this._playerIdFunc(input);
         this._playerNameFunc(input);
         this._levelFunc(input);
         this._alignmentSideFunc(input);
         this._breedFunc(input);
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserialize(input);
         this._moodSmileyIdFunc(input);
         var _id9:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id9);
         this.status.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FriendOnlineInformations(tree);
      }
      
      public function deserializeAsyncAs_FriendOnlineInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._playerNameFunc);
         tree.addChild(this._levelFunc);
         tree.addChild(this._alignmentSideFunc);
         tree.addChild(this._breedFunc);
         this._guildInfotree = tree.addChild(this._guildInfotreeFunc);
         tree.addChild(this._moodSmileyIdFunc);
         this._statustree = tree.addChild(this._statustreeFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.sex = BooleanByteWrapper.getFlag(_box0,0);
         this.havenBagShared = BooleanByteWrapper.getFlag(_box0,1);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of FriendOnlineInformations.playerId.");
         }
      }
      
      private function _playerNameFunc(input:ICustomDataInput) : void
      {
         this.playerName = input.readUTF();
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of FriendOnlineInformations.level.");
         }
      }
      
      private function _alignmentSideFunc(input:ICustomDataInput) : void
      {
         this.alignmentSide = input.readByte();
      }
      
      private function _breedFunc(input:ICustomDataInput) : void
      {
         this.breed = input.readByte();
         if(this.breed < PlayableBreedEnum.Feca || this.breed > PlayableBreedEnum.Forgelance)
         {
            throw new Error("Forbidden value (" + this.breed + ") on element of FriendOnlineInformations.breed.");
         }
      }
      
      private function _guildInfotreeFunc(input:ICustomDataInput) : void
      {
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserializeAsync(this._guildInfotree);
      }
      
      private function _moodSmileyIdFunc(input:ICustomDataInput) : void
      {
         this.moodSmileyId = input.readVarUhShort();
         if(this.moodSmileyId < 0)
         {
            throw new Error("Forbidden value (" + this.moodSmileyId + ") on element of FriendOnlineInformations.moodSmileyId.");
         }
      }
      
      private function _statustreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id);
         this.status.deserializeAsync(this._statustree);
      }
   }
}
