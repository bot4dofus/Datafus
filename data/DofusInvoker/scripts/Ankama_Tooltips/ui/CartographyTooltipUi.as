package Ankama_Tooltips.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class CartographyTooltipUi
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      public var ctr_additionalInfo:GraphicContainer;
      
      public var ctr_additionalInfoBg:GraphicContainer;
      
      public var lbl_additionalInfo:Label;
      
      public var ctr_mapElementBg:GraphicContainer;
      
      public var lbl_mapElement:Label;
      
      public var ctr_subAreaInfo:GraphicContainer;
      
      public var ctr_subAreaInfoBg:GraphicContainer;
      
      public var lbl_subAreaInfo:Label;
      
      public var lbl_subAreaLevel:Label;
      
      public var tx_subArea_separator:Texture;
      
      public var ctr_alliance:GraphicContainer;
      
      public var ctr_allianceBg:GraphicContainer;
      
      public var lbl_allianceName:Label;
      
      public var ctr_emblem:GraphicContainer;
      
      public var tx_emblemBack:Texture;
      
      public var tx_emblemUp:Texture;
      
      private var _currentAlliance:AllianceWrapper;
      
      private var _uiParams:Object;
      
      public function CartographyTooltipUi()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this.uiApi.addComponentHook(this.tx_emblemBack,"onTextureReady");
         this.uiApi.addComponentHook(this.tx_emblemUp,"onTextureReady");
         this._uiParams = oParam;
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         var customUnicName:String = this.uiApi.me().customUnicName;
         if(customUnicName && !this.uiApi.isUiLoading(customUnicName))
         {
            this.onUiLoaded(customUnicName);
         }
      }
      
      public function update(pParams:Array) : void
      {
         this.ctr_additionalInfo.visible = false;
         if(pParams[0] == "subAreaInfo")
         {
            this.updateMapInfo(pParams[1],pParams[2],pParams[3],pParams[4],pParams[5],pParams[6]);
         }
         else if(pParams[0] == "search")
         {
            this.updateSearchInfo(pParams[1],pParams[2],pParams[3]);
         }
      }
      
      public function unload() : void
      {
      }
      
      private function updateMapInfo(pMapX:int, pMapY:int, pMapElementText:String, pSubArea:Object, pSubAreaLevel:uint, pAlliance:AllianceWrapper) : void
      {
         var topBlock:GraphicContainer = null;
         var topBlockBg:GraphicContainer = null;
         var emblemMiddle:Number = NaN;
         var hasSubArea:* = pSubArea != null;
         this.ctr_additionalInfoBg.visible = this.lbl_additionalInfo.visible = false;
         if(pMapElementText)
         {
            this.ctr_additionalInfo.visible = this.ctr_mapElementBg.visible = this.lbl_mapElement.visible = true;
            this.initLabel(this.lbl_mapElement,"<b>" + pMapElementText + "</b>");
            this.ctr_mapElementBg.height = this.lbl_mapElement.textHeight + 12;
            this.ctr_subAreaInfo.y = this.ctr_mapElementBg.height + 4;
         }
         else
         {
            this.ctr_additionalInfo.visible = this.ctr_mapElementBg.visible = this.lbl_mapElement.visible = false;
            this.lbl_additionalInfo.text = "";
            this.ctr_subAreaInfo.y = 0;
         }
         var text:String = "";
         if(hasSubArea)
         {
            if(pSubArea.area)
            {
               text += "<b>" + pSubArea.area.name + "</b> - ";
            }
            text += "<b>" + pSubArea.name + "</b>";
         }
         this.initLabel(this.lbl_subAreaInfo,text);
         this.lbl_subAreaLevel.text = this.uiApi.getText("ui.common.short.level") + " " + pSubAreaLevel;
         this.lbl_subAreaLevel.fullWidthAndHeight();
         var levelDiff:int = pSubAreaLevel - this.playerApi.getPlayedCharacterInfo().level;
         var overLevel:* = levelDiff < 0;
         levelDiff = Math.abs(levelDiff);
         if(overLevel)
         {
            if(levelDiff < 20)
            {
               this.lbl_subAreaLevel.cssClass = "subarealevelgreen";
            }
            else
            {
               this.lbl_subAreaLevel.cssClass = "subarealevelgray";
            }
         }
         else if(levelDiff < 20)
         {
            this.lbl_subAreaLevel.cssClass = "subarealevelgreen";
         }
         else if(levelDiff > 20 && levelDiff < 40)
         {
            this.lbl_subAreaLevel.cssClass = "subarealevelorange";
         }
         else
         {
            this.lbl_subAreaLevel.cssClass = "subarealevelred";
         }
         this.tx_subArea_separator.visible = false;
         this.ctr_subAreaInfoBg.height = this.lbl_subAreaInfo.textHeight + 15 + 15;
         this.lbl_subAreaLevel.x = this.lbl_subAreaInfo.textWidth + 20;
         this.lbl_subAreaLevel.y = this.ctr_subAreaInfo.y;
         if(pAlliance)
         {
            if(!this._currentAlliance || pAlliance.allianceId != this._currentAlliance.allianceId)
            {
               this.initLabel(this.lbl_allianceName,pAlliance.allianceName + " [" + pAlliance.allianceTag + "]");
               emblemMiddle = this.tx_emblemBack.height / 2 + this.ctr_emblem.x;
               this.lbl_allianceName.y = emblemMiddle - this.lbl_allianceName.textHeight / 2 - 3;
               this.ctr_allianceBg.height = Math.max(this.tx_emblemBack.height,this.lbl_allianceName.textHeight) + 7 * 2;
               this.tx_emblemBack.dispatchMessages = this.tx_emblemUp.dispatchMessages = true;
               this.tx_emblemBack.uri = this.uiApi.createUri(this.sysApi.getConfigEntry("config.gfx.path.emblem_icons.large") + "backalliance/" + pAlliance.backEmblem.idEmblem + ".swf");
               this.tx_emblemUp.uri = this.uiApi.createUri(this.sysApi.getConfigEntry("config.gfx.path.emblem_icons.large") + "up/" + pAlliance.upEmblem.idEmblem + ".swf");
               this._currentAlliance = pAlliance;
            }
            topBlock = this.ctr_subAreaInfo;
            topBlockBg = this.ctr_subAreaInfoBg;
            this.ctr_alliance.y = topBlock.y + topBlockBg.height;
            this.ctr_alliance.visible = true;
         }
         else
         {
            this.ctr_alliance.visible = false;
         }
         this.updateSize();
      }
      
      private function updateSearchInfo(pSearchedItem:Object, pMapElementText:String, pSearchResults:String) : void
      {
         var jobName:String = null;
         var skills:Array = null;
         var skill:Skill = null;
         var topBlock:GraphicContainer = null;
         var topBlockBg:GraphicContainer = null;
         if(pMapElementText)
         {
            this.initLabel(this.lbl_mapElement,"<b>" + pMapElementText + "</b>");
            this.ctr_mapElementBg.height = this.lbl_mapElement.textHeight + 12;
            this.ctr_additionalInfoBg.y = this.lbl_additionalInfo.y = this.ctr_mapElementBg.y + this.ctr_mapElementBg.height + 4;
            this.ctr_mapElementBg.visible = this.lbl_mapElement.visible = true;
         }
         else
         {
            this.lbl_mapElement.text = "";
            this.ctr_additionalInfoBg.y = this.lbl_additionalInfo.y = 0;
            this.ctr_mapElementBg.visible = this.lbl_mapElement.visible = false;
         }
         this.ctr_additionalInfoBg.visible = this.lbl_additionalInfo.visible = true;
         var itemName:String = pSearchedItem.data.name;
         if(pSearchedItem.type == 4)
         {
            if(pSearchedItem.resourceSubAreaIds)
            {
               skills = this.dataApi.getSkills();
               for each(skill in skills)
               {
                  if(skill.gatheredRessourceItem == pSearchedItem.data.id)
                  {
                     jobName = skill.parentJob.name;
                     break;
                  }
               }
               itemName += " (" + jobName + ")";
            }
            else if(pSearchedItem.subAreasIds)
            {
               itemName += "\n" + this.uiApi.getText("ui.search.foundOn");
            }
         }
         this.initLabel(this.lbl_additionalInfo,"<b>" + itemName + "</b>\n" + pSearchResults);
         this.ctr_additionalInfoBg.height = this.lbl_additionalInfo.textHeight + 12;
         this.ctr_additionalInfo.visible = true;
         this.ctr_subAreaInfo.y = this.ctr_additionalInfoBg.y + this.ctr_additionalInfoBg.height + 9;
         if(this.ctr_alliance.visible)
         {
            topBlock = this.ctr_subAreaInfo;
            topBlockBg = this.ctr_subAreaInfoBg;
            this.ctr_alliance.y = topBlock.y + topBlockBg.height;
         }
         this.updateSize();
      }
      
      private function initLabel(pLabel:Label, pText:String) : void
      {
         pLabel.wordWrap = false;
         pLabel.text = "";
         pLabel.width = 1;
         pLabel.appendText(pText);
         pLabel.fullWidthAndHeight();
      }
      
      private function updateSize() : void
      {
         var toolTipHeight:Number = NaN;
         var maxWidth:Number = this.lbl_subAreaLevel.x + this.lbl_subAreaLevel.width;
         if(this.lbl_mapElement.visible && this.lbl_mapElement.width > maxWidth)
         {
            maxWidth = this.lbl_mapElement.width;
            this.lbl_subAreaLevel.x = this.lbl_mapElement.width - this.lbl_subAreaLevel.width;
         }
         if(this.lbl_additionalInfo.visible && this.lbl_additionalInfo.width > maxWidth)
         {
            maxWidth = this.lbl_additionalInfo.width;
            this.lbl_subAreaLevel.x = this.lbl_additionalInfo.width - this.lbl_subAreaLevel.width;
         }
         var allianceWidth:Number = !!this.ctr_alliance.visible ? Number(this.lbl_allianceName.textWidth + 8 + 40) : Number(0);
         if(allianceWidth > maxWidth)
         {
            maxWidth = allianceWidth;
            this.lbl_subAreaLevel.x = allianceWidth - this.lbl_subAreaLevel.width;
         }
         var uiRootCtr:* = this.uiApi.me();
         var tooltipWidth:Number = maxWidth + 40;
         uiRootCtr.width = tooltipWidth;
         this.ctr_subAreaInfo.width = this.ctr_subAreaInfoBg.width = tooltipWidth;
         this.ctr_additionalInfo.width = this.ctr_mapElementBg.width = this.ctr_additionalInfoBg.width = tooltipWidth;
         this.ctr_alliance.width = this.ctr_allianceBg.width = tooltipWidth;
         if(this.ctr_alliance.visible)
         {
            toolTipHeight = this.ctr_alliance.y + this.ctr_allianceBg.height;
         }
         else
         {
            toolTipHeight = this.ctr_subAreaInfo.y + this.ctr_subAreaInfoBg.height;
         }
         uiRootCtr.height = toolTipHeight;
         this.tx_subArea_separator.width = this.ctr_subAreaInfoBg.width;
      }
      
      public function onTextureReady(pTarget:GraphicContainer) : void
      {
         var icon:EmblemSymbol = null;
         switch(pTarget)
         {
            case this.tx_emblemBack:
               this.utilApi.changeColor(this.tx_emblemBack.getChildByName("back"),this._currentAlliance.backEmblem.color,1);
               break;
            case this.tx_emblemUp:
               icon = this.dataApi.getEmblemSymbol(this._currentAlliance.upEmblem.idEmblem);
               this.utilApi.changeColor(this.tx_emblemUp.getChildByName("up"),this._currentAlliance.upEmblem.color,0,!icon.colorizable);
         }
      }
      
      public function onUiLoaded(pUiName:String) : void
      {
         if(pUiName == this.uiApi.me().customUnicName)
         {
            this.updateMapInfo(this._uiParams.data.mapX,this._uiParams.data.mapY,this._uiParams.data.mapElementText,this._uiParams.data.subArea,this._uiParams.data.subAreaLevel,this._uiParams.data.alliance);
            this._uiParams.data.updatePositionFunction.call();
         }
      }
   }
}
