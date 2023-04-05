package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.guild.GuildRight;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class GuildRightsItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function GuildRightsItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean
      {
         var socialFrame:SocialFrame = Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
         if(!socialFrame.hasGuild)
         {
            if(_operator.text == ItemCriterionOperator.DIFFERENT)
            {
               return true;
            }
            return false;
         }
         var hasThisRight:* = socialFrame.playerGuildRank.rights.indexOf(criterionValue) != -1;
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
         var readableCriterionValue:String = GuildRight.getGuildRightById(criterionValue as uint).name;
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               readableCriterion = I18n.getUiText("ui.criterion.guildRights",[readableCriterionValue]);
               break;
            case ItemCriterionOperator.DIFFERENT:
               readableCriterion = I18n.getUiText("ui.criterion.notGuildRights",[readableCriterionValue]);
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion
      {
         return new GuildRightsItemCriterion(this.basicText);
      }
   }
}
