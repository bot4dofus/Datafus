package Ankama_Tooltips.blocks.mount
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.AbstractTooltipBlock;
   
   public class MountTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _mount:Object;
      
      public function MountTooltipBlock(mount:Object)
      {
         super();
         this._mount = mount;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk(new Array(Api.tooltip.createChunkData("base","chunks/mount/base.txt")));
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("base").processContent(this._mount);
      }
   }
}
