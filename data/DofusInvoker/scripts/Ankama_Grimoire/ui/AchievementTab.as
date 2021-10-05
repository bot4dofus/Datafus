package Ankama_Grimoire.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_Grimoire.Grimoire;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.ProgressBar;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.appearance.Ornament;
   import com.ankamagames.dofus.datacenter.appearance.Title;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.datacenter.idols.Idol;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.datacenter.quest.AchievementCategory;
   import com.ankamagames.dofus.datacenter.quest.AchievementObjective;
   import com.ankamagames.dofus.datacenter.quest.AchievementReward;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.internalDatacenter.appearance.OrnamentWrapper;
   import com.ankamagames.dofus.internalDatacenter.appearance.TitleWrapper;
   import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.quest.AchievementRewardsWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementAlmostFinishedDetailedListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementDetailedListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementDetailsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementRewardRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.network.types.game.achievement.Achievement;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementAchieved;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementAchievedRewardable;
   import com.ankamagames.dofus.network.types.game.guild.GuildMember;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.QuestApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   
   public class AchievementTab
   {
      
      private static const CTR_CAT_TYPE_CAT:String = "ctr_cat";
      
      private static const CTR_CAT_TYPE_SUBCAT:String = "ctr_subCat";
      
      private static const CTR_ACH_ACHIEVEMENT:String = "ctr_achievement";
      
      private static const CTR_ACH_OBJECTIVES:String = "ctr_objectives";
      
      private static const CTR_ACH_REWARDS:String = "ctr_rewards";
      
      private static const CTR_ACH_EMPTY:String = "ctr_empty";
      
      private static const NAN_PERCENT_STRING:String = "NaN%";
      
      private static const TEMPORIS_CATEGORY:uint = 107;
      
      private static var GAUGE_WIDTH_OBJECTIVE:int;
      
      private static var GAUGE_WIDTH_CATEGORY:int;
      
      private static var GAUGE_WIDTH_TOTAL:int;
      
      private static const CHARACTER_DISPLAY:int = 0;
      
      private static const ACCOUNT_DISPLAY:int = 1;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="QuestApi")]
      public var questApi:QuestApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      private var _displayMode:int;
      
      private var _successPointsByDisplayMode:Array;
      
      private var _finishedAchievementsIdByDisplayMode:Array;
      
      private var _progressCategoriesByDisplayMode:Array;
      
      private var _totalSuccessPoints:int;
      
      private var _openCatIndex:int;
      
      private var _currentSelectedCatId:int;
      
      private var _selectedAchievementId:int;
      
      private var _selectedAndOpenedAchievementId:int;
      
      private var _myGuildXp:int;
      
      private var _hideAchievedAchievement:Boolean = true;
      
      private var _lockSearchTimer:BenchmarkTimer;
      
      private var _previousSearchCriteria:String;
      
      private var _categories:Array;
      
      private var _objectivesTextByAchievementId:Array;
      
      private var _searchCriteria:String;
      
      private var _forceOpenAchievement:Boolean;
      
      private var _currentScrollValue:int;
      
      private var _catFinishedAchievements:Dictionary;
      
      private var _catProgressingAchievements:Dictionary;
      
      private var _catIlluBtnList:Dictionary;
      
      private var _catProgressBarList:Dictionary;
      
      private var _ctrAchPointsList:Dictionary;
      
      private var _ctrAchBtnsList:Dictionary;
      
      private var _ctrTxList:Dictionary;
      
      private var _rewardsListList:Dictionary;
      
      private var _btnsAcceptRewardList:Dictionary;
      
      private var _ctrObjectiveMetaList:Dictionary;
      
      private var _dataAchievements:Array;
      
      private var _dataCategories:Array;
      
      private var _progressPopupName:String;
      
      private var _searchSettimoutId:uint;
      
      private var _searchTextByCriteriaList:Dictionary;
      
      private var _searchResultByCriteriaList:Dictionary;
      
      private var _searchOnName:Boolean;
      
      private var _searchOnObjective:Boolean;
      
      private var _searchOnReward:Boolean;
      
      private var _checkedUri:Object;
      
      private var _uncheckedUri:Object;
      
      private var _focusOnSearch:Boolean = false;
      
      private var _compHookData:Dictionary;
      
      public var ctr_achievements:GraphicContainer;
      
      public var ctr_endingAchievements:GraphicContainer;
      
      public var ctr_summary:GraphicContainer;
      
      public var ctr_globalProgress:GraphicContainer;
      
      public var gd_categories:Grid;
      
      public var gd_achievements:Grid;
      
      public var gd_endingAchievements:Grid;
      
      public var gd_summary:Grid;
      
      public var btn_tabAccount:ButtonContainer;
      
      public var btn_tabCharacter:ButtonContainer;
      
      public var btn_closeSearch:ButtonContainer;
      
      public var btn_searchFilter:ButtonContainer;
      
      public var btn_hideCompletedAchievements:ButtonContainer;
      
      public var inp_search:Input;
      
      public var tx_inputBg_search:TextureBitmap;
      
      public var lbl_noAchievement:Label;
      
      public var lbl_myPoints:Label;
      
      public var lbl_titleProgress:Label;
      
      public var lbl_endingAchievementsInfo:Label;
      
      public var lbl_almostFinished:Label;
      
      public var lbl_percent:Label;
      
      public var pb_progress:ProgressBar;
      
      public function AchievementTab()
      {
         this._successPointsByDisplayMode = [];
         this._finishedAchievementsIdByDisplayMode = [];
         this._progressCategoriesByDisplayMode = [];
         this._categories = [];
         this._objectivesTextByAchievementId = [];
         this._catFinishedAchievements = new Dictionary(true);
         this._catProgressingAchievements = new Dictionary(true);
         this._catIlluBtnList = new Dictionary(true);
         this._catProgressBarList = new Dictionary(true);
         this._ctrAchPointsList = new Dictionary(true);
         this._ctrAchBtnsList = new Dictionary(true);
         this._ctrTxList = new Dictionary(true);
         this._rewardsListList = new Dictionary(true);
         this._btnsAcceptRewardList = new Dictionary(true);
         this._ctrObjectiveMetaList = new Dictionary(true);
         this._searchTextByCriteriaList = new Dictionary(true);
         this._searchResultByCriteriaList = new Dictionary(true);
         this._compHookData = new Dictionary(true);
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         var hasChild:Boolean = false;
         var cat:AchievementCategory = null;
         var mainCat:Object = null;
         var lastAchievementCategoryOpenedId:int = 0;
         var myMemberInfo:GuildMember = null;
         var myId:Number = NaN;
         var memberInfo:GuildMember = null;
         var category:AchievementCategory = null;
         this.sysApi.addHook(QuestHookList.AchievementList,this.onAchievementList);
         this.sysApi.addHook(QuestHookList.AchievementDetailedList,this.onAchievementDetailedList);
         this.sysApi.addHook(QuestHookList.AchievementAlmostFinishedDetailedList,this.onAchievementAlmostFinishedDetailedList);
         this.sysApi.addHook(QuestHookList.AchievementDetails,this.onAchievementDetails);
         this.sysApi.addHook(QuestHookList.AchievementFinished,this.onAchievementFinished);
         this.sysApi.addHook(HookList.OpenBook,this.onOpenAchievement);
         this.sysApi.addHook(QuestHookList.AchievementRewardSuccess,this.onAchievementRewardSuccess);
         this.sysApi.addHook(SocialHookList.GuildInformationsMemberUpdate,this.onGuildInformationsMemberUpdate);
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.sysApi.addHook(BeriliaHookList.FocusChange,this.onFocusChange);
         this.uiApi.addComponentHook(this.gd_categories,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.btn_hideCompletedAchievements,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.lbl_myPoints,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_myPoints,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ctr_globalProgress,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_globalProgress,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_searchFilter,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_searchFilter,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_RELEASE);
         GAUGE_WIDTH_OBJECTIVE = int(this.uiApi.me().getConstant("gauge_width_objective"));
         GAUGE_WIDTH_CATEGORY = int(this.uiApi.me().getConstant("gauge_width_category"));
         GAUGE_WIDTH_TOTAL = int(this.uiApi.me().getConstant("gauge_width_total"));
         this._checkedUri = this.uiApi.createUri(this.uiApi.me().getConstant("tx_checked"));
         this._uncheckedUri = this.uiApi.createUri(this.uiApi.me().getConstant("tx_unchecked"));
         this._lockSearchTimer = new BenchmarkTimer(500,1,"AchievementTab._lockSearchTimer");
         this._lockSearchTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
         this.btn_hideCompletedAchievements.selected = this._hideAchievedAchievement;
         this._searchOnName = Grimoire.getInstance().achievementSearchOnName;
         this._searchOnObjective = Grimoire.getInstance().achievementSearchOnObjective;
         this._searchOnReward = Grimoire.getInstance().achievementSearchOnReward;
         this.inp_search.text = this.uiApi.getText("ui.common.search.input");
         this._searchTextByCriteriaList["_searchOnName"] = this.uiApi.getText("ui.common.name");
         this._searchTextByCriteriaList["_searchOnObjective"] = this.uiApi.getText("ui.grimoire.quest.objectives");
         this._searchTextByCriteriaList["_searchOnReward"] = this.uiApi.getText("ui.common.rewards");
         this._progressCategoriesByDisplayMode = [];
         this._finishedAchievementsIdByDisplayMode = [];
         this._successPointsByDisplayMode = [];
         this._progressCategoriesByDisplayMode[ACCOUNT_DISPLAY] = [];
         this._progressCategoriesByDisplayMode[CHARACTER_DISPLAY] = [];
         this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY] = [];
         this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY] = [];
         this.sysApi.sendAction(new AchievementAlmostFinishedDetailedListRequestAction());
         this._dataAchievements = this.dataApi.getAchievements();
         for(var i:int = 0; i < this._dataAchievements.length; i++)
         {
            if(this._dataAchievements[i].category.visible)
            {
               this._totalSuccessPoints += this._dataAchievements[i].points;
            }
            else
            {
               this._dataAchievements.removeAt(i);
               i--;
            }
         }
         this._dataCategories = this.dataApi.getAchievementCategories();
         for(i = 0; i < this._dataCategories.length; i++)
         {
            if(!this._dataCategories[i].visible)
            {
               this._dataCategories.removeAt(i);
               i--;
            }
            else if(this._dataCategories[i].parentId == 0)
            {
               this._categories.push({
                  "id":this._dataCategories[i].id,
                  "name":this._dataCategories[i].name,
                  "icon":this._dataCategories[i].icon,
                  "achievements":this._dataCategories[i].achievements,
                  "subcats":[],
                  "color":this._dataCategories[i].color,
                  "order":this._dataCategories[i].order
               });
            }
         }
         this._categories.sortOn("order",Array.NUMERIC);
         this._categories.splice(0,0,{
            "id":0,
            "name":this.uiApi.getText("ui.achievement.synthesis"),
            "achievements":null,
            "subcats":null
         });
         for each(mainCat in this._categories)
         {
            hasChild = false;
            for each(cat in this._dataCategories)
            {
               if(mainCat.id != 0 && cat.parentId == mainCat.id && !(this.sysApi.getCurrentServer().gameTypeId == GameServerTypeEnum.SERVER_TYPE_TEMPORIS && cat.id === TEMPORIS_CATEGORY))
               {
                  mainCat.subcats.push({
                     "id":cat.id,
                     "name":cat.name,
                     "parentId":cat.parentId,
                     "achievements":cat.achievements,
                     "order":cat.order
                  });
                  hasChild = true;
               }
            }
            if(hasChild)
            {
               mainCat.name += " (+)";
            }
            if(mainCat.id != 0)
            {
               mainCat.subcats.sortOn("order",Array.NUMERIC);
            }
         }
         this.questApi.refreshAchievementsCriterions();
         this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY] = this.questApi.getFinishedAccountAchievementIds();
         this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY] = this.questApi.getFinishedCharacterAchievementIds();
         this.gd_categories.dataProvider = this._categories;
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
            this._myGuildXp = myMemberInfo.experienceGivenPercent;
         }
         this._hideAchievedAchievement = this.sysApi.getData("hideCompletedAchievements");
         this.btn_hideCompletedAchievements.selected = this._hideAchievedAchievement;
         this._objectivesTextByAchievementId = Grimoire.getInstance().objectivesTextByAchievement;
         var openAchId:int = 0;
         var lastAchievementSearchCriteria:String = Grimoire.getInstance().lastAchievementSearchCriteria;
         var lastAchievementOpenedId:int = Grimoire.getInstance().lastAchievementOpenedId;
         var lastAchievementScrollValue:int = Grimoire.getInstance().lastAchievementScrollValue;
         if(oParam && oParam.hasOwnProperty("achievementCategoryId") && oParam.achievementCategoryId)
         {
            lastAchievementCategoryOpenedId = oParam.achievementCategoryId;
         }
         else
         {
            lastAchievementCategoryOpenedId = Grimoire.getInstance().lastAchievementCategoryOpenedId;
         }
         if(oParam && oParam.achievementId)
         {
            openAchId = oParam.achievementId;
         }
         else if(lastAchievementSearchCriteria && lastAchievementSearchCriteria != "")
         {
            this._searchCriteria = lastAchievementSearchCriteria.toLowerCase();
            this.inp_search.text = this._searchCriteria;
            this._currentScrollValue = lastAchievementScrollValue;
            if(lastAchievementOpenedId > 0)
            {
               this.sysApi.sendAction(new AchievementDetailsRequestAction([lastAchievementOpenedId]));
               this._selectedAchievementId = lastAchievementOpenedId;
            }
            this.updateAchievementGrid(this._currentSelectedCatId);
         }
         else if(lastAchievementOpenedId > 0)
         {
            openAchId = lastAchievementOpenedId;
         }
         else if(lastAchievementCategoryOpenedId > 0)
         {
            this._currentScrollValue = lastAchievementScrollValue;
            category = this.dataApi.getAchievementCategory(lastAchievementCategoryOpenedId);
            this.updateCategories(category,true);
         }
         if(openAchId > 0)
         {
            this._selectedAchievementId = openAchId;
            this._forceOpenAchievement = true;
         }
         if(openAchId > 0 || lastAchievementCategoryOpenedId > 0 || this._searchCriteria)
         {
            this.ctr_achievements.visible = true;
            this.ctr_endingAchievements.visible = false;
            this.ctr_summary.visible = false;
         }
         else
         {
            this.gd_categories.selectedIndex = 0;
            this.ctr_achievements.visible = false;
            this.ctr_endingAchievements.visible = this._displayMode == CHARACTER_DISPLAY;
            this.ctr_summary.visible = this._displayMode == ACCOUNT_DISPLAY;
         }
         this.onAchievementList();
         this.displayAccountMode(this.sysApi.getData("achievementAccountDisplayMode"),true);
      }
      
      public function unload() : void
      {
         if(this._lockSearchTimer)
         {
            this._lockSearchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
            this._lockSearchTimer.stop();
            this._lockSearchTimer = null;
         }
         this.sysApi.setData("hideCompletedAchievements",this._hideAchievedAchievement);
         Grimoire.getInstance().lastAchievementSearchCriteria = this._searchCriteria;
         Grimoire.getInstance().lastAchievementCategoryOpenedId = this._currentSelectedCatId;
         Grimoire.getInstance().lastAchievementOpenedId = this._selectedAndOpenedAchievementId;
         Grimoire.getInstance().lastAchievementScrollValue = this.gd_achievements.verticalScrollValue;
      }
      
      public function showTabHints() : void
      {
         this.hintsApi.showSubHints();
      }
      
      public function updateCardLine(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         var objectiveId:int = 0;
         var ach:com.ankamagames.dofus.network.types.game.achievement.Achievement = null;
         var rewards:Array = null;
         var rewardId:int = 0;
         var xpX:int = 0;
         var kamasX:int = 0;
         var giftX:int = 0;
         var xpReward:Number = NaN;
         var kamasReward:Number = NaN;
         var rewardsText:String = null;
         var category:AchievementCategory = null;
         var objectiveData:Array = null;
         var startedObjective:* = undefined;
         if(data)
         {
            componentsRef.ctr_card.visible = true;
            componentsRef.ctr_cardBody.bgColor = 3029565;
            for each(objectiveId in data.objectiveIds)
            {
               if(AchievementObjective.getAchievementObjectiveById(objectiveId).criterion.indexOf("OA=") != -1)
               {
                  componentsRef.ctr_cardBody.bgColor = 2711404;
               }
            }
            if(this._catProgressingAchievements[data.id])
            {
               ach = this._catProgressingAchievements[data.id];
            }
            else if(this._catFinishedAchievements[data.id])
            {
               ach = this._catFinishedAchievements[data.id];
            }
            if(ach)
            {
               category = this.dataApi.getAchievementCategory(data.categoryId);
               componentsRef.lbl_cardType.text = (category.parentId > 0 ? this.dataApi.getAchievementCategory(category.parentId).name + " - " : "") + category.name;
               componentsRef.lbl_cardDescription.text = data.description;
               componentsRef.lbl_cardName.text = data.name;
               componentsRef.tx_cardPicture.uri = this.uiApi.createUri(this.uiApi.me().getConstant("achievementPath") + data.iconId + ".png");
               objectiveData = [];
               for each(startedObjective in ach.startedObjectives)
               {
                  if(this.dataApi.getAchievementObjective(startedObjective.id))
                  {
                     objectiveData.push(startedObjective);
                  }
               }
               componentsRef.gd_cardObjectives.dataProvider = objectiveData;
               componentsRef.lbl_cardMoreObjectives.visible = objectiveData.length > 2;
            }
            rewards = [];
            for each(rewardId in data.rewardIds)
            {
               rewards.push(AchievementReward.getAchievementRewardById(rewardId));
            }
            xpX = 0;
            kamasX = 29;
            giftX = 54;
            xpReward = this.questApi.getAchievementExperienceReward(data);
            if(xpReward > 0 && this.configApi.isFeatureWithKeywordEnabled("character.xp"))
            {
               this._compHookData[componentsRef.btn_cardXp] = xpReward;
               this.uiApi.addComponentHook(componentsRef.btn_cardXp,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.btn_cardXp,ComponentHookList.ON_ROLL_OUT);
               componentsRef.btn_cardXp.visible = true;
            }
            else
            {
               componentsRef.btn_cardXp.visible = false;
            }
            kamasReward = this.questApi.getAchievementKamasReward(data);
            if(kamasReward > 0)
            {
               this._compHookData[componentsRef.btn_cardKamas] = kamasReward;
               this.uiApi.addComponentHook(componentsRef.btn_cardKamas,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.btn_cardKamas,ComponentHookList.ON_ROLL_OUT);
               componentsRef.btn_cardKamas.visible = true;
            }
            else
            {
               xpX += 27;
               componentsRef.btn_cardKamas.visible = false;
            }
            rewardsText = this.questApi.getAchievementRewardsText(this.questApi.getAchievementReward(data));
            if(rewardsText != "")
            {
               this._compHookData[componentsRef.btn_cardGift] = rewardsText;
               this.uiApi.addComponentHook(componentsRef.btn_cardGift,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.btn_cardGift,ComponentHookList.ON_ROLL_OUT);
               componentsRef.btn_cardGift.visible = true;
            }
            else
            {
               xpX += 27;
               kamasX += 27;
               componentsRef.btn_cardGift.visible = false;
            }
            if(data.points > 0)
            {
               this._compHookData[componentsRef.btn_cardTrophy] = data.points;
               this.uiApi.addComponentHook(componentsRef.btn_cardTrophy,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.btn_cardTrophy,ComponentHookList.ON_ROLL_OUT);
               componentsRef.btn_cardTrophy.visible = true;
            }
            else
            {
               xpX += 27;
               kamasX += 27;
               giftX += 27;
               componentsRef.btn_cardTrophy.visible = false;
            }
            componentsRef.btn_cardXp.x = xpX;
            componentsRef.btn_cardKamas.x = kamasX;
            componentsRef.btn_cardGift.x = giftX;
            this._compHookData[componentsRef.btn_cardLink] = data;
            this.uiApi.addComponentHook(componentsRef.btn_cardLink,ComponentHookList.ON_RELEASE);
            this._compHookData[componentsRef.btn_mainGridLink] = data;
            this.uiApi.addComponentHook(componentsRef.btn_mainGridLink,ComponentHookList.ON_RELEASE);
         }
      }
      
      public function getCardLineType(data:*, line:uint) : String
      {
         if(data)
         {
            return "ctr_card";
         }
         return "ctr_emptyLine";
      }
      
      public function updateCardObjectives(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(!data)
         {
            componentsRef.ctr_cardObjectiveBinary.visible = false;
            componentsRef.ctr_cardObjectiveProgress.visible = false;
         }
         else if(data.maxValue == 1)
         {
            componentsRef.ctr_cardObjectiveBinary.visible = true;
            componentsRef.ctr_cardObjectiveProgress.visible = false;
            componentsRef.btn_texture_btn_cardObjectiveBinary.disabled = true;
            componentsRef.btn_label_btn_cardObjectiveBinary.text = AchievementObjective.getAchievementObjectiveById(data.id).name;
            componentsRef.btn_cardObjectiveBinary.selected = false;
            componentsRef.btn_cardObjectiveBinary.buttonMode = false;
         }
         else
         {
            componentsRef.ctr_cardObjectiveProgress.visible = true;
            componentsRef.ctr_cardObjectiveBinary.visible = false;
            componentsRef.tx_cardObjectiveProgress.value = (!!data.hasOwnProperty("value") ? data.value : data.maxValue) / data.maxValue;
            componentsRef.lbl_cardObjectiveProgress.text = (!!data.hasOwnProperty("value") ? data.value : data.maxValue) + "/" + data.maxValue;
         }
      }
      
      public function updateSummary(data:*, componentsRef:*, selected:Boolean) : void
      {
         var percentStr:String = null;
         var id:String = null;
         var percent:Number = NaN;
         if(!this._catIlluBtnList[componentsRef.ctr_illu.name])
         {
            this.uiApi.addComponentHook(componentsRef.ctr_illu,ComponentHookList.ON_RELEASE);
         }
         this._catIlluBtnList[componentsRef.ctr_illu.name] = data;
         if(!this._catProgressBarList[componentsRef.ctr_progress.name])
         {
            this.uiApi.addComponentHook(componentsRef.ctr_progress,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.ctr_progress,ComponentHookList.ON_ROLL_OUT);
         }
         this._catProgressBarList[componentsRef.ctr_progress.name] = data;
         if(data)
         {
            this.sysApi.log(1," - " + data.name + "  " + data.value);
            if(data.total > 0)
            {
               percent = Math.floor(data.value / data.total * 100);
               if(percent > 100)
               {
                  percent = 100;
               }
               percentStr = percent.toString();
            }
            else
            {
               percentStr = "-";
            }
            componentsRef.lbl_name.text = data.name;
            componentsRef.lbl_percent.text = percentStr + "%";
            id = data.icon.replace("cat_","");
            if(!id.length)
            {
               id = "7";
            }
            componentsRef.tx_illu.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illusUi") + "success_illu_" + id + ".png");
            componentsRef.tx_icon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("success") + "success_" + data.icon + ".png");
            componentsRef.ctr_illu.handCursor = true;
            componentsRef.pb_progress.value = percent / 100;
            componentsRef.ctr_summary.visible = true;
         }
         else
         {
            componentsRef.ctr_summary.visible = false;
         }
      }
      
      public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         var finishedNbCat:int = 0;
         var totalNbCat:int = 0;
         var ach:Object = null;
         var finishedNb:int = 0;
         var totalNb:int = 0;
         var subcat:* = undefined;
         var subach:Object = null;
         var percentStr:String = null;
         var percent:int = 0;
         if(!this._catProgressBarList[componentsRef.lbl_catPercent.name])
         {
            this.uiApi.addComponentHook(componentsRef.lbl_catPercent,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.lbl_catPercent,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(componentsRef.lbl_catPercent,ComponentHookList.ON_RELEASE);
         }
         this._catProgressBarList[componentsRef.lbl_catPercent.name] = data;
         switch(this.getCatLineType(data,line))
         {
            case CTR_CAT_TYPE_CAT:
               if(data.icon)
               {
                  componentsRef.tx_catIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("success") + "success_" + data.icon + ".png");
               }
               else
               {
                  componentsRef.tx_catIcon.uri = null;
               }
               componentsRef.lbl_catName.text = data.name;
               finishedNbCat = 0;
               totalNbCat = 0;
               for each(ach in data.achievements)
               {
                  if(ach)
                  {
                     totalNbCat++;
                     if(this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(ach.id) != -1)
                     {
                        finishedNbCat++;
                     }
                  }
               }
               for each(subcat in data.subcats)
               {
                  for each(subach in subcat.achievements)
                  {
                     if(subach)
                     {
                        totalNbCat++;
                        if(this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(subach.id) != -1)
                        {
                           finishedNbCat++;
                        }
                     }
                  }
               }
               componentsRef.lbl_catPercent.text = Math.floor(finishedNbCat / totalNbCat * 100).toString() + "%";
               if(data.id == 0)
               {
                  componentsRef.lbl_catPercent.text = this.lbl_percent.text;
               }
               componentsRef.lbl_catPercent.visible = componentsRef.lbl_catPercent.text != NAN_PERCENT_STRING;
               componentsRef.btn_cat.selected = selected;
               break;
            case CTR_CAT_TYPE_SUBCAT:
               componentsRef.lbl_catName.text = data.name;
               finishedNb = 0;
               totalNb = 0;
               if(data.id > 0 && data.achievements && data.achievements.length > 0)
               {
                  for each(ach in data.achievements)
                  {
                     if(ach)
                     {
                        totalNb++;
                        if(this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(ach.id) != -1)
                        {
                           finishedNb++;
                        }
                     }
                  }
                  if(totalNb > 0)
                  {
                     percent = Math.floor(finishedNb / totalNb * 100);
                     percentStr = percent.toString();
                  }
                  else
                  {
                     percentStr = "-";
                  }
                  componentsRef.lbl_catPercent.text = percentStr + "%";
               }
               else
               {
                  componentsRef.lbl_catPercent.text = "";
               }
               componentsRef.btn_cat.selected = selected;
         }
      }
      
      public function getCatLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         if(data && !data.hasOwnProperty("parentId"))
         {
            return CTR_CAT_TYPE_CAT;
         }
         return CTR_CAT_TYPE_SUBCAT;
      }
      
      public function getCatDataLength(data:*, selected:Boolean) : *
      {
         return 2 + (!!selected ? data.subcats.length : 0);
      }
      
      public function updateAchievement(data:*, compRef:*, selected:Boolean, line:uint) : void
      {
         var achievementObjectiveId:int = 0;
         var achievementObjective:AchievementObjective = null;
         var monster:Monster = null;
         var ach:Object = null;
         var objective:Object = null;
         var completed:Boolean = false;
         var obj:Object = null;
         var rewardData:Object = null;
         var rewardsSlotContent:Array = null;
         var firstXPosition:int = 0;
         var indexOA:int = 0;
         var lastValueIndex:int = 0;
         var charAt:String = null;
         var achId:int = 0;
         var value:Number = NaN;
         var maxValue:int = 0;
         var i:int = 0;
         var rewardId:uint = 0;
         var item:ItemWrapper = null;
         var emote:EmoteWrapper = null;
         var spell:SpellWrapper = null;
         var title:TitleWrapper = null;
         var ornament:OrnamentWrapper = null;
         var slot:Slot = null;
         switch(this.getAchievementLineType(data,line))
         {
            case CTR_ACH_ACHIEVEMENT:
               if(!this._ctrAchPointsList[compRef.ctr_achPoints.name])
               {
                  this.uiApi.addComponentHook(compRef.ctr_achPoints,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.ctr_achPoints,ComponentHookList.ON_ROLL_OUT);
               }
               this._ctrAchPointsList[compRef.ctr_achPoints.name] = data;
               if(!this._ctrAchBtnsList[compRef.btn_ach.name])
               {
                  this.uiApi.addComponentHook(compRef.btn_ach,ComponentHookList.ON_RELEASE);
               }
               this._ctrAchBtnsList[compRef.btn_ach.name] = data;
               if(!this._ctrTxList[compRef.tx_incompatibleIdols.name])
               {
                  this.uiApi.addComponentHook(compRef.tx_incompatibleIdols,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.tx_incompatibleIdols,ComponentHookList.ON_ROLL_OUT);
               }
               if(!this._ctrTxList[compRef.tx_successBySomeoneElse.name])
               {
                  this.uiApi.addComponentHook(compRef.tx_successBySomeoneElse,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.tx_successBySomeoneElse,ComponentHookList.ON_ROLL_OUT);
               }
               for each(achievementObjectiveId in data.objectiveIds)
               {
                  achievementObjective = this.dataApi.getAchievementObjective(achievementObjectiveId);
                  if(achievementObjective && achievementObjective.criterion.indexOf("Ei") != -1)
                  {
                     monster = this.dataApi.getMonsterFromId(achievementObjective.criterion.split(",")[0].split(">")[1]);
                     if(monster && monster.incompatibleIdols.length > 0)
                     {
                        this._ctrTxList[compRef.tx_incompatibleIdols.name] = monster;
                     }
                  }
               }
               compRef.tx_incompatibleIdols.visible = monster && monster.incompatibleIdols.length > 0;
               compRef.btn_ach.handCursor = true;
               compRef.lbl_name.text = data.name;
               if(this.sysApi.getPlayerManager().hasRights)
               {
                  compRef.lbl_name.text += " (" + data.id + ")";
               }
               compRef.lbl_points.text = data.points;
               compRef.lbl_description.text = data.getDescriptionWithLinks();
               compRef.lbl_description.fullWidthAndHeight(compRef.lbl_description.width);
               compRef.ctr_achievementText.y = compRef.btn_ach.y + compRef.btn_ach.height / 2 - compRef.ctr_achievementText.height / 2;
               compRef.tx_icon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("achievementPath") + data.iconId + ".png");
               if(this._catFinishedAchievements[data.id] || this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(data.id) != -1)
               {
                  compRef.ctr_bg.bgColor = this.sysApi.getConfigEntry("colors.multigrid.selected");
               }
               else
               {
                  compRef.ctr_bg.bgColor = this.sysApi.getConfigEntry("colors.multigrid.line");
               }
               if(this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY].indexOf(data.id) != -1 && this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY].indexOf(data.id) == -1)
               {
                  compRef.tx_successBySomeoneElse.visible = true;
                  if(this._displayMode == CHARACTER_DISPLAY)
                  {
                     compRef.ctr_bg.bgColor = this.sysApi.getConfigEntry("colors.multigrid.subselected");
                  }
               }
               else
               {
                  compRef.tx_successBySomeoneElse.visible = false;
               }
               if(compRef.tx_incompatibleIdols.visible || compRef.tx_successBySomeoneElse.visible)
               {
                  firstXPosition = compRef.lbl_name.x + compRef.lbl_name.textWidth + 10;
                  if(compRef.tx_incompatibleIdols.visible)
                  {
                     compRef.tx_incompatibleIdols.x = firstXPosition;
                     compRef.tx_successBySomeoneElse.x = firstXPosition + 20;
                  }
                  else
                  {
                     compRef.tx_successBySomeoneElse.x = firstXPosition;
                  }
               }
               break;
            case CTR_ACH_OBJECTIVES:
               this._selectedAndOpenedAchievementId = this._selectedAchievementId;
               if(this._catProgressingAchievements[this._selectedAchievementId])
               {
                  ach = this._catProgressingAchievements[this._selectedAchievementId];
               }
               else if(this._catFinishedAchievements[this._selectedAchievementId])
               {
                  ach = this._catFinishedAchievements[this._selectedAchievementId];
               }
               if(!ach)
               {
                  break;
               }
               objective = !!data.hasOwnProperty("objective") ? data.objective : null;
               for each(obj in ach.finishedObjective)
               {
                  if(obj.id == data.objectiveData.id)
                  {
                     objective = obj;
                     completed = true;
                  }
               }
               if(!completed)
               {
                  for each(obj in ach.startedObjectives)
                  {
                     if(obj.id == data.objectiveData.id)
                     {
                        objective = obj;
                     }
                  }
               }
               if(!objective)
               {
                  break;
               }
               if(this._displayMode == ACCOUNT_DISPLAY && data.doneBySomeoneElse)
               {
                  completed = true;
               }
               if(objective.maxValue == 1)
               {
                  compRef.lbl_objectiveBin.text = data.objectiveData.name;
                  if(data.objectiveData.id != -1 && this.sysApi.getPlayerManager().hasRights)
                  {
                     compRef.lbl_objectiveBin.text += " (" + data.objectiveData.id + ")";
                  }
                  if(completed || objective.value == 1)
                  {
                     compRef.tx_objectiveBin.uri = this._checkedUri;
                     compRef.lbl_objectiveBin.alpha = 0.5;
                  }
                  else
                  {
                     compRef.tx_objectiveBin.uri = this._uncheckedUri;
                     compRef.lbl_objectiveBin.alpha = 1;
                  }
                  compRef.ctr_objectiveBin.visible = true;
                  compRef.ctr_objectiveProgress.visible = false;
                  indexOA = data.objectiveData.criterion.indexOf("OA");
                  if(indexOA != -1)
                  {
                     if(!this._ctrObjectiveMetaList[compRef.ctr_objectiveBin.name])
                     {
                        this.uiApi.addComponentHook(compRef.ctr_objectiveBin,ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(compRef.ctr_objectiveBin,ComponentHookList.ON_ROLL_OUT);
                        this.uiApi.addComponentHook(compRef.ctr_objectiveBin,ComponentHookList.ON_RELEASE);
                     }
                     lastValueIndex = indexOA + 3;
                     charAt = data.objectiveData.criterion.charAt(lastValueIndex);
                     while(charAt == "0" || charAt == "1" || charAt == "2" || charAt == "3" || charAt == "4" || charAt == "5" || charAt == "6" || charAt == "7" || charAt == "8" || charAt == "9")
                     {
                        lastValueIndex++;
                        charAt = data.objectiveData.criterion.charAt(lastValueIndex);
                     }
                     achId = int(data.objectiveData.criterion.substring(indexOA + 3,lastValueIndex));
                     this._ctrObjectiveMetaList[compRef.ctr_objectiveBin.name] = achId;
                     compRef.lbl_objectiveBin.text += " " + this.uiApi.getText("ui.common.fakeLinkSee");
                     compRef.ctr_objectiveBin.handCursor = true;
                  }
                  else
                  {
                     compRef.ctr_objectiveBin.handCursor = false;
                     this._ctrObjectiveMetaList[compRef.ctr_objectiveBin.name] = 0;
                  }
               }
               else
               {
                  maxValue = objective.maxValue;
                  if(completed)
                  {
                     value = maxValue;
                  }
                  else
                  {
                     value = objective.value;
                  }
                  compRef.lbl_objectiveProgress.text = value + "/" + maxValue;
                  compRef.tx_objectiveProgress.value = value / maxValue;
                  compRef.ctr_objectiveBin.visible = false;
                  compRef.ctr_objectiveProgress.visible = true;
               }
               break;
            case CTR_ACH_REWARDS:
               if(this._displayMode == CHARACTER_DISPLAY)
               {
                  rewardData = data.characterRewardData;
               }
               else
               {
                  rewardData = data.rewardData;
               }
               if(data.kamas > 0)
               {
                  (compRef.lbl_rewardsKama as Label).visible = (compRef.tx_rewardsKama as TextureBitmap).visible = true;
                  (compRef.lbl_rewardsKama as Label).text = this.utilApi.formateIntToString(data.kamas);
               }
               else
               {
                  (compRef.lbl_rewardsKama as Label).visible = (compRef.tx_rewardsKama as TextureBitmap).visible = false;
               }
               if(data.xp > 0 && this.configApi.isFeatureWithKeywordEnabled("character.xp"))
               {
                  (compRef.tx_rewardsXp as TextureBitmap).visible = (compRef.lbl_rewardsXp as Label).visible = true;
                  (compRef.lbl_rewardsXp as Label).text = this.utilApi.formateIntToString(data.xp);
               }
               else
               {
                  (compRef.tx_rewardsXp as TextureBitmap).visible = (compRef.lbl_rewardsXp as Label).visible = false;
               }
               if(!((compRef.lbl_rewardsXp as Label).visible || (compRef.lbl_rewardsKama as Label).visible))
               {
                  (compRef.gd_rewards as Grid).x = this.uiApi.me().getConstant("reward_slot_without_xp_x");
               }
               else
               {
                  (compRef.gd_rewards as Grid).x = this.uiApi.me().getConstant("reward_slot_with_xp_x");
               }
               compRef.btn_accept.visible = data.rewardable;
               compRef.btn_accept.softDisabled = this._displayMode == ACCOUNT_DISPLAY;
               compRef.tx_warningReward.visible = rewardData.rewardTruncated;
               rewardsSlotContent = [];
               if(rewardData)
               {
                  for(i = 0; i < rewardData.itemsReward.length; i++)
                  {
                     item = this.dataApi.getItemWrapper(rewardData.itemsReward[i],0,0,rewardData.itemsQuantityReward[i]);
                     rewardsSlotContent.push(item);
                  }
                  for each(rewardId in rewardData.emotesReward)
                  {
                     emote = this.dataApi.getEmoteWrapper(rewardId);
                     rewardsSlotContent.push(emote);
                  }
                  for each(rewardId in rewardData.spellsReward)
                  {
                     spell = this.dataApi.getSpellWrapper(rewardId);
                     rewardsSlotContent.push(spell);
                  }
                  for each(rewardId in rewardData.titlesReward)
                  {
                     title = this.dataApi.getTitleWrapper(rewardId);
                     rewardsSlotContent.push(title);
                  }
                  for each(rewardId in rewardData.ornamentsReward)
                  {
                     ornament = this.dataApi.getOrnamentWrapper(rewardId);
                     rewardsSlotContent.push(ornament);
                  }
               }
               compRef.gd_rewards.dataProvider = rewardsSlotContent;
               if((compRef.gd_rewards.slots as Array).length > 0)
               {
                  (compRef.gd_rewards as Grid).visible = true;
                  for each(slot in compRef.gd_rewards.slots)
                  {
                     if(!slot.data)
                     {
                        slot.visible = false;
                     }
                     else
                     {
                        slot.visible = true;
                     }
                  }
               }
               else
               {
                  (compRef.gd_rewards as Grid).visible = false;
               }
               if(!this._rewardsListList[compRef.gd_rewards.name])
               {
                  this.uiApi.addComponentHook(compRef.gd_rewards,ComponentHookList.ON_ITEM_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.gd_rewards,ComponentHookList.ON_ITEM_ROLL_OUT);
               }
               this._rewardsListList[compRef.gd_rewards.name] = data;
               if(!this._rewardsListList[compRef.tx_warningReward.name])
               {
                  this.uiApi.addComponentHook(compRef.tx_warningReward,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.tx_warningReward,ComponentHookList.ON_ROLL_OUT);
               }
               this._rewardsListList[compRef.tx_warningReward.name] = data;
               if(!this._btnsAcceptRewardList[compRef.btn_accept.name])
               {
                  this.uiApi.addComponentHook(compRef.btn_accept,ComponentHookList.ON_RELEASE);
                  this.uiApi.addComponentHook(compRef.btn_accept,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.btn_accept,ComponentHookList.ON_ROLL_OUT);
               }
               this._btnsAcceptRewardList[compRef.btn_accept.name] = this._selectedAchievementId;
               break;
            case CTR_ACH_EMPTY:
         }
      }
      
      public function getAchievementLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         if(data && data.hasOwnProperty("rewardData"))
         {
            return CTR_ACH_REWARDS;
         }
         if(data && data.hasOwnProperty("objectiveData"))
         {
            return CTR_ACH_OBJECTIVES;
         }
         if(data && data.hasOwnProperty("empty"))
         {
            return CTR_ACH_EMPTY;
         }
         return CTR_ACH_ACHIEVEMENT;
      }
      
      public function getAchievementDataLength(data:*, selected:Boolean) : *
      {
         return 1;
      }
      
      private function updateAchievementGrid(catId:int, hideAchievedAchievementChanged:Boolean = false) : void
      {
         var ach:com.ankamagames.dofus.datacenter.quest.Achievement = null;
         var category:AchievementCategory = null;
         var tempAchs:Array = null;
         var ts:uint = 0;
         var result:Object = null;
         var titleName:String = null;
         var critSplit:Array = null;
         var options:String = null;
         var nameResult:Vector.<uint> = null;
         var objectiveResult:Vector.<uint> = null;
         var rewardResult:Vector.<uint> = null;
         var achObj:Object = null;
         var currentCriteria:String = null;
         var wannabeCriteria:String = null;
         var crit:* = null;
         var index:int = 0;
         var indexToScroll:int = 0;
         var achievements:Array = [];
         this._selectedAndOpenedAchievementId = 0;
         if(!this._searchCriteria)
         {
            if(catId == 0)
            {
               this.ctr_achievements.visible = false;
               this.ctr_endingAchievements.visible = this._displayMode == CHARACTER_DISPLAY;
               this.ctr_summary.visible = this._displayMode == ACCOUNT_DISPLAY;
               this._selectedAchievementId = 0;
            }
            else
            {
               this.ctr_achievements.visible = true;
               this.ctr_summary.visible = false;
               this.ctr_endingAchievements.visible = false;
               category = this.dataApi.getAchievementCategory(catId);
               tempAchs = [];
               for each(ach in category.achievements)
               {
                  if(ach)
                  {
                     if(!(this._hideAchievedAchievement && this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(ach.id) > -1))
                     {
                        tempAchs.push(ach);
                     }
                  }
               }
               tempAchs.sortOn("order",Array.NUMERIC);
               for each(ach in tempAchs)
               {
                  achievements.push(ach);
                  achievements.push(null);
                  achievements.push(null);
                  achievements.push(null);
                  achievements.push(null);
                  achievements.push(null);
                  if(ach.id == this._selectedAchievementId)
                  {
                     indexToScroll = index;
                     achievements = achievements.concat(this.addObjectivesAndRewards(ach,category));
                  }
                  index++;
                  index++;
                  index++;
                  index++;
                  index++;
                  index++;
               }
            }
         }
         else if(this._previousSearchCriteria != this._searchCriteria + "#" + this._searchOnName + "" + this._searchOnObjective + "" + this._searchOnReward || !this._hideAchievedAchievement && hideAchievedAchievementChanged)
         {
            ts = getTimer();
            titleName = this.playerApi.getPlayedCharacterInfo().sex == 0 ? "nameMale" : "nameFemale";
            critSplit = !!this._previousSearchCriteria ? this._previousSearchCriteria.split("#") : [];
            if(this._searchCriteria != critSplit[0])
            {
               nameResult = this.dataApi.queryUnion(this.dataApi.queryString(com.ankamagames.dofus.datacenter.quest.Achievement,"description",this._searchCriteria),this.dataApi.queryString(com.ankamagames.dofus.datacenter.quest.Achievement,"name",this._searchCriteria));
               objectiveResult = this.dataApi.queryEquals(com.ankamagames.dofus.datacenter.quest.Achievement,"objectiveIds",this.dataApi.queryString(AchievementObjective,"name",this._searchCriteria));
               rewardResult = this.dataApi.queryEquals(com.ankamagames.dofus.datacenter.quest.Achievement,"rewardIds",this.dataApi.queryUnion(this.dataApi.queryEquals(AchievementReward,"itemsReward",this.dataApi.queryString(Item,"name",this._searchCriteria)),this.dataApi.queryEquals(AchievementReward,"emotesReward",this.dataApi.queryString(Emoticon,"name",this._searchCriteria)),this.dataApi.queryEquals(AchievementReward,"spellsReward",this.dataApi.queryString(Spell,"name",this._searchCriteria)),this.dataApi.queryEquals(AchievementReward,"titlesReward",this.dataApi.queryString(Title,titleName,this._searchCriteria)),this.dataApi.queryEquals(AchievementReward,"ornamentsReward",this.dataApi.queryString(Ornament,"name",this._searchCriteria))));
               this._searchResultByCriteriaList["_searchOnName"] = nameResult;
               this._searchResultByCriteriaList["_searchOnObjective"] = objectiveResult;
               this._searchResultByCriteriaList["_searchOnReward"] = rewardResult;
               if(nameResult || objectiveResult || rewardResult)
               {
                  this.sysApi.log(2,"Result : " + ((!!nameResult ? nameResult.length : 0) + (!!objectiveResult ? objectiveResult.length : 0) + (!!rewardResult ? rewardResult.length : 0)) + " in " + (getTimer() - ts) + " ms");
               }
            }
            options = "" + this._searchOnName + "" + this._searchOnObjective + "" + this._searchOnReward;
            switch(options)
            {
               case "truetruetrue":
                  result = this.dataApi.queryReturnInstance(com.ankamagames.dofus.datacenter.quest.Achievement,this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnName"],this._searchResultByCriteriaList["_searchOnObjective"],this._searchResultByCriteriaList["_searchOnReward"]));
                  break;
               case "truetruefalse":
                  result = this.dataApi.queryReturnInstance(com.ankamagames.dofus.datacenter.quest.Achievement,this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnName"],this._searchResultByCriteriaList["_searchOnObjective"]));
                  break;
               case "truefalsetrue":
                  result = this.dataApi.queryReturnInstance(com.ankamagames.dofus.datacenter.quest.Achievement,this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnName"],this._searchResultByCriteriaList["_searchOnReward"]));
                  break;
               case "truefalsefalse":
                  result = this.dataApi.queryReturnInstance(com.ankamagames.dofus.datacenter.quest.Achievement,this._searchResultByCriteriaList["_searchOnName"]);
                  break;
               case "falsetruetrue":
                  result = this.dataApi.queryReturnInstance(com.ankamagames.dofus.datacenter.quest.Achievement,this.dataApi.queryUnion(this._searchResultByCriteriaList["_searchOnObjective"],this._searchResultByCriteriaList["_searchOnReward"]));
                  break;
               case "falsetruefalse":
                  result = this.dataApi.queryReturnInstance(com.ankamagames.dofus.datacenter.quest.Achievement,this._searchResultByCriteriaList["_searchOnObjective"]);
                  break;
               case "falsefalsetrue":
                  result = this.dataApi.queryReturnInstance(com.ankamagames.dofus.datacenter.quest.Achievement,this._searchResultByCriteriaList["_searchOnReward"]);
                  break;
               case "falsefalsefalse":
                  this.gd_achievements.dataProvider = [];
                  this.lbl_noAchievement.visible = true;
                  this.lbl_noAchievement.text = this.uiApi.getText("ui.search.needCriterion");
                  this._previousSearchCriteria = this._searchCriteria + "#" + this._searchOnName + "" + this._searchOnObjective + "" + this._searchOnReward;
                  return;
            }
            for each(ach in result)
            {
               if(!(!ach.category.visible || this._hideAchievedAchievement && this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(ach.id) > -1))
               {
                  achievements.push(ach);
                  achievements.push(null);
                  achievements.push(null);
                  achievements.push(null);
                  achievements.push(null);
                  achievements.push(null);
                  if(ach.id == this._selectedAchievementId)
                  {
                     achievements = achievements.concat(this.addObjectivesAndRewards(ach,ach.category));
                  }
               }
            }
         }
         else
         {
            for each(achObj in this.gd_achievements.dataProvider)
            {
               if(achObj && achObj is com.ankamagames.dofus.datacenter.quest.Achievement)
               {
                  if(!(!achObj.category.visible || this._hideAchievedAchievement && this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(achObj.id) > -1))
                  {
                     achievements.push(achObj);
                     achievements.push(null);
                     achievements.push(null);
                     achievements.push(null);
                     achievements.push(null);
                     achievements.push(null);
                     if(achObj.id == this._selectedAchievementId)
                     {
                        indexToScroll = index;
                        achievements = achievements.concat(this.addObjectivesAndRewards(achObj as com.ankamagames.dofus.datacenter.quest.Achievement,achObj.category));
                     }
                     index++;
                     index++;
                     index++;
                     index++;
                     index++;
                     index++;
                  }
               }
            }
         }
         this.gd_achievements.dataProvider = achievements;
         if(this._forceOpenAchievement)
         {
            this._forceOpenAchievement = false;
            this.gd_achievements.moveTo(indexToScroll,true);
         }
         if(this._currentScrollValue != 0)
         {
            this.gd_achievements.verticalScrollValue = this._currentScrollValue;
         }
         if(achievements.length > 0)
         {
            this.lbl_noAchievement.visible = false;
         }
         else
         {
            this.lbl_noAchievement.visible = true;
            this.lbl_noAchievement.text = this.uiApi.getText("ui.search.noResult");
            if(this._searchCriteria)
            {
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
                  this.lbl_noAchievement.text = this.uiApi.getText("ui.search.noResultFor",this._searchCriteria);
               }
               else
               {
                  this.lbl_noAchievement.text = this.uiApi.getText("ui.search.noResultsBut",currentCriteria,wannabeCriteria);
               }
            }
         }
         this._previousSearchCriteria = this._searchCriteria + "#" + this._searchOnName + "" + this._searchOnObjective + "" + this._searchOnReward;
      }
      
      private function addObjectivesAndRewards(ach:com.ankamagames.dofus.datacenter.quest.Achievement, category:AchievementCategory) : Array
      {
         var objectiveId:int = 0;
         var objective:AchievementObjective = null;
         var finishedLevel:int = 0;
         var rewardable:Boolean = false;
         var rewards:AchievementRewardsWrapper = null;
         var playerRewards:AchievementRewardsWrapper = null;
         var o:AchievementObjective = null;
         var ar:AchievementAchievedRewardable = null;
         var achievementSucceedBySomeoneElse:Boolean = false;
         if(this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY].indexOf(ach.id) != -1 && this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY].indexOf(ach.id) == -1)
         {
            achievementSucceedBySomeoneElse = true;
         }
         var achievements:Array = [];
         var objectives:Array = [];
         for each(objectiveId in ach.objectiveIds)
         {
            o = this.dataApi.getAchievementObjective(objectiveId);
            if(o)
            {
               objectives.push(o);
            }
         }
         objectives.sortOn("order",Array.NUMERIC);
         if(objectives.length > 0)
         {
            achievements.push({"empty":true});
         }
         for each(objective in objectives)
         {
            if(category.parentId == 0)
            {
               achievements.push({
                  "objectiveData":objective,
                  "color":category.color,
                  "doneBySomeoneElse":achievementSucceedBySomeoneElse
               });
            }
            else
            {
               achievements.push({
                  "objectiveData":objective,
                  "color":this.dataApi.getAchievementCategory(category.parentId).color,
                  "doneBySomeoneElse":achievementSucceedBySomeoneElse
               });
            }
            achievements.push(null);
         }
         if(objectives.length > 0)
         {
            achievements.push({"empty":true});
         }
         var reward:Object = {
            "rewardData":null,
            "characterRewardData":null,
            "kamas":0,
            "xp":0,
            "rewardable":false
         };
         if(this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(ach.id) != -1)
         {
            for each(ar in this.questApi.getRewardableAchievements())
            {
               if(ar.id == ach.id)
               {
                  finishedLevel = ar.finishedlevel;
                  rewardable = true;
                  break;
               }
            }
         }
         if(finishedLevel)
         {
            rewards = this.questApi.getAchievementReward(ach,finishedLevel,true);
            playerRewards = this.questApi.getAchievementReward(ach,finishedLevel,false);
         }
         else
         {
            rewards = this.questApi.getAchievementReward(ach,0,true);
            playerRewards = this.questApi.getAchievementReward(ach,0,false);
         }
         reward.characterRewardData = playerRewards;
         reward.rewardData = rewards;
         reward.kamas = this.questApi.getAchievementKamasReward(ach,finishedLevel);
         reward.xp = this.questApi.getAchievementExperienceReward(ach,finishedLevel);
         reward.rewardable = rewardable;
         achievements.push(reward);
         achievements.push(null);
         achievements.push(null);
         achievements.push(null);
         achievements.push(null);
         achievements.push(null);
         return achievements;
      }
      
      private function updateCategories(selectedCategory:Object, forceOpen:Boolean = false, fakeOpen:Boolean = false) : void
      {
         var alreadyInTheRightCategory:Boolean = false;
         var myIndex:int = 0;
         var cat:Object = null;
         var tempCat:* = undefined;
         var cat2:Object = null;
         var subcat:Object = null;
         if(this._openCatIndex != selectedCategory.id)
         {
            for each(tempCat in this._categories)
            {
               if(selectedCategory.id == tempCat.id && tempCat.subcats && tempCat.subcats.length > 0)
               {
                  selectedCategory = AchievementCategory.getAchievementCategoryById(tempCat.subcats[0].id);
               }
            }
         }
         if(!fakeOpen)
         {
            if(selectedCategory.id > 0 && this._currentSelectedCatId != selectedCategory.id)
            {
               this.sysApi.sendAction(new AchievementDetailedListRequestAction([selectedCategory.id]));
            }
            else
            {
               alreadyInTheRightCategory = true;
            }
            if(selectedCategory.parentId > 0 && this._openCatIndex == selectedCategory.parentId || this._openCatIndex == selectedCategory.id)
            {
               this._currentSelectedCatId = selectedCategory.id;
               for each(cat2 in this.gd_categories.dataProvider)
               {
                  if(cat2.id == this._currentSelectedCatId)
                  {
                     break;
                  }
                  myIndex++;
               }
               if(this.gd_categories.selectedIndex != myIndex)
               {
                  this.gd_categories.silent = true;
                  this.gd_categories.selectedIndex = myIndex;
                  this.gd_categories.silent = false;
               }
               this.gd_categories.focus();
               this.gd_categories.selectWithArrows = false;
               if(this._forceOpenAchievement && alreadyInTheRightCategory)
               {
                  this.updateAchievementGrid(this._currentSelectedCatId);
               }
               if(this._openCatIndex != selectedCategory.id)
               {
                  return;
               }
            }
         }
         var bigCatId:int = selectedCategory.id;
         if(selectedCategory.parentId > 0)
         {
            bigCatId = selectedCategory.parentId;
         }
         var index:int = -1;
         var tempCats:Array = [];
         var categoryOpened:int = -1;
         for each(cat in this._categories)
         {
            tempCats.push(cat);
            index++;
            if(bigCatId == cat.id)
            {
               myIndex = index;
               if(this._currentSelectedCatId != cat.id || this._openCatIndex == 0 || forceOpen)
               {
                  categoryOpened = cat.id;
                  for each(subcat in cat.subcats)
                  {
                     tempCats.push(subcat);
                     index++;
                     if(subcat.id == selectedCategory.id)
                     {
                        myIndex = index;
                     }
                  }
               }
            }
         }
         if(categoryOpened >= 0)
         {
            this._openCatIndex = categoryOpened;
         }
         else
         {
            this._openCatIndex = 0;
         }
         if(!fakeOpen)
         {
            this._currentSelectedCatId = selectedCategory.id;
         }
         this.uiApi.hideTooltip();
         this.gd_categories.dataProvider = tempCats;
         if(this.gd_categories.selectedIndex != myIndex)
         {
            this.gd_categories.silent = true;
            this.gd_categories.selectedIndex = myIndex;
            this.gd_categories.silent = false;
         }
         this.gd_categories.focus();
         if(!fakeOpen && this._currentSelectedCatId == 0)
         {
            this.updateAchievementGrid(this._currentSelectedCatId);
         }
      }
      
      private function updateGeneralInfo() : void
      {
         var percentStr:String = null;
         var percent:Number = NaN;
         this.lbl_myPoints.text = this.utilApi.kamasToString(this._successPointsByDisplayMode[this._displayMode],"");
         if(this._dataAchievements.length > 0)
         {
            percent = Math.floor(this._finishedAchievementsIdByDisplayMode[this._displayMode].length / this._dataAchievements.length * 100);
            percentStr = percent.toString();
            this.pb_progress.value = percent / 100;
         }
         else
         {
            percentStr = "-";
            this.pb_progress.value = 0;
         }
         this.lbl_percent.text = percentStr + "%";
      }
      
      private function displayAccountMode(displayModeRequested:int, forceDisplay:Boolean = false) : void
      {
         if(displayModeRequested == this._displayMode && !forceDisplay)
         {
            return;
         }
         this.sysApi.setData("achievementAccountDisplayMode",displayModeRequested);
         this._displayMode = displayModeRequested;
         this.updateGeneralInfo();
         this.gd_categories.updateItems();
         this.gd_achievements.updateItems();
         if(displayModeRequested == ACCOUNT_DISPLAY)
         {
            this.gd_summary.dataProvider = this._progressCategoriesByDisplayMode[this._displayMode];
            this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_tabAccount,this.uiApi.me());
            this.btn_tabAccount.selected = true;
            this.ctr_summary.visible = true;
            this.ctr_endingAchievements.visible = false;
         }
         else
         {
            this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_tabCharacter,this.uiApi.me());
            this.btn_tabCharacter.selected = true;
            this.ctr_summary.visible = false;
            this.ctr_endingAchievements.visible = true;
         }
      }
      
      private function getMountPercentXp() : int
      {
         var xpRatio:int = 0;
         if(this.playerApi.getMount() != null && this.playerApi.isRidding() && this.playerApi.getMount().xpRatio > 0)
         {
            xpRatio = this.playerApi.getMount().xpRatio;
         }
         return xpRatio;
      }
      
      private function changeSearchOnName() : void
      {
         this._searchOnName = !this._searchOnName;
         Grimoire.getInstance().achievementSearchOnName = this._searchOnName;
         if(!this._searchOnName && !this._searchOnObjective && !this._searchOnReward)
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
            this.updateAchievementGrid(this.gd_categories.selectedItem);
         }
      }
      
      private function changeSearchOnObjective() : void
      {
         this._searchOnObjective = !this._searchOnObjective;
         Grimoire.getInstance().achievementSearchOnObjective = this._searchOnObjective;
         if(!this._searchOnName && !this._searchOnObjective && !this._searchOnReward)
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
            this.updateAchievementGrid(this.gd_categories.selectedItem);
         }
      }
      
      private function changeSearchOnReward() : void
      {
         this._searchOnReward = !this._searchOnReward;
         Grimoire.getInstance().achievementSearchOnReward = this._searchOnReward;
         if(!this._searchOnName && !this._searchOnObjective && !this._searchOnReward)
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
            this.updateAchievementGrid(this.gd_categories.selectedItem);
         }
      }
      
      private function setCardGridData(datas:Array) : void
      {
         var i:uint = 0;
         var dataLine:com.ankamagames.dofus.datacenter.quest.Achievement = null;
         var sameLine:* = true;
         var tempArray:Array = [];
         for each(dataLine in datas)
         {
            tempArray.push(dataLine);
            if(!sameLine)
            {
               for(i = 0; i < 10; i++)
               {
                  tempArray.push(null);
               }
            }
            sameLine = !sameLine;
         }
         if(!sameLine)
         {
            for(i = 0; i < 11; i++)
            {
               tempArray.push(null);
            }
         }
         this.gd_endingAchievements.dataProvider = tempArray;
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(target == this.gd_categories)
         {
            if(selectMethod != GridItemSelectMethodEnum.AUTO)
            {
               this._searchCriteria = null;
               this.inp_search.text = this.uiApi.getText("ui.common.search.input");
               this._currentScrollValue = 0;
               this.updateCategories((target as Grid).selectedItem);
            }
            this.gd_endingAchievements.dataProvider = this.gd_endingAchievements.dataProvider;
         }
      }
      
      public function onItemRightClick(target:GraphicContainer, item:Object) : void
      {
         var data:Object = null;
         var contextMenu:ContextMenuData = null;
         if(item.data && target.name.indexOf("gd_rewards") != -1)
         {
            data = item.data;
            if(data == null || !(data is ItemWrapper))
            {
               return;
            }
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         var text:String = null;
         if(item.data && target.name.indexOf("gd_rewards") != -1)
         {
            if(item.data is ItemWrapper)
            {
               this.uiApi.showTooltip(item.data,target,false,"standard",8,0,0,"itemName",null,{
                  "showEffects":true,
                  "header":true
               },"ItemInfo");
               return;
            }
            if(item.data is EmoteWrapper)
            {
               text = this.uiApi.getText("ui.common.emote",item.data.emote.name);
            }
            else if(item.data is SpellWrapper)
            {
               text = this.uiApi.getText("ui.common.spell",item.data.spell.name);
            }
            else if(item.data is TitleWrapper)
            {
               text = this.uiApi.getText("ui.common.title",item.data.title.name);
            }
            else if(item.data is OrnamentWrapper)
            {
               text = this.uiApi.getText("ui.common.ornament",item.data.name);
            }
            if(text)
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
            }
         }
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var contextMenu:Array = null;
         var achievement:com.ankamagames.dofus.datacenter.quest.Achievement = null;
         var category:AchievementCategory = null;
         var data:Object = null;
         var achMetaId:int = 0;
         this._focusOnSearch = false;
         switch(target)
         {
            case this.btn_closeSearch:
               this._searchCriteria = null;
               this.inp_search.text = this.uiApi.getText("ui.common.search.input");
               this.updateAchievementGrid(this.gd_categories.selectedItem.id);
               break;
            case this.btn_searchFilter:
               contextMenu = [];
               contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.search.criteria")));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnName"],this.changeSearchOnName,null,false,null,this._searchOnName,false));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnObjective"],this.changeSearchOnObjective,null,false,null,this._searchOnObjective,false));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this._searchTextByCriteriaList["_searchOnReward"],this.changeSearchOnReward,null,false,null,this._searchOnReward,false));
               this.modContextMenu.createContextMenu(contextMenu);
               break;
            case this.btn_hideCompletedAchievements:
               this._hideAchievedAchievement = this.btn_hideCompletedAchievements.selected;
               this.updateAchievementGrid(this.gd_categories.selectedItem.id,true);
               break;
            case this.inp_search:
               if(this.uiApi.getText("ui.common.search.input") == this.inp_search.text)
               {
                  this.inp_search.text = "";
               }
               this._focusOnSearch = true;
               break;
            case this.btn_tabAccount:
               this.displayAccountMode(ACCOUNT_DISPLAY);
               break;
            case this.btn_tabCharacter:
               this.displayAccountMode(CHARACTER_DISPLAY);
               break;
            default:
               if(target)
               {
                  if(target.name.indexOf("ctr_illu") != -1)
                  {
                     this._searchCriteria = null;
                     this.inp_search.text = "";
                     this.gd_categories.selectedIndex = this._catIlluBtnList[target.name].order + 1;
                  }
                  else if(target.name.indexOf("btn_ach") != -1)
                  {
                     if(this.uiApi.keyIsDown(Keyboard.SHIFT))
                     {
                        this.sysApi.dispatchHook(BeriliaHookList.MouseShiftClick,{"data":this._ctrAchBtnsList[target.name]});
                        break;
                     }
                     data = this._ctrAchBtnsList[target.name];
                     if(this._selectedAchievementId == 0 || this._selectedAchievementId != data.id)
                     {
                        this.gd_achievements.selectedItem = data;
                        this._selectedAchievementId = data.id;
                     }
                     else
                     {
                        this._selectedAchievementId = 0;
                     }
                     if(this._selectedAchievementId > 0 && !this._catProgressingAchievements[this._selectedAchievementId] && !this._catFinishedAchievements[this._selectedAchievementId])
                     {
                        this.sysApi.sendAction(new AchievementDetailsRequestAction([this._selectedAchievementId]));
                     }
                     else
                     {
                        this.updateAchievementGrid(this.gd_categories.selectedItem.id);
                        if(this._searchCriteria != "" && this._searchCriteria != null && this._selectedAchievementId > 0)
                        {
                           achievement = this.dataApi.getAchievement(this._selectedAchievementId);
                           category = this.dataApi.getAchievementCategory(achievement.categoryId);
                           this.updateCategories(category,true,true);
                        }
                        this.gd_achievements.focus();
                     }
                  }
                  else if(target.name.indexOf("ctr_objectiveBin") != -1)
                  {
                     achMetaId = this._ctrObjectiveMetaList[target.name];
                     if(achMetaId > 0)
                     {
                        this.uiApi.hideTooltip();
                        this.onOpenAchievement("achievementTab",{
                           "forceOpen":true,
                           "achievementId":achMetaId
                        });
                     }
                  }
                  else if(target.name.indexOf("btn_accept") != -1)
                  {
                     this.uiApi.hideTooltip();
                     this.sysApi.sendAction(new AchievementRewardRequestAction([this._btnsAcceptRewardList[target.name]]));
                  }
                  else if(target.name.indexOf("btn_mainGridLink") != -1)
                  {
                     this._forceOpenAchievement = true;
                     this._selectedAchievementId = this._compHookData[target].id;
                     achievement = this.dataApi.getAchievement(this._selectedAchievementId);
                     category = this.dataApi.getAchievementCategory(achievement.categoryId);
                     this.updateAchievementGrid(category.id);
                     this.updateCategories(category,true,true);
                  }
               }
         }
         if(target != this.inp_search && this.inp_search && this.inp_search.text.length == 0)
         {
            this.inp_search.text = this.uiApi.getText("ui.common.search.input");
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         var param:String = null;
         var footer:String = null;
         var achMetaId:int = 0;
         var achMeta:com.ankamagames.dofus.datacenter.quest.Achievement = null;
         var myMountXp:int = 0;
         var monster:Monster = null;
         var incompatibleIdols:String = null;
         var id:uint = 0;
         var idol:Idol = null;
         var pos:Object = {
            "point":LocationEnum.POINT_BOTTOM,
            "relativePoint":LocationEnum.POINT_TOP
         };
         switch(target)
         {
            case this.lbl_myPoints:
               if(this._displayMode == ACCOUNT_DISPLAY)
               {
                  param = this.utilApi.kamasToString(this._successPointsByDisplayMode[ACCOUNT_DISPLAY],"") + " / " + this.utilApi.kamasToString(this._totalSuccessPoints,"");
                  footer = " " + this.uiApi.getText("ui.achievement.pointsForAccount");
               }
               else
               {
                  param = this.utilApi.kamasToString(this._successPointsByDisplayMode[CHARACTER_DISPLAY],"") + " / " + this.utilApi.kamasToString(this._totalSuccessPoints,"");
                  footer = " " + this.uiApi.getText("ui.achievement.pointsForCharacter");
               }
               text = this.uiApi.processText(this.uiApi.getText("ui.achievement.successPoints",param),"n",false);
               text += footer;
               break;
            case this.btn_searchFilter:
               text = this.uiApi.getText("ui.search.criteria");
               break;
            case this.ctr_globalProgress:
               text = this._finishedAchievementsIdByDisplayMode[this._displayMode].length + " / " + this._dataAchievements.length;
               break;
            default:
               if(target.name.indexOf("ctr_achPoints") != -1)
               {
                  text = this.uiApi.getText("ui.achievement.successPointsText");
               }
               else if(target.name.indexOf("lbl_catPercent") != -1)
               {
                  if(this._catProgressBarList[target.name] && this._catProgressBarList[target.name].subcats && this._catProgressBarList[target.name].subcats.length > 0)
                  {
                     text = this.uiApi.getText("ui.achievement.noSubCategoryIncluded");
                  }
               }
               else if(target.name.indexOf("ctr_objectiveBin") != -1)
               {
                  achMetaId = this._ctrObjectiveMetaList[target.name];
                  if(achMetaId > 0)
                  {
                     achMeta = this.dataApi.getAchievement(achMetaId);
                     text = achMeta.description;
                  }
               }
               else if(target.name.indexOf("ctr_progress") != -1)
               {
                  text = this._catProgressBarList[target.name].value + "/" + this._catProgressBarList[target.name].total;
               }
               else if(target.name.indexOf("tx_successBySomeoneElse") != -1)
               {
                  text = this.uiApi.getText("ui.achievement.achievedBySomeoneElse");
               }
               else if(target.name.indexOf("tx_warningReward") != -1)
               {
                  text = this.uiApi.getText("ui.achievement.partialRewards");
               }
               else if(target.name.indexOf("btn_accept") != -1)
               {
                  if(target.softDisabled)
                  {
                     text = this.uiApi.getText("ui.achievement.rewardsToGetWaiting");
                  }
                  else
                  {
                     text = this.uiApi.getText("ui.achievement.rewardsGet");
                     myMountXp = this.getMountPercentXp();
                     if(myMountXp)
                     {
                        text += "\n" + this.uiApi.getText("ui.achievement.mountXpPercent",myMountXp);
                     }
                     if(this._myGuildXp)
                     {
                        text += "\n" + this.uiApi.getText("ui.achievement.guildXpPercent",this._myGuildXp);
                     }
                  }
               }
               else if(target.name.indexOf("tx_incompatibleIdols") != -1)
               {
                  monster = this._ctrTxList[target.name];
                  incompatibleIdols = "";
                  for each(id in monster.incompatibleIdols)
                  {
                     idol = this.dataApi.getIdol(id);
                     if(idol)
                     {
                        incompatibleIdols += "\n" + idol.item.name;
                     }
                  }
                  text = this.uiApi.getText("ui.idol.incompatibleIdols",incompatibleIdols);
               }
               else if(target.name.indexOf("btn_cardXp") != -1)
               {
                  text = this.utilApi.kamasToString(this._compHookData[target],"") + " " + this.uiApi.getText("ui.common.xp");
               }
               else if(target.name.indexOf("btn_cardKamas") != -1)
               {
                  this.uiApi.showTooltip({
                     "text":this.utilApi.kamasToString(this._compHookData[target],""),
                     "uri":this.uiApi.createUri(this.uiApi.me().getConstant("kamas_icon")),
                     "textureSize":15
                  },target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,"textWithTexture",null,null);
               }
               else if(target.name.indexOf("btn_cardGift") != -1)
               {
                  text = this._compHookData[target];
               }
               else if(target.name.indexOf("btn_cardTrophy") != -1)
               {
                  text = this.utilApi.kamasToString(this._compHookData[target],"") + " " + this.uiApi.getText("ui.achievement.successPointsText");
               }
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint);
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onFocusChange(pTarget:Object) : void
      {
         if(pTarget && pTarget != this.inp_search && this._focusOnSearch)
         {
            this.onRelease(null);
         }
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
            this._currentScrollValue = 0;
            if(this._openCatIndex == 0)
            {
               this.ctr_achievements.visible = true;
               this.ctr_endingAchievements.visible = false;
               this.ctr_summary.visible = false;
            }
            this.updateAchievementGrid(this._currentSelectedCatId);
         }
         else
         {
            if(this._searchCriteria)
            {
               this._searchCriteria = null;
            }
            if(this.inp_search.text.length == 0)
            {
               this.updateAchievementGrid(this.gd_categories.selectedItem.id);
            }
         }
      }
      
      public function onParseObjectives(i:int = 0) : void
      {
         Grimoire.getInstance().objectivesTextByAchievement = this._objectivesTextByAchievementId;
         this.updateAchievementGrid(this.gd_categories.selectedItem.id);
         this.onCancelSearch();
      }
      
      private function onCancelSearch() : void
      {
         clearTimeout(this._searchSettimoutId);
         if(this._progressPopupName)
         {
            this.uiApi.unloadUi(this._progressPopupName);
            this._progressPopupName = null;
         }
      }
      
      private function onAchievementList() : void
      {
         var totalNb:int = 0;
         var cat:AchievementCategory = null;
         var ach:com.ankamagames.dofus.datacenter.quest.Achievement = null;
         var finishedId:int = 0;
         var finishedAch:com.ankamagames.dofus.datacenter.quest.Achievement = null;
         var total:int = 0;
         this._successPointsByDisplayMode = [];
         this._progressCategoriesByDisplayMode[ACCOUNT_DISPLAY] = [];
         this._progressCategoriesByDisplayMode[CHARACTER_DISPLAY] = [];
         this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY] = [];
         this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY] = [];
         var currentCountByDisplayMode:Array = [];
         var tempCatArray:Array = [];
         this._successPointsByDisplayMode[ACCOUNT_DISPLAY] = 0;
         this._successPointsByDisplayMode[CHARACTER_DISPLAY] = 0;
         this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY] = this.questApi.getFinishedAccountAchievementIds();
         this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY] = this.questApi.getFinishedCharacterAchievementIds();
         for each(finishedId in this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY])
         {
            finishedAch = this.dataApi.getAchievement(finishedId);
            if(finishedAch)
            {
               this._successPointsByDisplayMode[ACCOUNT_DISPLAY] += finishedAch.points;
            }
         }
         for each(finishedId in this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY])
         {
            finishedAch = this.dataApi.getAchievement(finishedId);
            if(finishedAch)
            {
               this._successPointsByDisplayMode[CHARACTER_DISPLAY] += finishedAch.points;
            }
         }
         for each(cat in this._dataCategories)
         {
            if(cat.parentId > 0)
            {
               if(!tempCatArray[cat.parentId])
               {
                  tempCatArray[cat.parentId] = {
                     "valueAccount":0,
                     "valueCharacter":0,
                     "total":0
                  };
               }
               totalNb = 0;
               currentCountByDisplayMode[ACCOUNT_DISPLAY] = 0;
               currentCountByDisplayMode[CHARACTER_DISPLAY] = 0;
               for each(ach in cat.achievements)
               {
                  if(ach)
                  {
                     if(this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY].indexOf(ach.id) != -1)
                     {
                        ++currentCountByDisplayMode[ACCOUNT_DISPLAY];
                     }
                     if(this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY].indexOf(ach.id) != -1)
                     {
                        ++currentCountByDisplayMode[CHARACTER_DISPLAY];
                     }
                     totalNb++;
                  }
               }
               tempCatArray[cat.parentId] = {
                  "valueAccount":tempCatArray[cat.parentId].valueAccount + currentCountByDisplayMode[ACCOUNT_DISPLAY],
                  "valueCharacter":tempCatArray[cat.parentId].valueCharacter + currentCountByDisplayMode[CHARACTER_DISPLAY],
                  "total":tempCatArray[cat.parentId].total + totalNb
               };
            }
         }
         for each(cat in this._dataCategories)
         {
            if(cat.parentId == 0)
            {
               if(!tempCatArray[cat.id])
               {
                  tempCatArray[cat.id] = {
                     "valueAccount":0,
                     "valueCharacter":0,
                     "total":0
                  };
               }
               total = 0;
               totalNb = 0;
               currentCountByDisplayMode[ACCOUNT_DISPLAY] = 0;
               currentCountByDisplayMode[CHARACTER_DISPLAY] = 0;
               for each(ach in cat.achievements)
               {
                  if(ach)
                  {
                     if(this._finishedAchievementsIdByDisplayMode[ACCOUNT_DISPLAY].indexOf(ach.id) != -1)
                     {
                        ++currentCountByDisplayMode[ACCOUNT_DISPLAY];
                     }
                     if(this._finishedAchievementsIdByDisplayMode[CHARACTER_DISPLAY].indexOf(ach.id) != -1)
                     {
                        ++currentCountByDisplayMode[CHARACTER_DISPLAY];
                     }
                     totalNb++;
                  }
               }
               if(tempCatArray[cat.id])
               {
                  currentCountByDisplayMode[ACCOUNT_DISPLAY] += tempCatArray[cat.id].valueAccount;
                  currentCountByDisplayMode[CHARACTER_DISPLAY] += tempCatArray[cat.id].valueCharacter;
                  total = totalNb + tempCatArray[cat.id].total;
               }
               this._progressCategoriesByDisplayMode[ACCOUNT_DISPLAY].push({
                  "id":cat.id,
                  "name":cat.name,
                  "value":currentCountByDisplayMode[ACCOUNT_DISPLAY],
                  "total":total,
                  "color":cat.color,
                  "icon":cat.icon,
                  "order":cat.order
               });
               this._progressCategoriesByDisplayMode[CHARACTER_DISPLAY].push({
                  "id":cat.id,
                  "name":cat.name,
                  "value":currentCountByDisplayMode[CHARACTER_DISPLAY],
                  "total":total,
                  "color":cat.color,
                  "icon":cat.icon,
                  "order":cat.order
               });
            }
         }
         this._progressCategoriesByDisplayMode[ACCOUNT_DISPLAY].sortOn("order",Array.NUMERIC);
         this._progressCategoriesByDisplayMode[CHARACTER_DISPLAY].sortOn("order",Array.NUMERIC);
         this.gd_summary.dataProvider = this._progressCategoriesByDisplayMode[this._displayMode];
         this.updateGeneralInfo();
         if(this._forceOpenAchievement)
         {
            this.onOpenAchievement("achievementTab",{
               "forceOpen":true,
               "achievementId":this._selectedAchievementId
            });
         }
      }
      
      private function onAchievementFinished(finishedAchievement:AchievementAchieved) : void
      {
         var cat:Object = null;
         var achievedByCurrentCharacter:* = finishedAchievement.achievedBy == this.playerApi.id();
         var finishedAch:com.ankamagames.dofus.datacenter.quest.Achievement = this.dataApi.getAchievement(finishedAchievement.id);
         if(!finishedAch)
         {
            return;
         }
         this._successPointsByDisplayMode[ACCOUNT_DISPLAY] += finishedAch.points;
         var catFrom:AchievementCategory = this.dataApi.getAchievementCategory(finishedAch.categoryId);
         for each(cat in this._progressCategoriesByDisplayMode[ACCOUNT_DISPLAY])
         {
            if(cat.id == catFrom.id || cat.id == catFrom.parentId)
            {
               cat.value += 1;
            }
         }
         if(achievedByCurrentCharacter)
         {
            this._successPointsByDisplayMode[CHARACTER_DISPLAY] += finishedAch.points;
            for each(cat in this._progressCategoriesByDisplayMode[CHARACTER_DISPLAY])
            {
               if(cat.id == catFrom.id || cat.id == catFrom.parentId)
               {
                  cat.value += 1;
               }
            }
         }
         this.gd_summary.dataProvider = this._progressCategoriesByDisplayMode[this._displayMode];
         this.updateGeneralInfo();
      }
      
      private function onAchievementDetailedList(finishedAchievements:Object, startedAchievements:Object) : void
      {
         var ach:Object = null;
         for each(ach in finishedAchievements)
         {
            this._catFinishedAchievements[ach.id] = ach;
            ach.id = null;
         }
         for each(ach in startedAchievements)
         {
            this._catProgressingAchievements[ach.id] = ach;
            ach.id = null;
         }
         this.updateAchievementGrid(this._currentSelectedCatId);
      }
      
      private function onAchievementAlmostFinishedDetailedList(almostFinishedAchievements:*) : void
      {
         var ach:Object = null;
         var datas:Array = [];
         for each(ach in almostFinishedAchievements)
         {
            this._catProgressingAchievements[ach.id] = ach;
            datas.push(com.ankamagames.dofus.datacenter.quest.Achievement.getAchievementById(ach.id));
         }
         if(datas.length == 0)
         {
            this.lbl_endingAchievementsInfo.text = this.uiApi.getText("ui.achievement.allSuccessesEnded");
            this.lbl_endingAchievementsInfo.visible = true;
            this.lbl_almostFinished.visible = false;
         }
         else
         {
            this.lbl_endingAchievementsInfo.visible = false;
            this.lbl_almostFinished.visible = true;
         }
         this.setCardGridData(datas);
      }
      
      private function onAchievementDetails(achievement:Object) : void
      {
         var category:AchievementCategory = null;
         if(achievement == null)
         {
            return;
         }
         var achievementId:uint = achievement.id;
         if(this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(achievementId) == -1)
         {
            this._catProgressingAchievements[achievementId] = achievement;
         }
         else
         {
            this._catFinishedAchievements[achievementId] = achievement;
         }
         achievement.id = null;
         this.updateAchievementGrid(this._currentSelectedCatId);
         var achievementData:com.ankamagames.dofus.datacenter.quest.Achievement = this.dataApi.getAchievement(achievementId);
         if(achievementData != null)
         {
            category = this.dataApi.getAchievementCategory(achievementData.categoryId);
            if(category != null)
            {
               this.updateCategories(category,true,true);
            }
         }
      }
      
      private function onAchievementRewardSuccess(achievementId:int) : void
      {
         this.updateAchievementGrid(this._currentSelectedCatId);
      }
      
      public function onGuildInformationsMemberUpdate(member:Object) : void
      {
         if(member.id == this.playerApi.id())
         {
            this._myGuildXp = member.experienceGivenPercent;
         }
      }
      
      private function onOpenAchievement(tab:String = null, param:Object = null) : void
      {
         var achievement:com.ankamagames.dofus.datacenter.quest.Achievement = null;
         var category:AchievementCategory = null;
         if(tab == "achievementTab" && param && param.forceOpen)
         {
            this._selectedAchievementId = param.achievementId;
            this.ctr_achievements.visible = true;
            this.ctr_endingAchievements.visible = false;
            this.ctr_summary.visible = false;
            this._forceOpenAchievement = true;
            this._searchCriteria = null;
            this.inp_search.text = "";
            if(this._finishedAchievementsIdByDisplayMode[this._displayMode].indexOf(this._selectedAchievementId) != -1 && this._hideAchievedAchievement == true)
            {
               this._hideAchievedAchievement = false;
               this.btn_hideCompletedAchievements.selected = false;
            }
            achievement = this.dataApi.getAchievement(this._selectedAchievementId);
            category = this.dataApi.getAchievementCategory(achievement.categoryId);
            this.updateCategories(category,true);
         }
      }
   }
}
