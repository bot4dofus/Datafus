package Ankama_Tooltips.makers.world
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.mount.PaddockWithInstancesBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   
   public class WorldRpPaddockTooltipMaker implements ITooltipMaker
   {
       
      
      public function WorldRpPaddockTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var tooltip:Tooltip = Api.tooltip.createTooltip("chunks/base/base.txt","chunks/base/container.txt","chunks/base/empty.txt");
         tooltip.addBlock(new PaddockWithInstancesBlock().block);
         return tooltip;
      }
   }
}
