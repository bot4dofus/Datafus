package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class WorldRpMonstersAgeBonusBlock extends AbstractTooltipBlock
   {
      
      private static var _infos:Object;
       
      
      public function WorldRpMonstersAgeBonusBlock()
      {
         super();
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/world/rpMonstersAgeBonus.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent(_infos);
      }
   }
}
