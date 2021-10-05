package Ankama_Tooltips.makers
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.TextureTooltipBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   
   public class TexturesListTooltipMaker implements ITooltipMaker
   {
       
      
      public function TexturesListTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var uri:* = undefined;
         var tooltip:Tooltip = Api.tooltip.createTooltip("chunks/base/base.txt","chunks/base/linearContainer.txt");
         for each(uri in data)
         {
            tooltip.addBlock(new TextureTooltipBlock(uri).block);
         }
         tooltip.strata = -1;
         return tooltip;
      }
   }
}
