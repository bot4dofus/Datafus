package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class BreachTitleTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _text:String;
      
      public function BreachTitleTooltipBlock(txt:String)
      {
         super();
         this._text = txt;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","htmlChunks/breach/subTitle.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent({"text":this._text});
      }
   }
}
