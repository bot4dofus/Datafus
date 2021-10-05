package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class CartographyTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _data:Object;
      
      public function CartographyTooltipBlock(pData:Object)
      {
         super();
         this._data = pData;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/cartography/cartography.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent(this._data);
      }
   }
}
