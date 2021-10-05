package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class MonsterFightBlock extends AbstractTooltipBlock
   {
       
      
      public function MonsterFightBlock()
      {
         super();
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/world/monsterFight.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").content;
      }
   }
}
