package Ankama_Tooltips.makers
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.TextInfoWithHorizontalSeparatorTooltipBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   
   public class TextInfoWithHorizontalSeparatorTooltipMaker implements ITooltipMaker
   {
       
      
      public function TextInfoWithHorizontalSeparatorTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var tooltip:Tooltip = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt","chunks/base/container.txt","chunks/base/empty.txt");
         tooltip.addBlock(new TextInfoWithHorizontalSeparatorTooltipBlock(data).block);
         return tooltip;
      }
   }
}
