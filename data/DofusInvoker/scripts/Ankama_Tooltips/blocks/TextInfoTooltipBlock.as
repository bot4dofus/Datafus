package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class TextInfoTooltipBlock extends AbstractTooltipBlock
   {
       
      
      public function TextInfoTooltipBlock()
      {
         super();
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/text/textInfo.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").content;
      }
   }
}
