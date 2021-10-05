package Ankama_Tooltips.makers
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.ResizableTextureTooltipBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   
   public class SlotTextureTooltipMaker implements ITooltipMaker
   {
       
      
      public function SlotTextureTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var tooltip:Tooltip = Api.tooltip.createTooltip("chunks/base/baseWithSlotBackground.txt","chunks/base/container.txt");
         tooltip.addBlock(new ResizableTextureTooltipBlock(data.uri,data.width,data.height).block);
         tooltip.strata = -1;
         return tooltip;
      }
   }
}
