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
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.utils.Dictionary;
   
   public class AllianceCard
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
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      private var _data:Object;
      
      private var _compsTxEmblem:Dictionary;
      
      private var _comps:Dictionary;
      
      public var lbl_title:Label;
      
      public var lbl_tag:Label;
      
      public var lbl_leader:Label;
      
      public var lbl_guilds:Label;
      
      public var lbl_areas:Label;
      
      public var lbl_members:Label;
      
      public var lbl_creationDate:Label;
      
      public var tx_emblemBack:Texture;
      
      public var tx_emblemUp:Texture;
      
      public var gd_guilds:Grid;
      
      public var btn_close:ButtonContainer;
      
      public var btn_sortByName:ButtonContainer;
      
      public var btn_sortByLevel:ButtonContainer;
      
      private var _descendingSort:Boolean = false;
      
      public function AllianceCard()
      {
         this._compsTxEmblem = new Dictionary(true);
         this._comps = new Dictionary(true);
         super();
      }
      
      public function main(... args) : void
      {
         this.sysApi.addHook(SocialHookList.OpenOneAlliance,this.onOpenOneAlliance);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addComponentHook(this.btn_sortByName,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_sortByLevel,ComponentHookList.ON_RELEASE);
         this.tx_emblemBack.dispatchMessages = true;
         this.tx_emblemUp.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_emblemBack,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.tx_emblemUp,ComponentHookList.ON_TEXTURE_READY);
         this._data = args[0].alliance;
         this.updateInformations();
      }
      
      public function unload() : void
      {
      }
      
      public function updateGuildLine(data:*, components:*, selected:Boolean) : void
      {
         var icon:EmblemSymbol = null;
         this._compsTxEmblem[components.tx_emblemBackGuild.name] = data;
         this._compsTxEmblem[components.tx_emblemUpGuild.name] = data;
         if(data != null)
         {
            components.lbl_guildName.text = this.chatApi.getGuildLink(data,data.guildName);
            components.lbl_guildLvl.text = data.guildLevel;
            components.tx_emblemBackGuild.uri = data.backEmblem.iconUri;
            components.tx_emblemUpGuild.uri = data.upEmblem.iconUri;
            this.utilApi.changeColor(components.tx_emblemBackGuild,data.backEmblem.color,1);
            icon = this.dataApi.getEmblemSymbol(data.upEmblem.idEmblem);
            if(icon.colorizable)
            {
               this.utilApi.changeColor(components.tx_emblemUpGuild,data.upEmblem.color,0);
            }
            else
            {
               this.utilApi.changeColor(components.tx_emblemUpGuild,data.upEmblem.color,0,true);
            }
         }
         else
         {
            components.lbl_guildName.text = "";
            components.lbl_guildLvl.text = "";
            components.tx_emblemBackGuild.uri = null;
            components.tx_emblemUpGuild.uri = null;
         }
      }
      
      private function updateInformations() : void
      {
         this.lbl_title.text = this._data.allianceName;
         this.lbl_tag.text = "[" + this._data.allianceTag + "]";
         this.lbl_leader.text = "{player," + this._data.leaderCharacterName + "," + this._data.leaderCharacterId + "::" + this._data.leaderCharacterName + "}";
         this.lbl_guilds.text = "" + this._data.nbGuilds;
         this.lbl_members.text = "" + this.utilApi.formateIntToString(this._data.nbMembers);
         if(this._data.prismIds && this._data.prismIds.length)
         {
            this.lbl_areas.text = this.uiApi.getText("ui.prism.nbPrisms",this._data.prismIds.length);
         }
         else
         {
            this.lbl_areas.text = this.uiApi.getText("ui.prism.noPrism");
         }
         this.lbl_creationDate.text = this.timeApi.getDofusDate(this._data.creationDate * 1000);
         this.tx_emblemBack.uri = this._data.backEmblem.fullSizeIconUri;
         this.tx_emblemUp.uri = this._data.upEmblem.fullSizeIconUri;
         this.gd_guilds.dataProvider = this._data.guilds;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_sortByName:
               this.sortGuildsBy("guildName",Array.CASEINSENSITIVE);
               break;
            case this.btn_sortByLevel:
               this.sortGuildsBy("guildLevel",Array.CASEINSENSITIVE);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
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
         var data:Object = this._data;
         if(target.name.indexOf("Guild") != -1)
         {
            data = this._compsTxEmblem[target.name];
         }
         if(target.name.indexOf("tx_emblemBack") != -1)
         {
            this.utilApi.changeColor(target.getChildByName("back"),data.backEmblem.color,1);
         }
         else if(target.name.indexOf("tx_emblemUp") != -1)
         {
            icon = this.dataApi.getEmblemSymbol(data.upEmblem.idEmblem);
            if(icon.colorizable)
            {
               this.utilApi.changeColor(target,data.upEmblem.color,0);
            }
            else
            {
               this.utilApi.changeColor(target,data.upEmblem.color,0,true);
            }
         }
      }
      
      private function onOpenOneAlliance(alliance:Object) : void
      {
         this._data = alliance;
         this.updateInformations();
      }
      
      private function sortGuildsBy(property:String, options:int = 0) : void
      {
         if(this._descendingSort)
         {
            this.gd_guilds.sortOn(property,options | Array.DESCENDING);
         }
         else
         {
            this.gd_guilds.sortOn(property,options);
         }
         this._descendingSort = !this._descendingSort;
      }
   }
}
