package Ankama_Tooltips.blocks.mount
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.AbstractTooltipBlock;
   
   public class MountSeparatorTooltipBlock extends AbstractTooltipBlock
   {
       
      
      public function MountSeparatorTooltipBlock()
      {
         super();
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("separator","chunks/mount/separator.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("separator").processContent({});
      }
   }
}
