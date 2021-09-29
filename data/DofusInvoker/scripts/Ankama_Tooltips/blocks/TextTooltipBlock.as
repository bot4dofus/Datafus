package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class TextTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _param:Object;
      
      public function TextTooltipBlock(txt:String, param:Object = null, chunkType:String = "chunks")
      {
         var css:* = undefined;
         var cssNameIndex:Number = NaN;
         var cssUri:* = undefined;
         var tmp:Array = null;
         super();
         if(param == null)
         {
            this._param = {"css":"[local.css]tooltip_default.css"};
         }
         else
         {
            this._param = param;
         }
         if(!this._param.classCss)
         {
            this._param.classCss = "left";
         }
         if(!this._param.css)
         {
            this._param.css = "[local.css]tooltip_default.css";
         }
         this._param.content = txt;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         if(this._param.width)
         {
            _block.initChunk([Api.tooltip.createChunkData("content",chunkType + "/text/fixedContent.txt")]);
         }
         else if(this._param.nameless)
         {
            _block.initChunk([Api.tooltip.createChunkData("content",chunkType + "/text/namelessContent.txt")]);
         }
         else
         {
            css = null;
            cssNameIndex = this._param.css.indexOf("]");
            cssUri = null;
            if(cssNameIndex !== -1)
            {
               tmp = this._param.css.split("]");
               if(tmp.length > 1)
               {
                  css = Api.system.getConfigEntry("config.ui.skin") + "css/" + tmp[1];
               }
               if(css)
               {
                  cssUri = Api.ui.createUri(css);
               }
            }
            this._param.width = Api.ui.getTextSize(this._param.content,cssUri,this._param.classCss).width + 50;
            _block.initChunk([Api.tooltip.createChunkData("content",chunkType + "/text/content.txt")]);
         }
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent(this._param);
      }
   }
}
