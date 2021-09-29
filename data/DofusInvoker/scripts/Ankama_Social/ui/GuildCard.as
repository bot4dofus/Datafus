package Ankama_Social.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.datacenter.guild.RankName;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInvitationAction;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalGuildPublicInformations;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.Uri;
   
   public class GuildCard
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      private var _data:Object;
      
      private var _myGuild:GuildWrapper;
      
      private var _bgLevelUri:Uri;
      
      private var _bgPrestigeUri:Uri;
      
      private var _descendingSort:Boolean = false;
      
      public var lbl_title:Label;
      
      public var lbl_alliance:Label;
      
      public var lbl_level:Label;
      
      public var lbl_creationDate:Label;
      
      public var lbl_leader:Label;
      
      public var lbl_taxcollectors:Label;
      
      public var lbl_members:Label;
      
      public var tx_emblemBack:Texture;
      
      public var tx_emblemUp:Texture;
      
      public var tx_disabled:Texture;
      
      public var gd_members:Grid;
      
      public var btn_inviteInAlliance:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_sortByName:ButtonContainer;
      
      public var btn_sortByRank:ButtonContainer;
      
      public var btn_sortByLevel:ButtonContainer;
      
      public function GuildCard()
      {
         super();
      }
      
      public function main(... args) : void
      {
         this.sysApi.addHook(SocialHookList.OpenOneGuild,this.onOpenOneGuild);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addComponentHook(this.btn_inviteInAlliance,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_inviteInAlliance,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_inviteInAlliance,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_disabled,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_disabled,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_sortByName,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_sortByRank,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_sortByLevel,ComponentHookList.ON_RELEASE);
         this.tx_emblemBack.dispatchMessages = true;
         this.tx_emblemUp.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_emblemBack,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.tx_emblemUp,ComponentHookList.ON_TEXTURE_READY);
         this._bgLevelUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgLevel_uri"));
         this._bgPrestigeUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgPrestige_uri"));
         this._data = args[0].guild;
         this._myGuild = this.socialApi.getGuild();
         this.updateInformations();
      }
      
      public function unload() : void
      {
      }
      
      public function updateMemberLine(data:*, components:*, selected:Boolean) : void
      {
         var rankName:RankName = null;
         if(data != null)
         {
            components.lbl_memberName.text = "{player," + data.name + "," + data.id + "::" + data.name + "}";
            rankName = this.dataApi.getRankName(data.rank);
            if(rankName != null)
            {
               components.lbl_memberRank.text = rankName.name;
            }
            else
            {
               components.lbl_memberRank.text = "-";
            }
            if(data.level > ProtocolConstantsEnum.MAX_LEVEL)
            {
               components.lbl_memberLvl.cssClass = "darkboldcenter";
               components.lbl_memberLvl.text = "" + (data.level - ProtocolConstantsEnum.MAX_LEVEL);
               components.tx_memberLvl.uri = this._bgPrestigeUri;
               this.uiApi.addComponentHook(components.tx_memberLvl,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.tx_memberLvl,ComponentHookList.ON_ROLL_OUT);
            }
            else
            {
               components.lbl_memberLvl.cssClass = "boldcenter";
               components.lbl_memberLvl.text = data.level;
               components.tx_memberLvl.uri = this._bgLevelUri;
               this.uiApi.removeComponentHook(components.tx_memberLvl,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.removeComponentHook(components.tx_memberLvl,ComponentHookList.ON_ROLL_OUT);
            }
         }
         else
         {
            components.lbl_memberName.text = "";
            components.lbl_memberLvl.text = "";
            components.lbl_memberRank.text = "";
            components.tx_memberLvl.uri = null;
         }
      }
      
      private function updateInformations() : void
      {
         var alliance:AllianceWrapper = null;
         this.lbl_title.text = this._data.guildName;
         this.btn_inviteInAlliance.visible = false;
         if(this._data.allianceId)
         {
            this.lbl_alliance.text = this.uiApi.getText("ui.common.alliance") + this.uiApi.getText("ui.common.colon") + this.chatApi.getAllianceLink(this._data,this._data.allianceName);
         }
         else
         {
            this.lbl_alliance.text = this.uiApi.getText("ui.alliance.noAllianceForThisGuild");
            if(this.socialApi.hasAlliance())
            {
               alliance = this.socialApi.getAlliance();
               if(alliance)
               {
                  if(this._myGuild.guildId == alliance.leadingGuildId && this.socialApi.hasGuildRight(this.playerApi.id(),"isBoss"))
                  {
                     this.btn_inviteInAlliance.visible = true;
                  }
               }
            }
         }
         this.lbl_level.text = this._data.guildLevel;
         this.lbl_creationDate.text = this.timeApi.getDofusDate(this._data.creationDate * 1000);
         this.lbl_leader.text = "{player," + this._data.leaderName + "," + this._data.leaderId + "::" + this._data.leaderName + "}";
         this.lbl_members.text = this._data.nbMembers;
         this.lbl_taxcollectors.text = this.uiApi.processText(this.uiApi.getText("ui.guild.taxcollectorsCurrentlyCollecting",this._data.nbTaxCollectors),"n",this._data.nbTaxCollectors < 2,this._data.nbTaxCollectors == 0);
         this.tx_emblemBack.uri = this._data.backEmblem.fullSizeIconUri;
         this.tx_emblemUp.uri = this._data.upEmblem.fullSizeIconUri;
         if(this._data.members && this._data.members.length)
         {
            this.gd_members.dataProvider = this._data.members;
         }
         else
         {
            this.gd_members.dataProvider = new Vector.<CharacterMinimalGuildPublicInformations>();
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_inviteInAlliance:
               this.sysApi.sendAction(new AllianceInvitationAction([this._data.leaderId]));
               break;
            case this.btn_sortByName:
               this.sortPlayersBy("name",Array.CASEINSENSITIVE);
               break;
            case this.btn_sortByLevel:
               this.sortPlayersBy("level");
               break;
            case this.btn_sortByRank:
               this.gd_members.sortBy(this.sortPlayersByRank);
               this._descendingSort = !this._descendingSort;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case this.btn_inviteInAlliance:
               tooltipText = this.uiApi.getText("ui.alliance.inviteLeader",this._data.leaderName);
               break;
            case this.tx_disabled:
               tooltipText = this.uiApi.getText("ui.guild.disabled");
               break;
            default:
               if(target.name.indexOf("tx_memberLvl") != -1)
               {
                  tooltipText = this.uiApi.getText("ui.tooltip.OmegaLevel");
               }
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         var icon:EmblemSymbol = null;
         if(target.name.indexOf("tx_emblemBack") != -1)
         {
            this.utilApi.changeColor(target.getChildByName("back"),this._data.backEmblem.color,1);
         }
         else if(target.name.indexOf("tx_emblemUp") != -1)
         {
            icon = this.dataApi.getEmblemSymbol(this._data.upEmblem.idEmblem);
            if(icon.colorizable)
            {
               this.utilApi.changeColor(target.getChildByName("up"),this._data.upEmblem.color,0);
            }
            else
            {
               this.utilApi.changeColor(target.getChildByName("up"),this._data.upEmblem.color,0,true);
            }
         }
      }
      
      private function onOpenOneGuild(guild:Object) : void
      {
         this._data = guild;
         this.updateInformations();
      }
      
      public function sortPlayersBy(property:String, options:int = 0) : void
      {
         if(this._descendingSort)
         {
            this.gd_members.sortOn(property,options | Array.DESCENDING);
         }
         else
         {
            this.gd_members.sortOn(property,options);
         }
         this._descendingSort = !this._descendingSort;
      }
      
      public function sortPlayersByRank(a:CharacterMinimalGuildPublicInformations, b:CharacterMinimalGuildPublicInformations) : int
      {
         var rankNameA:RankName = this.dataApi.getRankName(a.rank);
         var rankNameB:RankName = this.dataApi.getRankName(b.rank);
         if(this._descendingSort)
         {
            return rankNameA.order - rankNameB.order;
         }
         return rankNameB.order - rankNameA.order;
      }
   }
}
