package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   import com.ankamagames.dofus.datacenter.communication.Smiley;
   
   public class SmileyTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _smileyId:uint;
      
      public function SmileyTooltipBlock(smileyId:uint)
      {
         super();
         this._smileyId = smileyId;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/smiley/content.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         var smiley:Smiley = Api.data.getSmiley(this._smileyId);
         var uri:String = "";
         if(smiley)
         {
            uri = "[config.gfx.path]smilies/assets.swf|" + smiley.gfxId;
         }
         _content = _block.getChunk("content").processContent({
            "id":this._smileyId,
            "uri":uri
         });
      }
   }
}
