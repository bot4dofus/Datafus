package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.alliance.AllianceRight;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.network.types.game.rank.RankInformation;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AllianceRightsItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function AllianceRightsItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean
      {
         if(!SocialFrame.getInstance().hasAlliance)
         {
            if(_operator.text == ItemCriterionOperator.DIFFERENT)
            {
               return true;
            }
            return false;
         }
         var playerRank:RankInformation = SocialFrame.getInstance().playerAllianceRank;
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               return playerRank.rights.indexOf(criterionValue) != -1;
            case ItemCriterionOperator.DIFFERENT:
               return playerRank.rights.indexOf(criterionValue) == -1;
            default:
               return false;
         }
      }
      
      override public function get text() : String
      {
         var readableCriterion:String = null;
         var readableCriterionValue:String = AllianceRight.getAllianceRightById(criterionValue as uint).name;
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               readableCriterion = I18n.getUiText("ui.criterion.allianceRights",[readableCriterionValue]);
               break;
            case ItemCriterionOperator.DIFFERENT:
               readableCriterion = I18n.getUiText("ui.criterion.notAllianceRights",[readableCriterionValue]);
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion
      {
         return new AllianceRightsItemCriterion(this.basicText);
      }
   }
}
