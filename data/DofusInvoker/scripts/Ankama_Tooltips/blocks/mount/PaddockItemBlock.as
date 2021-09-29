package Ankama_Tooltips.blocks.mount
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.AbstractTooltipBlock;
   
   public class PaddockItemBlock extends AbstractTooltipBlock
   {
       
      
      private var _infos:Object;
      
      public function PaddockItemBlock(infos:Object)
      {
         super();
         this._infos = infos;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/mount/paddockItem.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent(this._infos);
      }
   }
}
