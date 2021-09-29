package Ankama_Tooltips.makers.world
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.FightTooltipBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   
   public class WorldRpFightTooltipMaker implements ITooltipMaker
   {
       
      
      public function WorldRpFightTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var fighter:* = undefined;
         var teamMembers:* = data.fighters;
         var tooltip:Tooltip = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt","chunks/base/container.txt","chunks/base/empty.txt");
         var infos:Object = {};
         var totalLevel:uint = 0;
         for each(fighter in teamMembers)
         {
            if(fighter.id > 0 && fighter.level > ProtocolConstantsEnum.MAX_LEVEL)
            {
               totalLevel += ProtocolConstantsEnum.MAX_LEVEL;
            }
            else
            {
               totalLevel += fighter.level;
            }
         }
         infos.level = Api.ui.getText("ui.common.level") + " " + totalLevel;
         tooltip.addBlock(new FightTooltipBlock(infos).block);
         return tooltip;
      }
   }
}
