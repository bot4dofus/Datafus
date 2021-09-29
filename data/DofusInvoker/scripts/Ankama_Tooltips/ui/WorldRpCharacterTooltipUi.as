package Ankama_Tooltips.ui
{
   import Ankama_Tooltips.Api;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.arena.ArenaLeague;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.network.enums.AlignmentSideEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionAlliance;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionGuild;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.utils.display.FpsControler;
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class WorldRpCharacterTooltipUi
   {
      
      private static const TOOLTIP_MIN_WIDTH:int = 160;
      
      private static const TOOLTIP_MIN_HEIGHT:int = 40;
      
      private static const EMBLEM_BACK_WIDTH:int = 40;
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      private var _guildInformations:Object;
      
      private var _colorBack:int;
      
      private var _colorUp:int;
      
      private var _allianceInformations:Object;
      
      private var _allianceEmblemBgColor:int;
      
      private var _allianceEmblemIconColor:int;
      
      private var _zoom:Number;
      
      public var mainCtr:Object;
      
      public var infosCtr:GraphicContainer;
      
      public var tx_back:GraphicContainer;
      
      public var tx_emblemBack:Texture;
      
      public var tx_emblemUp:Texture;
      
      public var tx_AllianceEmblemBack:Texture;
      
      public var tx_AllianceEmblemUp:Texture;
      
      public var tx_alignment:Texture;
      
      public var tx_alignmentBottom:Texture;
      
      public var lbl_playerName:Label;
      
      public var lbl_guildName:Label;
      
      public var lbl_title:Label;
      
      public var tx_ornament:Texture;
      
      public var tx_omega:Texture;
      
      public var tx_league:Texture;
      
      private var _omegaLevel:int;
      
      private var _leagueId:int;
      
      private var _ladderPosition:int;
      
      public function WorldRpCharacterTooltipUi()
      {
         super();
      }
      
      public static function convertFromRoman(num:String) : String
      {
         var romanNumeral:Array = ["I","II","III","IV","V","VI","VII","VIII","IX","X"];
         return "" + (romanNumeral.indexOf(num) + 1);
      }
      
      public static function showAlignmentWings(oParam:Object, instance:Object) : void
      {
         var alignmentInfos:Object = null;
         var w:int = 0;
         var data:Object = oParam.data;
         var uiInstance:Object = instance["uiApi"].me();
         var alignmentUri:String = uiInstance.getConstant("alignment");
         var tx_back:GraphicContainer = uiInstance.getElement("tx_back") as GraphicContainer;
         if(!tx_back)
         {
            tx_back = uiInstance.getElement("backgroundCtr") as GraphicContainer;
         }
         var ctr_alignment_bottom:GraphicContainer = uiInstance.getElement("ctr_alignment_bottom") as GraphicContainer;
         var ctr_alignment_top:GraphicContainer = uiInstance.getElement("ctr_alignment_top") as GraphicContainer;
         var tx_alignment:Texture = uiInstance.getElement("tx_alignment") as Texture;
         var tx_alignmentBottom:Texture = uiInstance.getElement("tx_alignmentBottom") as Texture;
         if(data.hasOwnProperty("infos") && data.infos.hasOwnProperty("alignmentInfos"))
         {
            alignmentInfos = oParam.data.infos.alignmentInfos;
         }
         else if(data.hasOwnProperty("alignmentInfos"))
         {
            alignmentInfos = data.alignmentInfos;
         }
         if(alignmentInfos && alignmentInfos.alignmentSide > AlignmentSideEnum.ALIGNMENT_NEUTRAL && alignmentInfos.alignmentGrade > 0)
         {
            w = tx_back.width / 2 - 4;
            ctr_alignment_bottom.x = w;
            ctr_alignment_top.x = w;
            ctr_alignment_bottom.y = tx_back.height - 4;
            ctr_alignment_top.addContent(tx_alignment);
            ctr_alignment_bottom.addContent(tx_alignmentBottom);
            tx_alignment.uri = Api.ui.createUri(alignmentUri + "wings.swf|demonAngel");
            tx_alignmentBottom.uri = Api.ui.createUri(alignmentUri + "wings.swf|demonAngel2");
            tx_alignment.cacheAsBitmap = true;
            tx_alignmentBottom.cacheAsBitmap = true;
            tx_alignment.gotoAndStop = (alignmentInfos.alignmentSide - 1) * 10 + 1 + alignmentInfos.alignmentGrade;
            tx_alignmentBottom.gotoAndStop = (alignmentInfos.alignmentSide - 1) * 10 + 1 + alignmentInfos.alignmentGrade;
            tx_alignment.filters = [];
            tx_alignmentBottom.filters = [];
            tx_alignment.transform.colorTransform = new ColorTransform(1,1,1);
            tx_alignmentBottom.transform.colorTransform = new ColorTransform(1,1,1);
            if(data.hasOwnProperty("wingsEffect"))
            {
               if(data.wingsEffect == -1)
               {
                  if(alignmentInfos.alignmentSide == AlignmentSideEnum.ALIGNMENT_EVIL)
                  {
                     tx_alignment.transform.colorTransform = new ColorTransform(0.6,0.6,0.6);
                     tx_alignmentBottom.transform.colorTransform = new ColorTransform(0.6,0.6,0.6);
                  }
                  else
                  {
                     tx_alignment.transform.colorTransform = new ColorTransform(0.7,0.7,0.7);
                     tx_alignmentBottom.transform.colorTransform = new ColorTransform(0.7,0.7,0.7);
                  }
               }
               else if(data.wingsEffect == 1)
               {
                  if(alignmentInfos.alignmentSide == AlignmentSideEnum.ALIGNMENT_ANGEL)
                  {
                     tx_alignment.filters = new Array(new GlowFilter(16777215,1,5,5,1,3));
                     tx_alignmentBottom.filters = new Array(new GlowFilter(16777215,1,5,5,1,3));
                     tx_alignment.transform.colorTransform = new ColorTransform(1.1,1.1,1.2);
                     tx_alignmentBottom.transform.colorTransform = new ColorTransform(1.1,1.1,1.2);
                  }
                  else if(alignmentInfos.alignmentSide == AlignmentSideEnum.ALIGNMENT_EVIL)
                  {
                     tx_alignment.filters = new Array(new GlowFilter(16711704,1,10,10,2,3));
                     tx_alignmentBottom.filters = new Array(new GlowFilter(16711704,1,10,10,2,3));
                     tx_alignment.transform.colorTransform = new ColorTransform(1.2,1.1,1.1);
                     tx_alignmentBottom.transform.colorTransform = new ColorTransform(1.2,1.1,1.1);
                  }
               }
            }
         }
      }
      
      public function main(oParam:Object = null) : void
      {
         var option:* = undefined;
         var maxLabel:Label = null;
         var backgroundWidth:int = 0;
         var alignmentInfos:Object = null;
         var guildDec:Number = NaN;
         this._zoom = oParam.zoom;
         this.uiApi.me().mouseEnabled = this.uiApi.me().mouseChildren = false;
         var data:Object = oParam.data;
         this.lbl_playerName.x = this.lbl_playerName.y = this.lbl_playerName.width = 0;
         this.lbl_guildName.x = this.lbl_guildName.y = this.lbl_guildName.width = 0;
         this.lbl_guildName.removeFromParent();
         this.tx_emblemBack.removeFromParent();
         this.tx_emblemUp.removeFromParent();
         this.tx_AllianceEmblemBack.removeFromParent();
         this.tx_AllianceEmblemUp.removeFromParent();
         this.lbl_playerName.removeFromParent();
         this.updatePlayerName(oParam.makerName,data);
         this.infosCtr.addContent(this.lbl_playerName);
         if(!this.tx_omega)
         {
            this.tx_omega = new Texture();
         }
         if(!this.tx_league)
         {
            this.tx_league = new Texture();
         }
         var hasGuildInformation:Boolean = false;
         var hasAllianceInformation:Boolean = false;
         var hasInfos:Boolean = data.hasOwnProperty("infos");
         var hasTitle:Boolean = data.hasOwnProperty("titleName") && data.titleName;
         var hasOrnament:Boolean = data.hasOwnProperty("ornamentAssetId") && data.ornamentAssetId > 0;
         if(hasInfos)
         {
            this._guildInformations = null;
            if(data.infos.humanoidInfo is HumanInformations)
            {
               for each(option in (data.infos.humanoidInfo as HumanInformations).options)
               {
                  if(option is HumanOptionGuild && (!data.hasOwnProperty("hideGuild") || !data.hideGuild))
                  {
                     this._guildInformations = option.guildInformations;
                     hasGuildInformation = true;
                  }
                  else if(option is HumanOptionAlliance && (!data.hasOwnProperty("hideAlliance") || !data.hideAlliance))
                  {
                     this._allianceInformations = option.allianceInformations;
                     hasAllianceInformation = true;
                  }
               }
            }
         }
         else if(data is GameRolePlayMerchantInformations)
         {
            for each(option in (data as GameRolePlayMerchantInformations).options)
            {
               if(option is HumanOptionGuild && (!data.hasOwnProperty("hideGuild") || !data.hideGuild))
               {
                  this._guildInformations = option.guildInformations;
                  hasGuildInformation = true;
               }
               else if(option is HumanOptionAlliance && (!data.hasOwnProperty("hideAlliance") || !data.hideAlliance))
               {
                  this._allianceInformations = option.allianceInformations;
                  hasAllianceInformation = true;
               }
            }
         }
         if(hasGuildInformation)
         {
            this._colorUp = this._guildInformations.guildEmblem.symbolColor;
            this._colorBack = this._guildInformations.guildEmblem.backgroundColor;
            this.lbl_playerName.y = 18;
            this.tx_emblemBack.visible = false;
            this.tx_emblemUp.visible = false;
            this.infosCtr.addContent(this.tx_emblemBack);
            this.infosCtr.addContent(this.tx_emblemUp);
            this.infosCtr.addContent(this.lbl_guildName);
            this.lbl_guildName.text = this._guildInformations.guildName;
            this.lbl_guildName.fullWidthAndHeight();
            this.tx_emblemBack.dispatchMessages = true;
            this.uiApi.addComponentHook(this.tx_emblemBack,"onTextureReady");
            this.tx_emblemUp.dispatchMessages = true;
            this.uiApi.addComponentHook(this.tx_emblemUp,"onTextureReady");
            this.tx_emblemBack.uri = this.uiApi.createUri(this.uiApi.me().getConstant("emblems") + "back/" + this._guildInformations.guildEmblem.backgroundShape + ".swf",true);
            this.tx_emblemUp.uri = this.uiApi.createUri(this.uiApi.me().getConstant("emblems") + "up/" + this._guildInformations.guildEmblem.symbolShape + ".swf",true);
            this.tx_emblemBack.x = 2;
            this.tx_emblemUp.x = 10;
            this.tx_emblemUp.y = 8;
            this.lbl_guildName.x = 50;
            this.lbl_guildName.y = -2;
            this.lbl_playerName.x = 50;
         }
         this.lbl_title.x = this.lbl_title.y = 0;
         this.lbl_title.width = 0;
         this.lbl_title.removeFromParent();
         if(hasTitle)
         {
            this.lbl_title.useCustomFormat = true;
            if(data.titleColor)
            {
               this.lbl_title.text = "<font color=\'#" + data.titleColor.substr(2) + "\'>" + data.titleName + "</font>";
            }
            this.lbl_title.fullWidthAndHeight();
            this.infosCtr.addContent(this.lbl_title);
            if(hasGuildInformation)
            {
               this.lbl_title.y = 40;
               this.lbl_title.x = 40;
            }
            else
            {
               this.lbl_title.y = 20;
            }
         }
         else
         {
            this.lbl_title.text = "";
            this.tx_emblemBack.x = 2;
            this.tx_emblemUp.x = 10;
         }
         if(hasGuildInformation)
         {
            if(hasAllianceInformation)
            {
               this.tx_AllianceEmblemBack.visible = false;
               this.tx_AllianceEmblemUp.visible = false;
               this.infosCtr.addContent(this.tx_AllianceEmblemBack);
               this.infosCtr.addContent(this.tx_AllianceEmblemUp);
               this.lbl_guildName.appendText(" - [" + this._allianceInformations.allianceTag + "]");
               this.lbl_guildName.fullWidthAndHeight();
               this._allianceEmblemBgColor = this._allianceInformations.allianceEmblem.backgroundColor;
               this._allianceEmblemIconColor = this._allianceInformations.allianceEmblem.symbolColor;
               this.tx_AllianceEmblemBack.dispatchMessages = this.tx_AllianceEmblemUp.dispatchMessages = true;
               this.uiApi.addComponentHook(this.tx_AllianceEmblemBack,"onTextureReady");
               this.uiApi.addComponentHook(this.tx_AllianceEmblemUp,"onTextureReady");
               if(this._allianceInformations.allianceEmblem.backgroundShape != this._guildInformations.guildEmblem.backgroundShape)
               {
                  this.tx_AllianceEmblemBack.uri = this.uiApi.createUri(this.uiApi.me().getConstant("emblems") + "backalliance/" + this._allianceInformations.allianceEmblem.backgroundShape + ".swf",true);
               }
               if(this._allianceInformations.allianceEmblem.symbolShape != this._guildInformations.guildEmblem.symbolShape)
               {
                  this.tx_AllianceEmblemUp.uri = this.uiApi.createUri(this.uiApi.me().getConstant("emblems") + "up/" + this._allianceInformations.allianceEmblem.symbolShape + ".swf",true);
               }
               this.tx_AllianceEmblemBack.y = this.tx_emblemBack.y;
               this.tx_AllianceEmblemUp.y = this.tx_emblemUp.y;
               if(this.lbl_guildName.width > this.lbl_playerName.width)
               {
                  maxLabel = this.lbl_guildName;
               }
               else
               {
                  maxLabel = this.lbl_playerName;
               }
               if(hasTitle && this.lbl_title.width > maxLabel.width)
               {
                  maxLabel = this.lbl_title;
               }
               this.tx_AllianceEmblemBack.x = maxLabel.x + maxLabel.width + (maxLabel != this.lbl_title ? 8 : 0);
               this.tx_AllianceEmblemUp.x = this.tx_AllianceEmblemBack.x + 8;
            }
            if(this.lbl_guildName.width > this.lbl_playerName.width)
            {
               maxLabel = this.lbl_guildName;
            }
            else
            {
               maxLabel = this.lbl_playerName;
            }
            if(hasTitle && this.lbl_title.width > maxLabel.width)
            {
               maxLabel = this.lbl_title;
            }
            this.lbl_playerName.x += (maxLabel.width - this.lbl_playerName.width) / 2;
            this.lbl_guildName.x += (maxLabel.width - this.lbl_guildName.width) / 2;
            this.lbl_title.x += (maxLabel.width - this.lbl_title.width) / 2;
         }
         this.tx_back.height = 0;
         this.tx_back.width = 0;
         this.tx_back.removeFromParent();
         if(this.lbl_title.text != "")
         {
            if(hasGuildInformation && this.lbl_guildName.width > this.lbl_playerName.width)
            {
               maxLabel = this.lbl_guildName;
            }
            else
            {
               maxLabel = this.lbl_playerName;
            }
            if(this.lbl_title.width > maxLabel.width)
            {
               maxLabel = this.lbl_title;
            }
            backgroundWidth = maxLabel.x + maxLabel.width;
            if(hasGuildInformation)
            {
               if(hasAllianceInformation)
               {
                  backgroundWidth += EMBLEM_BACK_WIDTH + (maxLabel != this.lbl_title ? 8 : 0);
               }
               else
               {
                  backgroundWidth += 2;
               }
            }
            this.tx_back.width = backgroundWidth + 6;
            if(hasGuildInformation)
            {
               this.lbl_guildName.x = maxLabel.x + maxLabel.width / 2 - this.lbl_guildName.width / 2;
            }
            this.lbl_playerName.x = maxLabel.x + maxLabel.width / 2 - this.lbl_playerName.width / 2;
            this.lbl_title.x = maxLabel.x + maxLabel.width / 2 - this.lbl_title.width / 2;
            this.tx_back.height = this.infosCtr.height + 8;
         }
         else if(hasGuildInformation)
         {
            if(this.lbl_guildName.width > this.lbl_playerName.width)
            {
               this.tx_back.width = this.lbl_guildName.x + this.lbl_guildName.width + 8;
            }
            else
            {
               this.tx_back.width = this.lbl_playerName.x + this.lbl_playerName.width + 8;
            }
            if(hasAllianceInformation)
            {
               if(this.lbl_guildName.width > this.lbl_playerName.width)
               {
                  this.tx_back.width = this.lbl_guildName.x + this.lbl_guildName.width + EMBLEM_BACK_WIDTH + 16;
               }
               else
               {
                  this.tx_back.width = this.lbl_playerName.x + this.lbl_playerName.width + EMBLEM_BACK_WIDTH + 16;
               }
            }
            this.tx_back.height = this.infosCtr.height + 6;
         }
         else
         {
            if(this.lbl_playerName.width < 60)
            {
               this.lbl_playerName.x = (60 - this.lbl_playerName.width) / 2;
               this.tx_back.width = 68;
            }
            else
            {
               this.tx_back.width = this.lbl_playerName.width + 8;
            }
            this.tx_back.height = this.infosCtr.height + 5;
         }
         this.tx_back.width += 2;
         if(this.lbl_title.text != "" && !hasGuildInformation && !hasAllianceInformation)
         {
            this.lbl_playerName.x = this.tx_back.width / 2 - this.lbl_playerName.width / 2 - 4;
         }
         if(data.hasOwnProperty("infos") && data.infos.hasOwnProperty("alignmentInfos"))
         {
            alignmentInfos = oParam.data.infos.alignmentInfos;
         }
         else if(data.hasOwnProperty("alignmentInfos"))
         {
            alignmentInfos = data.alignmentInfos;
         }
         if(alignmentInfos && alignmentInfos.alignmentSide > AlignmentSideEnum.ALIGNMENT_NEUTRAL && alignmentInfos.alignmentGrade > 0)
         {
            hasOrnament = false;
         }
         if(hasOrnament && this.tx_back.width < TOOLTIP_MIN_WIDTH)
         {
            this.tx_back.width = TOOLTIP_MIN_WIDTH;
            this.lbl_playerName.x = (TOOLTIP_MIN_WIDTH - this.lbl_playerName.width) / 2 - 5;
            if(hasGuildInformation)
            {
               if(this.lbl_playerName.width > this.lbl_guildName.width)
               {
                  guildDec = (TOOLTIP_MIN_WIDTH - (this.tx_emblemBack.width + this.lbl_playerName.width)) / 2;
               }
               else
               {
                  guildDec = (TOOLTIP_MIN_WIDTH - (this.tx_emblemBack.width + this.lbl_guildName.width)) / 2;
               }
               if(guildDec > 8)
               {
                  guildDec -= 8;
               }
               this.tx_emblemBack.x = guildDec;
               this.tx_emblemUp.x = guildDec + 8;
               this.lbl_playerName.x = this.tx_emblemBack.x + 48;
               this.lbl_guildName.x = this.tx_emblemBack.x + 48;
            }
            if(hasTitle)
            {
               this.lbl_title.x = (TOOLTIP_MIN_WIDTH - this.lbl_title.width) / 2 - 5;
            }
         }
         if(hasOrnament && this.tx_back.height < TOOLTIP_MIN_HEIGHT)
         {
            this.tx_back.height = TOOLTIP_MIN_HEIGHT;
            this.lbl_playerName.y = (TOOLTIP_MIN_HEIGHT - this.lbl_playerName.height) / 2 - 3;
         }
         this.infosCtr.addContent(this.tx_back,0);
         this.tx_ornament.uri = null;
         if(hasOrnament)
         {
            this.mainCtr.visible = false;
            this.tx_ornament.dispatchMessages = true;
            this.tx_ornament.disableAnimation = true;
            this.uiApi.addComponentHook(this.tx_ornament,"onTextureReady");
            this.tx_ornament.uri = this.uiApi.createUri(this.sysApi.getConfigEntry("config.gfx.path.ornament") + "ornament_" + data.ornamentAssetId + ".swf|ornament_" + data.ornamentAssetId);
            this._omegaLevel = data.omegaLevel;
            this._leagueId = data.leagueId;
            this._ladderPosition = data.ladderPosition;
            if(this.sysApi.getOption("showOmegaUnderOrnament","dofus") && this._omegaLevel > 0)
            {
               this.tx_back.height += 10;
            }
         }
         else
         {
            this.mainCtr.visible = true;
         }
         if(oParam.zoom)
         {
            this.uiApi.me().scale = oParam.zoom;
         }
         this.tx_alignment.removeFromParent();
         this.tx_alignmentBottom.removeFromParent();
         this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset);
         showAlignmentWings(oParam,this);
      }
      
      private function updatePlayerName(makerName:String, data:Object) : void
      {
         switch(makerName)
         {
            case "player":
            case "mutant":
               this.lbl_playerName.text = data.infos.name;
               break;
            case "merchant":
               this.lbl_playerName.text = data.name + " (" + Api.ui.getText("ui.common.merchant") + ")";
         }
         this.lbl_playerName.fullWidthAndHeight();
      }
      
      private function updateEmblemBack(pTexture:Texture, pColor:int) : void
      {
         this.utilApi.changeColor(pTexture.getChildByName("back"),pColor,1);
         pTexture.visible = true;
      }
      
      private function updateEmblemUp(pTexture:Texture, pColor:int, pSymbolId:int) : void
      {
         var icon:EmblemSymbol = this.dataApi.getEmblemSymbol(pSymbolId);
         if(icon.colorizable)
         {
            this.utilApi.changeColor(pTexture.getChildByName("up"),pColor,0);
         }
         else
         {
            this.utilApi.changeColor(pTexture.getChildByName("up"),pColor,0,true);
         }
         pTexture.visible = true;
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         var uiBounds:Rectangle = null;
         var displayOmegaBottom:Boolean = false;
         var koliRankBounds:* = undefined;
         var bounds:* = undefined;
         var omegaBounds:* = undefined;
         var league:ArenaLeague = null;
         var matches:Array = null;
         var rank:String = null;
         switch(target)
         {
            case this.tx_emblemBack:
               if(!this._guildInformations)
               {
                  return;
               }
               this.updateEmblemBack(this.tx_emblemBack,this._colorBack);
               if(this._allianceInformations && this._allianceInformations.allianceEmblem.backgroundShape == this._guildInformations.guildEmblem.backgroundShape)
               {
                  this.tx_AllianceEmblemBack.uri = this.uiApi.createUri(this.uiApi.me().getConstant("emblems") + "backalliance/" + this._allianceInformations.allianceEmblem.backgroundShape + ".swf",true);
               }
               break;
            case this.tx_emblemUp:
               if(!this._guildInformations)
               {
                  return;
               }
               this.updateEmblemUp(this.tx_emblemUp,this._colorUp,this._guildInformations.guildEmblem.symbolShape);
               if(this._allianceInformations && this._allianceInformations.allianceEmblem.symbolShape == this._guildInformations.guildEmblem.symbolShape)
               {
                  this.tx_AllianceEmblemUp.uri = this.uiApi.createUri(this.uiApi.me().getConstant("emblems") + "up/" + this._allianceInformations.allianceEmblem.symbolShape + ".swf",true);
               }
               break;
            case this.tx_AllianceEmblemBack:
               if(!this._allianceInformations)
               {
                  return;
               }
               this.updateEmblemBack(this.tx_AllianceEmblemBack,this._allianceEmblemBgColor);
               break;
            case this.tx_AllianceEmblemUp:
               if(!this._allianceInformations)
               {
                  return;
               }
               this.updateEmblemUp(this.tx_AllianceEmblemUp,this._allianceEmblemIconColor,this._allianceInformations.allianceEmblem.symbolShape);
               break;
            case this.tx_ornament:
               this.uiApi.removeComponentHook(this.tx_ornament,"onTextureReady");
               this.uiApi.buildOrnamentTooltipFrom(this.tx_ornament,new Rectangle(0,0,this.tx_back.width,this.tx_back.height));
               this.mainCtr.visible = true;
               if(this.tx_ornament.child)
               {
                  FpsControler.controlFpsNoLoop(this.tx_ornament.child as MovieClip,25);
                  displayOmegaBottom = this.sysApi.getOption("showOmegaUnderOrnament","dofus");
                  if(this.tx_ornament.child.hasOwnProperty("bottom"))
                  {
                     if(displayOmegaBottom && this._omegaLevel > 0)
                     {
                        Object(Object(this.tx_ornament.child).bottom).visible = false;
                     }
                     else
                     {
                        bounds = Object(this.tx_ornament.child).bottom.getBounds(Object(this.tx_ornament.child).bottom);
                        this.uiApi.me().y = this.uiApi.me().y - (Object(this.tx_ornament.child).bottom.height + bounds.top) * (this.uiApi.me().name != "tooltip_tooltipCharacter" ? this._zoom : 1);
                     }
                  }
                  if(displayOmegaBottom && this.tx_ornament.child.hasOwnProperty("omega_bottom") && this._omegaLevel > 0)
                  {
                     omegaBounds = Object(this.tx_ornament.child).omega_bottom.getBounds(Object(this.tx_ornament.child).omega_bottom);
                     this.uiApi.me().y = this.uiApi.me().y - (Object(this.tx_ornament.child).omega_bottom.height + omegaBounds.top) * (this.uiApi.me().name != "tooltip_tooltipCharacter" ? this._zoom : 1);
                     this.tx_omega.dispatchMessages = true;
                     this.uiApi.addComponentHook(this.tx_omega,"onTextureReady");
                     this.tx_omega.uri = this.uiApi.createUri(this.sysApi.getConfigEntry("config.gfx.path.ornament") + "cartouche_omega.swf");
                     this.tx_omega.width = omegaBounds.width;
                     this.tx_omega.height = omegaBounds.height;
                     this.tx_omega.finalize();
                     Object(this.tx_ornament.child).omega_bottom.addChild(this.tx_omega);
                  }
                  if(this.tx_ornament.child.hasOwnProperty("kolizeum_rank_picto"))
                  {
                     league = this.dataApi.getArenaLeagueById(this._leagueId);
                     if(league)
                     {
                        matches = league.name.split(" ");
                     }
                     if(matches)
                     {
                        rank = convertFromRoman(matches[1]);
                     }
                     if(rank && parseInt(rank) > 0)
                     {
                        koliRankBounds = Object(this.tx_ornament.child).kolizeum_rank_picto.getBounds(Object(this.tx_ornament.child).kolizeum_rank_picto);
                        this.tx_league.dispatchMessages = true;
                        this.uiApi.addComponentHook(this.tx_league,"onTextureReady");
                        this.tx_league.uri = this.uiApi.createUri(this.sysApi.getConfigEntry("config.gfx.path.ornament") + "chiffres_kolizeum.swf|kolizeum_rank_picto" + rank);
                        this.tx_league.width = koliRankBounds.width;
                        this.tx_league.height = koliRankBounds.height;
                        this.tx_league.finalize();
                        Object(this.tx_ornament.child).kolizeum_rank_picto.addChild(this.tx_league);
                     }
                  }
                  else if(this.tx_ornament.child.hasOwnProperty("tx_kolizeum_rank"))
                  {
                     if(this._ladderPosition <= 0)
                     {
                        TextField(Object(this.tx_ornament.child).tx_kolizeum_rank.rank_tx).text = "";
                     }
                     else
                     {
                        TextField(Object(this.tx_ornament.child).tx_kolizeum_rank.rank_tx).text = "" + this._ladderPosition;
                     }
                  }
               }
               uiBounds = this.uiApi.me().getBounds(this.uiApi.me());
               if(this.uiApi.me().x + uiBounds.left < 0)
               {
                  this.uiApi.me().x = this.uiApi.me().x - uiBounds.left;
               }
               else if(this.uiApi.me().x + uiBounds.right > this.uiApi.getStageWidth())
               {
                  this.uiApi.me().x = this.uiApi.me().x - (this.uiApi.me().x + uiBounds.right - this.uiApi.getStageWidth());
               }
               if(this.uiApi.me().y + uiBounds.top < 0)
               {
                  this.uiApi.me().y = this.uiApi.me().y - (this.uiApi.me().y + uiBounds.top);
               }
               break;
            case this.tx_omega:
               this.tx_omega.dispatchMessages = false;
               this.uiApi.removeComponentHook(this.tx_omega,"onTextureReady");
               if(this.tx_omega.child && this.tx_omega.child.hasOwnProperty("omega_bottom") && this.sysApi.getOption("showOmegaUnderOrnament","dofus"))
               {
                  TextField(Object(this.tx_omega.child).omega_bottom.count_bg).text = TextField(Object(this.tx_omega.child).omega_bottom.count_fg).text = "" + this._omegaLevel;
               }
               break;
            case this.tx_league:
               this.tx_league.dispatchMessages = false;
               this.uiApi.removeComponentHook(this.tx_league,"onTextureReady");
         }
      }
   }
}
