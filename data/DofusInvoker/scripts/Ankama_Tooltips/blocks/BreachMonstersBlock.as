package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class BreachMonstersBlock extends AbstractTooltipBlock
   {
      
      private static var _infos:Object;
       
      
      public function BreachMonstersBlock()
      {
         super();
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/breach/breachMonsters.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent(_infos);
      }
   }
}
