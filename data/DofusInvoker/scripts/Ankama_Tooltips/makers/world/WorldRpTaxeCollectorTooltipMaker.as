package Ankama_Tooltips.makers.world
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.WorldRpCharacterWithGuildBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   
   public class WorldRpTaxeCollectorTooltipMaker implements ITooltipMaker
   {
       
      
      public function WorldRpTaxeCollectorTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var tooltip:Tooltip = Api.tooltip.createTooltip("chunks/base/base.txt","chunks/base/container.txt","chunks/base/separator.txt");
         var infos:Object = {};
         infos.guildName = data.guildIdentity.guildName;
         if(data.allianceIdentity)
         {
            infos.guildName += " - [" + data.allianceIdentity.allianceTag + "]";
         }
         tooltip.addBlock(new WorldRpCharacterWithGuildBlock(infos).block);
         return tooltip;
      }
   }
}
