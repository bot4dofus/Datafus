package com.ankamagames.dofus.network.messages.game.guild.application
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildSubmitApplicationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3903;
       
      
      private var _isInitialized:Boolean = false;
      
      public var applyText:String = "";
      
      public var guildId:uint = 0;
      
      public var timeSpent:uint = 0;
      
      public var filterLanguage:String = "";
      
      public var filterAmbiance:String = "";
      
      public var filterPlaytime:String = "";
      
      public var filterInterest:String = "";
      
      public var filterMinMaxGuildLevel:String = "";
      
      public var filterRecruitmentType:String = "";
      
      public var filterMinMaxCharacterLevel:String = "";
      
      public var filterMinMaxAchievement:String = "";
      
      public var filterSearchName:String = "";
      
      public var filterLastSort:String = "";
      
      public function GuildSubmitApplicationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3903;
      }
      
      public function initGuildSubmitApplicationMessage(applyText:String = "", guildId:uint = 0, timeSpent:uint = 0, filterLanguage:String = "", filterAmbiance:String = "", filterPlaytime:String = "", filterInterest:String = "", filterMinMaxGuildLevel:String = "", filterRecruitmentType:String = "", filterMinMaxCharacterLevel:String = "", filterMinMaxAchievement:String = "", filterSearchName:String = "", filterLastSort:String = "") : GuildSubmitApplicationMessage
      {
         this.applyText = applyText;
         this.guildId = guildId;
         this.timeSpent = timeSpent;
         this.filterLanguage = filterLanguage;
         this.filterAmbiance = filterAmbiance;
         this.filterPlaytime = filterPlaytime;
         this.filterInterest = filterInterest;
         this.filterMinMaxGuildLevel = filterMinMaxGuildLevel;
         this.filterRecruitmentType = filterRecruitmentType;
         this.filterMinMaxCharacterLevel = filterMinMaxCharacterLevel;
         this.filterMinMaxAchievement = filterMinMaxAchievement;
         this.filterSearchName = filterSearchName;
         this.filterLastSort = filterLastSort;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.applyText = "";
         this.guildId = 0;
         this.timeSpent = 0;
         this.filterLanguage = "";
         this.filterAmbiance = "";
         this.filterPlaytime = "";
         this.filterInterest = "";
         this.filterMinMaxGuildLevel = "";
         this.filterRecruitmentType = "";
         this.filterMinMaxCharacterLevel = "";
         this.filterMinMaxAchievement = "";
         this.filterSearchName = "";
         this.filterLastSort = "";
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
         this.serializeAs_GuildSubmitApplicationMessage(output);
      }
      
      public function serializeAs_GuildSubmitApplicationMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.applyText);
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
         }
         output.writeVarInt(this.guildId);
         if(this.timeSpent < 0)
         {
            throw new Error("Forbidden value (" + this.timeSpent + ") on element timeSpent.");
         }
         output.writeVarInt(this.timeSpent);
         output.writeUTF(this.filterLanguage);
         output.writeUTF(this.filterAmbiance);
         output.writeUTF(this.filterPlaytime);
         output.writeUTF(this.filterInterest);
         output.writeUTF(this.filterMinMaxGuildLevel);
         output.writeUTF(this.filterRecruitmentType);
         output.writeUTF(this.filterMinMaxCharacterLevel);
         output.writeUTF(this.filterMinMaxAchievement);
         output.writeUTF(this.filterSearchName);
         output.writeUTF(this.filterLastSort);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildSubmitApplicationMessage(input);
      }
      
      public function deserializeAs_GuildSubmitApplicationMessage(input:ICustomDataInput) : void
      {
         this._applyTextFunc(input);
         this._guildIdFunc(input);
         this._timeSpentFunc(input);
         this._filterLanguageFunc(input);
         this._filterAmbianceFunc(input);
         this._filterPlaytimeFunc(input);
         this._filterInterestFunc(input);
         this._filterMinMaxGuildLevelFunc(input);
         this._filterRecruitmentTypeFunc(input);
         this._filterMinMaxCharacterLevelFunc(input);
         this._filterMinMaxAchievementFunc(input);
         this._filterSearchNameFunc(input);
         this._filterLastSortFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildSubmitApplicationMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildSubmitApplicationMessage(tree:FuncTree) : void
      {
         tree.addChild(this._applyTextFunc);
         tree.addChild(this._guildIdFunc);
         tree.addChild(this._timeSpentFunc);
         tree.addChild(this._filterLanguageFunc);
         tree.addChild(this._filterAmbianceFunc);
         tree.addChild(this._filterPlaytimeFunc);
         tree.addChild(this._filterInterestFunc);
         tree.addChild(this._filterMinMaxGuildLevelFunc);
         tree.addChild(this._filterRecruitmentTypeFunc);
         tree.addChild(this._filterMinMaxCharacterLevelFunc);
         tree.addChild(this._filterMinMaxAchievementFunc);
         tree.addChild(this._filterSearchNameFunc);
         tree.addChild(this._filterLastSortFunc);
      }
      
      private function _applyTextFunc(input:ICustomDataInput) : void
      {
         this.applyText = input.readUTF();
      }
      
      private function _guildIdFunc(input:ICustomDataInput) : void
      {
         this.guildId = input.readVarUhInt();
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element of GuildSubmitApplicationMessage.guildId.");
         }
      }
      
      private function _timeSpentFunc(input:ICustomDataInput) : void
      {
         this.timeSpent = input.readVarUhInt();
         if(this.timeSpent < 0)
         {
            throw new Error("Forbidden value (" + this.timeSpent + ") on element of GuildSubmitApplicationMessage.timeSpent.");
         }
      }
      
      private function _filterLanguageFunc(input:ICustomDataInput) : void
      {
         this.filterLanguage = input.readUTF();
      }
      
      private function _filterAmbianceFunc(input:ICustomDataInput) : void
      {
         this.filterAmbiance = input.readUTF();
      }
      
      private function _filterPlaytimeFunc(input:ICustomDataInput) : void
      {
         this.filterPlaytime = input.readUTF();
      }
      
      private function _filterInterestFunc(input:ICustomDataInput) : void
      {
         this.filterInterest = input.readUTF();
      }
      
      private function _filterMinMaxGuildLevelFunc(input:ICustomDataInput) : void
      {
         this.filterMinMaxGuildLevel = input.readUTF();
      }
      
      private function _filterRecruitmentTypeFunc(input:ICustomDataInput) : void
      {
         this.filterRecruitmentType = input.readUTF();
      }
      
      private function _filterMinMaxCharacterLevelFunc(input:ICustomDataInput) : void
      {
         this.filterMinMaxCharacterLevel = input.readUTF();
      }
      
      private function _filterMinMaxAchievementFunc(input:ICustomDataInput) : void
      {
         this.filterMinMaxAchievement = input.readUTF();
      }
      
      private function _filterSearchNameFunc(input:ICustomDataInput) : void
      {
         this.filterSearchName = input.readUTF();
      }
      
      private function _filterLastSortFunc(input:ICustomDataInput) : void
      {
         this.filterLastSort = input.readUTF();
      }
   }
}
