package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class TchatTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _msg:String;
      
      public function TchatTooltipBlock(msg:String)
      {
         super();
         this._msg = Api.chat.getStaticHyperlink(Api.chat.unEscapeChatString(msg));
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/tchat/tchat.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent({"msg":this._msg});
      }
   }
}
