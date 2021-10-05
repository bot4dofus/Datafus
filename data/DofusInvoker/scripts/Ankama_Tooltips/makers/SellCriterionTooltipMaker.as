package Ankama_Tooltips.makers
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.ConditionTooltipBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   
   public class SellCriterionTooltipMaker implements ITooltipMaker
   {
      
      private static const chunkType:String = "htmlChunks";
       
      
      public function SellCriterionTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var tooltip:Tooltip = Api.tooltip.createTooltip(chunkType + "/base/baseWithBackground.txt",chunkType + "/base/container.txt",chunkType + "/base/separator.txt");
         tooltip.chunkType = chunkType;
         tooltip.addBlock(new ConditionTooltipBlock({"criteria":[data]},Api.ui.getText("ui.sell.condition"),false,chunkType).block);
         return tooltip;
      }
   }
}
