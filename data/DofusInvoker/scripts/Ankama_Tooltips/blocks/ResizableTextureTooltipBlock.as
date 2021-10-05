package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class ResizableTextureTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _uri:String;
      
      private var _width:Number;
      
      private var _height:Number;
      
      public function ResizableTextureTooltipBlock(uri:String, width:Number, height:Number)
      {
         super();
         this._uri = uri;
         this._width = width;
         this._height = height;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("simpleTextureContent","chunks/texture/simpleTextureContent.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("simpleTextureContent").processContent({
            "uri":this._uri,
            "width":this._width,
            "height":this._height
         });
      }
   }
}
