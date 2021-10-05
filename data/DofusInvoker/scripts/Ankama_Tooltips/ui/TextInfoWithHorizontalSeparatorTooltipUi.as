package Ankama_Tooltips.ui
{
   import Ankama_Tooltips.Api;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   
   public class TextInfoWithHorizontalSeparatorTooltipUi
   {
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      public var lbl_text:Label;
      
      public var lbl_additionalInfo:Label;
      
      public var tx_separator:TextureBitmap;
      
      public var ctr_infos:GraphicContainer;
      
      public var backgroundCtr:GraphicContainer;
      
      public var mainCtr:GraphicContainer;
      
      public function TextInfoWithHorizontalSeparatorTooltipUi()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this.lbl_text.text = oParam.data.content;
         this.lbl_additionalInfo.text = oParam.data.additionalInfo;
         this.lbl_text.fullWidthAndHeight(oParam.data.maxWidth);
         if(oParam.data.addInfoCssClass)
         {
            this.lbl_additionalInfo.cssClass = oParam.data.addInfoCssClass;
         }
         this.backgroundCtr.bgColor = Api.system.getConfigEntry("colors.tooltip.bg");
         this.backgroundCtr.bgAlpha = Api.system.getConfigEntry("colors.tooltip.bg.alpha");
         this.tx_separator.y = this.lbl_text.y + this.lbl_text.textfield.height + 5;
         this.lbl_additionalInfo.y = this.tx_separator.y + this.tx_separator.height + 5;
         this.ctr_infos.x = 10;
         this.ctr_infos.y = 10;
         this.mainCtr.height = this.lbl_text.textfield.height + this.tx_separator.height + this.lbl_additionalInfo.textfield.height + 30;
         this.mainCtr.width = oParam.data.maxWidth + 20;
         this.tx_separator.width = this.mainCtr.width / 2;
         this.tx_separator.x = (this.mainCtr.width - this.tx_separator.width) / 2;
         if(this.tx_separator.width < 150)
         {
            this.tx_separator.width = this.mainCtr.width;
            this.tx_separator.x = 0;
         }
         this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset,oParam.data.checkSuperposition,oParam.data.cellId);
      }
      
      public function unload() : void
      {
      }
   }
}
