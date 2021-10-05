package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class TextWithTwoColumnsBlock extends AbstractTooltipBlock
   {
       
      
      private var _param:Object;
      
      public function TextWithTwoColumnsBlock(param:Object, chunkType:String = "htmlChunks")
      {
         super();
         this._param = param;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent,chunkType);
         _block.initChunk([Api.tooltip.createChunkData("twoColumns",chunkType + "/text/twoColumns.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("twoColumns").processContent(this._param);
      }
   }
}
