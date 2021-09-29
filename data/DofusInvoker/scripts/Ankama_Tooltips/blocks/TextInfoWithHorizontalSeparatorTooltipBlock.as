package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class TextInfoWithHorizontalSeparatorTooltipBlock extends AbstractTooltipBlock
   {
       
      
      public function TextInfoWithHorizontalSeparatorTooltipBlock(pData:Object)
      {
         super();
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/textInfoWithSeparator/textInfoWithHorizontalSeparator.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").content;
      }
   }
}
