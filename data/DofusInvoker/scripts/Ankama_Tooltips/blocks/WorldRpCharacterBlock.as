package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class WorldRpCharacterBlock extends AbstractTooltipBlock
   {
       
      
      public function WorldRpCharacterBlock()
      {
         super();
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/world/worldRpCharacter.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent({});
      }
   }
}
