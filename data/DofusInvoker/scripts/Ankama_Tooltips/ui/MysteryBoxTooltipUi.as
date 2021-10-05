package Ankama_Tooltips.ui
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   
   public class MysteryBoxTooltipUi extends TooltipPinableBaseUi
   {
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      public var lbl_header:Label;
      
      public var lbl_description:Label;
      
      public var tx_bgIcon:TextureBitmap;
      
      public function MysteryBoxTooltipUi()
      {
         super();
      }
      
      override public function main(oParam:Object = null) : void
      {
         this.lbl_header.fullSize(280);
         this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset);
         super.main(oParam);
      }
      
      override protected function makePin() : void
      {
         btnClose.x = this.tx_bgIcon.x + this.tx_bgIcon.width + 7;
         btnClose.y = this.tx_bgIcon.y - 2;
         backgroundCtr.width = 450;
         super.makePin();
      }
   }
}
