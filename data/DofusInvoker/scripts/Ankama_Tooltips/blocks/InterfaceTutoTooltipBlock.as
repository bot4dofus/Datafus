package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class InterfaceTutoTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _data;
      
      private var _blocks:Array;
      
      public function InterfaceTutoTooltipBlock(data:*)
      {
         super();
         this._data = data;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         this._blocks = [];
         this._blocks.push(Api.tooltip.createChunkData("content","chunks/tutorial/interfaceTuto.txt"));
         this._blocks.push(Api.tooltip.createChunkData("labelContent","chunks/tutorial/interfaceTutoLabel.txt"));
         if(this._data.hasOwnProperty("hint_tooltip_url") && this._data.hint_tooltip_url != null && this._data.hint_tooltip_url != "")
         {
            this._blocks.push(Api.tooltip.createChunkData("textureContent","chunks/tutorial/interfaceTutoTexture.txt"));
         }
         if(this._data.hasOwnProperty("hint_tooltip_guided") && this._data.hint_tooltip_guided)
         {
            this._blocks.push(Api.tooltip.createChunkData("buttonContent","chunks/tutorial/interfaceTutoButton.txt"));
         }
         else if(!this._data.hasOwnProperty("hint_tooltip_guided"))
         {
            this._blocks.push(Api.tooltip.createChunkData("buttonContent","chunks/tutorial/interfaceTutoDisplayHelp.txt"));
         }
         _block.initChunk(this._blocks);
      }
      
      public function onAllChunkLoaded() : void
      {
         var dataContent:Object = {};
         dataContent.labelContent = _block.getChunk("labelContent").processContent(null);
         if(this._data.hasOwnProperty("hint_tooltip_url") && this._data.hint_tooltip_url != null && this._data.hint_tooltip_url != "")
         {
            dataContent.textureContent = _block.getChunk("textureContent").processContent(null);
         }
         if(!this._data.hasOwnProperty("hint_tooltip_guided") || this._data.hint_tooltip_guided)
         {
            dataContent.buttonContent = _block.getChunk("buttonContent").processContent(null);
         }
         _content = _block.getChunk("content").processContent(dataContent);
      }
   }
}
