package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class SignTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _blocks:Array;
      
      private var _data;
      
      public function SignTooltipBlock(data:*)
      {
         super();
         this._data = data;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         this._blocks = [];
         this._blocks.push(Api.tooltip.createChunkData("content","chunks/world/worldRpSign.txt"));
         this._blocks.push(Api.tooltip.createChunkData("labelContent","chunks/world/worldRpSignLabel.txt"));
         var dir:int = parseInt(data.params.split(",")[1]);
         if(dir > 0 && dir < 9)
         {
            this._blocks.push(Api.tooltip.createChunkData("textureContent","chunks/world/worldRpSignTexture.txt"));
         }
         _block.initChunk(this._blocks);
      }
      
      public function onAllChunkLoaded() : void
      {
         var dataContent:Object = {};
         dataContent.labelContent = _block.getChunk("labelContent").processContent(null);
         var dir:int = parseInt(this._data.params.split(",")[1]);
         if(dir > 0 && dir < 9)
         {
            dataContent.textureContent = _block.getChunk("textureContent").processContent(null);
         }
         _content = _block.getChunk("content").processContent(dataContent);
      }
   }
}
