package Ankama_Tooltips.makers.world
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.TextTooltipBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   
   public class WorldTaxeCollectorFighterTooltipMaker implements ITooltipMaker
   {
       
      
      public function WorldTaxeCollectorFighterTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var tooltip:Tooltip = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt","chunks/base/container.txt","chunks/base/separator.txt");
         param = {
            "css":"[local.css]tooltip_title.css",
            "classCss":"center"
         };
         if(Api.fight.preFightIsActive())
         {
            tooltip.addBlock(new TextTooltipBlock(Api.fight.getFighterName(data.contextualId) + " (" + Api.fight.getFighterLevel(data.contextualId) + ")",param).block);
         }
         else
         {
            tooltip.addBlock(new TextTooltipBlock(Api.fight.getFighterName(data.contextualId) + " (" + data.stats.lifePoints + ")",param).block);
         }
         return tooltip;
      }
   }
}
