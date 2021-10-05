package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class TextWithShortcutTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _param:Object;
      
      public function TextWithShortcutTooltipBlock(txt:String, param:Object = null)
      {
         super();
         if(param == null)
         {
            this._param = {"css":"[local.css]tooltip_title.css"};
         }
         else
         {
            this._param = param;
         }
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         if(this._param.width)
         {
            _block.initChunk([Api.tooltip.createChunkData("content","chunks/text/fixedContentWithShortcut.txt")]);
         }
         else if(this._param.nameless)
         {
            _block.initChunk([Api.tooltip.createChunkData("content","chunks/text/namelessContentWithShortcut.txt")]);
         }
         else
         {
            _block.initChunk([Api.tooltip.createChunkData("content","chunks/text/contentWithShortcut.txt")]);
         }
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent(this._param);
      }
   }
}
