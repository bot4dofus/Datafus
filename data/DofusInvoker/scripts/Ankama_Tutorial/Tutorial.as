package Ankama_Tutorial
{
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_Tutorial.managers.AdvancedTutorialStepManager;
   import Ankama_Tutorial.managers.TutorialStepManager;
   import Ankama_Tutorial.ui.SubhintEditorUi;
   import Ankama_Tutorial.ui.SubhintList;
   import Ankama_Tutorial.ui.TipsUi;
   import Ankama_Tutorial.ui.TutorialUi;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestListRequestAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.HighlightApi;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.QuestApi;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.display.Sprite;
   
   public class Tutorial extends Sprite
   {
       
      
      private var include_TipsUi:TipsUi;
      
      private var include_TutorialUi:TutorialUi;
      
      private var include_SubhintEditorUi:SubhintEditorUi;
      
      private var include_SubhintList:SubhintList;
      
      [Module(name="Ankama_ContextMenu")]
      public var modMenu:ContextMenu;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="QuestApi")]
      public var questApi:QuestApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="MapApi")]
      public var mapApi:MapApi;
      
      [Api(name="HighlightApi")]
      public var highlightApi:HighlightApi;
      
      [Api(name="FightApi")]
      public var fightApi:FightApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="RoleplayApi")]
      public var roleplayApi:RoleplayApi;
      
      public const SUPERAREA_INCARNAM:uint = 3;
      
      public const MAP_REFERENCE_TUTORIAL:uint = 12;
      
      public const MAX_CHARACTER_LEVEL_FOR_TUTORIAL:uint = 14;
      
      private var _subArea:Object;
      
      private var _showTutorial:Boolean = false;
      
      private var _questListUpdated:Boolean = false;
      
      private var _disableTutorial:Boolean = false;
      
      public function Tutorial()
      {
         super();
      }
      
      public function main() : void
      {
         Api.ui = this.uiApi;
         Api.system = this.sysApi;
         Api.modMenu = this.modMenu;
         Api.player = this.playerApi;
         Api.data = this.dataApi;
         Api.highlight = this.highlightApi;
         Api.fight = this.fightApi;
         Api.storage = this.storageApi;
         Api.binds = this.bindsApi;
         Api.quest = this.questApi;
         Api.sound = this.soundApi;
         Api.roleplay = this.roleplayApi;
         this.sysApi.addHook(ChatHookList.Notification,this.onNotification);
         this.sysApi.addHook(HookList.NotificationReset,this.resetTips);
         this.sysApi.addHook(CustomUiHookList.RefreshTips,this.onRefreshTips);
         this.sysApi.addHook(HookList.CurrentMap,this.onCurrentMap);
         this.sysApi.addHook(QuestHookList.QuestListUpdated,this.onQuestListUpdated);
         this.sysApi.addHook(QuestHookList.QuestValidated,this.onQuestValidated);
         this.sysApi.addHook(HookList.OpenSubhintList,this.onSubhintListOpened);
         this.sysApi.addHook(HookList.IntroductionCinematicStart,this.onIntroductionCinematicStart);
         this.sysApi.addHook(HookList.IntroductionCinematicEnd,this.onIntroductionCinematicEnd);
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         if(this.sysApi.getBuildType() == BuildTypeEnum.INTERNAL)
         {
            this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         }
      }
      
      public function unload() : void
      {
         if(AdvancedTutorialStepManager.getInstance(false) != null)
         {
            AdvancedTutorialStepManager.getInstance().destroy();
         }
      }
      
      private function onSubhintListOpened() : void
      {
         if(!this.uiApi.getUi(UIEnum.SUBHINT_LIST))
         {
            this.uiApi.loadUi(UIEnum.SUBHINT_LIST,UIEnum.SUBHINT_LIST,null,this.uiApi.getUi(UIEnum.SUBHINT_EDITOR_UI).strata);
         }
         else
         {
            this.uiApi.unloadUi(UIEnum.SUBHINT_LIST);
         }
      }
      
      private function onRefreshTips(... args) : void
      {
         if(!this.uiApi.getUi("tips"))
         {
            this.uiApi.loadUi("tips","tips",[],3);
         }
         else
         {
            this.uiApi.getUi("tips").uiClass.checkQuietMode();
         }
      }
      
      private function resetTips(... args) : void
      {
         var notifications:Array = this.questApi.getNotificationList();
         if(notifications)
         {
            this.uiApi.getUi("tips").uiClass.resetTips(notifications);
         }
         this.onRefreshTips();
      }
      
      private function onNotification(pNotification:Object) : void
      {
         if(!this.uiApi.getUi("tips"))
         {
            this.uiApi.loadUi("tips","tips",[pNotification],3);
         }
      }
      
      private function onUiLoaded(name:String) : void
      {
         if(name == "bannerActionBar" && this.sysApi.getBuildType() == BuildTypeEnum.INTERNAL)
         {
            TutorialStepManager.getInstance().preload();
            if(this.uiApi.getUi("chat") && this.uiApi.getUi("tips"))
            {
               this.sysApi.removeHook(BeriliaHookList.UiLoaded);
            }
         }
         if(name == "chat")
         {
            this.onRefreshTips();
            if(!this.sysApi.getBuildType() == BuildTypeEnum.INTERNAL || this.uiApi.getUi("bannerActionBar"))
            {
               this.sysApi.removeHook(BeriliaHookList.UiLoaded);
            }
         }
      }
      
      private function onCurrentMap(mapId:Number) : void
      {
         if(this.playerApi.isInBreach())
         {
            return;
         }
         this._subArea = this.mapApi.subAreaByMapId(mapId);
         if(this._subArea && this._subArea.id == 536)
         {
            TutorialStepManager.initStepManager();
            if(this.uiApi.getUi(UIEnum.TUTORIAL_UI))
            {
               if(!this.uiApi.getUi(UIEnum.TUTORIAL_UI).uiClass.visible)
               {
                  this.uiApi.getUi(UIEnum.TUTORIAL_UI).uiClass.displayTutorial();
               }
            }
            else
            {
               this.uiApi.loadUi(UIEnum.TUTORIAL_UI,UIEnum.TUTORIAL_UI,[true]);
            }
         }
         else if(this._subArea && this._subArea.area.superArea.id == this.SUPERAREA_INCARNAM)
         {
            if(this.uiApi.getUi(UIEnum.TUTORIAL_UI))
            {
               if(this.uiApi.getUi(UIEnum.TUTORIAL_UI).uiClass.visible)
               {
                  this.uiApi.getUi(UIEnum.TUTORIAL_UI).uiClass.closeTutorial();
               }
            }
            else
            {
               this.showTutorialInIncarnam();
            }
         }
         else if(this.uiApi.getUi(UIEnum.TUTORIAL_UI))
         {
            this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
         }
         if(TutorialAdvancedConstants.MAP_IDS.indexOf(mapId) != -1)
         {
            AdvancedTutorialStepManager.getInstance().currentMapId = mapId;
         }
         else
         {
            AdvancedTutorialStepManager.getInstance().destroy();
         }
      }
      
      private function onQuestListUpdated() : void
      {
         var questId:uint = 0;
         var completedQuests:Vector.<uint> = this.questApi.getCompletedQuests();
         this._questListUpdated = true;
         this._showTutorial = true;
         for each(questId in completedQuests)
         {
            if(questId == TutorialConstants.QUEST_TUTORIAL_ID)
            {
               this._showTutorial = false;
               if(this.uiApi.getUi(UIEnum.TUTORIAL_UI))
               {
                  this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
               }
            }
         }
         this.showTutorialInIncarnam();
      }
      
      private function onQuestValidated(questId:int) : void
      {
         if(questId == TutorialConstants.QUEST_TUTORIAL_ID)
         {
            this._questListUpdated = true;
            this._showTutorial = false;
            if(this.uiApi.getUi(UIEnum.TUTORIAL_UI))
            {
               this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
            }
         }
      }
      
      private function showTutorialInIncarnam() : void
      {
         if(this.playerApi.isInBreach())
         {
            return;
         }
         if(this._questListUpdated)
         {
            if(this._showTutorial && this._subArea && this._subArea.area.superArea.id == this.SUPERAREA_INCARNAM && !this.uiApi.getUi(UIEnum.TUTORIAL_UI) && !this._disableTutorial)
            {
               this.uiApi.loadUi(UIEnum.TUTORIAL_UI,UIEnum.TUTORIAL_UI,[false]);
            }
         }
         else
         {
            this.sysApi.sendAction(new QuestListRequestAction([]));
         }
      }
      
      private function onIntroductionCinematicEnd() : void
      {
         this._disableTutorial = false;
         this.onCurrentMap(TutorialConstants.TUTORIAL_MAP_ID_FIRST);
      }
      
      private function onIntroductionCinematicStart() : void
      {
         if(this.uiApi.getUi(UIEnum.TUTORIAL_UI))
         {
            this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
         }
         this._disableTutorial = true;
      }
   }
}
