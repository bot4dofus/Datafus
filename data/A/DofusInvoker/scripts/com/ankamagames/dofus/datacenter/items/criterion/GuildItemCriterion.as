package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.internalDatacenter.social.GuildWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class GuildItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function GuildItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         if(_criterionValue == 0)
         {
            return I18n.getUiText("ui.criterion.noguild");
         }
         return I18n.getUiText("ui.criterion.hasGuild");
      }
      
      override public function clone() : IItemCriterion
      {
         return new GuildItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         var guild:GuildWrapper = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild;
         if(guild)
         {
            return 1;
         }
         return 0;
      }
   }
}
