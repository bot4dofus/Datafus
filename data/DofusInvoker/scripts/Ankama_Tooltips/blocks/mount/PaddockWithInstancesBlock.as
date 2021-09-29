package Ankama_Tooltips.blocks.mount
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.AbstractTooltipBlock;
   
   public class PaddockWithInstancesBlock extends AbstractTooltipBlock
   {
       
      
      public function PaddockWithInstancesBlock()
      {
         super();
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/mount/paddockWithInstances.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent(null);
      }
   }
}
