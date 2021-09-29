package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class HouseTooltipBlock extends AbstractTooltipBlock
   {
       
      
      public function HouseTooltipBlock()
      {
         super();
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/world/house/houseWithInstances.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent(null);
      }
   }
}
