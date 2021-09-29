package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class TextWithTextureTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _data;
      
      public function TextWithTextureTooltipBlock(data:*)
      {
         super();
         this._data = data;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/text/textWithTexture.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent(this._data);
      }
   }
}
