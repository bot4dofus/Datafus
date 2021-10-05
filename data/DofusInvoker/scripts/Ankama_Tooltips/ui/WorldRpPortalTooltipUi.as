package Ankama_Tooltips.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class WorldRpPortalTooltipUi
   {
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      public var infosCtr:GraphicContainer;
      
      public var lbl_prismName:Label;
      
      public var tx_AllianceEmblemBack:Texture;
      
      public var tx_AllianceEmblemUp:Texture;
      
      public var bgContainer:GraphicContainer;
      
      private var _area:Area;
      
      public function WorldRpPortalTooltipUi()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this._area = this.dataApi.getArea(oParam.data.areaId);
         this.bgContainer.width = 1;
         this.bgContainer.removeFromParent();
         this.lbl_prismName.text = this.uiApi.getText("ui.dimension.portal",this._area.name);
         this.lbl_prismName.fullWidthAndHeight();
         this.tx_AllianceEmblemBack.uri = null;
         this.tx_AllianceEmblemUp.uri = null;
         this.infosCtr.width = this.lbl_prismName.width + 8;
         this.bgContainer.width = this.lbl_prismName.width + 16;
         this.infosCtr.addContent(this.bgContainer,0);
         this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset,oParam.data.checkSuperposition,oParam.data.cellId);
      }
   }
}
