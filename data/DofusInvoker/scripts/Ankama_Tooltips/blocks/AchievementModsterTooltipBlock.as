package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class AchievementModsterTooltipBlock extends AbstractTooltipBlock
   {
       
      
      public function AchievementModsterTooltipBlock()
      {
         super();
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/achievement/achievementModster.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").content;
      }
   }
}
