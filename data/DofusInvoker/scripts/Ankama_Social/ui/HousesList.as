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
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkMapPosition;
   import com.ankamagames.dofus.logic.game.common.actions.HouseTeleportRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.utils.Dictionary;
   
   public class HousesList
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      private var _houses:Vector.<HouseWrapper>;
      
      private var _houseUri:String;
      
      private var _myGuild:GuildWrapper;
      
      private var _interactiveComponentsList:Dictionary;
      
      public var ctr_main:GraphicContainer;
      
      public var ctr_window:GraphicContainer;
      
      public var ctr_block:GraphicContainer;
      
      public var tx_bgLight:Texture;
      
      public var ctr_bottom:GraphicContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var gd_houses:Grid;
      
      public var lbl_housesCount:Label;
      
      public function HousesList()
      {
         this._interactiveComponentsList = new Dictionary(true);
         super();
      }
      
      public function main(... params) : void
      {
         this.sysApi.addHook(HookList.OpenHouses,this.onOpenHouses);
         this.sysApi.addHook(HookList.HouseInformations,this.onHouseInformations);
         this.sysApi.addHook(SocialHookList.GuildMembershipUpdated,this.onGuildMembershipUpdated);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this._houseUri = this.uiApi.me().getConstant("houses_uri");
         this._myGuild = this.socialApi.getGuild();
         this._houses = this.playerApi.getPlayerHouses();
         this.displayHouses();
      }
      
      public function updateHouseLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var icon:EmblemSymbol = null;
         if(!this._interactiveComponentsList[componentsRef.lbl_guildShare.name])
         {
            this.uiApi.addComponentHook(componentsRef.lbl_guildShare,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(componentsRef.lbl_guildShare,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.lbl_guildShare,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[componentsRef.lbl_guildShare.name] = data;
         if(!this._interactiveComponentsList[componentsRef.btn_join.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_join,ComponentHookList.ON_RELEASE);
         }
         this._interactiveComponentsList[componentsRef.btn_join.name] = data;
         if(!this._interactiveComponentsList[componentsRef.tx_isLocked.name])
         {
            this.uiApi.addComponentHook(componentsRef.tx_isLocked,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.tx_isLocked,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[componentsRef.tx_isLocked.name] = data;
         if(!this._interactiveComponentsList[componentsRef.tx_isOnSale.name])
         {
            this.uiApi.addComponentHook(componentsRef.tx_isOnSale,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.tx_isOnSale,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[componentsRef.tx_isOnSale.name] = data;
         if(!this._interactiveComponentsList[componentsRef.ctr_emblem.name])
         {
            this.uiApi.addComponentHook(componentsRef.ctr_emblem,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.ctr_emblem,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[componentsRef.ctr_emblem.name] = data;
         if(data)
         {
            componentsRef.lbl_house.text = data.name;
            componentsRef.tx_illu.uri = data.iconUri;
            componentsRef.lbl_loc.text = data.subareaName;
            componentsRef.lbl_coord.text = HyperlinkMapPosition.getLink(int(data.worldX),int(data.worldY),data.worldmapId);
            if(data.houseInstances[0].isLocked)
            {
               componentsRef.tx_isLocked.visible = true;
            }
            else
            {
               componentsRef.tx_isLocked.visible = false;
            }
            if(data.houseInstances[0].price > 0 || !this._myGuild && !data.houseInstances[0].guildIdentity)
            {
               componentsRef.tx_isOnSale.visible = true;
               componentsRef.lbl_guildShare.softDisabled = true;
            }
            else
            {
               componentsRef.tx_isOnSale.visible = false;
               componentsRef.lbl_guildShare.softDisabled = false;
            }
            if(data.houseInstances[0].guildIdentity)
            {
               componentsRef.tx_emblemBack.uri = data.houseInstances[0].guildIdentity.backEmblem.iconUri;
               componentsRef.tx_emblemUp.uri = data.houseInstances[0].guildIdentity.upEmblem.iconUri;
               this.utilApi.changeColor(componentsRef.tx_emblemBack,data.houseInstances[0].guildIdentity.backEmblem.color,1);
               icon = this.dataApi.getEmblemSymbol(data.houseInstances[0].guildIdentity.upEmblem.idEmblem);
               if(icon.colorizable)
               {
                  this.utilApi.changeColor(componentsRef.tx_emblemUp,data.houseInstances[0].guildIdentity.upEmblem.color,0);
               }
               else
               {
                  this.utilApi.changeColor(componentsRef.tx_emblemUp,data.houseInstances[0].guildIdentity.upEmblem.color,0,true);
               }
               componentsRef.ctr_emblem.visible = true;
            }
            else
            {
               componentsRef.ctr_emblem.visible = false;
            }
            componentsRef.lbl_guildShare.visible = true;
            componentsRef.btn_join.visible = true;
         }
         else
         {
            componentsRef.lbl_house.text = "";
            componentsRef.lbl_coord.text = "";
            componentsRef.lbl_loc.text = "";
            componentsRef.tx_illu.uri = null;
            componentsRef.lbl_guildShare.visible = false;
            componentsRef.btn_join.visible = false;
            componentsRef.tx_isLocked.visible = false;
            componentsRef.tx_isOnSale.visible = false;
            componentsRef.ctr_emblem.visible = false;
         }
      }
      
      private function displayHouses() : void
      {
         this.ctr_bottom.visible = false;
         if(this._houses.length == 1)
         {
            if(this.gd_houses.height == this.gd_houses.slotHeight)
            {
               this.gd_houses.dataProvider = this._houses;
               return;
            }
            this.gd_houses.height = this.gd_houses.slotHeight;
            this.ctr_main.height -= this.gd_houses.slotHeight + this.ctr_bottom.height;
            this.ctr_window.height -= this.gd_houses.slotHeight + this.ctr_bottom.height;
            this.ctr_block.height -= this.gd_houses.slotHeight + this.ctr_bottom.height;
            this.tx_bgLight.height -= this.gd_houses.slotHeight;
            this.uiApi.me().render();
         }
         else
         {
            this.ctr_bottom.visible = true;
            this.lbl_housesCount.text = this.uiApi.processText(this.uiApi.getText("ui.house.housesCount",this._houses.length),"m",this._houses.length <= 1,this._houses.length == 0);
         }
         this.gd_houses.dataProvider = this._houses;
      }
      
      private function onOpenHouses() : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      private function onHouseInformations(houses:Vector.<HouseWrapper>) : void
      {
         this._houses = houses;
         if(this._houses && this._houses.length)
         {
            this.displayHouses();
         }
         else
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function onGuildMembershipUpdated(hasGuild:Boolean) : void
      {
         if(hasGuild)
         {
            this._myGuild = this.socialApi.getGuild();
         }
         else
         {
            this._myGuild = null;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:Object = null;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_help:
               this.hintsApi.showSubHints();
               break;
            default:
               if(target.name.indexOf("lbl_guildShare") != -1)
               {
                  data = this._interactiveComponentsList[target.name];
                  if(data)
                  {
                     this.sysApi.dispatchHook(HookList.OpenHouseGuildManager,data);
                  }
               }
               else if(target.name.indexOf("btn_join") != -1)
               {
                  data = this._interactiveComponentsList[target.name];
                  if(data)
                  {
                     this.sysApi.sendAction(new HouseTeleportRequestAction([data.houseId,data.houseInstances[0].id]));
                  }
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var data:Object = null;
         var point:uint = 6;
         var relPoint:uint = 0;
         if(target.name.indexOf("tx_isLocked") != -1)
         {
            tooltipText = this.uiApi.getText("ui.house.isLocked");
         }
         else if(target.name.indexOf("tx_isOnSale") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            if(data)
            {
               tooltipText = this.uiApi.getText("ui.house.isOnSale",this.utilApi.kamasToString(data.houseInstances[0].price));
            }
         }
         else if(target.name.indexOf("ctr_emblem") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            if(data)
            {
               tooltipText = this.uiApi.getText("ui.house.isGuildShared",data.houseInstances[0].guildIdentity.guildName);
            }
         }
         else if(target.name.indexOf("lbl_guildShare") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            if(!data)
            {
               return;
            }
            if(data.houseInstances[0].price > 0)
            {
               tooltipText = this.uiApi.getText("ui.house.noShareWhileOnSale");
            }
            else if(!this._myGuild && !data.houseInstances[0].guildIdentity)
            {
               tooltipText = this.uiApi.getText("ui.house.noShareWhenNoGuild");
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
   }
}
