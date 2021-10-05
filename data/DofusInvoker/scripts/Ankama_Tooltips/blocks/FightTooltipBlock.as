package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class FightTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _infos:Object;
      
      public function FightTooltipBlock(infos:Object)
      {
         super();
         this._infos = infos;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/world/fighterList.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent(this._infos);
      }
   }
}
