package Ankama_Tooltips.ui
{
   import Ankama_Tooltips.Api;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   
   public class WorldMonsterFighterTooltipUi extends AbstractWorldFighterTooltipUi
   {
       
      
      public function WorldMonsterFighterTooltipUi()
      {
         super();
      }
      
      override public function updateContent(oParam:Object) : void
      {
         var m:Monster = null;
         var firstInit:* = lbl_name.textHeight == 0;
         beforeLevelText = "";
         var monsterId:int = Api.fight.getMonsterId(oParam.data.contextualId);
         if(monsterId > -1)
         {
            m = Api.data.getMonsterFromId(monsterId);
            if(m.isBoss)
            {
               beforeLevelText = Api.ui.getText("ui.item.boss");
            }
            else if(m.isMiniBoss)
            {
               beforeLevelText = Api.ui.getText("ui.item.miniboss");
            }
         }
         if(beforeLevelText != "")
         {
            beforeLevelText += " " + Api.ui.getText("ui.common.short.level");
         }
         else
         {
            beforeLevelText += Api.ui.getText("ui.common.level");
         }
         super.updateContent(oParam);
         if(firstInit)
         {
            backgroundCtr.height -= Y_PADDING;
            mainCtr.height -= Y_PADDING;
         }
      }
   }
}
