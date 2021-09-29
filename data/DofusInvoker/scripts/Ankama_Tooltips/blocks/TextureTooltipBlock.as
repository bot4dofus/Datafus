package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class TextureTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _uri:String;
      
      public function TextureTooltipBlock(uri:String)
      {
         super();
         this._uri = uri;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/texture/content.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent({"uri":this._uri});
      }
   }
}
