package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.network.enums.AllianceRightsBitEnum;
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
         var hasThisRight:Boolean = false;
         if(!AllianceFrame.getInstance().hasAlliance)
         {
            if(_operator.text == ItemCriterionOperator.DIFFERENT)
            {
               return true;
            }
            return false;
         }
         var alliance:AllianceWrapper = AllianceFrame.getInstance().alliance;
         switch(criterionValue)
         {
            case AllianceRightsBitEnum.ALLIANCE_RIGHT_BOSS:
               hasThisRight = alliance.isBoss;
               break;
            default:
               hasThisRight = true;
         }
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               return hasThisRight;
            case ItemCriterionOperator.DIFFERENT:
               return !hasThisRight;
            default:
               return false;
         }
      }
      
      override public function get text() : String
      {
         var readableCriterion:String = null;
         var readableCriterionValue:String = null;
         switch(criterionValue)
         {
            case AllianceRightsBitEnum.ALLIANCE_RIGHT_BOSS:
               readableCriterionValue = I18n.getUiText("ui.guild.right.leader");
               break;
            case AllianceRightsBitEnum.ALLIANCE_RIGHT_KICK_GUILDS:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsBann");
               break;
            case AllianceRightsBitEnum.ALLIANCE_RIGHT_MANAGE_PRISMS:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsSetAlliancePrism");
               break;
            case AllianceRightsBitEnum.ALLIANCE_RIGHT_MANAGE_RIGHTS:
               readableCriterionValue = I18n.getUiText("ui.social.guildManageRights");
               break;
            case AllianceRightsBitEnum.ALLIANCE_RIGHT_RECRUIT_GUILDS:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsInvit");
               break;
            case AllianceRightsBitEnum.ALLIANCE_RIGHT_TALK_IN_CHAN:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsTalkInAllianceChannel");
         }
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
