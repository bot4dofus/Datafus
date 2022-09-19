package Ankama_Tutorial.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_Tutorial.Api;
   import Ankama_Tutorial.TutorialConstants;
   import Ankama_Tutorial.managers.TutorialStepManager;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.ProgressBar;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.datacenter.quest.QuestStep;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.quest.GuidedModeQuitRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.GuidedModeReturnRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestInfosRequestAction;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.QuestApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   
   public class TutorialUi
   {
       
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="QuestApi")]
      public var questApi:QuestApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      public var ctr_joinTutorial:GraphicContainer;
      
      public var ctr_quest:GraphicContainer;
      
      public var ctr_reward:GraphicContainer;
      
      public var lbl_stepName:Label;
      
      public var lbl_expRewardValue:Label;
      
      public var tx_expRewardIcon:TextureBitmap;
      
      public var slot_reward1:Slot;
      
      public var texta_description:Label;
      
      public var pb_progressBar:ProgressBar;
      
      public var btn_close_ctr_quest:ButtonContainer;
      
      public var btn_joinTutorial:ButtonContainer;
      
      public var tx_stepImage:Texture;
      
      private var _iconTexture:Texture;
      
      private var _tutorialManager:Object;
      
      private var _questInfo:Object;
      
      private var _quest:Quest;
      
      private var _currentStepNumber:uint;
      
      private var _tipsUiClass:TipsUi = null;
      
      private var _heightBackground:int;
      
      private var _yReward:int;
      
      private var _yProgress:int;
      
      private var _popupName:String;
      
      private var _unloading:Boolean = false;
      
      public function TutorialUi()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         this.sysApi.addHook(QuestHookList.QuestStarted,this.onQuestStarted);
         this.sysApi.addHook(QuestHookList.QuestInfosUpdated,this.onQuestInfosUpdated);
         this.sysApi.addHook(QuestHookList.QuestStepValidated,this.onQuestStepValidated);
         this.sysApi.addHook(HookList.GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(HookList.GameFightJoin,this.onGameFightJoin);
         this.sysApi.addHook(ExchangeHookList.ExchangeLeave,this.onExchangeLeave);
         this.sysApi.addHook(ExchangeHookList.ExchangeStarted,this.onExchangeStarted);
         this.sysApi.addHook(ExchangeHookList.ExchangeStartOkHumanVendor,this.onExchangeStartOkHumanVendor);
         this.sysApi.addHook(ExchangeHookList.ExchangeShopStockStarted,this.onExchangeShopStockStarted);
         this.sysApi.addHook(ExchangeHookList.ExchangeStartOkNpcTrade,this.onExchangeStartOkNpcTrade);
         this.sysApi.addHook(HookList.GameRolePlayPlayerLifeStatus,this.onGameRolePlayPlayerLifeStatus);
         this.sysApi.addHook(RoleplayHookList.TeleportDestinationList,this.onTeleportDestinationList);
         this.sysApi.addHook(CraftHookList.ExchangeStartOkCraft,this.onExchangeStartOkCraft);
         this.sysApi.addHook(ExchangeHookList.ExchangeStartOkNpcShop,this.onExchangeStartOkNpcShop);
         this.sysApi.addHook(RoleplayHookList.DocumentReadingBegin,this.onDocumentReadingBegin);
         this.sysApi.addHook(RoleplayHookList.NpcDialogCreation,this.onNpcDialogCreation);
         this.sysApi.addHook(HookList.LeaveDialog,this.onLeaveDialog);
         if(this.uiApi.getUi("tips"))
         {
            this._tipsUiClass = this.uiApi.getUi("tips").uiClass;
         }
         else
         {
            this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         }
         this._heightBackground = this.uiApi.me().getConstant("height_background");
         this._yReward = this.uiApi.me().getConstant("y_reward");
         this._yProgress = this.uiApi.me().getConstant("y_progress");
         TutorialStepManager.initStepManager();
         this._tutorialManager = TutorialStepManager.getInstance();
         var bannerMenu:UiRootContainer = this.uiApi.getUi("bannerMenu");
         if(bannerMenu)
         {
            this._tutorialManager.bannerMenuUiClass = bannerMenu.uiClass;
         }
         this._tutorialManager.disabled = false;
         if(!this._tutorialManager.preloaded)
         {
            this._tutorialManager.preload();
         }
         this.uiApi.addComponentHook(this.slot_reward1,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.slot_reward1,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.slot_reward1,ComponentHookList.ON_RIGHT_CLICK);
         this.uiApi.addComponentHook(this.slot_reward1,ComponentHookList.ON_RELEASE);
         this._iconTexture = this.uiApi.createComponent("Texture") as Texture;
         this._iconTexture.width = this.slot_reward1.icon.width;
         this._iconTexture.height = this.slot_reward1.icon.height;
         this.uiApi.addChild(this.uiApi.getUi(UIEnum.BANNER),this._iconTexture);
         if(param[0])
         {
            this.displayTutorial(false);
         }
         else
         {
            this.closeTutorial();
         }
         this.moveDefault();
      }
      
      public function get tutorialDisabled() : Boolean
      {
         return this._tutorialManager.disabled;
      }
      
      public function get quest() : Quest
      {
         if(!this._quest)
         {
            this._quest = this.dataApi.getQuest(TutorialConstants.QUEST_TUTORIAL_ID);
         }
         return this._quest;
      }
      
      public function unload() : void
      {
         this._unloading = true;
         if(this._tutorialManager)
         {
            if(!this._tutorialManager.disabled)
            {
               this._tutorialManager.disabled = true;
               this._tutorialManager.removeHooks();
            }
            this._tutorialManager.unload();
            this._tutorialManager = null;
         }
         this.showHud(false,true);
         var tipsUi:TipsUi = this.getTipsUi();
         if(tipsUi)
         {
            tipsUi.activate();
         }
         if(this.sysApi && this.questApi && this.questApi.getRewardableAchievements() && this.questApi.getRewardableAchievements().length > 0)
         {
            this.sysApi.dispatchHook(QuestHookList.RewardableAchievementsVisible,true);
         }
         if(Api.highlight)
         {
            Api.highlight.stop();
         }
         this.uiApi.removeChild(this.uiApi.getUi(UIEnum.BANNER),this._iconTexture);
         this.uiApi.unloadUi(this._popupName);
      }
      
      public function onQuestStarted(questId:uint) : void
      {
         if(questId == TutorialConstants.QUEST_TUTORIAL_ID)
         {
            this.sysApi.sendAction(new QuestInfosRequestAction([TutorialConstants.QUEST_TUTORIAL_ID]));
         }
      }
      
      public function moveLeft() : void
      {
         this.ctr_quest.x = 5;
         this.ctr_quest.y = 15;
      }
      
      public function moveDefault() : void
      {
         this.ctr_quest.x = 850;
         this.ctr_quest.y = 15;
      }
      
      private function onQuestStepValidated(questId:uint, stepId:uint) : void
      {
         this.sysApi.sendAction(new QuestInfosRequestAction([questId]));
      }
      
      private function onQuestInfosUpdated(questId:uint, infosAvailable:Boolean) : void
      {
         var stepId:uint = 0;
         if(questId == TutorialConstants.QUEST_TUTORIAL_ID && infosAvailable && !this._tutorialManager.disabled)
         {
            if(this.questApi.getRewardableAchievements() && this.questApi.getRewardableAchievements().length > 0)
            {
               this.sysApi.dispatchHook(QuestHookList.RewardableAchievementsVisible,false);
            }
            this._questInfo = this.questApi.getQuestInformations(questId);
            this._quest = this.dataApi.getQuest(this._questInfo.questId);
            this._currentStepNumber = 0;
            for each(stepId in this.quest.stepIds)
            {
               if(stepId == this._questInfo.stepId)
               {
                  break;
               }
               ++this._currentStepNumber;
            }
            this.showHud(this._currentStepNumber > 1,false);
            if(questId == 489 && !this._tutorialManager.doneIntroStep && this._currentStepNumber <= 1)
            {
               this._tutorialManager.jumpToStep(0);
            }
            else
            {
               this._tutorialManager.jumpToStep(this._currentStepNumber + 1);
            }
            this.setStep(this._currentStepNumber);
            this.ctr_quest.visible = this.visible;
         }
      }
      
      private function onUiLoaded(name:String) : void
      {
         var tipsUi:TipsUi = null;
         if(name == "tips" && !this._tutorialManager.disabled)
         {
            tipsUi = this.getTipsUi();
            if(tipsUi)
            {
               tipsUi.deactivate();
            }
         }
         this.sysApi.dispatchHook(QuestHookList.RewardableAchievementsVisible,false);
      }
      
      private function setStep(stepCount:int) : void
      {
         var iw:ItemWrapper = null;
         var steps:Vector.<uint> = this.quest.stepIds;
         var stepId:uint = steps[stepCount];
         var step:QuestStep = this.dataApi.getQuestStep(stepId);
         this.lbl_stepName.text = step.name;
         this.texta_description.text = step.description;
         this.tx_stepImage.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + "tutorial/illu_tuto_" + (stepCount + 1) + ".png");
         var textHeight:int = this.texta_description.textHeight + 10;
         this.ctr_quest.height = this._heightBackground + textHeight;
         this.ctr_reward.y = this.texta_description.y + 5 + textHeight;
         if(this._iconTexture)
         {
            this._iconTexture.y = this.ctr_quest.y + (this._yReward + this.texta_description.textHeight + 10) + this.slot_reward1.y;
         }
         var maxSteps:int = steps.length;
         this.pb_progressBar.value = stepCount / maxSteps;
         if(step.experienceReward > 0 && this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.CHARACTER_XP))
         {
            this.lbl_expRewardValue.text = step.experienceReward.toString();
            this.lbl_expRewardValue.visible = true;
            this.tx_expRewardIcon.visible = true;
         }
         else
         {
            this.lbl_expRewardValue.visible = false;
            this.tx_expRewardIcon.visible = false;
         }
         if(step.itemsReward && step.itemsReward.length > 0)
         {
            this.slot_reward1.visible = true;
            iw = this.dataApi.getItemWrapper(step.itemsReward[0][0]);
            this.slot_reward1.data = iw;
         }
         else
         {
            this.slot_reward1.visible = false;
            this.slot_reward1.data = null;
         }
         this.uiApi.me().render();
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.slot_reward1:
               if((target as Slot).data)
               {
                  this.uiApi.showTooltip((target as Slot).data,target,false,"standard",0,2,3,null,null,{
                     "showEffects":true,
                     "header":true,
                     "averagePrice":false
                  },"ItemInfo" + (target as Slot).data.objectGID);
               }
               break;
            case this.btn_joinTutorial:
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.tutorial.joinTutorialTooltip")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
               break;
            case this.btn_close_ctr_quest:
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.tutorial.leaveTutorialTooltip")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         var data:Object = null;
         var contextMenu:ContextMenuData = null;
         if(target == this.slot_reward1)
         {
            data = (target as Slot).data;
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_joinTutorial:
               this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.tutorial.tutorial"),this.uiApi.getText("ui.tutorial.joinTutorialPopup"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onJoinTutorial,this.nullFunction],this.onJoinTutorial,this.nullFunction);
               break;
            case this.btn_close_ctr_quest:
               this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.tutorial.tutorial"),this.uiApi.getText("ui.tutorial.closeTutorialPopup"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onCloseTutorial,this.nullFunction],this.onCloseTutorial,this.nullFunction);
         }
      }
      
      public function onItemRollOver(target:Grid, item:GridItem) : void
      {
         if(item.data)
         {
            this.uiApi.showTooltip(item.data,item.container,false,"standard",8,0,0,"itemName",null,{
               "showEffects":true,
               "header":true
            },"ItemInfo");
         }
      }
      
      public function onItemRollOut(target:Grid, item:GridItem) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onJoinTutorial() : void
      {
         if(this._unloading)
         {
            return;
         }
         this.sysApi.sendAction(new GuidedModeReturnRequestAction([]));
         this.sysApi.dispatchHook(QuestHookList.RewardableAchievementsVisible,false);
      }
      
      public function onCloseTutorial() : void
      {
         if(this._unloading)
         {
            return;
         }
         this.sysApi.sendAction(new GuidedModeQuitRequestAction([]));
         if(this.questApi.getRewardableAchievements().length > 0)
         {
            this.sysApi.dispatchHook(QuestHookList.RewardableAchievementsVisible,true);
         }
      }
      
      public function displayTutorial(visible:Boolean = true) : void
      {
         var uirc:UiRootContainer = null;
         var tipsUi:TipsUi = null;
         this.sysApi.sendAction(new QuestInfosRequestAction([TutorialConstants.QUEST_TUTORIAL_ID]));
         this.ctr_joinTutorial.visible = false;
         this.ctr_quest.visible = visible;
         var uish:Array = this.hintsApi.getAllOpenedUiWithSubHints();
         for each(uirc in uish)
         {
            uirc.getElement("btn_help").visible = false;
         }
         this._tutorialManager.disabled = false;
         tipsUi = this.getTipsUi();
         if(tipsUi)
         {
            tipsUi.deactivate();
         }
      }
      
      public function get visible() : Boolean
      {
         return !this._tutorialManager.disabled;
      }
      
      public function closeTutorial() : void
      {
         var uirc:UiRootContainer = null;
         var tipsUi:TipsUi = null;
         this.showHud(false,true);
         this.ctr_quest.visible = false;
         this.ctr_joinTutorial.visible = true;
         this._tutorialManager.disabled = true;
         var uish:Array = this.hintsApi.getAllOpenedUiWithSubHints();
         for each(uirc in uish)
         {
            uirc.getElement("btn_help").visible = true;
         }
         tipsUi = this.getTipsUi();
         if(tipsUi)
         {
            tipsUi.activate();
         }
         Api.highlight.stop();
      }
      
      private function getTipsUi() : TipsUi
      {
         var tipsUi:UiRootContainer = this.uiApi.getUi("tips");
         if(tipsUi)
         {
            this._tipsUiClass = tipsUi.uiClass;
            if(this._tipsUiClass)
            {
               return this._tipsUiClass;
            }
         }
         return null;
      }
      
      private function showHud(show:Boolean = false, endTuto:Boolean = false) : void
      {
         var uirc:UiRootContainer = null;
         var uiArr:Array = this.uiApi.getHud();
         for each(uirc in uiArr)
         {
            if(uirc)
            {
               if(endTuto)
               {
                  if(uirc.uiData.name == "questList")
                  {
                     uirc.uiClass.visible = true;
                     uirc.uiClass.unfollowQuest(null);
                  }
                  else if(uirc.uiData.name == "questListMinimized" && uirc.uiClass)
                  {
                     uirc.uiClass.visible = true;
                  }
                  else
                  {
                     uirc.visible = true;
                  }
               }
               else if(show)
               {
                  uirc.visible = uirc.uiData.name == "banner" || uirc.uiData.name == "bannerMenu" || uirc.uiData.name == "chat";
               }
               else
               {
                  uirc.visible = false;
               }
            }
         }
      }
      
      public function nullFunction() : void
      {
      }
      
      public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:int, fightType:int, alliesPreparation:Boolean) : void
      {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.visible = false;
         }
         this.btn_close_ctr_quest.disabled = true;
      }
      
      public function onGameFightEnd(resultsKey:String) : void
      {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.visible = true;
         }
         this.btn_close_ctr_quest.disabled = false;
      }
      
      public function onNpcDialogCreation(mapId:Number, npcId:int, look:Object) : void
      {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      public function onLeaveDialog() : void
      {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = false;
         }
      }
      
      private function onExchangeStarted(pSourceName:String, pTargetName:String, pSourceLook:Object, pTargetLook:Object, pSourceCurrentPods:int, pTargetCurrentPods:int, pSourceMaxPods:int, pTargetMaxPods:int, otherId:Number) : void
      {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onExchangeLeave(success:Boolean) : void
      {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = false;
         }
      }
      
      private function onExchangeStartOkHumanVendor(vendorName:String, shopStock:Object, look:Object) : void
      {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onExchangeShopStockStarted(shopStock:Object) : void
      {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onExchangeStartOkNpcShop(pNCPSellerId:int, pObjects:Object, pLook:Object, tokenId:int) : void
      {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onExchangeStartOkNpcTrade(pNPCId:uint, pSourceName:String, pTargetName:String, pSourceLook:Object, pTargetLook:Object) : void
      {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onDocumentReadingBegin(documentId:uint) : void
      {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onTeleportDestinationList(teleportList:Object, tpType:uint) : void
      {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onExchangeStartOkCraft(skillId:uint) : void
      {
         if(this._tutorialManager.disabled)
         {
            this.ctr_joinTutorial.disabled = true;
         }
      }
      
      private function onGameRolePlayPlayerLifeStatus(status:uint, hardcore:uint) : void
      {
         if(hardcore == 0)
         {
            switch(status)
            {
               case 0:
                  if(this._tutorialManager.disabled)
                  {
                     this.ctr_joinTutorial.disabled = false;
                  }
                  break;
               case 1:
                  if(this._tutorialManager.disabled)
                  {
                     this.ctr_joinTutorial.disabled = true;
                  }
                  break;
               case 2:
                  if(this._tutorialManager.disabled)
                  {
                     this.ctr_joinTutorial.disabled = true;
                  }
            }
         }
      }
   }
}
