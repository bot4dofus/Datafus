package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class HeaderWithIconTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _params:Object;
      
      private var _length:uint;
      
      public function HeaderWithIconTooltipBlock(params:Object)
      {
         super();
         this._params = params;
         this._length = 400;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded2,getContent);
         _block.initChunk([Api.tooltip.createChunkData("headerIcon","chunks/item/headerWithIcon.txt")]);
      }
      
      public function onAllChunkLoaded2() : void
      {
         _content = _block.getChunk("headerIcon").processContent({
            "length":this._length,
            "name":this._params.name,
            "iconUri":this._params.iconUri
         });
      }
   }
}
