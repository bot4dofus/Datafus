package Ankama_Tooltips.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   
   public class InterfaceTutoTooltipUi
   {
       
      
      private const MAX_WIDTH:int = 300;
      
      private const MARGIN_RIGHT:int = 5;
      
      private const MARGIN_BOTTOM:int = 15;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      private var _param:Object;
      
      private var _data:Object;
      
      private var _tooltipMaxWidth:int;
      
      public var mainCtr:GraphicContainer;
      
      public var infosCtr:GraphicContainer;
      
      public var backgroundCtr:GraphicContainer;
      
      public var ctr_button:GraphicContainer;
      
      public var lbl_info:Label;
      
      public var tx_illu:Texture;
      
      public var btn_skip:ButtonContainer;
      
      public var btn_next:ButtonContainer;
      
      public var btn_lbl_btn_next:Label;
      
      public var btn_ok:ButtonContainer;
      
      public function InterfaceTutoTooltipUi()
      {
         super();
      }
      
      public function main(param:Object = null) : void
      {
         this.mainCtr.visible = false;
         this._param = param;
         this._data = param.data;
         this.sysApi.addHook(HookList.FontActiveTypeChanged,this.onFontActiveTypeChanged);
         if(this._data.hasOwnProperty("hint_tooltip_width"))
         {
            this._tooltipMaxWidth = this._data.hint_tooltip_width;
         }
         else
         {
            this._tooltipMaxWidth = this.MAX_WIDTH;
         }
         this.onFontActiveTypeChanged();
         if(!this.tx_illu)
         {
            this.tooltipApi.place(this._param.position,this._param.showDirectionalArrow,this._param.point,this._param.relativePoint,this._param.offset);
         }
      }
      
      private function onFontActiveTypeChanged() : void
      {
         this.backgroundCtr.height = 0;
         if(this.tx_illu)
         {
            this.setTextureBlock(this._param);
         }
         else
         {
            this.setTextBlock(this._param);
            if(this.ctr_button)
            {
               this.setButtonBlock(this._param);
            }
            this.mainCtr.visible = true;
         }
      }
      
      private function setTextBlock(param:Object) : void
      {
         this.lbl_info.html = false;
         this.lbl_info.useCustomFormat = true;
         this.lbl_info.text = param.data.hint_tooltip_text;
         var textSize:Number = this.uiApi.getTextSize(this.lbl_info.text,this.lbl_info.css,this.lbl_info.cssClass).width;
         if(textSize < this._tooltipMaxWidth)
         {
            if(this.ctr_button)
            {
               this.lbl_info.fullWidthAndHeight(Math.max(textSize + this.lbl_info.anchorX * 2,this.ctr_button.width));
            }
            else
            {
               this.lbl_info.fullWidthAndHeight(textSize + this.lbl_info.anchorX * 2);
            }
            if(this.tx_illu)
            {
               if(this.lbl_info.width < this.tx_illu.width)
               {
                  this.lbl_info.fullWidthAndHeight(this.tx_illu.width);
               }
            }
         }
         else if(this.ctr_button)
         {
            this.lbl_info.fullWidthAndHeight(Math.max(this._tooltipMaxWidth + this.lbl_info.anchorX * 2,this.ctr_button.width));
         }
         else
         {
            this.lbl_info.fullWidthAndHeight(this._tooltipMaxWidth + this.lbl_info.anchorX * 2);
         }
         this.backgroundCtr.width = this.lbl_info.width + this.lbl_info.anchorX * 2;
         this.backgroundCtr.height += this.lbl_info.height + this.lbl_info.anchorY * 2;
      }
      
      private function setTextureBlock(param:Object) : void
      {
         var path:String = param.data.hint_tooltip_url;
         this.tx_illu.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_illu,ComponentHookList.ON_TEXTURE_READY);
         this.tx_illu.uri = this.uiApi.createUri(this.uiApi.me().getConstant("helpTooltips") + path);
      }
      
      private function resizeTexture() : void
      {
         var ratio:Number = this.tx_illu.width / this.tx_illu.height;
         this.tx_illu.width = this._tooltipMaxWidth;
         this.tx_illu.height = this.tx_illu.width / ratio;
      }
      
      private function setButtonBlock(param:Object) : void
      {
         var bgButtonMargin:int = 0;
         if(this.tx_illu)
         {
            this.ctr_button.x = this.lbl_info.width - this.ctr_button.width - this.MARGIN_RIGHT;
            this.ctr_button.y = this.backgroundCtr.height;
            bgButtonMargin = 15;
         }
         else
         {
            this.ctr_button.x = this.lbl_info.width - this.ctr_button.width - this.MARGIN_RIGHT;
            this.ctr_button.y = this.backgroundCtr.height - this.MARGIN_BOTTOM;
         }
         if(this._data.hint_tooltip_guided != null)
         {
            if(this.hintsApi.getNumberOfSubHints() == 1)
            {
               this.btn_skip.visible = false;
               this.btn_lbl_btn_next.text = this.uiApi.getText("ui.uiTutorial.understood");
            }
            else if(this._data.hint_order >= this.hintsApi.getNumberOfSubHints())
            {
               this.btn_skip.visible = false;
               this.btn_lbl_btn_next.text = this.uiApi.getText("ui.common.finish");
            }
            else
            {
               this.btn_lbl_btn_next.text = this.uiApi.getText("ui.common.next");
            }
         }
         this.backgroundCtr.height += this.ctr_button.height + bgButtonMargin;
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.tx_illu:
               if(this.tx_illu.width > this._tooltipMaxWidth)
               {
                  this.resizeTexture();
               }
               this.backgroundCtr.height = 0;
               this.backgroundCtr.height += this.tx_illu.height + this.tx_illu.anchorY * 2;
               this.setTextBlock(this._param);
               this.tx_illu.x = this.backgroundCtr.width / 2 - this.tx_illu.width / 2;
               this.tx_illu.y = this.lbl_info.height + this.lbl_info.anchorY * 2;
               if(this.ctr_button)
               {
                  this.setButtonBlock(this._param);
               }
               this.tooltipApi.place(this._param.position,this._param.showDirectionalArrow,this._param.point,this._param.relativePoint,this._param.offset);
               this.mainCtr.visible = true;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_next:
               this.hintsApi.showNextSubHint(this._data.hint_order);
               break;
            case this.btn_ok:
               this.hintsApi.closeEndTooltip();
               break;
            case this.btn_skip:
               this.hintsApi.skipTuto();
         }
      }
   }
}
