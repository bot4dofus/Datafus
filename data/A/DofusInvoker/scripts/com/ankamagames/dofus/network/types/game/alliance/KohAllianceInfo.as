package com.ankamagames.dofus.network.types.game.alliance
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class KohAllianceInfo implements INetworkType
   {
      
      public static const protocolId:uint = 7195;
       
      
      public var alliance:AllianceInformation;
      
      public var memberCount:Number = 0;
      
      public var kohAllianceRoleMembers:Vector.<KohAllianceRoleMembers>;
      
      public var scores:Vector.<KohScore>;
      
      public var matchDominationScores:uint = 0;
      
      private var _alliancetree:FuncTree;
      
      private var _kohAllianceRoleMemberstree:FuncTree;
      
      private var _scorestree:FuncTree;
      
      public function KohAllianceInfo()
      {
         this.alliance = new AllianceInformation();
         this.kohAllianceRoleMembers = new Vector.<KohAllianceRoleMembers>();
         this.scores = new Vector.<KohScore>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7195;
      }
      
      public function initKohAllianceInfo(alliance:AllianceInformation = null, memberCount:Number = 0, kohAllianceRoleMembers:Vector.<KohAllianceRoleMembers> = null, scores:Vector.<KohScore> = null, matchDominationScores:uint = 0) : KohAllianceInfo
      {
         this.alliance = alliance;
         this.memberCount = memberCount;
         this.kohAllianceRoleMembers = kohAllianceRoleMembers;
         this.scores = scores;
         this.matchDominationScores = matchDominationScores;
         return this;
      }
      
      public function reset() : void
      {
         this.alliance = new AllianceInformation();
         this.kohAllianceRoleMembers = new Vector.<KohAllianceRoleMembers>();
         this.scores = new Vector.<KohScore>();
         this.matchDominationScores = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_KohAllianceInfo(output);
      }
      
      public function serializeAs_KohAllianceInfo(output:ICustomDataOutput) : void
      {
         this.alliance.serializeAs_AllianceInformation(output);
         if(this.memberCount < 0 || this.memberCount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberCount + ") on element memberCount.");
         }
         output.writeVarLong(this.memberCount);
         output.writeShort(this.kohAllianceRoleMembers.length);
         for(var _i3:uint = 0; _i3 < this.kohAllianceRoleMembers.length; _i3++)
         {
            (this.kohAllianceRoleMembers[_i3] as KohAllianceRoleMembers).serializeAs_KohAllianceRoleMembers(output);
         }
         output.writeShort(this.scores.length);
         for(var _i4:uint = 0; _i4 < this.scores.length; _i4++)
         {
            (this.scores[_i4] as KohScore).serializeAs_KohScore(output);
         }
         if(this.matchDominationScores < 0)
         {
            throw new Error("Forbidden value (" + this.matchDominationScores + ") on element matchDominationScores.");
         }
         output.writeVarInt(this.matchDominationScores);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_KohAllianceInfo(input);
      }
      
      public function deserializeAs_KohAllianceInfo(input:ICustomDataInput) : void
      {
         var _item3:KohAllianceRoleMembers = null;
         var _item4:KohScore = null;
         this.alliance = new AllianceInformation();
         this.alliance.deserialize(input);
         this._memberCountFunc(input);
         var _kohAllianceRoleMembersLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _kohAllianceRoleMembersLen; _i3++)
         {
            _item3 = new KohAllianceRoleMembers();
            _item3.deserialize(input);
            this.kohAllianceRoleMembers.push(_item3);
         }
         var _scoresLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _scoresLen; _i4++)
         {
            _item4 = new KohScore();
            _item4.deserialize(input);
            this.scores.push(_item4);
         }
         this._matchDominationScoresFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_KohAllianceInfo(tree);
      }
      
      public function deserializeAsyncAs_KohAllianceInfo(tree:FuncTree) : void
      {
         this._alliancetree = tree.addChild(this._alliancetreeFunc);
         tree.addChild(this._memberCountFunc);
         this._kohAllianceRoleMemberstree = tree.addChild(this._kohAllianceRoleMemberstreeFunc);
         this._scorestree = tree.addChild(this._scorestreeFunc);
         tree.addChild(this._matchDominationScoresFunc);
      }
      
      private function _alliancetreeFunc(input:ICustomDataInput) : void
      {
         this.alliance = new AllianceInformation();
         this.alliance.deserializeAsync(this._alliancetree);
      }
      
      private function _memberCountFunc(input:ICustomDataInput) : void
      {
         this.memberCount = input.readVarUhLong();
         if(this.memberCount < 0 || this.memberCount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberCount + ") on element of KohAllianceInfo.memberCount.");
         }
      }
      
      private function _kohAllianceRoleMemberstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._kohAllianceRoleMemberstree.addChild(this._kohAllianceRoleMembersFunc);
         }
      }
      
      private function _kohAllianceRoleMembersFunc(input:ICustomDataInput) : void
      {
         var _item:KohAllianceRoleMembers = new KohAllianceRoleMembers();
         _item.deserialize(input);
         this.kohAllianceRoleMembers.push(_item);
      }
      
      private function _scorestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._scorestree.addChild(this._scoresFunc);
         }
      }
      
      private function _scoresFunc(input:ICustomDataInput) : void
      {
         var _item:KohScore = new KohScore();
         _item.deserialize(input);
         this.scores.push(_item);
      }
      
      private function _matchDominationScoresFunc(input:ICustomDataInput) : void
      {
         this.matchDominationScores = input.readVarUhInt();
         if(this.matchDominationScores < 0)
         {
            throw new Error("Forbidden value (" + this.matchDominationScores + ") on element of KohAllianceInfo.matchDominationScores.");
         }
      }
   }
}
