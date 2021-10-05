package Ankama_Grimoire.ui
{
   import Ankama_Cartography.Cartography;
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_Grimoire.Grimoire;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.datacenter.quest.QuestCategory;
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.dofus.datacenter.quest.QuestStep;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.internalDatacenter.appearance.TitleWrapper;
   import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.jobs.JobWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.quest.WatchQuestInfosRequestAction;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.network.enums.CompassTypeEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveDetailedInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestObjectiveInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestObjectiveInformationsWithCompletion;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.QuestApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class WatchQuestTab
   {
      
      private static const FLAG_COLOR:uint = 6736896;
      
      private static const INVISIBLE_ITEM_TYPE:int = 203;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="QuestApi")]
      public var questApi:QuestApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="MapApi")]
      public var mapApi:MapApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_Cartography")]
      public var modCartography:Cartography;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      private var _questsToShow:Array;
      
      private var _questActiveList:Array;
      
      private var _questCompletedList:Array;
      
      private var _questStepsList:Array;
      
      private var _iconRewards:Array;
      
      private var _itemRewardsDic:Dictionary;
      
      private var _questInfos:Object;
      
      private var _currentStep:uint;
      
      private var _displayedStep:uint;
      
      private var _currentIndexForStep:uint;
      
      private var _selectedQuest:uint;
      
      private var _closedCategories:Array;
      
      private var _showCompletedQuest:Boolean;
      
      private var _bDescendingSort:Boolean = false;
      
      private var _aSlotsReward:Array;
      
      private var _aSlotsObjective:Dictionary;
      
      private var _aObjectivesDialog:Dictionary;
      
      private var _selectedQuestCategory:int;
      
      private var _forceOpenCategory:Boolean = false;
      
      private var _stepNpcMessage:String;
      
      private var _lockSearchTimer:BenchmarkTimer;
      
      private var _previousSearchCriteria:String;
      
      private var _searchCriteria:String;
      
      private var _searchTextByCriteriaList:Dictionary;
      
      private var _searchResultByCriteriaList:Dictionary;
      
      private var _searchOnName:Boolean;
      
      private var _searchOnCategory:Boolean;
      
      private var _activeUri:Uri;
      
      private var _completeUri:Uri;
      
      private var _repeatUri:Uri;
      
      private var _pinNormalUri:Uri;
      
      private var _pinSelectedUri:Uri;
      
      private var _pinWhiteUri:Uri;
      
      private var _downArrowUri:Uri;
      
      private var _rightArrowUri:Uri;
      
      private var _dungeonIconUri:Uri;
      
      private var _partyIconUri:Uri;
      
      private var _checkedIconUri:Uri;
      
      private var _notCheckedIconUri:Uri;
      
      public var ctr_itemBlock:GraphicContainer;
      
      public var ctn_slots:GraphicContainer;
      
      public var tx_reward_1:Slot;
      
      public var tx_reward_2:Slot;
      
      public var tx_reward_3:Slot;
      
      public var tx_reward_4:Slot;
      
      public var tx_reward_5:Slot;
      
      public var tx_reward_6:Slot;
      
      public var tx_reward_7:Slot;
      
      public var tx_reward_8:Slot;
      
      public var tx_dialog:Texture;
      
      public var tx_rewardsXp:Texture;
      
      public var tx_rewardsKama:Texture;
      
      public var tx_inputBg_search:TextureBitmap;
      
      public var txa_description:TextArea;
      
      public var lbl_stepName:Label;
      
      public var lbl_nbQuests:Label;
      
      public var lbl_objectives:Label;
      
      public var lbl_rewardsXp:Label;
      
      public var lbl_rewardsKama:Label;
      
      public var lbl_noQuest:Label;
      
      public var inp_search:Input;
      
      public var cbx_steps:ComboBox;
      
      public var bgcbx_steps:TextureBitmap;
      
      public var tx_bg_step:TextureBitmap;
      
      public var btn_tabComplete:ButtonContainer;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_showCompletedQuests:ButtonContainer;
      
      public var btn_label_btn_showCompletedQuests:Label;
      
      public var btn_close_ctr_itemBlock:ButtonContainer;
      
      public var btn_loc:ButtonContainer;
      
      public var btn_resetSearch:ButtonContainer;
      
      public var btn_searchFilter:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var gd_objectives:Grid;
      
      public var gd_quests:Grid;
      
      private var _completedQuests:Vector.<uint>;
      
      private var _activeQuests:Vector.<QuestActiveInformations>;
      
      private var _questsInformations:Dictionary;
      
      private var _playerId:int;
      
      public function WatchQuestTab()
      {
         this._searchTextByCriteriaList = new Dictionary(true);
         this._searchResultByCriteriaList = new Dictionary(true);
         this._completedQuests = new Vector.<uint>();
         this._activeQuests = new Vector.<QuestActiveInformations>();
         this._questsInformations = new Dictionary();
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         var slot:Slot = null;
         this._completedQuests = oParam.completedQuests;
         this._activeQuests = oParam.activeQuests;
         this._playerId = oParam.playerId;
         this.bgcbx_steps.visible = false;
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.sysApi.addHook(QuestHookList.WatchQuestInfosUpdated,this.onWatchQuestInfosUpdated);
         this.sysApi.addHook(BeriliaHookList.TextureLoadFailed,this.onTextureLoadFailed);
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.uiApi.addComponentHook(this.gd_quests,ComponentHookList.ON_SELECT_ITEM);
         this._lockSearchTimer = new BenchmarkTimer(500,1,"QuestTab._lockSearchTimer");
         this._lockSearchTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
         this._questActiveList = [];
         this._questCompletedList = [];
         this._questStepsList = [];
         this._iconRewards = [];
         this._aSlotsReward = [this.tx_reward_1,this.tx_reward_2,this.tx_reward_3,this.tx_reward_4,this.tx_reward_5,this.tx_reward_6,this.tx_reward_7,this.tx_reward_8];
         this._aSlotsObjective = new Dictionary();
         this._aObjectivesDialog = new Dictionary();
         this._itemRewardsDic = new Dictionary();
         this._searchTextByCriteriaList["_searchOnName"] = this.uiApi.getText("ui.common.name");
         this._searchTextByCriteriaList["_searchOnCategory"] = this.uiApi.getText("ui.common.category");
         this._searchOnCategory = Grimoire.getInstance().questSearchOnCategory;
         this._searchOnName = Grimoire.getInstance().questSearchOnName;
         this._activeUri = this.uiApi.createUri(this.uiApi.me().getConstant("active_uri"));
         this._completeUri = this.uiApi.createUri(this.uiApi.me().getConstant("complete_uri"));
         this._repeatUri = this.uiApi.createUri(this.uiApi.me().getConstant("repeat_uri"));
         this._pinNormalUri = this.uiApi.createUri(this.uiApi.me().getConstant("pin_uri"));
         this._pinSelectedUri = this.uiApi.createUri(this.uiApi.me().getConstant("pin_selected_uri"));
         this._pinWhiteUri = this.uiApi.createUri(this.uiApi.me().getConstant("pin_white_uri"));
         this._downArrowUri = this.uiApi.createUri(this.uiApi.me().getConstant("flechebas_uri"));
         this._rightArrowUri = this.uiApi.createUri(this.uiApi.me().getConstant("flecheright_uri"));
         this._dungeonIconUri = this.uiApi.createUri(this.uiApi.me().getConstant("dungeon_icon"));
         this._partyIconUri = this.uiApi.createUri(this.uiApi.me().getConstant("party_icon"));
         this._checkedIconUri = this.uiApi.createUri(this.uiApi.me().getConstant("checked"));
         this._notCheckedIconUri = this.uiApi.createUri(this.uiApi.me().getConstant("not_checked"));
         for each(slot in this._aSlotsReward)
         {
            this.registerSlot(slot);
         }
         this.ctr_itemBlock.visible = false;
         this.uiApi.addComponentHook(this.tx_dialog,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_dialog,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.cbx_steps,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addShortcutHook("leftArrow",this.onShortCut);
         this.uiApi.addShortcutHook("rightArrow",this.onShortCut);
         this._closedCategories = [];
         this._showCompletedQuest = this.sysApi.getData("showCompletedQuest");
         this.updateQuestList();
      }
      
      public function unload() : void
      {
         this._selectedQuest = 0;
         if(this._lockSearchTimer)
         {
            this._lockSearchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
            this._lockSearchTimer.stop();
            this._lockSearchTimer = null;
         }
         this.uiApi.unloadUi("itemBox_" + this.uiApi.me().name);
         this.uiApi.hideTooltip();
      }
      
      public function showTabHints() : void
      {
         this.hintsApi.showSubHints();
      }
      
      public function updateItem(data:*, componentsRef:*, selected:Boolean) : void
      {
         var questCat:QuestCategory = null;
         var quest:Quest = null;
         var w:Number = NaN;
         var hasIcon:Boolean = false;
         var lvlQuest:String = null;
         if(this.gd_quests.dataProvider.length * this.gd_quests.slotHeight > this.gd_quests.height)
         {
            componentsRef.btn_quest.width = componentsRef.tx_cat_bg.width = 415;
            componentsRef.tx_cat_bg.bgColor = this.sysApi.getConfigEntry("colors.grid.line");
         }
         else
         {
            componentsRef.btn_quest.width = componentsRef.tx_cat_bg.width = 425;
            componentsRef.tx_cat_bg.bgColor = this.sysApi.getConfigEntry("colors.grid.line");
         }
         if(data)
         {
            componentsRef.lbl_questName.visible = true;
            componentsRef.btn_quest.disabled = false;
            if(data.isCategory)
            {
               questCat = this.dataApi.getQuestCategory(data.id);
               if(questCat != null)
               {
                  componentsRef.lbl_questName.text = questCat.name;
                  componentsRef.lbl_questName.x = 15;
                  componentsRef.lbl_questName.cssClass = "p";
                  componentsRef.lbl_questName.css = this.uiApi.createUri(this.uiApi.me().getConstant("css") + "normal2.css");
                  componentsRef.tx_questComplete.uri = null;
                  componentsRef.tx_repeatable.uri = null;
                  componentsRef.tx_questIcon.uri = null;
                  componentsRef.tx_cat_bg.visible = true;
                  componentsRef.btn_quest.selected = data.id == this._selectedQuestCategory;
                  componentsRef.lbl_questLevel.visible = false;
               }
               else
               {
                  this.clearLine(componentsRef);
               }
            }
            else
            {
               quest = this.dataApi.getQuest(data.id);
               if(quest != null)
               {
                  w = parseInt(this.uiApi.me().getConstant("lbl_questName_width"));
                  hasIcon = false;
                  if(quest.isDungeonQuest)
                  {
                     componentsRef.tx_questIcon.uri = this._dungeonIconUri;
                     hasIcon = true;
                  }
                  else if(quest.isPartyQuest)
                  {
                     componentsRef.tx_questIcon.uri = this._partyIconUri;
                     hasIcon = true;
                  }
                  if(hasIcon)
                  {
                     w -= 22;
                  }
                  else
                  {
                     componentsRef.tx_questIcon.uri = null;
                  }
                  componentsRef.lbl_questName.x = 35;
                  componentsRef.lbl_questName.fullSize(w);
                  componentsRef.lbl_questName.height = parseInt(this.uiApi.me().getConstant("lbl_questName_height"));
                  lvlQuest = quest.levelMin == quest.levelMax || quest.levelMin > quest.levelMax ? quest.levelMin.toString() : quest.levelMin + "-" + quest.levelMax;
                  componentsRef.lbl_questLevel.text = this.uiApi.getText("ui.common.short.level") + (quest.levelMin == quest.levelMax && quest.levelMin == 0 ? "" : lvlQuest);
                  componentsRef.lbl_questLevel.visible = true;
                  if(data.status)
                  {
                     componentsRef.tx_questComplete.uri = null;
                     componentsRef.lbl_questName.cssClass = "p";
                     componentsRef.lbl_questName.css = this.uiApi.createUri(this.uiApi.me().getConstant("css") + "small2.css");
                  }
                  else
                  {
                     componentsRef.tx_questComplete.uri = this._completeUri;
                     componentsRef.tx_questComplete.x = 20;
                     componentsRef.lbl_questName.cssClass = "questfinished";
                     componentsRef.lbl_questName.css = this.uiApi.createUri(this.uiApi.me().getConstant("css") + "small2.css");
                  }
                  componentsRef.lbl_questName.text = this.getQuestName(quest);
                  if(quest.repeatType != 0)
                  {
                     componentsRef.tx_repeatable.uri = this._repeatUri;
                  }
                  else
                  {
                     componentsRef.tx_repeatable.uri = null;
                  }
                  componentsRef.btn_quest.selected = this._selectedQuest == data.id;
                  componentsRef.tx_cat_bg.visible = false;
               }
               else
               {
                  this.clearLine(componentsRef);
               }
            }
         }
         else
         {
            this.clearLine(componentsRef);
         }
      }
      
      private function getQuestName(quest:Quest) : String
      {
         var name:String = quest.name;
         if(this.sysApi.getPlayerManager().hasRights)
         {
            name += " (" + quest.id + ")";
         }
         return name;
      }
      
      private function clearLine(componentsRef:*) : void
      {
         componentsRef.lbl_questName.visible = false;
         componentsRef.tx_questComplete.uri = null;
         componentsRef.tx_repeatable.uri = null;
         componentsRef.tx_questIcon.uri = null;
         if(componentsRef.btn_quest.selected)
         {
            componentsRef.btn_quest.selected = false;
         }
         componentsRef.btn_quest.disabled = true;
         componentsRef.tx_cat_bg.visible = false;
         componentsRef.lbl_questLevel.visible = false;
      }
      
      public function updateObjectivesItem(data:*, componentsRef:*, selected:Boolean) : void
      {
         var objective:QuestObjective = null;
         var objectiveText:String = null;
         var dialog:String = null;
         var mapPos:MapPosition = null;
         var flagList:* = undefined;
         var flag:Object = null;
         var newTextEnding:* = null;
         var text:String = null;
         if(data)
         {
            this.uiApi.addComponentHook(componentsRef.btn_loc,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(componentsRef.btn_loc,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.btn_loc,ComponentHookList.ON_ROLL_OUT);
            objective = this.dataApi.getQuestObjective(data.id);
            this._aSlotsObjective[componentsRef.btn_loc] = objective;
            objectiveText = objective.text;
            if(this.sysApi.getPlayerManager().hasRights)
            {
               objectiveText += " (" + data.id + ")";
            }
            componentsRef.lbl_objective.text = objectiveText;
            if(objective)
            {
               dialog = objective.dialog;
               if(this._questInfos && this._questInfos.objectivesDialogParams[objective.id])
               {
                  dialog = this.utilApi.applyTextParams(dialog,this._questInfos.objectivesDialogParams[objective.id],"#");
               }
               this._aObjectivesDialog[componentsRef.tx_infos] = dialog;
               if(objective.dialog != "")
               {
                  this.uiApi.addComponentHook(componentsRef.tx_infos,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(componentsRef.tx_infos,ComponentHookList.ON_ROLL_OUT);
                  componentsRef.tx_infos.visible = true;
               }
               else
               {
                  componentsRef.tx_infos.visible = false;
               }
            }
            if(!data.status)
            {
               componentsRef.tx_achieve.visible = true;
               componentsRef.btn_loc.visible = false;
               componentsRef.lbl_objective.cssClass = "p4";
            }
            else
            {
               componentsRef.tx_achieve.visible = false;
               if(objective.coords || objective.mapId)
               {
                  mapPos = !!objective.mapId ? this.dataApi.getMapInfo(objective.mapId) : null;
                  componentsRef.btn_loc.visible = !!objective.mapId ? mapPos != null : true;
                  componentsRef.btn_loc.selected = false;
                  componentsRef.lbl_objective.cssClass = "p";
                  flagList = this.modCartography.getFlags(!!mapPos ? int(mapPos.subArea.worldmap.id) : int(this.mapApi.getCurrentWorldMap().id));
                  for each(flag in flagList)
                  {
                     if(flag.id == "flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + this._selectedQuest + "_" + objective.id)
                     {
                        componentsRef.btn_loc.selected = true;
                     }
                  }
               }
               else
               {
                  componentsRef.btn_loc.visible = false;
                  componentsRef.lbl_objective.cssClass = "p";
               }
               if(data.currentCompletion != -1 && data.maxCompletion != -1)
               {
                  newTextEnding = " (" + data.currentCompletion + "/" + data.maxCompletion + ")" + "</FONT></P>";
                  text = componentsRef.lbl_objective.htmlText;
                  componentsRef.lbl_objective.htmlText = text.replace("</FONT></P>",newTextEnding);
               }
            }
         }
         else
         {
            componentsRef.lbl_objective.text = "";
            componentsRef.tx_achieve.visible = false;
            componentsRef.tx_infos.visible = false;
            componentsRef.btn_loc.visible = false;
         }
      }
      
      public function selectQuestById(questId:uint) : void
      {
         this._selectedQuest = questId;
         this.selectQuest();
      }
      
      private function getAllQuestsOrderByCategory(withCompletedQuests:Boolean = false, withActiveQuests:Boolean = true) : Array
      {
         var quest:Quest = null;
         var questInfos:QuestActiveInformations = null;
         var category:Object = null;
         var activeQuests:Vector.<QuestActiveInformations> = null;
         var questId:uint = 0;
         var completedQuests:Vector.<uint> = null;
         var catsListWithQuests:Array = [];
         var tabIndex:uint = 0;
         if(withActiveQuests)
         {
            activeQuests = this._activeQuests;
            for each(questInfos in activeQuests)
            {
               quest = Quest.getQuestById(questInfos.questId);
               if(quest)
               {
                  tabIndex = quest.category.order;
                  if(tabIndex > catsListWithQuests.length || !catsListWithQuests[tabIndex])
                  {
                     category = {};
                     category.data = [];
                     category.id = quest.categoryId;
                     catsListWithQuests[tabIndex] = category;
                  }
                  catsListWithQuests[tabIndex].data.push({
                     "id":questInfos.questId,
                     "status":true
                  });
               }
            }
         }
         if(withCompletedQuests)
         {
            completedQuests = this._completedQuests;
            for each(questId in completedQuests)
            {
               quest = Quest.getQuestById(questId);
               if(quest)
               {
                  tabIndex = quest.category.order;
                  if(tabIndex > catsListWithQuests.length || !catsListWithQuests[tabIndex])
                  {
                     category = {};
                     category.data = [];
                     category.id = quest.categoryId;
                     catsListWithQuests[tabIndex] = category;
                  }
                  catsListWithQuests[tabIndex].data.push({
                     "id":questId,
                     "status":false
                  });
               }
            }
         }
         return catsListWithQuests;
      }
      
      public function getActiveQuestsIds() : Vector.<uint>
      {
         var activeQuest:QuestActiveInformations = null;
         var data:Vector.<uint> = new Vector.<uint>();
         var activeQuests:Vector.<QuestActiveInformations> = this._activeQuests;
         for each(activeQuest in activeQuests)
         {
            data.push(activeQuest.questId);
         }
         return data;
      }
      
      private function registerSlot(slot:Slot) : void
      {
         this.uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(slot,ComponentHookList.ON_RIGHT_CLICK);
      }
      
      private function updateQuestGrid() : void
      {
         var list:Object = null;
         var o:Object = null;
         var i:int = 0;
         var txtPendingQuests:String = null;
         var isCatVisible:* = false;
         var p:Object = null;
         var iQ:* = undefined;
         var ts:uint = 0;
         var critSplit:Array = null;
         var knownQuests:Array = null;
         var qId:int = 0;
         var nameCatResult:Array = null;
         var nameNameResult:Array = null;
         var catCatResult:Array = null;
         var catNameResult:Array = null;
         var catId:int = 0;
         var nameId:int = 0;
         var j:int = 0;
         var nameResult:Vector.<uint> = null;
         var categoryResult:Vector.<uint> = null;
         var questCat:QuestCategory = null;
         var q:Object = null;
         var currentCriteria:String = null;
         var wannabeCriteria:String = null;
         var crit:* = null;
         var realDP:Array = [];
         if(!this._searchCriteria)
         {
            if(this._showCompletedQuest)
            {
               this.btn_showCompletedQuests.selected = true;
            }
            else if(!this.btn_showCompletedQuests.selected && this._forceOpenCategory && !this._questActiveList.indexOf(this.dataApi.getQuest(this._selectedQuest)) == -1)
            {
               this.btn_showCompletedQuests.selected = true;
               this.sysApi.setData("showCompletedQuest",true);
            }
            this._questsToShow = [];
            for(list = this.getAllQuestsOrderByCategory(this.btn_showCompletedQuests.selected,!this.btn_showCompletedQuests.selected); i < list.length; )
            {
               if(!(list[i] == null || list[i].data.length == 0))
               {
                  isCatVisible = !this.isCatClosed(list[i].id);
                  o = {
                     "id":list[i].id,
                     "isCategory":true,
                     "visible":isCatVisible
                  };
                  this._questsToShow.push(o);
                  realDP.push(o);
                  for each(p in list[i].data)
                  {
                     this._questsToShow.push(p);
                     if(isCatVisible)
                     {
                        realDP.push(p);
                     }
                  }
               }
               i += 1;
            }
            this.btn_label_btn_showCompletedQuests.text = this.uiApi.getText("ui.grimoire.displayFinishedQuests",this._questCompletedList.length);
            this.btn_showCompletedQuests.visible = true;
            txtPendingQuests = this.uiApi.processText(this.uiApi.getText("ui.grimoire.pendingQuests",this._questActiveList.length),"n",this._questActiveList.length <= 1,this._questActiveList.length == 0);
            this.lbl_nbQuests.text = txtPendingQuests;
            this.lbl_nbQuests.visible = !this.btn_showCompletedQuests.selected;
            this.gd_quests.dataProvider = realDP;
            if(realDP.length > 0)
            {
               this.lbl_noQuest.visible = false;
               for(iQ in realDP)
               {
                  if(realDP[iQ].id == this._selectedQuest && realDP[iQ].status)
                  {
                     this.gd_quests.selectedIndex = iQ;
                  }
               }
               this.selectQuest();
            }
            else
            {
               this.updateEmptyStep();
               this.lbl_noQuest.visible = true;
               this.lbl_noQuest.text = this.uiApi.getText("ui.grimoire.quest.noQuest");
            }
         }
         else if(this._previousSearchCriteria != this._searchCriteria + "#" + this._searchOnName + "" + this._searchOnCategory)
         {
            ts = getTimer();
            critSplit = !!this._previousSearchCriteria ? this._previousSearchCriteria.split("#") : [];
            if(this._searchCriteria != critSplit[0])
            {
               nameResult = this.dataApi.queryString(Quest,"name",this._searchCriteria);
               categoryResult = this.dataApi.queryString(QuestCategory,"name",this._searchCriteria);
               this._searchResultByCriteriaList["_searchOnName"] = nameResult;
               this._searchResultByCriteriaList["_searchOnCategory"] = categoryResult;
               if(nameResult || categoryResult)
               {
                  this.sysApi.log(2,"Result : " + ((!!nameResult ? nameResult.length : 0) + (!!categoryResult ? categoryResult.length : 0)) + " in " + (getTimer() - ts) + " ms");
               }
            }
            if(!this._searchOnName && !this._searchOnCategory)
            {
               this.gd_quests.dataProvider = [];
               this.lbl_noQuest.visible = true;
               this.lbl_noQuest.text = this.uiApi.getText("ui.search.needCriterion");
               this._previousSearchCriteria = this._searchCriteria + "#" + this._searchOnName + "" + this._searchOnCategory;
               return;
            }
            this.lbl_noQuest.visible = false;
            this._questsToShow = [];
            knownQuests = [];
            for each(qId in this.getActiveQuestsIds())
            {
               knownQuests.push(qId);
            }
            for each(qId in this._completedQuests)
            {
               knownQuests.push(qId);
            }
            nameCatResult = [];
            nameNameResult = [];
            catCatResult = [];
            catNameResult = [];
            for each(catId in this._searchResultByCriteriaList["_searchOnCategory"])
            {
               catCatResult.push(catId);
               questCat = this.dataApi.getQuestCategory(catId);
               for each(qId in questCat.questIds)
               {
                  catNameResult.push(qId);
               }
            }
            for each(nameId in this._searchResultByCriteriaList["_searchOnName"])
            {
               if(knownQuests.indexOf(nameId) != -1)
               {
                  nameNameResult.push(nameId);
                  nameCatResult.push(this.dataApi.getQuest(nameId).categoryId);
               }
            }
            for(list = this.getAllQuestsOrderByCategory(true); j < list.length; )
            {
               if(!(list[j] == null || list[j].data.length == 0))
               {
                  if(this._searchOnCategory && catCatResult && catCatResult.indexOf(list[j].id) != -1)
                  {
                     o = {
                        "id":list[j].id,
                        "isCategory":true,
                        "visible":true
                     };
                     this._questsToShow.push(o);
                     realDP.push(o);
                  }
                  else if(this._searchOnName && nameCatResult && nameCatResult.indexOf(list[j].id) != -1)
                  {
                     o = {
                        "id":list[j].id,
                        "isCategory":true,
                        "visible":true
                     };
                     this._questsToShow.push(o);
                     realDP.push(o);
                  }
                  for each(q in list[j].data)
                  {
                     if(this._searchOnName && nameNameResult && nameNameResult.indexOf(q.id) != -1)
                     {
                        this._questsToShow.push(q);
                        realDP.push(q);
                     }
                     else if(this._searchOnCategory && catNameResult && catNameResult.indexOf(q.id) != -1)
                     {
                        this._questsToShow.push(q);
                        realDP.push(q);
                     }
                  }
               }
               j += 1;
            }
            this.gd_quests.dataProvider = realDP;
            if(realDP.length > 0)
            {
               this.lbl_noQuest.visible = false;
            }
            else
            {
               this.lbl_noQuest.visible = true;
               this.lbl_noQuest.text = this.uiApi.getText("ui.search.noResult");
               currentCriteria = "";
               wannabeCriteria = "";
               for(crit in this._searchTextByCriteriaList)
               {
                  if(this[crit])
                  {
                     currentCriteria += this._searchTextByCriteriaList[crit] + ", ";
                  }
                  else if(this._searchResultByCriteriaList[crit].length > 0)
                  {
                     wannabeCriteria += this._searchTextByCriteriaList[crit] + ", ";
                  }
               }
               if(currentCriteria.length > 0)
               {
                  currentCriteria = currentCriteria.slice(0,-2);
               }
               if(wannabeCriteria.length > 0)
               {
                  wannabeCriteria = wannabeCriteria.slice(0,-2);
               }
               if(wannabeCriteria.length == 0)
               {
                  this.lbl_noQuest.text = this.uiApi.getText("ui.search.noResultFor",this._searchCriteria);
               }
               else
               {
                  this.lbl_noQuest.text = this.uiApi.getText("ui.search.noResultsBut",currentCriteria,wannabeCriteria);
               }
            }
         }
      }
      
      private function selectQuest() : void
      {
         if(this.ctr_itemBlock.visible)
         {
            this.ctr_itemBlock.visible = false;
         }
         this.sysApi.sendAction(new WatchQuestInfosRequestAction([this._selectedQuest,this._playerId]));
      }
      
      private function updateStep(completedQuest:Boolean = false) : void
      {
         var cbxDP:Array = null;
         var i:uint = 0;
         var quest:Quest = null;
         var txtKamas:uint = 0;
         var txtXp:uint = 0;
         var reward:Vector.<uint> = null;
         var rewardId:uint = 0;
         var objectives:Array = null;
         var obv:Object = null;
         var objWrapper:ObjectiveWrapper = null;
         var item:ItemWrapper = null;
         var emote:EmoteWrapper = null;
         var job:JobWrapper = null;
         var spell:SpellWrapper = null;
         var title:TitleWrapper = null;
         var len:uint = this._questStepsList.length;
         if(len > 1)
         {
            cbxDP = [];
            for(i = 1; i <= len; i += 1)
            {
               cbxDP.push({
                  "label":this.uiApi.getText("ui.grimoire.quest.step") + " " + i,
                  "value":i
               });
            }
            this.cbx_steps.dataProvider = cbxDP;
            this.cbx_steps.selectedIndex = this._currentIndexForStep;
            this.cbx_steps.visible = true;
            this.bgcbx_steps.visible = true;
            this.tx_bg_step.visible = true;
         }
         else
         {
            this.cbx_steps.visible = false;
            this.bgcbx_steps.visible = false;
            this.tx_bg_step.visible = false;
         }
         var step:QuestStep = this.dataApi.getQuestStep(this._displayedStep) as QuestStep;
         if(step.name == null || step.name == "")
         {
            quest = this.dataApi.getQuest(this._selectedQuest);
            this.lbl_stepName.text = quest.name;
         }
         else
         {
            this.lbl_stepName.text = step.name;
         }
         if(this._questStepsList.indexOf(this._displayedStep) <= this._questStepsList.indexOf(this._currentStep))
         {
            this.txa_description.text = step.description;
            this.lbl_objectives.text = "";
            this.tx_dialog.visible = true;
            objectives = [];
            for each(obv in step.objectives)
            {
               if(!completedQuest)
               {
                  if(this._questInfos && this._questInfos.objectives[obv.id] != undefined)
                  {
                     objWrapper = ObjectiveWrapper.create(obv.id,this._questInfos.objectives[obv.id]);
                     if(this._questInfos.objectivesData[obv.id] != null)
                     {
                        objWrapper.currentCompletion = this._questInfos.objectivesData[obv.id].current;
                        objWrapper.maxCompletion = this._questInfos.objectivesData[obv.id].max;
                     }
                     objectives.push(objWrapper);
                  }
               }
               else
               {
                  objectives.push(ObjectiveWrapper.create(obv.id,false));
               }
            }
            this.gd_objectives.dataProvider = objectives;
         }
         else
         {
            this.txa_description.text = this.uiApi.getText("ui.grimoire.quest.descriptionNonAvailable");
            this.lbl_objectives.text = this.uiApi.getText("ui.grimoire.quest.objectivesNonAvailable");
            this.tx_dialog.visible = false;
            this.gd_objectives.dataProvider = [];
         }
         this._stepNpcMessage = step.dialog;
         if(this._stepNpcMessage == "")
         {
            this.tx_dialog.visible = false;
         }
         if(this.gd_objectives.dataProvider.length == 0 && this._questActiveList.length > 0)
         {
            this.lbl_objectives.text = this.uiApi.getText("ui.grimoire.quest.objectivesNonAvailable");
         }
         else
         {
            this.lbl_objectives.text = "";
         }
         if(step.kamasReward != 0)
         {
            txtKamas = step.kamasReward + step.kamasReward * this.questApi.getAlmanaxQuestKamasBonusMultiplier(step.questId);
         }
         else
         {
            txtKamas = 0;
         }
         var xpReward:uint = step.experienceReward;
         if(xpReward != 0)
         {
            txtXp = xpReward + xpReward * this.questApi.getAlmanaxQuestXpBonusMultiplier(step.questId);
         }
         else
         {
            txtXp = 0;
         }
         this.formateRewardsLbl(txtXp,txtKamas);
         this.clearSlots();
         this._iconRewards = [];
         var cpt:uint = 0;
         this.ctn_slots.x = txtXp > 0 || txtKamas > 0 ? Number(this.uiApi.me().getConstant("reward_slot_with_xp_x")) : Number(this.uiApi.me().getConstant("reward_slot_without_xp_x"));
         for each(reward in step.itemsReward)
         {
            item = this.dataApi.getItemWrapper(reward[0],0,0,reward[1]);
            if(item.type.id != INVISIBLE_ITEM_TYPE)
            {
               this.displaySlot(this._aSlotsReward[cpt],item);
            }
            this._iconRewards.push("item" + item.objectGID);
            this._itemRewardsDic["item" + item.objectGID] = item;
            cpt++;
         }
         for each(rewardId in step.emotesReward)
         {
            emote = this.dataApi.getEmoteWrapper(rewardId);
            this.displaySlot(this._aSlotsReward[cpt],emote);
            this._iconRewards.push(emote.emote.name);
            cpt++;
         }
         for each(rewardId in step.jobsReward)
         {
            job = this.dataApi.getJobWrapper(rewardId);
            this.displaySlot(this._aSlotsReward[cpt],job);
            this._iconRewards.push(job.job.name);
            cpt++;
         }
         for each(rewardId in step.spellsReward)
         {
            spell = this.dataApi.getSpellWrapper(rewardId);
            this.displaySlot(this._aSlotsReward[cpt],spell);
            this._iconRewards.push(spell.spell.name);
            cpt++;
         }
         for each(rewardId in step.titlesReward)
         {
            title = this.dataApi.getTitleWrapper(rewardId);
            this.displaySlot(this._aSlotsReward[cpt],title);
            this._iconRewards.push(title.title.name);
            cpt++;
         }
         quest = this.dataApi.getQuest(this._selectedQuest);
      }
      
      private function updateEmptyStep() : void
      {
         this.lbl_stepName.text = "";
         this.txa_description.text = "";
         this.tx_dialog.visible = false;
         this.gd_objectives.dataProvider = [];
         if(this._questActiveList.length > 0)
         {
            this.lbl_objectives.text = this.uiApi.getText("ui.grimoire.quest.objectivesNonAvailable");
         }
         this.formateRewardsLbl(0,0);
         this.clearSlots();
      }
      
      private function clearSlots() : void
      {
         var slot:Slot = null;
         for each(slot in this._aSlotsReward)
         {
            slot.data = null;
            slot.buttonMode = false;
            slot.visible = false;
         }
      }
      
      private function formateRewardsLbl(xp:uint, kamas:uint) : void
      {
         if(kamas > 0)
         {
            this.lbl_rewardsKama.visible = this.tx_rewardsKama.visible = true;
            this.lbl_rewardsKama.text = this.utilApi.formateIntToString(kamas);
         }
         else
         {
            this.lbl_rewardsKama.visible = this.tx_rewardsKama.visible = false;
         }
         if(xp > 0 && this.configApi.isFeatureWithKeywordEnabled("character.xp"))
         {
            this.tx_rewardsXp.visible = this.lbl_rewardsXp.visible = true;
            this.lbl_rewardsXp.text = this.utilApi.formateIntToString(xp);
         }
         else
         {
            this.tx_rewardsXp.visible = this.lbl_rewardsXp.visible = false;
         }
      }
      
      private function displaySlot(slot:Slot, data:Object) : void
      {
         slot.data = data;
         slot.visible = true;
      }
      
      private function showOrHideCategory(categoryId:uint, type:uint = 0) : void
      {
         var newVisibleState:* = false;
         var quest:Object = null;
         this._closedCategories = [];
         var newDp:Array = [];
         var isVisible:Boolean = false;
         for each(quest in this._questsToShow)
         {
            if(quest.isCategory)
            {
               newDp.push(quest);
               if(quest.id == categoryId)
               {
                  switch(type)
                  {
                     case 0:
                        newVisibleState = !quest.visible;
                        break;
                     case 1:
                        newVisibleState = true;
                        break;
                     case 2:
                        newVisibleState = false;
                  }
                  if(newVisibleState == quest.visible)
                  {
                     return;
                  }
                  quest.visible = newVisibleState;
               }
               isVisible = quest.visible;
               if(!isVisible)
               {
                  this._closedCategories.push(quest.id);
               }
            }
            else if(isVisible)
            {
               newDp.push(quest);
            }
         }
         this.gd_quests.dataProvider = newDp;
      }
      
      private function isCatClosed(catId:int) : Boolean
      {
         if(this._forceOpenCategory && this._selectedQuestCategory == catId)
         {
            this._forceOpenCategory = false;
            return false;
         }
         if(!this._closedCategories || this._closedCategories.length == 0)
         {
            return false;
         }
         return this._closedCategories.indexOf(catId) > -1;
      }
      
      private function changeSearchOnName() : void
      {
         this._searchOnName = !this._searchOnName;
         Grimoire.getInstance().questSearchOnName = this._searchOnName;
         if(!this._searchOnName && !this._searchOnCategory)
         {
            this.inp_search.visible = false;
            this.tx_inputBg_search.disabled = true;
         }
         else
         {
            this.inp_search.visible = true;
            this.tx_inputBg_search.disabled = false;
         }
         if(this._searchCriteria && this._searchCriteria != "")
         {
            this.updateQuestGrid();
         }
      }
      
      private function changeSearchOnCategory() : void
      {
         this._searchOnCategory = !this._searchOnCategory;
         Grimoire.getInstance().questSearchOnCategory = this._searchOnCategory;
         if(!this._searchOnName && !this._searchOnCategory)
         {
            this.inp_search.visible = false;
            this.tx_inputBg_search.disabled = true;
         }
         else
         {
            this.inp_search.visible = true;
            this.tx_inputBg_search.disabled = false;
         }
         if(this._searchCriteria && this._searchCriteria != "")
         {
            this.updateQuestGrid();
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var contextMenu:Array = null;
         switch(target)
         {
            case this.btn_tabComplete:
               if(this._bDescendingSort)
               {
                  this.gd_quests.sortOn("complete");
               }
               else
               {
                  this.gd_quests.sortOn("complete",Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_tabName:
               if(this._bDescendingSort)
               {
                  this.gd_quests.sortOn("name",Array.CASEINSENSITIVE);
               }
               else
               {
                  this.gd_quests.sortOn("name",Array.CASEINSENSITIVE | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_showCompletedQuests:
               this.sysApi.setData("showCompletedQuest",this.btn_showCompletedQuests.selected);
               this._showCompletedQuest = this.btn_showCompletedQuests.selected;
               this.updateQuestGrid();
               break;
            case this.btn_close_ctr_itemBlock:
               if(this.ctr_itemBlock.visible)
               {
                  this.ctr_itemBlock.visible = false;
               }
               break;
            case this.btn_resetSearch:
               this._searchCriteria = null;
               this.inp_search.text = "";
               this.updateQuestGrid();
               break;
            case this.btn_searchFilter:
               contextMenu = [];
               contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.search.criteria")));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnName"],this.changeSearchOnName,null,false,null,this._searchOnName,false));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnCategory"],this.changeSearchOnCategory,null,false,null,this._searchOnCategory,false));
               this.modContextMenu.createContextMenu(contextMenu);
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var selectedItem:Object = null;
         this.ctr_itemBlock.visible = false;
         switch(target)
         {
            case this.gd_quests:
               selectedItem = this.gd_quests.selectedItem;
               if(selectedItem.id != this._selectedQuest && !selectedItem.isCategory && selectMethod != SelectMethodEnum.AUTO && selectMethod != SelectMethodEnum.LEFT_ARROW && selectMethod != SelectMethodEnum.RIGHT_ARROW)
               {
                  this._selectedQuest = selectedItem.id;
                  this._selectedQuestCategory = this.dataApi.getQuest(this._selectedQuest).category.id;
                  this.selectQuest();
               }
               else if(selectedItem.isCategory && selectMethod != SelectMethodEnum.AUTO)
               {
                  this._selectedQuestCategory = selectedItem.id;
                  if(selectMethod == SelectMethodEnum.CLICK || selectMethod == SelectMethodEnum.DOUBLE_CLICK)
                  {
                     this.showOrHideCategory(selectedItem.id);
                  }
               }
               this.gd_quests.updateItem(this.gd_quests.selectedIndex);
               break;
            case this.cbx_steps:
               if(this.cbx_steps.selectedIndex != this._currentIndexForStep)
               {
                  this._currentIndexForStep = this.cbx_steps.selectedIndex;
                  this._displayedStep = this._questStepsList[this.cbx_steps.selectedIndex];
                  this.updateStep(this._completedQuests.indexOf(this._selectedQuest) != -1);
               }
         }
      }
      
      public function onShortCut(s:String) : Boolean
      {
         if(this.inp_search.haveFocus || !this.gd_quests.selectedItem || !this.gd_quests.selectedItem.isCategory)
         {
            return false;
         }
         switch(s)
         {
            case "leftArrow":
               this.showOrHideCategory(this.gd_quests.selectedItem.id,2);
               return true;
            case "rightArrow":
               this.showOrHideCategory(this.gd_quests.selectedItem.id,1);
               return true;
            default:
               return false;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var index:int = 0;
         var content:String = null;
         var infosObjectiveText:String = null;
         var point:uint = 0;
         var relPoint:uint = 0;
         var data:TextTooltipInfo = null;
         var slotIndex:int = this._aSlotsReward.indexOf(target);
         if(slotIndex != -1 && this._aSlotsReward[slotIndex].data != null)
         {
            index = parseInt(target.name.substr(10)) - 1;
            content = this._iconRewards[index];
            if(content.indexOf("item") == 0)
            {
               this.uiApi.showTooltip(this._itemRewardsDic[content],target,false,"standard",8,0,0,"itemName",null,{
                  "showEffects":true,
                  "header":true
               },"ItemInfo");
            }
            else
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(content),target,false,"standard",7,1,3,null,null,null,"TextInfo");
            }
         }
         else if(target == this.tx_dialog)
         {
            if(this._stepNpcMessage != "")
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this._stepNpcMessage),target,false,"standard",3,5,3,null,null,null,"TextInfo");
            }
         }
         else if(target.name.indexOf("tx_infos") != -1)
         {
            infosObjectiveText = this._aObjectivesDialog[target];
            if(infosObjectiveText != "")
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(infosObjectiveText),target,false,"standard",3,5,3,null,null,null,"TextInfo");
            }
         }
         else if(target.name.substr(0,7) == "btn_loc")
         {
            point = 7;
            relPoint = 1;
            data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.tooltip.questMarker"));
            this.uiApi.showTooltip(data,target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
         else if(target == this.btn_searchFilter)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.search.criteria")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
         else if(target.name.indexOf("tx_questComplete") == 0)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.almanax.questDone")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
         else if(target.name.indexOf("tx_repeatable") == 0)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.quest.repeatable")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
         else if(target.name.indexOf("tx_questIcon") == 0)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo((target as Texture).uri == this._dungeonIconUri ? this.uiApi.getText("ui.quest.dungeonQuest") : this.uiApi.getText("ui.quest.partyQuest")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         var contextMenu:ContextMenuData = null;
         var slotIndex:int = this._aSlotsReward.indexOf(target);
         if(slotIndex == -1 || this._aSlotsReward[slotIndex].data == null)
         {
            return;
         }
         var index:int = parseInt(target.name.substr(10)) - 1;
         var content:String = this._iconRewards[index];
         if(content.indexOf("item") != 0)
         {
            return;
         }
         var data:Object = this._itemRewardsDic[content];
         if(data)
         {
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function updateQuestList() : void
      {
         var questA:* = undefined;
         var questC:* = undefined;
         this._questActiveList = [];
         this._questCompletedList = [];
         var selectedStillHere:Boolean = false;
         for each(questA in this.getActiveQuestsIds())
         {
            if(this._selectedQuest == questA)
            {
               selectedStillHere = true;
            }
            this._questActiveList.push({
               "id":questA,
               "status":true
            });
         }
         for each(questC in this._completedQuests)
         {
            if(this._selectedQuest == questC)
            {
               selectedStillHere = true;
            }
            this._questCompletedList.push({
               "id":questC,
               "status":true
            });
         }
         if(!selectedStillHere && this._questActiveList.length > 0)
         {
            this._selectedQuest = this._questActiveList[0].id;
         }
         this.updateQuestGrid();
      }
      
      public function onWatchQuestInfosUpdated(infos:QuestActiveInformations, playerId:int) : void
      {
         var stepsIds:Vector.<uint> = null;
         var st:* = undefined;
         var questId:int = infos.questId;
         var infosAvailable:Boolean = this.processQuestInfos(infos);
         if(questId == this._selectedQuest && playerId == this._playerId)
         {
            this._questInfos = this._questsInformations[this._selectedQuest];
            this._questStepsList = [];
            if(!this.dataApi.getQuest(questId))
            {
               return;
            }
            stepsIds = this.dataApi.getQuest(questId).stepIds;
            for(st in stepsIds)
            {
               this._questStepsList.push(stepsIds[st]);
               if(infosAvailable && stepsIds[st] == this._questInfos.stepId)
               {
                  this._currentIndexForStep = st;
               }
            }
            if(infosAvailable)
            {
               this._currentStep = this._displayedStep = this._questInfos.stepId;
            }
            else
            {
               this._currentIndexForStep = 0;
               this._displayedStep = stepsIds[0];
               this._currentStep = stepsIds[stepsIds.length - 1];
            }
            this.updateStep(this._completedQuests.indexOf(questId) != -1);
         }
      }
      
      public function onTextureLoadFailed(target:GraphicContainer, behavior:Boolean) : void
      {
         (target as Texture).uri = this.uiApi.createUri(this.sysApi.getConfigEntry("config.gfx.path.item.bitmap") + "error.png");
      }
      
      public function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         if(this.inp_search.haveFocus)
         {
            this._lockSearchTimer.reset();
            this._lockSearchTimer.start();
         }
      }
      
      public function onTimeOut(e:TimerEvent) : void
      {
         if(this.inp_search.text.length > 2)
         {
            this._searchCriteria = this.inp_search.text.toLowerCase();
            this.updateQuestGrid();
         }
         else
         {
            if(this._searchCriteria)
            {
               this._searchCriteria = null;
            }
            if(this.inp_search.text.length == 0)
            {
               this.updateQuestGrid();
            }
         }
      }
      
      private function processQuestInfos(infos:QuestActiveInformations) : Boolean
      {
         var qai:QuestActiveInformations = null;
         var qid:uint = 0;
         var stepsInfos:QuestActiveDetailedInformations = null;
         var objective:QuestObjectiveInformations = null;
         var dialogParams:Array = null;
         var nbParams:int = 0;
         var i:int = 0;
         var compl:Object = null;
         var questAlreadyInArray:Boolean = false;
         for each(qai in this._activeQuests)
         {
            if(qai.questId == infos.questId)
            {
               questAlreadyInArray = true;
            }
         }
         for each(qid in this._completedQuests)
         {
            if(qid == infos.questId)
            {
               questAlreadyInArray = true;
            }
         }
         if(!questAlreadyInArray)
         {
            this._activeQuests.push(infos);
         }
         if(infos is QuestActiveDetailedInformations)
         {
            stepsInfos = infos as QuestActiveDetailedInformations;
            this._questsInformations[stepsInfos.questId] = {
               "questId":stepsInfos.questId,
               "stepId":stepsInfos.stepId
            };
            this._questsInformations[stepsInfos.questId].objectives = [];
            this._questsInformations[stepsInfos.questId].objectivesData = [];
            this._questsInformations[stepsInfos.questId].objectivesDialogParams = [];
            for each(objective in stepsInfos.objectives)
            {
               this._questsInformations[stepsInfos.questId].objectives[objective.objectiveId] = objective.objectiveStatus;
               if(objective.dialogParams && objective.dialogParams.length > 0)
               {
                  dialogParams = new Array();
                  nbParams = objective.dialogParams.length;
                  for(i = 0; i < nbParams; i++)
                  {
                     dialogParams.push(objective.dialogParams[i]);
                  }
               }
               this._questsInformations[stepsInfos.questId].objectivesDialogParams[objective.objectiveId] = dialogParams;
               if(objective is QuestObjectiveInformationsWithCompletion)
               {
                  compl = new Object();
                  compl.current = (objective as QuestObjectiveInformationsWithCompletion).curCompletion;
                  compl.max = (objective as QuestObjectiveInformationsWithCompletion).maxCompletion;
                  this._questsInformations[stepsInfos.questId].objectivesData[objective.objectiveId] = compl;
               }
            }
            return true;
         }
         return false;
      }
   }
}

class ObjectiveWrapper
{
    
   
   public var id:int;
   
   public var status:Boolean;
   
   public var currentCompletion:int = -1;
   
   public var maxCompletion:int = -1;
   
   function ObjectiveWrapper()
   {
      super();
   }
   
   public static function create(pId:int, pStatus:Boolean) : ObjectiveWrapper
   {
      var o:ObjectiveWrapper = new ObjectiveWrapper();
      o.id = pId;
      o.status = pStatus;
      return o;
   }
   
   public function addCompletion(pCurrentNb:int, pMaxNb:int) : void
   {
      this.currentCompletion = pCurrentNb;
      this.maxCompletion = pMaxNb;
   }
}
