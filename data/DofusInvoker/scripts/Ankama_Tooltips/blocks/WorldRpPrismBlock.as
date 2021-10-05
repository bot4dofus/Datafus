package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class WorldRpPrismBlock extends AbstractTooltipBlock
   {
       
      
      private var _infos:Object;
      
      public function WorldRpPrismBlock(infos:Object)
      {
         super();
         this._infos = infos;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/world/worldRpPrism.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent(this._infos);
      }
   }
}
