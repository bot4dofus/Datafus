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
   
   public class BreachRoomTooltipUi
   {
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      public var mainCtr:GraphicContainer;
      
      public var backgroundCtr:GraphicContainer;
      
      public var lbl_title:Label;
      
      public var lbl_text:Label;
      
      public var lbl_reward:Label;
      
      public var tx_icon:Texture;
      
      private var _param:Object;
      
      private var _data:Object;
      
      public function BreachRoomTooltipUi()
      {
         super();
      }
      
      public function main(param:Object = null) : void
      {
         this.mainCtr.visible = false;
         this._param = param;
         this._data = param.data;
         this.setTexture(this._data.uri);
      }
      
      private function setContainer() : void
      {
         var margin:Number = 20;
         this.backgroundCtr.width = Math.max(this.lbl_text.x + this.lbl_text.width,this.lbl_title.x + this.lbl_title.width,this.lbl_reward.x + this.lbl_reward.width,this.tx_icon.x + this.tx_icon.width) - Math.min(this.lbl_text.x,this.lbl_title.x,this.lbl_reward.x,this.tx_icon.x) + margin;
         this.backgroundCtr.height = Math.max(this.lbl_text.y + this.lbl_text.height,this.lbl_title.y + this.lbl_title.height,this.lbl_reward.y + this.lbl_reward.height,this.tx_icon.y + this.tx_icon.height) - Math.min(this.lbl_text.y,this.lbl_title.y,this.lbl_reward.y,this.tx_icon.y) + margin;
      }
      
      private function setTexture(uri:Uri) : void
      {
         this.tx_icon.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_icon,ComponentHookList.ON_TEXTURE_READY);
         this.tx_icon.uri = uri;
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         var linesVector:Array = null;
         var lastLine:String = null;
         var lastLineSize:Rectangle = null;
         switch(target)
         {
            case this.tx_icon:
               this.backgroundCtr.width = 0;
               this.backgroundCtr.height = 0;
               this.backgroundCtr.width += this.tx_icon.width + this.tx_icon.anchorX * 2 - 1;
               this.backgroundCtr.height += this.tx_icon.height + this.tx_icon.anchorY * 2 - 1;
               this.lbl_title.text = this._data.title;
               this.lbl_text.text = this._data.text;
               this.lbl_reward.text = this._data.reward;
               this.lbl_text.y = this.lbl_title.y + this.lbl_title.height + 10;
               this.lbl_reward.y = this.lbl_text.y + this.lbl_text.height;
               if(!this._data.iconOffset)
               {
                  this._data.iconOffset = {
                     "x":0,
                     "y":0
                  };
               }
               if(this._data.texturePosition && this._data.texturePosition == "lastLine")
               {
                  linesVector = this.lbl_reward.text.split("\r\r");
                  lastLine = linesVector[linesVector.length - 1];
                  lastLineSize = this.uiApi.getTextSize(lastLine,this.lbl_reward.css,this.lbl_reward.cssClass);
                  this.tx_icon.x = this.lbl_reward.x + lastLineSize.width + 10 + this._data.iconOffset.x;
                  this.tx_icon.y = this.lbl_reward.y + this.lbl_reward.height - lastLineSize.height / 2 - this.tx_icon.width / 2 + this._data.iconOffset.y;
               }
               else
               {
                  this.tx_icon.x = this.lbl_text.anchorX + this.lbl_text.width + this._data.iconOffset.x;
                  this.tx_icon.y = this.backgroundCtr.height / 2 - this.tx_icon.height / 2 - this.tx_icon.anchorY + this._data.iconOffset.y;
               }
               this.setContainer();
               this.tooltipApi.place(this._param.position,this._param.showDirectionalArrow,this._param.point,this._param.relativePoint,this._param.offset);
               this.mainCtr.visible = true;
         }
      }
   }
}
