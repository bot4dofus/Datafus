package Ankama_Tooltips.makers.world
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.WorldRpCharacterBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   
   public class WorldRpMerchantCharacterTooltipMaker implements ITooltipMaker
   {
       
      
      public function WorldRpMerchantCharacterTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var tooltip:Tooltip = Api.tooltip.createTooltip("chunks/base/base.txt","chunks/base/container.txt","chunks/base/empty.txt");
         tooltip.addBlock(new WorldRpCharacterBlock().block);
         return tooltip;
      }
   }
}
