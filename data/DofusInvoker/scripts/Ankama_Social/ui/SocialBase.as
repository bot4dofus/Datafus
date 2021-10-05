package Ankama_Social.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInsiderInfoRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismFightJoinLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.ContactsListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.EnemiesListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendsListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.SpouseRequestAction;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class SocialBase
   {
      
      private static var _shortcutColor:String;
       
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      private var _currentTabUi:int = -1;
      
      private var _currentSubTabUi:int = -1;
      
      private var _hasGuild:Boolean;
      
      private var _hasAlliance:Boolean;
      
      private var _hasSpouse:Boolean;
      
      public var uiCtr:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_tabFriend:ButtonContainer;
      
      public var btn_tabGuild:ButtonContainer;
      
      public var btn_tabAlliance:ButtonContainer;
      
      public var btn_tabDirectory:ButtonContainer;
      
      public var lbl_btn_tabFriend:Label;
      
      public var lbl_btn_tabGuild:Label;
      
      public var lbl_btn_tabAlliance:Label;
      
      public var lbl_btn_tabDirectory:Label;
      
      public function SocialBase()
      {
         super();
      }
      
      public function main(params:Object) : void
      {
         var shortcut:String = null;
         var restoreSnapshotAfterLoading:Boolean = false;
         var subTab:uint = 0;
         var lastFriendsSubTab:uint = 0;
         this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
         this.soundApi.playSound(SoundTypeEnum.SOCIAL_OPEN);
         this.btn_tabFriend.soundId = SoundEnum.TAB;
         this.btn_tabGuild.soundId = SoundEnum.TAB;
         this.btn_tabAlliance.soundId = SoundEnum.TAB;
         this.btn_tabDirectory.soundId = SoundEnum.TAB;
         this.sysApi.addHook(SocialHookList.SpouseUpdated,this.onSpouseUpdated);
         this.sysApi.addHook(SocialHookList.GuildMembershipUpdated,this.onGuildMembershipUpdated);
         this.sysApi.addHook(SocialHookList.AllianceMembershipUpdated,this.onAllianceMembershipUpdated);
         this.uiApi.addComponentHook(this.btn_tabFriend,"onRelease");
         this.uiApi.addComponentHook(this.btn_tabFriend,"onRollOver");
         this.uiApi.addComponentHook(this.btn_tabFriend,"onRollOut");
         this.uiApi.addComponentHook(this.btn_tabGuild,"onRelease");
         this.uiApi.addComponentHook(this.btn_tabGuild,"onRollOver");
         this.uiApi.addComponentHook(this.btn_tabGuild,"onRollOut");
         this.uiApi.addComponentHook(this.btn_tabAlliance,"onRelease");
         this.uiApi.addComponentHook(this.btn_tabAlliance,"onRollOver");
         this.uiApi.addComponentHook(this.btn_tabAlliance,"onRollOut");
         this.uiApi.addComponentHook(this.btn_tabDirectory,"onRelease");
         this.uiApi.addComponentHook(this.btn_tabDirectory,"onRollOver");
         this.uiApi.addComponentHook(this.btn_tabDirectory,"onRollOut");
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.uiApi.addComponentHook(this.btn_help,"onRelease");
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("openSocialFriends",this.onShortcut);
         this.uiApi.addShortcutHook("openSocialGuild",this.onShortcut);
         this.uiApi.addShortcutHook("openSocialAlliance",this.onShortcut);
         this._hasGuild = this.socialApi.hasGuild();
         this._hasAlliance = this.socialApi.hasAlliance();
         this._hasSpouse = this.socialApi.hasSpouse();
         this.displayTabs();
         this._currentTabUi = -2;
         if(params && params.hasOwnProperty("tab"))
         {
            if(params.hasOwnProperty("subTab"))
            {
               restoreSnapshotAfterLoading = this.uiApi.me().restoreSnapshotAfterLoading;
               if(params.hasOwnProperty("restoreSnapshotAfterLoading"))
               {
                  restoreSnapshotAfterLoading = params.restoreSnapshotAfterLoading;
               }
               if(params.hasOwnProperty("params") && params.params != null)
               {
                  this.openTab(params.tab,params.subTab,params.params,restoreSnapshotAfterLoading);
               }
               else
               {
                  this.openTab(params.tab,params.subTab,null,restoreSnapshotAfterLoading);
               }
            }
            else
            {
               subTab = 0;
               if(params.tab == DataEnum.SOCIAL_TAB_FRIENDS_ID)
               {
                  lastFriendsSubTab = this.sysApi.getData("lastFriendsSubTab");
                  if(lastFriendsSubTab)
                  {
                     subTab = lastFriendsSubTab;
                     this.setSubTab(subTab);
                  }
               }
               this.openTab(params.tab,subTab,null,false);
            }
         }
         else
         {
            this.openTab(-1);
         }
         if(!_shortcutColor)
         {
            _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
            _shortcutColor = _shortcutColor.replace("0x","#");
         }
         this.lbl_btn_tabFriend.text = this.uiApi.getText("ui.common.friends");
         shortcut = this.bindsApi.getShortcutBindStr("openSocialFriends");
         if(shortcut != "")
         {
            this.lbl_btn_tabFriend.text += " <font color=\'" + _shortcutColor + "\'>(" + shortcut + ")</font>";
         }
         this.lbl_btn_tabGuild.text = this.uiApi.getText("ui.common.guild");
         shortcut = this.bindsApi.getShortcutBindStr("openSocialGuild");
         if(shortcut != "")
         {
            this.lbl_btn_tabGuild.text += " <font color=\'" + _shortcutColor + "\'>(" + shortcut + ")</font>";
         }
         this.lbl_btn_tabAlliance.text = this.uiApi.getText("ui.common.alliance");
         shortcut = this.bindsApi.getShortcutBindStr("openSocialAlliance");
         if(shortcut != "")
         {
            this.lbl_btn_tabAlliance.text += " <font color=\'" + _shortcutColor + "\'>(" + shortcut + ")</font>";
         }
         this.lbl_btn_tabDirectory.text = this.uiApi.getText("ui.common.directory");
      }
      
      public function unload() : void
      {
         this.sysApi.sendAction(new GuildFightLeaveRequestAction([0,this.playerApi.id(),true]));
         this.sysApi.sendAction(new PrismFightJoinLeaveRequestAction([0,false]));
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
         this.closeTab(this._currentTabUi);
      }
      
      public function getTab() : int
      {
         return this._currentTabUi;
      }
      
      public function getSubTab() : int
      {
         return this._currentSubTabUi;
      }
      
      public function setSubTab(subTab:int) : void
      {
         this._currentSubTabUi = subTab;
         if(this._currentTabUi == DataEnum.SOCIAL_TAB_FRIENDS_ID)
         {
            this.sysApi.setData("lastFriendsSubTab",this._currentSubTabUi);
         }
      }
      
      private function displayTabs() : void
      {
         if(this.btn_tabGuild.softDisabled == this._hasGuild)
         {
            this.btn_tabGuild.softDisabled = !this._hasGuild;
         }
         if(this.btn_tabAlliance.softDisabled == this._hasAlliance)
         {
            this.btn_tabAlliance.softDisabled = !this._hasAlliance;
         }
         if(this._currentTabUi == 1 && this.btn_tabGuild.softDisabled)
         {
            this.openTab(0);
         }
         if(this._currentTabUi == 2 && this.btn_tabAlliance.softDisabled)
         {
            this.openTab(0);
         }
      }
      
      public function openTab(tab:int = -1, subTab:int = 0, params:Object = null, restoreSnapshot:Boolean = true) : void
      {
         var lastTab:uint = 0;
         if(tab != -1 && (this._currentTabUi == tab && this._currentSubTabUi == subTab || this.getButtonByTab(tab).disabled || this.getButtonByTab(tab).softDisabled))
         {
            return;
         }
         if(this._currentTabUi > -1)
         {
            this.uiApi.unloadUi("subSocialUi");
         }
         if(tab == -1)
         {
            lastTab = this.sysApi.getData("lastSocialTab");
            if(lastTab && this.getButtonByTab(lastTab) && !this.getButtonByTab(lastTab).disabled)
            {
               this._currentTabUi = lastTab;
            }
            else
            {
               this._currentTabUi = DataEnum.SOCIAL_TAB_FRIENDS_ID;
            }
            if(lastTab && (lastTab == DataEnum.SOCIAL_TAB_GUILD_ID && !this.socialApi.hasGuild() || lastTab == DataEnum.SOCIAL_TAB_ALLIANCE_ID && !this.socialApi.hasAlliance()))
            {
               this._currentTabUi = DataEnum.SOCIAL_TAB_FRIENDS_ID;
            }
         }
         else
         {
            this._currentTabUi = tab;
         }
         if(this._currentTabUi == DataEnum.SOCIAL_TAB_FRIENDS_ID)
         {
            this.sysApi.sendAction(new FriendsListRequestAction([]));
            this.sysApi.sendAction(new ContactsListRequestAction([]));
            this.sysApi.sendAction(new EnemiesListRequestAction([]));
         }
         else if(this._currentTabUi == DataEnum.SOCIAL_TAB_ALLIANCE_ID)
         {
            this.sysApi.sendAction(new AllianceInsiderInfoRequestAction([]));
         }
         else if(this._currentTabUi == DataEnum.SOCIAL_TAB_SPOUSE_ID)
         {
            this.sysApi.sendAction(new SpouseRequestAction([]));
         }
         else if(this._currentTabUi == DataEnum.SOCIAL_TAB_DIRECTORY_ID)
         {
         }
         this.sysApi.setData("lastSocialTab",this._currentTabUi);
         this.uiCtr.getUi().restoreSnapshotAfterLoading = restoreSnapshot;
         this.uiApi.loadUiInside(this.getUiNameByTab(this._currentTabUi),this.uiCtr,"subSocialUi",[subTab,params]);
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.getButtonByTab(this._currentTabUi),this.uiApi.me());
         this.getButtonByTab(this._currentTabUi).selected = true;
      }
      
      private function closeTab(tab:uint) : void
      {
         this.uiApi.unloadUi("subSocialUi");
      }
      
      private function getButtonByTab(tab:uint) : ButtonContainer
      {
         var returnButton:ButtonContainer = null;
         switch(tab)
         {
            case DataEnum.SOCIAL_TAB_FRIENDS_ID:
               returnButton = this.btn_tabFriend;
               break;
            case DataEnum.SOCIAL_TAB_GUILD_ID:
               returnButton = this.btn_tabGuild;
               break;
            case DataEnum.SOCIAL_TAB_ALLIANCE_ID:
               returnButton = this.btn_tabAlliance;
               break;
            case DataEnum.SOCIAL_TAB_DIRECTORY_ID:
               returnButton = this.btn_tabDirectory;
         }
         return returnButton;
      }
      
      private function getUiNameByTab(tab:uint) : String
      {
         switch(tab)
         {
            case DataEnum.SOCIAL_TAB_FRIENDS_ID:
               return "friends";
            case DataEnum.SOCIAL_TAB_GUILD_ID:
               return "guild";
            case DataEnum.SOCIAL_TAB_ALLIANCE_ID:
               return "alliance";
            case DataEnum.SOCIAL_TAB_SPOUSE_ID:
               return "spouse";
            case DataEnum.SOCIAL_TAB_DIRECTORY_ID:
               return "directory";
            default:
               return "";
         }
      }
      
      private function closeSocial() : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      private function onGuildMembershipUpdated(hasGuild:Boolean) : void
      {
         this._hasGuild = hasGuild;
         this.displayTabs();
      }
      
      private function onAllianceMembershipUpdated(hasAlliance:Boolean) : void
      {
         this._hasAlliance = hasAlliance;
         this.displayTabs();
      }
      
      private function onSpouseUpdated() : void
      {
         this._hasSpouse = this.socialApi.hasSpouse();
         this.displayTabs();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.closeSocial();
               break;
            case this.btn_help:
               this.uiApi.me().childUiRoot.uiClass.selectWhichTabHintsToDisplay();
               break;
            case this.btn_tabFriend:
               this.openTab(DataEnum.SOCIAL_TAB_FRIENDS_ID);
               break;
            case this.btn_tabGuild:
               this.openTab(DataEnum.SOCIAL_TAB_GUILD_ID);
               break;
            case this.btn_tabAlliance:
               this.openTab(DataEnum.SOCIAL_TAB_ALLIANCE_ID);
               break;
            case this.btn_tabDirectory:
               this.openTab(DataEnum.SOCIAL_TAB_DIRECTORY_ID);
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "openSocialFriends":
               if(this._currentTabUi == DataEnum.SOCIAL_TAB_FRIENDS_ID)
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               else
               {
                  this.openTab(DataEnum.SOCIAL_TAB_FRIENDS_ID);
               }
               return true;
            case "openSocialGuild":
               if(this._currentTabUi == DataEnum.SOCIAL_TAB_GUILD_ID)
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               else
               {
                  this.openTab(DataEnum.SOCIAL_TAB_GUILD_ID);
               }
               return true;
            case "openSocialAlliance":
               if(this._currentTabUi == DataEnum.SOCIAL_TAB_ALLIANCE_ID)
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               else
               {
                  this.openTab(DataEnum.SOCIAL_TAB_ALLIANCE_ID);
               }
               return true;
            case "closeUi":
               this.closeSocial();
               return true;
            default:
               return false;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var point:uint = LocationEnum.POINT_LEFT;
         var relPoint:uint = LocationEnum.POINT_RIGHT;
         var description:String = "";
         var tooltipTxt:String = "";
         switch(target)
         {
            case this.btn_tabGuild:
               description = this.uiApi.getText("ui.banner.lockBtn.guild");
               break;
            case this.btn_tabAlliance:
               description = this.uiApi.getText("ui.banner.lockBtn.alliance");
         }
         if(target.softDisabled)
         {
            if(description)
            {
               tooltipTxt = description;
            }
         }
         if(tooltipTxt && tooltipTxt != "")
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipTxt),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
   }
}
