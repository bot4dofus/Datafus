package Ankama_Tooltips.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.EventEnums;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class WorldRpPrismTooltipUi
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
      
      private var _alliance:AllianceWrapper;
      
      public function WorldRpPrismTooltipUi()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this._alliance = oParam.data.allianceIdentity;
         this.bgContainer.width = 1;
         this.bgContainer.removeFromParent();
         this.lbl_prismName.text = this._alliance.allianceName;
         this.lbl_prismName.fullWidthAndHeight();
         this.lbl_prismName.y = this.tx_AllianceEmblemBack.height / 2 - this.lbl_prismName.height / 2;
         this.tx_AllianceEmblemBack.x = this.lbl_prismName.width + 8;
         this.tx_AllianceEmblemUp.x = this.tx_AllianceEmblemBack.x + 8;
         this.tx_AllianceEmblemUp.y = this.tx_AllianceEmblemBack.y + 8;
         this.tx_AllianceEmblemBack.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_AllianceEmblemBack,EventEnums.EVENT_ONTEXTUREREADY);
         this.tx_AllianceEmblemBack.uri = this.uiApi.createUri(this._alliance.backEmblem.fullSizeIconUri.toString(),true);
         this.tx_AllianceEmblemUp.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_AllianceEmblemUp,EventEnums.EVENT_ONTEXTUREREADY);
         this.tx_AllianceEmblemUp.uri = this.uiApi.createUri(this._alliance.upEmblem.fullSizeIconUri.toString(),true);
         this.infosCtr.width = this.lbl_prismName.width + 8 + this.tx_AllianceEmblemBack.width;
         this.infosCtr.height = this.tx_AllianceEmblemBack.height;
         this.bgContainer.width = this.lbl_prismName.width + this.tx_AllianceEmblemBack.width + 16;
         this.infosCtr.addContent(this.bgContainer,0);
         this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset,oParam.data.checkSuperposition,oParam.data.cellId);
      }
      
      public function onTextureReady(pTarget:GraphicContainer) : void
      {
         var icon:EmblemSymbol = null;
         switch(pTarget)
         {
            case this.tx_AllianceEmblemBack:
               this.utilApi.changeColor(this.tx_AllianceEmblemBack.getChildByName("back"),this._alliance.backEmblem.color,1);
               this.tx_AllianceEmblemBack.visible = true;
               break;
            case this.tx_AllianceEmblemUp:
               icon = this.dataApi.getEmblemSymbol(this._alliance.upEmblem.idEmblem);
               if(icon.colorizable)
               {
                  this.utilApi.changeColor(this.tx_AllianceEmblemUp,this._alliance.upEmblem.color,0);
               }
               else
               {
                  this.utilApi.changeColor(this.tx_AllianceEmblemUp,this._alliance.upEmblem.color,0,true);
               }
               this.tx_AllianceEmblemUp.visible = true;
         }
      }
   }
}
