package Ankama_Tooltips.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.jerakine.types.Uri;
   import flash.geom.Rectangle;
   
   public class TextWithTextureTooltipUi
   {
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      public var mainCtr:GraphicContainer;
      
      public var backgroundCtr:GraphicContainer;
      
      public var lbl_text:Label;
      
      public var tx_icon:Texture;
      
      private var _param:Object;
      
      private var _data:Object;
      
      public function TextWithTextureTooltipUi()
      {
         super();
      }
      
      public function main(param:Object = null) : void
      {
         this.mainCtr.visible = false;
         this._param = param;
         this._data = param.data;
         this.setTexture(this._data.uri);
         if(this._data.textureSize)
         {
            this.setTextureSize(this._data.textureSize);
         }
      }
      
      private function setText(text:String) : void
      {
         this.lbl_text.text = text;
         var textSize:Number = this.uiApi.getTextSize(this.lbl_text.text,this.lbl_text.css,this.lbl_text.cssClass).width;
         this.lbl_text.fullWidthAndHeight(textSize + this.lbl_text.anchorX * 2);
         this.backgroundCtr.width += this.lbl_text.width + this.lbl_text.anchorX * 2 - 1;
         this.backgroundCtr.height = Math.max(this.backgroundCtr.height,this.lbl_text.height + this.lbl_text.anchorY * 2 - 1);
         this.lbl_text.y = (this.backgroundCtr.height - (this.lbl_text.textHeight + this.lbl_text.anchorY * 2)) / 2;
      }
      
      private function setTexture(uri:Uri) : void
      {
         this.tx_icon.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_icon,ComponentHookList.ON_TEXTURE_READY);
         this.tx_icon.uri = uri;
      }
      
      private function setTextureSize(size:int) : void
      {
         this.tx_icon.width = size;
         this.tx_icon.height = size;
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         var linesVector:Array = null;
         var lastLine:String = null;
         var lastLineSize:Rectangle = null;
         var textHeight:Number = NaN;
         switch(target)
         {
            case this.tx_icon:
               this.backgroundCtr.width = 0;
               this.backgroundCtr.height = 0;
               this.backgroundCtr.width += this.tx_icon.width + this.tx_icon.anchorX * 2 - 1;
               this.backgroundCtr.height += this.tx_icon.height + this.tx_icon.anchorY * 2 - 1;
               this.setText(this._data.text);
               if(this._data.texturePosition && this._data.texturePosition == "lastLine")
               {
                  linesVector = this.lbl_text.text.split("\r\r");
                  lastLine = linesVector[linesVector.length - 1];
                  lastLineSize = this.uiApi.getTextSize(lastLine,this.lbl_text.css,this.lbl_text.cssClass);
                  textHeight = this.uiApi.getTextSize(this.lbl_text.text,this.lbl_text.css,this.lbl_text.cssClass).height;
                  this.tx_icon.x = this.lbl_text.x + lastLineSize.width + 10;
                  this.tx_icon.y = this.lbl_text.y + textHeight - lastLineSize.height / 2 - this.tx_icon.width / 2;
               }
               else
               {
                  this.tx_icon.x = this.lbl_text.anchorX + this.lbl_text.width;
                  this.tx_icon.y = this.backgroundCtr.height / 2 - this.tx_icon.height / 2 - this.tx_icon.anchorY;
               }
               this.tooltipApi.place(this._param.position,this._param.showDirectionalArrow,this._param.point,this._param.relativePoint,this._param.offset);
               this.mainCtr.visible = true;
         }
      }
   }
}
