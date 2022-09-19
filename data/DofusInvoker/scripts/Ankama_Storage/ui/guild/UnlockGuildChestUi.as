package Ankama_Storage.ui.guild
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.InputComboBox;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.logic.game.common.actions.StartGuildChestContributionAction;
   import com.ankamagames.dofus.logic.game.common.actions.StopGuildChestContributionAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetChestTabContributionsRequestAction;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.network.types.game.guild.Contribution;
   import com.ankamagames.dofus.network.types.game.guild.GuildMember;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class UnlockGuildChestUi
   {
       
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      public var btn_close:ButtonContainer;
      
      public var btn_contribute:ButtonContainer;
      
      public var btn_contributors:ButtonContainer;
      
      public var inp_myContribution:InputComboBox;
      
      public var lbl_totalContribution:Label;
      
      public var lbl_totalToUnlock:Label;
      
      public var lbl_error:Label;
      
      public var tx_kamaTotalContribution:Texture;
      
      public var tx_kamaTotalToUnlock:Texture;
      
      private var _proposedContribution:Array;
      
      private var _totalToUnlock:uint = 0;
      
      private var _totalContributions:uint = 0;
      
      private var _myContribution:uint = 0;
      
      private var _enrollmentDelay:Number = 0;
      
      private var _contributionDelay:Number = 0;
      
      private var _contributions:Vector.<Contribution>;
      
      public function UnlockGuildChestUi()
      {
         this._proposedContribution = [{
            "label":"5 000",
            "value":5000
         },{
            "label":"50 000",
            "value":50000
         },{
            "label":"500 000",
            "value":500000
         }];
         this._contributions = new Vector.<Contribution>();
         super();
      }
      
      public function main(params:Object) : void
      {
         this.sysApi.sendAction(StartGuildChestContributionAction.create());
         this._totalToUnlock = params.requiredAmount;
         this._totalContributions = params.currentAmount;
         this._enrollmentDelay = 0;
         this._contributionDelay = 0;
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this.sysApi.addHook(ExchangeHookList.GuildChestContributions,this.onGuildChestContributions);
         this.sysApi.addHook(InventoryHookList.KamasUpdate,this.onKamasUpdate);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_contribute,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_contributors,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_myContribution.list,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.inp_myContribution.input,ComponentHookList.ON_CHANGE);
         this.lbl_totalContribution.text = this.utilApi.kamasToString(this._totalContributions,"");
         this.lbl_totalToUnlock.text = this.uiApi.getText("ui.guild.nextChestUnlockAt",this.utilApi.kamasToString(this._totalToUnlock,""));
         this.inp_myContribution.dataProvider = this._proposedContribution;
         this.inp_myContribution.selectedIndex = 0;
         this.inp_myContribution.input.focus();
         this.checkMyContribution(this.inp_myContribution.selectedItem.value);
         this.updateContributeButton();
      }
      
      public function onUiLoaded(uiName:String) : void
      {
         if(uiName == this.uiApi.me().name)
         {
            this.tx_kamaTotalContribution.x = this.lbl_totalContribution.x + this.lbl_totalContribution.width / 2 + this.lbl_totalContribution.textWidth / 2;
            this.tx_kamaTotalToUnlock.x = this.lbl_totalToUnlock.x + this.lbl_totalToUnlock.width / 2 + this.lbl_totalToUnlock.textWidth / 2;
            this.sysApi.sendAction(GuildGetChestTabContributionsRequestAction.create());
         }
      }
      
      public function unload() : void
      {
         this.sysApi.sendAction(StopGuildChestContributionAction.create());
      }
      
      public function updateContribution(params:Object) : void
      {
         this._totalToUnlock = params.requiredAmount;
         this._totalContributions = params.currentAmount;
         this._enrollmentDelay = params.enrollmentDelay;
         this._contributionDelay = params.contributionDelay;
         this.lbl_totalContribution.text = this.utilApi.kamasToString(this._totalContributions,"");
         this.lbl_totalToUnlock.text = this.uiApi.getText("ui.guild.nextChestUnlockAt",this.utilApi.kamasToString(this._totalToUnlock,""));
         this.tx_kamaTotalContribution.x = this.lbl_totalContribution.x + this.lbl_totalContribution.width / 2 + this.lbl_totalContribution.textWidth / 2;
         this.tx_kamaTotalToUnlock.x = this.lbl_totalToUnlock.x + this.lbl_totalToUnlock.width / 2 + this.lbl_totalToUnlock.textWidth / 2;
         this.sysApi.sendAction(GuildGetChestTabContributionsRequestAction.create());
         this.updateContributeButton();
      }
      
      private function checkMyContribution(contribution:uint) : void
      {
         this._myContribution = Math.max(0,Math.min(contribution,this._totalToUnlock - this._totalContributions));
      }
      
      private function updateContributeButton() : void
      {
         this.btn_contribute.softDisabled = this._myContribution <= 0 || this._myContribution > this.playerApi.characteristics().kamas || this.playerApi.hasDebt() || !this.canContributeToday() || this.isNewGuildMember();
         this.lbl_error.visible = this.btn_contribute.softDisabled;
         if(this.playerApi.hasDebt())
         {
            this.lbl_error.text = this.uiApi.getText("ui.guild.chest.cantContribute.debt");
         }
         else if(this.isNewGuildMember())
         {
            this.lbl_error.text = this.uiApi.getText("ui.guild.chest.cantContribute.enrollmentDate");
         }
         else if(!this.canContributeToday())
         {
            this.lbl_error.text = this.uiApi.getText("ui.guild.chest.cantContribute.day");
         }
         else if(this._myContribution > this.playerApi.characteristics().kamas)
         {
            this.lbl_error.text = this.uiApi.getText("ui.guild.chest.cantContribute.notEnoughtKamas");
         }
         else
         {
            this.lbl_error.text = "";
         }
      }
      
      private function canContributeToday() : Boolean
      {
         var lastContributionDate:Number = this.playerApi.guildChestLastContributionDate();
         var timeZoneEffect:Number = this.timeApi.getTimezoneOffset() / TimeApi.HOUR_TO_MILLISECOND;
         var lastContributionDay:Date = new Date(lastContributionDate);
         lastContributionDay.setHours(timeZoneEffect,0,0,0);
         var nextContributionDate:Number = lastContributionDay.time + this._contributionDelay;
         var currentDate:Date = new Date();
         return lastContributionDate == 0 || this._contributionDelay == 0 || currentDate.time >= nextContributionDate;
      }
      
      private function isNewGuildMember() : Boolean
      {
         var myMemberInfo:GuildMember = null;
         var myId:Number = NaN;
         var memberInfo:GuildMember = null;
         var currentDate:Date = null;
         var currentTimestamp:Number = NaN;
         var enrollmentTimestamp:Number = NaN;
         if(this.socialApi.hasGuild())
         {
            myId = this.playerApi.id();
            for each(memberInfo in this.socialApi.getGuildMembers())
            {
               if(memberInfo.id == myId)
               {
                  myMemberInfo = memberInfo;
                  break;
               }
            }
            currentDate = new Date();
            currentTimestamp = currentDate.time;
            enrollmentTimestamp = myMemberInfo.enrollmentDate;
            return currentTimestamp - this._enrollmentDelay < enrollmentTimestamp;
         }
         return true;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_contribute:
               this.uiApi.loadUi(UIEnum.GUILD_CHEST_CONTRIBUTE_POPUP,UIEnum.GUILD_CHEST_CONTRIBUTE_POPUP,{"myContribution":this._myContribution});
               break;
            case this.btn_contributors:
               if(!this.uiApi.getUi(UIEnum.GUILD_CHEST_CONTRIBUTIONS))
               {
                  this.uiApi.loadUi(UIEnum.GUILD_CHEST_CONTRIBUTIONS,UIEnum.GUILD_CHEST_CONTRIBUTIONS,this._contributions);
               }
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         switch(target)
         {
            case this.inp_myContribution.list:
               if(selectMethod == GridItemSelectMethodEnum.CLICK)
               {
                  this.inp_myContribution.input.text = this.utilApi.kamasToString(this.inp_myContribution.selectedItem.value,"");
                  this.updateContributeButton();
               }
         }
      }
      
      public function onChange(target:Object) : void
      {
         if(target != this.inp_myContribution.input)
         {
            return;
         }
         if(this.inp_myContribution.input.text != this.utilApi.kamasToString(this._myContribution,""))
         {
            this.checkMyContribution(this.utilApi.stringToKamas(this.inp_myContribution.input.text,""));
            this.inp_myContribution.input.text = this.utilApi.kamasToString(this._myContribution,"");
            this.updateContributeButton();
         }
      }
      
      private function onGuildChestContributions(contributions:Vector.<Contribution>) : void
      {
         this.btn_contributors.visible = contributions.length > 0;
         this._contributions = contributions;
      }
      
      private function onKamasUpdate(kama:Number) : void
      {
         this.updateContributeButton();
      }
   }
}
