package Ankama_Tooltips.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   
   public class WorldRpSignTooltipUi
   {
      
      private static const MARGIN:uint = 5;
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      public var mainCtr:GraphicContainer;
      
      public var backgroundCtr:GraphicContainer;
      
      public var lbl_text:Label;
      
      public var tx_direction:Texture;
      
      private var _param:Object;
      
      private var _data:Object;
      
      public function WorldRpSignTooltipUi()
      {
         super();
      }
      
      public function main(param:Object = null) : void
      {
         this.mainCtr.visible = false;
         this._param = param;
         this._data = param.data;
         var direction:int = parseInt(this._data.params.split(",")[1]);
         if(direction > 0 && direction < 9)
         {
            this.setTextureBlock(direction);
         }
         else
         {
            this.backgroundCtr.width = 0;
            this.backgroundCtr.height = 0;
            this.setTextBlock(this._param);
            this.tooltipApi.place(param.position,param.showDirectionalArrow,param.point,param.relativePoint,param.offset);
            this.mainCtr.visible = true;
         }
      }
      
      private function setTextBlock(param:Object) : void
      {
         this.lbl_text.text = param.data.signText;
         var textSize:Number = this.uiApi.getTextSize(this.lbl_text.text,this.lbl_text.css,this.lbl_text.cssClass).width;
         this.lbl_text.fullWidthAndHeight(textSize + this.lbl_text.anchorX * 2);
         this.backgroundCtr.width += this.lbl_text.width + this.lbl_text.anchorX * 2 - 1;
         this.backgroundCtr.height = Math.max(this.backgroundCtr.height,this.lbl_text.height + this.lbl_text.anchorY * 2 - 1);
      }
      
      private function setTextureBlock(dir:int) : void
      {
         this.tx_direction.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_direction,ComponentHookList.ON_TEXTURE_READY);
         this.tx_direction.uri = this.uiApi.createUri(this.uiApi.me().getConstant("hud") + "tx_direction_arrow_green_" + dir + ".png");
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.tx_direction:
               this.backgroundCtr.width = 0;
               this.backgroundCtr.height = 0;
               this.backgroundCtr.width += this.tx_direction.width + this.tx_direction.anchorX * 2 - 1;
               this.backgroundCtr.height += this.tx_direction.height + this.tx_direction.anchorY * 2 - 1;
               this.setTextBlock(this._param);
               this.tx_direction.x = this.lbl_text.anchorX * 2 + this.lbl_text.width;
               this.tx_direction.y = this.backgroundCtr.height / 2 - this.tx_direction.height / 2 - this.tx_direction.anchorY;
               this.tooltipApi.place(this._param.position,this._param.showDirectionalArrow,this._param.point,this._param.relativePoint,this._param.offset);
               this.mainCtr.visible = true;
         }
      }
   }
}
