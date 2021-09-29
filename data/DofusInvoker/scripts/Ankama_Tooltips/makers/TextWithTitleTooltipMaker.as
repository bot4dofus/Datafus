package Ankama_Tooltips.makers
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.TextTooltipBlock;
   import Ankama_Tooltips.blocks.TitleTooltipBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   
   public class TextWithTitleTooltipMaker implements ITooltipMaker
   {
      
      private static const chunkType:String = "htmlChunks";
       
      
      public function TextWithTitleTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var tooltip:Tooltip = Api.tooltip.createTooltip(chunkType + "/base/baseWithBackground.txt",chunkType + "/base/container.txt");
         tooltip.chunkType = chunkType;
         tooltip.addBlock(new TitleTooltipBlock(data.title).block);
         tooltip.addBlock(new TextTooltipBlock(data.text,null,chunkType).block);
         return tooltip;
      }
   }
}
