package Ankama_Job
{
   import Ankama_Common.Common;
   import Ankama_Job.ui.CheckCraft;
   import Ankama_Job.ui.Craft;
   import Ankama_Job.ui.CraftCoop;
   import Ankama_Job.ui.CrafterForm;
   import Ankama_Job.ui.CrafterList;
   import Ankama_Job.ui.Decraft;
   import Ankama_Job.ui.ItemEffectsModifierUi;
   import Ankama_Job.ui.Recycle;
   import Ankama_Job.ui.RuneMaker;
   import Ankama_Job.ui.SmithMagic;
   import Ankama_Job.ui.SmithMagicCoop;
   import Ankama_Job.ui.items.SmithMagicLogLine;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeAcceptAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeRefuseAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddIgnoredAction;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.NotificationApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class Job extends Sprite
   {
      
      private static var _self:Job;
       
      
      protected var craft:Craft;
      
      protected var decraft:Decraft;
      
      protected var crafterForm:CrafterForm;
      
      protected var crafterList:CrafterList;
      
      protected var craftCoop:CraftCoop;
      
      protected var smithMagic:SmithMagic;
      
      protected var smithMagicCoop:SmithMagicCoop;
      
      protected var checkCraft:CheckCraft;
      
      protected var runeMaker:RuneMaker;
      
      protected var recycle:Recycle;
      
      protected var itemEffectsModifierUi:ItemEffectsModifierUi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="NotificationApi")]
      public var notificationApi:NotificationApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="JobsApi")]
      public var jobsApi:JobsApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _popupName:String;
      
      private var _ignoreName:String;
      
      private var _mageLog:Array;
      
      private var _jobExpByPlayerId:Dictionary;
      
      public function Job()
      {
         this._mageLog = [];
         this._jobExpByPlayerId = new Dictionary();
         super();
      }
      
      public static function getInstance() : Job
      {
         return _self;
      }
      
      public function main() : void
      {
         _self = this;
         this.sysApi.addHook(CraftHookList.ExchangeStartOkCraft,this.onExchangeStartOkCraft);
         this.sysApi.addHook(CraftHookList.ExchangeStartOkMultiCraft,this.onExchangeStartOkMultiCraft);
         this.sysApi.addHook(CraftHookList.ExchangeMultiCraftRequest,this.onExchangeMultiCraftRequest);
         this.sysApi.addHook(CraftHookList.ExchangeStartOkJobIndex,this.onExchangeStartOkJobIndex);
         this.sysApi.addHook(CraftHookList.ExchangeStartOkRunesTrade,this.onExchangeStartOkRunesTrade);
         this.sysApi.addHook(CraftHookList.ExchangeStartOkRecycleTrade,this.onExchangeStartOkRecycleTrade);
         this.sysApi.addHook(CraftHookList.JobsExpOtherPlayerUpdated,this.onJobsExpOtherPlayerUpdated);
         this.sysApi.addHook(CraftHookList.JobLevelUp,this.onJobLevelUp);
         this.sysApi.addHook(ExchangeHookList.ExchangeLeave,this.onExchangeLeave);
      }
      
      public function get mageLog() : Array
      {
         return this._mageLog;
      }
      
      public function addToMageLog(line:SmithMagicLogLine) : void
      {
         this._mageLog.push(line);
      }
      
      public function removeMageLogFirstLine() : void
      {
         do
         {
            this._mageLog.splice(0,1);
         }
         while(this._mageLog[0] == null);
         
      }
      
      public function emptyMageLog() : void
      {
         this._mageLog = [];
      }
      
      public function realMageLogLength() : int
      {
         var length:int = 0;
         for(var i:int = 0; i < this._mageLog.length; i++)
         {
            if(this._mageLog[i] != null)
            {
               length++;
            }
         }
         return length;
      }
      
      private function onExchangeStartOkCraft(skillId:uint) : void
      {
         this.sysApi.disableWorldInteraction();
         var skill:Skill = this.jobsApi.getSkillFromId(skillId);
         if(skill.isForgemagus || skill.modifiableItemTypeIds.length > 0)
         {
            if(!this.uiApi.getUi(UIEnum.SMITH_MAGIC))
            {
               this.uiApi.loadUi(UIEnum.SMITH_MAGIC,UIEnum.SMITH_MAGIC,{"skillId":skillId});
            }
            this.sysApi.dispatchHook(HookList.OpenInventory,"smithMagic",UIEnum.STORAGE_UI);
         }
         else if(skillId == DataEnum.SKILL_SHATTER_ITEM)
         {
            this.uiApi.loadUi(UIEnum.RUNE_MAKER,UIEnum.RUNE_MAKER);
            this.sysApi.dispatchHook(HookList.OpenInventory,"decraft",UIEnum.STORAGE_UI);
         }
         else if(skillId == DataEnum.SKILL_CHINQ)
         {
            this.sysApi.dispatchHook(HookList.OpenChinq);
         }
         else if(skillId == DataEnum.SKILL_MINOUKI)
         {
            if(!this.uiApi.getUi(UIEnum.ITEM_EFFECTS_MODIFIER))
            {
               this.uiApi.loadUi(UIEnum.ITEM_EFFECTS_MODIFIER,UIEnum.ITEM_EFFECTS_MODIFIER);
            }
            this.sysApi.dispatchHook(HookList.OpenInventory,StorageState.ITEM_EFFECTS_MODIFIER_UI_MOD,UIEnum.STORAGE_UI);
         }
         else
         {
            if(!this.uiApi.getUi(UIEnum.CRAFT))
            {
               this.uiApi.loadUi(UIEnum.CRAFT,UIEnum.CRAFT,{"skillId":skillId});
            }
            this.sysApi.dispatchHook(HookList.OpenInventory,"craft",UIEnum.STORAGE_UI);
         }
      }
      
      private function onExchangeStartOkMultiCraft(skillId:int, crafterInfos:Object, customerInfos:Object) : void
      {
         var characterInfos:Object = null;
         this.sysApi.disableWorldInteraction();
         var skill:Skill = this.jobsApi.getSkillFromId(skillId);
         if(this.uiApi.getUi(this._popupName))
         {
            this.uiApi.unloadUi(this._popupName);
         }
         if(skill.isForgemagus)
         {
            if(!this.uiApi.getUi(UIEnum.SMITH_MAGIC_COOP))
            {
               this.uiApi.loadUi(UIEnum.SMITH_MAGIC_COOP,UIEnum.SMITH_MAGIC,{
                  "skillId":skillId,
                  "crafterInfos":crafterInfos,
                  "customerInfos":customerInfos
               });
            }
            characterInfos = this.playerApi.getPlayedCharacterInfo();
            this.sysApi.dispatchHook(HookList.OpenInventory,"smithMagicCoop",UIEnum.STORAGE_UI);
         }
         else
         {
            if(!this.uiApi.getUi(UIEnum.CRAFT_COOP))
            {
               this.uiApi.loadUi(UIEnum.CRAFT_COOP,UIEnum.CRAFT,{
                  "skillId":skillId,
                  "crafterInfos":crafterInfos,
                  "customerInfos":customerInfos,
                  "jobExperience":this._jobExpByPlayerId[crafterInfos.id]
               });
            }
            this.sysApi.dispatchHook(HookList.OpenInventory,"craft",UIEnum.STORAGE_UI);
         }
      }
      
      private function onExchangeMultiCraftRequest(role:int, otherName:String, askerId:Number) : void
      {
         var playedCharacterInfo:Object = this.playerApi.getPlayedCharacterInfo();
         if(askerId == playedCharacterInfo.id)
         {
            this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.exchange"),this.uiApi.getText("ui.craft.waitForCraftClient",otherName),[this.uiApi.getText("ui.common.cancel")],[this.sendActionCraftRefuse],null,this.sendActionCraftRefuse);
         }
         else
         {
            this._ignoreName = otherName;
            if(role == ExchangeTypeEnum.MULTICRAFT_CUSTOMER)
            {
               this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.exchange"),this.uiApi.getText("ui.craft.CrafterAskCustomer",otherName),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no"),this.uiApi.getText("ui.common.ignore")],[this.sendActionCraftAccept,this.sendActionCraftRefuse,this.sendActionIgnore],this.sendActionCraftAccept,this.sendActionCraftRefuse);
            }
            else if(role == ExchangeTypeEnum.MULTICRAFT_CRAFTER)
            {
               this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.exchange"),this.uiApi.getText("ui.craft.CustomerAskCrafter",otherName),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no"),this.uiApi.getText("ui.common.ignore")],[this.sendActionCraftAccept,this.sendActionCraftRefuse,this.sendActionIgnore],this.sendActionCraftAccept,this.sendActionCraftRefuse);
            }
         }
      }
      
      private function onJobLevelUp(jobId:uint, jobName:String, newLevel:uint, podsBonus:uint) : void
      {
         this.notificationApi.showNotification(this.uiApi.getText("ui.craft.jobLevelUp"),this.uiApi.getText("ui.craft.newJobLevel",jobName,newLevel,podsBonus),NotificationTypeEnum.INFORMATION);
      }
      
      private function onExchangeLeave(success:Boolean) : void
      {
         if(this.uiApi.getUi(this._popupName))
         {
            this.uiApi.unloadUi(this._popupName);
         }
      }
      
      private function sendActionCraftAccept() : void
      {
         this.sysApi.sendAction(new ExchangeAcceptAction([]));
      }
      
      private function sendActionCraftRefuse() : void
      {
         this.sysApi.sendAction(new ExchangeRefuseAction([]));
      }
      
      private function sendActionIgnore() : void
      {
         this.sysApi.sendAction(new ExchangeRefuseAction([]));
         this.sysApi.sendAction(new AddIgnoredAction([this._ignoreName]));
      }
      
      public function onExchangeStartOkJobIndex(list:*) : void
      {
         var jobItem:* = undefined;
         var jobIds:Array = [];
         for each(jobItem in list)
         {
            jobIds.push(jobItem);
         }
         this.uiApi.loadUi("crafterList","crafterList",jobIds);
      }
      
      public function onExchangeStartOkRunesTrade() : void
      {
         this.uiApi.loadUi(UIEnum.RUNE_MAKER,UIEnum.RUNE_MAKER);
         this.sysApi.dispatchHook(HookList.OpenInventory,"decraft",UIEnum.STORAGE_UI);
      }
      
      public function onExchangeStartOkRecycleTrade(percentToPlayer:uint, percentToPrism:uint) : void
      {
         this.uiApi.loadUi(UIEnum.RECYCLE,UIEnum.RECYCLE,[percentToPlayer,percentToPrism]);
         this.sysApi.dispatchHook(HookList.OpenInventory,"decraft",UIEnum.STORAGE_UI);
      }
      
      protected function onJobsExpOtherPlayerUpdated(playerId:Number, jobExperience:Object) : void
      {
         this._jobExpByPlayerId[playerId] = jobExperience;
      }
   }
}
