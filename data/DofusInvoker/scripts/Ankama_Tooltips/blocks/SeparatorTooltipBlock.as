package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class SeparatorTooltipBlock extends AbstractTooltipBlock
   {
       
      
      public function SeparatorTooltipBlock(chunkType:String = "chunks")
      {
         super();
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("separator",chunkType + "/base/separator.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("separator").processContent({});
      }
   }
}
