package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class GuildMasterItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function GuildMasterItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean
      {
         var socialFrame:SocialFrame = Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
         if(!socialFrame.hasGuild)
         {
            return _operator.text == ItemCriterionOperator.DIFFERENT;
         }
         var isBoss:* = socialFrame.playerGuildRank.order == 0;
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               return isBoss;
            case ItemCriterionOperator.DIFFERENT:
               return !isBoss;
            default:
               return false;
         }
      }
      
      override public function get text() : String
      {
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               return I18n.getUiText("ui.criterion.guildMaster");
            case ItemCriterionOperator.DIFFERENT:
               return I18n.getUiText("ui.criterion.notGuildMaster");
            default:
               return "";
         }
      }
      
      override public function clone() : IItemCriterion
      {
         return new GuildMasterItemCriterion(this.basicText);
      }
   }
}
