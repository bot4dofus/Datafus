package Ankama_Tooltips.ui
{
   import Ankama_Tooltips.Api;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.arena.ArenaLeague;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.BreedEnum;
   import com.ankamagames.dofus.network.enums.FightTypeEnum;
   import com.ankamagames.dofus.network.enums.PlayerStatusEnum;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class WorldCharacterFighterTooltipUi extends AbstractWorldFighterTooltipUi
   {
       
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      public var infosCtr:GraphicContainer;
      
      public var lbl_unsortedInfo:Label;
      
      public var tx_alignment:Texture;
      
      public var tx_alignmentBottom:Texture;
      
      public var tx_status:Texture;
      
      public var tx_ornament:Texture;
      
      public var tx_league:Texture;
      
      private var _params;
      
      private var _leagueId:int;
      
      private var _ladderPosition:int;
      
      private var _hideAlignementWings:Boolean;
      
      public function WorldCharacterFighterTooltipUi()
      {
         super();
      }
      
      override public function main(oParam:Object = null) : void
      {
         this._params = oParam;
         parentCtr = this.infosCtr;
         this.tx_alignment.removeFromParent();
         this.tx_alignmentBottom.removeFromParent();
         this.tx_ornament.uri = null;
         super.main(oParam);
      }
      
      override public function placeTooltip(oParam:Object) : void
      {
         super.placeTooltip(oParam);
         if(!this._hideAlignementWings && Api.system.getOption("showAlignmentWings","dofus"))
         {
            WorldRpCharacterTooltipUi.showAlignmentWings(oParam,this);
         }
      }
      
      override public function updateContent(oParam:Object) : void
      {
         this.fillBeforeLevelText(oParam);
         this.updateStatus(oParam);
         super.updateContent(oParam);
      }
      
      protected function updateStatus(oParam:Object) : void
      {
         var playerStatus:int = Api.fight.getFighterStatus(oParam.data.contextualId);
         if(playerStatus == PlayerStatusEnum.PLAYER_STATUS_IDLE || playerStatus == PlayerStatusEnum.PLAYER_STATUS_AFK)
         {
            this.tx_status.visible = true;
            offsetName = 25;
            this.tx_status.y = lbl_name.y + 4;
            this.tx_status.x = 0;
         }
         else
         {
            this.tx_status.visible = false;
         }
      }
      
      override protected function updateInfo(oParam:Object) : void
      {
         lbl_info.text = "";
         lbl_info.removeFromParent();
         lbl_info.y = lbl_name.y + (lbl_name.text == "" ? 0 : lbl_name.height);
         if(Api.fight.preFightIsActive())
         {
            lbl_info.text = beforeLevelText + " " + Api.fight.getFighterLevel(oParam.data.contextualId);
            this.showOrnament(oParam);
         }
         else if(this.infosCtr.getChildByName(this.lbl_unsortedInfo.name))
         {
            this.lbl_unsortedInfo.text = "";
            this.lbl_unsortedInfo.fullWidthAndHeight();
            this.infosCtr.removeChild(this.lbl_unsortedInfo);
         }
         if(!Api.fight.preFightIsActive() && this._params.data.breed > 0 && sysApi.getOption("showBreed","dofus"))
         {
            lbl_info.text = Api.data.getBreed(this._params.data.breed).shortName;
         }
         lbl_info.fullWidthAndHeight();
         this.lbl_unsortedInfo.y = lbl_info.y + (lbl_info.text == "" ? 0 : lbl_info.height);
         this.lbl_unsortedInfo.fullWidthAndHeight();
         backgroundCtr.height += lbl_info.height;
         if(this.lbl_unsortedInfo.text != "")
         {
            backgroundCtr.height += this.lbl_unsortedInfo.height;
         }
         this.infosCtr.addContent(lbl_info);
      }
      
      override protected function updateState(oParam:Object) : void
      {
         super.updateState(oParam);
         if(this.lbl_unsortedInfo.text != "")
         {
            lbl_fightStatus.y = this.lbl_unsortedInfo.y + (this.lbl_unsortedInfo.text == "" ? 0 : this.lbl_unsortedInfo.height);
         }
      }
      
      override protected function alignLabels(offset:Number) : void
      {
         super.alignLabels(offset);
         var maxWidth:Number = this.getMaxLabelWidth();
         this.lbl_unsortedInfo.x = maxWidth / 2 - this.lbl_unsortedInfo.width / 2 + offset;
      }
      
      override protected function getMaxLabelWidth() : Number
      {
         var maxWidth:Number = super.getMaxLabelWidth();
         if(this.lbl_unsortedInfo.text != "" && (isNaN(maxWidth) || this.lbl_unsortedInfo.width > maxWidth))
         {
            maxWidth = this.lbl_unsortedInfo.width;
         }
         return maxWidth;
      }
      
      private function showOrnament(oParam:Object) : void
      {
         var ornamentId:int = 0;
         if(fightApi.getFightType() == FightTypeEnum.FIGHT_TYPE_PVP_ARENA)
         {
            mainCtr.visible = true;
            if(oParam.data.leagueId > 0)
            {
               ornamentId = dataApi.getArenaLeagueById(oParam.data.leagueId).ornamentId;
               if(ornamentId > 0)
               {
                  mainCtr.visible = false;
                  this.tx_ornament.dispatchMessages = true;
                  uiApi.addComponentHook(this.tx_ornament,"onTextureReady");
                  this.tx_ornament.uri = uiApi.createUri(sysApi.getConfigEntry("config.gfx.path.ornament") + "ornament_" + ornamentId + ".swf|ornament_" + ornamentId);
                  this._leagueId = oParam.data.leagueId;
                  this._ladderPosition = oParam.data.ladderPosition;
                  this._hideAlignementWings = true;
               }
            }
         }
         else
         {
            this.tx_ornament.uri = null;
         }
         if(oParam.data.hiddenInPrefight)
         {
            this.lbl_unsortedInfo.text = uiApi.getText("ui.pvp.fighterNotOrdonned");
            this.lbl_unsortedInfo.fullWidthAndHeight();
            this.infosCtr.addChild(this.lbl_unsortedInfo);
         }
      }
      
      private function fillBeforeLevelText(oParam:Object) : void
      {
         beforeLevelText = "";
         if(oParam.data.breed > 0)
         {
            beforeLevelText = Api.data.getBreed(oParam.data.breed).shortName;
         }
         else if(oParam.data.breed == BreedEnum.INCARNATION)
         {
            beforeLevelText = Api.ui.getText("ui.common.incarnation");
         }
         if(beforeLevelText != "")
         {
            if(oParam.data.contextualId > 0 && oParam.data.level > ProtocolConstantsEnum.MAX_LEVEL)
            {
               beforeLevelText += " " + uiApi.getText("ui.common.short.prestige");
               specifiedLevel = oParam.data.level - ProtocolConstantsEnum.MAX_LEVEL;
            }
            else
            {
               beforeLevelText += " " + uiApi.getText("ui.common.short.level");
            }
         }
         else
         {
            beforeLevelText += Api.ui.getText("ui.common.level");
         }
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         var uiBounds:Rectangle = null;
         var koliRankBounds:* = undefined;
         var bounds:* = undefined;
         var league:ArenaLeague = null;
         var matches:Array = null;
         var rank:String = null;
         switch(target)
         {
            case this.tx_ornament:
               uiApi.removeComponentHook(this.tx_ornament,"onTextureReady");
               uiApi.buildOrnamentTooltipFrom(this.tx_ornament,new Rectangle(0,0,backgroundCtr.width,backgroundCtr.height));
               mainCtr.visible = true;
               if(this.tx_ornament.child)
               {
                  if(this.tx_ornament.child.hasOwnProperty("kolizeum_rank_picto"))
                  {
                     league = dataApi.getArenaLeagueById(this._leagueId);
                     if(league)
                     {
                        matches = league.name.split(" ");
                     }
                     if(matches)
                     {
                        rank = WorldRpCharacterTooltipUi.convertFromRoman(matches[1]);
                     }
                     if(rank)
                     {
                        koliRankBounds = Object(this.tx_ornament.child).kolizeum_rank_picto.getBounds(Object(this.tx_ornament.child).kolizeum_rank_picto);
                        if(!this.tx_league)
                        {
                           this.tx_league = new Texture();
                        }
                        this.tx_league.dispatchMessages = true;
                        uiApi.addComponentHook(this.tx_league,"onTextureReady");
                        this.tx_league.uri = uiApi.createUri(sysApi.getConfigEntry("config.gfx.path.ornament") + "chiffres_kolizeum.swf|kolizeum_rank_picto" + rank);
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
                  bounds = Object(this.tx_ornament.child).bottom.getBounds(Object(this.tx_ornament.child).bottom);
                  uiApi.me().y = uiApi.me().y - (Object(this.tx_ornament.child).bottom.height + bounds.top) * (uiApi.me().name != "tooltip_tooltipCharacter" ? this._params.zoom : 1);
               }
               uiBounds = uiApi.me().getBounds(uiApi.me());
               if(uiApi.me().x + uiBounds.left < 0)
               {
                  uiApi.me().x = uiApi.me().x - uiBounds.left;
               }
               else if(uiApi.me().x + uiBounds.right > uiApi.getStageWidth())
               {
                  uiApi.me().x = uiApi.me().x - (uiApi.me().x + uiBounds.right - uiApi.getStageWidth());
               }
               if(uiApi.me().y + uiBounds.top < 0)
               {
                  uiApi.me().y = uiApi.me().y - (uiApi.me().y + uiBounds.top);
               }
               break;
            case this.tx_league:
               this.tx_league.dispatchMessages = false;
               uiApi.removeComponentHook(this.tx_league,"onTextureReady");
         }
      }
   }
}
