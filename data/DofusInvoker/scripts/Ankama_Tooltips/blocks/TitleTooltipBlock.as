package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class TitleTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _text:String;
      
      public function TitleTooltipBlock(txt:String)
      {
         super();
         this._text = txt;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","htmlChunks/base/subTitle.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent({"text":this._text});
      }
   }
}
