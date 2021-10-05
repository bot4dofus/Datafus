package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class InteractiveElementBlock extends AbstractTooltipBlock
   {
       
      
      private var _infos:Object;
      
      public function InteractiveElementBlock(pInfos:Object)
      {
         super();
         this._infos = pInfos;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/world/worldRpInteractiveElement.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent(this._infos);
      }
   }
}
