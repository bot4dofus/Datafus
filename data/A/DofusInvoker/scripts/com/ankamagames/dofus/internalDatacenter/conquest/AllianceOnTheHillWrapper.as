package com.ankamagames.dofus.internalDatacenter.conquest
{
   import com.ankamagames.dofus.internalDatacenter.social.EmblemWrapper;
   import com.ankamagames.dofus.network.enums.AvaScoreTypeEnum;
   import com.ankamagames.dofus.network.types.game.alliance.KohAllianceRoleMembers;
   import com.ankamagames.dofus.network.types.game.alliance.KohScore;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformation;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   
   public class AllianceOnTheHillWrapper implements IDataCenter
   {
       
      
      private var _allianceName:String;
      
      private var _allianceTag:String;
      
      public var allianceId:uint;
      
      public var upEmblem:EmblemWrapper;
      
      public var backEmblem:EmblemWrapper;
      
      public var memberCount:Number = 0;
      
      public var roleDescription:Dictionary;
      
      public var roundScore:Score;
      
      public var cumulScore:Score;
      
      public var totalCumulScore:Number = 0;
      
      public var matchDominationScore:Number = 0;
      
      public var side:Number = 0;
      
      public function AllianceOnTheHillWrapper()
      {
         this.roleDescription = new Dictionary();
         super();
      }
      
      public static function create(pAlliance:AllianceInformation, memberCount:uint, listRole:Object, listScore:Object, matchDominationScores:uint, side:uint) : AllianceOnTheHillWrapper
      {
         var descriptif:KohAllianceRoleMembers = null;
         var score:KohScore = null;
         var item:AllianceOnTheHillWrapper = new AllianceOnTheHillWrapper();
         item.allianceId = pAlliance.allianceId;
         item._allianceTag = pAlliance.allianceTag;
         item._allianceName = pAlliance.allianceName;
         if(pAlliance.allianceEmblem)
         {
            item.upEmblem = EmblemWrapper.create(pAlliance.allianceEmblem.symbolShape,EmblemWrapper.UP,pAlliance.allianceEmblem.symbolColor,true);
            item.backEmblem = EmblemWrapper.create(pAlliance.allianceEmblem.backgroundShape,EmblemWrapper.BACK,pAlliance.allianceEmblem.backgroundColor,true);
         }
         item.memberCount = memberCount;
         item.matchDominationScore = matchDominationScores;
         item.side = side;
         for each(descriptif in listRole)
         {
            item.roleDescription[descriptif.roleAvAId] = descriptif.memberCount;
         }
         item.roundScore = new Score();
         item.cumulScore = new Score();
         for each(score in listScore)
         {
            item.totalCumulScore += score.cumulScores;
            switch(score.avaScoreTypeEnum)
            {
               case AvaScoreTypeEnum.AVA_DOMINATION:
                  item.cumulScore.map = score.cumulScores;
                  item.roundScore.map = score.roundScores;
                  break;
               case AvaScoreTypeEnum.AVA_FIGHT:
                  item.cumulScore.fight = score.cumulScores;
                  item.roundScore.fight = score.roundScores;
                  break;
               case AvaScoreTypeEnum.AVA_PRISM:
                  item.cumulScore.prism = score.cumulScores;
                  item.roundScore.prism = score.roundScores;
                  break;
            }
         }
         return item;
      }
      
      public function get allianceTag() : String
      {
         if(this._allianceTag == "#TAG#")
         {
            return I18n.getUiText("ui.alliance.noTag");
         }
         return this._allianceTag;
      }
      
      public function get allianceName() : String
      {
         if(this._allianceName == "#NONAME#")
         {
            return I18n.getUiText("ui.social.noName");
         }
         return this._allianceName;
      }
      
      public function update(pAlliance:AllianceInformation, memberCount:uint, listRole:Object, listScore:Object, matchDominationScores:uint, side:uint) : void
      {
         var descriptif:KohAllianceRoleMembers = null;
         var score:KohScore = null;
         this.allianceId = pAlliance.allianceId;
         this._allianceTag = pAlliance.allianceTag;
         this._allianceName = pAlliance.allianceName;
         this.upEmblem.update(pAlliance.allianceEmblem.symbolShape,EmblemWrapper.UP,pAlliance.allianceEmblem.symbolColor);
         this.backEmblem.update(pAlliance.allianceEmblem.backgroundShape,EmblemWrapper.BACK,pAlliance.allianceEmblem.backgroundColor);
         this.memberCount = memberCount;
         this.matchDominationScore = matchDominationScores;
         this.side = side;
         for each(descriptif in listRole)
         {
            this.roleDescription[descriptif.roleAvAId] = descriptif.memberCount;
         }
         for each(score in listScore)
         {
            this.totalCumulScore += score.cumulScores;
            switch(score.avaScoreTypeEnum)
            {
               case AvaScoreTypeEnum.AVA_DOMINATION:
                  this.cumulScore.map = score.cumulScores;
                  this.roundScore.map = score.roundScores;
                  break;
               case AvaScoreTypeEnum.AVA_FIGHT:
                  this.cumulScore.fight = score.cumulScores;
                  this.roundScore.fight = score.roundScores;
                  break;
               case AvaScoreTypeEnum.AVA_PRISM:
                  this.cumulScore.prism = score.cumulScores;
                  this.roundScore.prism = score.roundScores;
                  break;
            }
         }
      }
   }
}

class Score
{
    
   
   public var fight:Number;
   
   public var map:Number;
   
   public var prism:Number;
   
   function Score()
   {
      super();
   }
}
