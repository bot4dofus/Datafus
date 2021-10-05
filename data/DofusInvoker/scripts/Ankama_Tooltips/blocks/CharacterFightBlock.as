package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class CharacterFightBlock extends AbstractTooltipBlock
   {
       
      
      public function CharacterFightBlock()
      {
         super();
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/world/characterFight.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").content;
      }
   }
}
