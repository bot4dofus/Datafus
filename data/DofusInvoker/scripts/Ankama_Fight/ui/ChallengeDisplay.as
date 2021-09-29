package Ankama_Fight.ui
{
   import Ankama_Grimoire.enum.EnumTab;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.internalDatacenter.fight.ChallengeWrapper;
   import com.ankamagames.dofus.internalDatacenter.fight.EnumChallengeCategory;
   import com.ankamagames.dofus.internalDatacenter.fight.EnumChallengeResult;
   import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ChallengeTargetsListRequestAction;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class ChallengeDisplay
   {
      
      private static const IS_VERTICAL_ID:String = "challengeDisplayIsVertical";
      
      private static const TOOLTIP_NAME:String = "standard";
      
      private static const TYPE_GRID_DATA_EMPTY:String = "ctr_empty";
      
      private static const TYPE_GRID_DATA_CHALLENGE:String = "ctr_challengeEntry";
      
      private static const TYPE_GRID_DATA_PANEL:String = "ctr_challengePanel";
      
      private static const STORAGE_CHALLENGE_VISIBILITY_PREFIX:String = "challengeDisplayChallengeVisibility_";
      
      private static const NO_BOSS_BOUND_KEY:String = "no_boss_bound";
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      public var ctr_challenges:GraphicContainer;
      
      public var btn_changeOrientation:ButtonContainer;
      
      public var tx_background:TextureBitmap;
      
      public var tx_challengeIcon:TextureBitmap;
      
      public var tx_changeOrientation:Texture;
      
      public var gd_challenges:Grid;
      
      private const DEFAULT_IS_VERTICAL:Boolean = true;
      
      private const DEFAULT_CHALLENGE_VISIBILITY:Boolean = true;
      
      private var _challengeCategoryData:Dictionary = null;
      
      private var _componentsData:Dictionary;
      
      private var _isVertical:Boolean = true;
      
      private var _lastGridItem:GraphicContainer = null;
      
      private var _isLastItemAPanel:Boolean = false;
      
      private var _emptyLinesToAddWithChallengeEntry:Number = NaN;
      
      public function ChallengeDisplay()
      {
         this._componentsData = new Dictionary();
         super();
      }
      
      private static function sortChallenges(challenge1:ChallengeWrapper, challenge2:ChallengeWrapper) : Number
      {
         var bossId1:Number = challenge1.getBoundBossId();
         var bossId2:Number = challenge2.getBoundBossId();
         var isBossId1NaN:Boolean = isNaN(bossId1);
         var isBossId2NaN:Boolean = isNaN(bossId2);
         var playersNumberType1:Number = challenge1.getPlayersNumberType();
         var playersNumberType2:Number = challenge2.getPlayersNumberType();
         var isPlayersNumberType1NaN:Boolean = isNaN(playersNumberType1);
         var isPlayersNumberType2NaN:Boolean = isNaN(playersNumberType2);
         if((!isBossId1NaN || !isBossId2NaN) && bossId1 !== bossId2)
         {
            if(isBossId1NaN)
            {
               return -1;
            }
            if(isBossId2NaN)
            {
               return 1;
            }
            if(bossId1 < bossId2)
            {
               return -1;
            }
            if(bossId1 > bossId2)
            {
               return 1;
            }
         }
         if((!isPlayersNumberType1NaN || !isPlayersNumberType2NaN) && playersNumberType1 !== playersNumberType2)
         {
            if(isPlayersNumberType1NaN)
            {
               return -1;
            }
            if(isPlayersNumberType2NaN)
            {
               return 1;
            }
            if(playersNumberType1 < playersNumberType2)
            {
               return -1;
            }
            return 1;
         }
         if(challenge1.id < challenge2.id)
         {
            return -1;
         }
         if(challenge1.id > challenge2.id)
         {
            return 1;
         }
         return 0;
      }
      
      public function main(params:Object = null) : void
      {
         if(params === null)
         {
            params = {"challenges":[this.dataApi.getChallengeWrapper(1),this.dataApi.getChallengeWrapper(2)]};
         }
         this.sysApi.addHook(FightHookList.ChallengeInfoUpdate,this.onChallengeInfoUpdate);
         this.sysApi.addHook(CustomUiHookList.FoldAll,this.onFoldAll);
         this.gd_challenges.mouseClickEnabled = false;
         var me:UiRootContainer = this.uiApi.me();
         if(me !== null)
         {
            this._emptyLinesToAddWithChallengeEntry = Number(me.getConstant("emptyLinesToAddWithChallengeEntry"));
            if(isNaN(this._emptyLinesToAddWithChallengeEntry) || this._emptyLinesToAddWithChallengeEntry < 0)
            {
               this._emptyLinesToAddWithChallengeEntry = 0;
            }
         }
         if(params.challenges !== null && params.challenges is Array)
         {
            this.loadChallenges(params.challenges);
         }
         var savedIsVertical:* = this.sysApi.getData(IS_VERTICAL_ID,DataStoreEnum.BIND_ACCOUNT);
         this.changeOrientation(savedIsVertical is Boolean ? Boolean(savedIsVertical) : Boolean(this.DEFAULT_IS_VERTICAL),true);
      }
      
      public function unload() : void
      {
      }
      
      public function updateChallengeGrid(data:*, components:*, isSelected:Boolean, line:uint) : void
      {
         var challenge:ChallengeWrapper = null;
         var challengeResultIconUri:Uri = null;
         var isAchievementTabLink:Boolean = false;
         var panelGridData:PanelGridData = null;
         var boundAchievements:Vector.<Achievement> = null;
         var me:UiRootContainer = this.uiApi.me();
         switch(this.getGridDataType(data,line))
         {
            case TYPE_GRID_DATA_CHALLENGE:
               challenge = (data as ChallengeGridData).challenge;
               components.ctr_challengeEntry.x = this.getContextualConstant("CtrChallengeEntryX");
               components.ctr_challengeEntry.y = this.getContextualConstant("CtrChallengeEntryY");
               if(challenge === null)
               {
                  components.tx_challengeIcon.uri = null;
                  components.tx_challengeResult.uri = null;
                  this.uiApi.removeComponentHook(components.ctr_challengeEntry,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.removeComponentHook(components.ctr_challengeEntry,ComponentHookList.ON_ROLL_OUT);
                  this.uiApi.removeComponentHook(components.ctr_challengeEntry,ComponentHookList.ON_RELEASE);
                  delete this._componentsData[components.ctr_challengeEntry.name];
                  return;
               }
               components.tx_challengeIcon.uri = challenge.iconUri;
               challengeResultIconUri = null;
               if(me !== null)
               {
                  switch(challenge.result)
                  {
                     case EnumChallengeResult.COMPLETED:
                        challengeResultIconUri = this.uiApi.createUri(me.getConstant("texture") + "hud/filter_iconChallenge_check.png");
                        break;
                     case EnumChallengeResult.FAILED:
                        challengeResultIconUri = this.uiApi.createUri(me.getConstant("texture") + "hud/filter_iconChallenge_cross.png");
                  }
               }
               components.tx_challengeResult.uri = challengeResultIconUri;
               this.uiApi.addComponentHook(components.ctr_challengeEntry,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.ctr_challengeEntry,ComponentHookList.ON_ROLL_OUT);
               this._componentsData[components.ctr_challengeEntry.name] = challenge;
               isAchievementTabLink = false;
               if(challenge.categoryId === EnumChallengeCategory.ACHIEVEMENT)
               {
                  boundAchievements = challenge.boundAchievements;
                  isAchievementTabLink = boundAchievements !== null && boundAchievements.length > 0;
               }
               components.ctr_challengeEntry.handCursor = isAchievementTabLink;
               if(isAchievementTabLink)
               {
                  this.uiApi.addComponentHook(components.ctr_challengeEntry,ComponentHookList.ON_RELEASE);
               }
               this._lastGridItem = components.tx_challengeResult;
               break;
            case TYPE_GRID_DATA_PANEL:
               panelGridData = data as PanelGridData;
               this.uiApi.addComponentHook(components.btn_minimize,ComponentHookList.ON_RELEASE);
               this._componentsData[components.btn_minimize.name] = panelGridData.categoryKey;
               components.ctr_challengePanel.x = Number(this.getContextualConstant("CtrChallengePanelX"));
               components.ctr_challengePanel.y = Number(this.getContextualConstant("CtrChallengePanelY"));
               components.tx_challengePanel.x = Number(this.getContextualConstant("TxChallengePanelX"));
               components.tx_challengePanel.y = Number(this.getContextualConstant("TxChallengePanelY"));
               components.tx_challengePanel.rotation = Number(this.getContextualConstant("TxChallengePanelRotation"));
               components.btn_minimize.x = Number(this.getContextualConstant("BtnMinimizeX"));
               components.btn_minimize.y = Number(this.getContextualConstant("BtnMinimizeY"));
               if(me !== null)
               {
                  if(this.isChallengeCategoryVisible(panelGridData.categoryKey))
                  {
                     components.tx_minimize.uri = this.uiApi.createUri(me.getConstant("texture") + "hud/icon_minus_floating_menu.png");
                  }
                  else
                  {
                     components.tx_minimize.uri = this.uiApi.createUri(me.getConstant("texture") + "hud/icon_plus_floating_menu.png");
                  }
                  if(components.tx_minimize.uri !== null)
                  {
                     components.tx_minimize.finalize();
                  }
               }
               this._lastGridItem = components.tx_challengePanel;
         }
      }
      
      public function getGridDataType(data:*, line:uint) : String
      {
         if(data is ChallengeGridData)
         {
            return TYPE_GRID_DATA_CHALLENGE;
         }
         if(data is PanelGridData)
         {
            return TYPE_GRID_DATA_PANEL;
         }
         return TYPE_GRID_DATA_EMPTY;
      }
      
      private function loadChallenges(challenges:Array) : void
      {
         var categoryKey:String = null;
         var isCategoryVisibleCached:* = undefined;
         var challenge:ChallengeWrapper = null;
         challenges.sort(sortChallenges);
         var bossId:Number = Number.NaN;
         var isBossChallenge:* = false;
         this._challengeCategoryData = new Dictionary();
         for each(challenge in challenges)
         {
            isBossChallenge = challenge.categoryId === EnumChallengeCategory.ACHIEVEMENT;
            if(isBossChallenge)
            {
               bossId = challenge.getBoundBossId();
               categoryKey = "boss_" + bossId.toString();
            }
            else
            {
               categoryKey = NO_BOSS_BOUND_KEY;
            }
            if(!(categoryKey in this._challengeCategoryData))
            {
               isCategoryVisibleCached = this.sysApi.getData(STORAGE_CHALLENGE_VISIBILITY_PREFIX + categoryKey);
               this._challengeCategoryData[categoryKey] = new ChallengeCategoryData(categoryKey,isCategoryVisibleCached is Boolean ? Boolean(isCategoryVisibleCached) : Boolean(this.DEFAULT_CHALLENGE_VISIBILITY));
            }
            this._challengeCategoryData[categoryKey].addChallenge(challenge);
         }
      }
      
      private function addGridData(gridData:Vector.<GridData>, challengeCategoryData:ChallengeCategoryData) : void
      {
         var challenge:ChallengeWrapper = null;
         var index:uint = 0;
         gridData.push(new PanelGridData(challengeCategoryData.categoryKey));
         this._isLastItemAPanel = true;
         if(challengeCategoryData.isVisible)
         {
            for each(challenge in challengeCategoryData.challenges)
            {
               gridData.push(new ChallengeGridData(challenge));
               this._isLastItemAPanel = false;
               for(index = 0; index < this._emptyLinesToAddWithChallengeEntry; index++)
               {
                  gridData.push(null);
               }
            }
         }
      }
      
      private function displayChallenges() : void
      {
         var challengeCategoryData:ChallengeCategoryData = null;
         var elementNumber:uint = 0;
         var gdChallengesPos:Point = null;
         var lastDisplayedItemPos:Point = null;
         var offset:Number = NaN;
         this._lastGridItem = null;
         this._isLastItemAPanel = false;
         var gridData:Vector.<GridData> = new Vector.<GridData>();
         var me:UiRootContainer = this.uiApi.me();
         if(me !== null)
         {
            if(NO_BOSS_BOUND_KEY in this._challengeCategoryData)
            {
               this.addGridData(gridData,this._challengeCategoryData[NO_BOSS_BOUND_KEY]);
            }
            for each(challengeCategoryData in this._challengeCategoryData)
            {
               if(challengeCategoryData.categoryKey !== NO_BOSS_BOUND_KEY)
               {
                  this.addGridData(gridData,challengeCategoryData);
               }
            }
            elementNumber = gridData.length;
            if(me !== null)
            {
               if(this._isVertical)
               {
                  this.gd_challenges.height = this.gd_challenges.slotHeight * (elementNumber + 1);
                  this.gd_challenges.width = me.getConstant("challengeSize");
               }
               else
               {
                  this.gd_challenges.height = me.getConstant("challengeSize");
                  this.gd_challenges.width = this.gd_challenges.slotWidth * (elementNumber + 1);
               }
            }
         }
         this.gd_challenges.dataProvider = gridData;
         if(elementNumber > 1)
         {
            if(this._lastGridItem !== null && me !== null)
            {
               gdChallengesPos = this.gd_challenges.localToGlobal(new Point());
               lastDisplayedItemPos = this._lastGridItem.localToGlobal(new Point());
               if(this._isLastItemAPanel)
               {
                  offset = Number(this.getContextualConstant("TxBackgroundOffsetWithPanel"));
               }
               else
               {
                  offset = Number(this.getContextualConstant("TxBackgroundOffsetWithChallenge"));
               }
               if(this._isVertical)
               {
                  this.tx_background.height = lastDisplayedItemPos.y + this._lastGridItem.height - gdChallengesPos.y + offset;
               }
               else
               {
                  this.tx_background.height = lastDisplayedItemPos.x + this._lastGridItem.width - gdChallengesPos.x + offset;
               }
               this.tx_background.visible = true;
            }
         }
         else
         {
            this.tx_background.visible = false;
         }
      }
      
      private function getContextualConstant(constantKey:String) : *
      {
         var orientationLabel:String = null;
         var me:UiRootContainer = this.uiApi.me();
         if(me === null)
         {
            return null;
         }
         if(this._isVertical)
         {
            orientationLabel = "vertical_";
         }
         else
         {
            orientationLabel = "horizontal_";
         }
         return me.getConstant(orientationLabel + constantKey);
      }
      
      private function changeOrientation(isVertical:Boolean, isForceDisplayRefresh:Boolean = false) : void
      {
         var me:UiRootContainer = null;
         if(this._isVertical !== isVertical || isForceDisplayRefresh)
         {
            this._isVertical = isVertical;
            this.sysApi.setData(IS_VERTICAL_ID,this._isVertical,DataStoreEnum.BIND_ACCOUNT);
            me = this.uiApi.me();
            this.tx_background.x = Number(this.getContextualConstant("TxBackgroundX"));
            this.tx_background.y = Number(this.getContextualConstant("TxBackgroundY"));
            this.tx_background.rotation = Number(this.getContextualConstant("TxBackgroundRotation"));
            this.ctr_challenges.x = Number(this.getContextualConstant("CtrChallengesX"));
            this.ctr_challenges.y = Number(this.getContextualConstant("CtrChallengesY"));
            this.tx_challengeIcon.x = Number(this.getContextualConstant("TxChallengeIconX"));
            this.tx_challengeIcon.y = Number(this.getContextualConstant("TxChallengeIconY"));
            this.tx_changeOrientation.x = Number(this.getContextualConstant("TxChangeOrientationX"));
            this.tx_changeOrientation.y = Number(this.getContextualConstant("TxChangeOrientationY"));
            this.tx_changeOrientation.uri = this.uiApi.createUri(me.getConstant("texture") + this.getContextualConstant("TxChangeOrientationIcon"));
            this.gd_challenges.slotWidth = Number(this.getContextualConstant("GdChallengesSlotWidth"));
            this.gd_challenges.slotHeight = Number(this.getContextualConstant("GdChallengesSlotHeight"));
         }
         this.displayChallenges();
      }
      
      private function setChallengeVisibility(categoryKey:String, isVisible:Boolean, isRefresh:Boolean = true) : void
      {
         if(this._challengeCategoryData === null || !(categoryKey in this._challengeCategoryData))
         {
            return;
         }
         if(this.isChallengeCategoryVisible(categoryKey) !== isVisible)
         {
            this._challengeCategoryData[categoryKey].isVisible = isVisible;
            this.sysApi.setData(STORAGE_CHALLENGE_VISIBILITY_PREFIX + categoryKey,isVisible);
            if(isRefresh)
            {
               this.displayChallenges();
            }
         }
      }
      
      private function isChallengeCategoryVisible(categoryKey:String) : Boolean
      {
         if(this._challengeCategoryData === null || !(categoryKey in this._challengeCategoryData))
         {
            return false;
         }
         return this._challengeCategoryData[categoryKey].isVisible;
      }
      
      private function openAchievementTab(challenge:ChallengeWrapper) : void
      {
         if(challenge === null)
         {
            return;
         }
         var boundAchievements:Vector.<Achievement> = challenge.boundAchievements;
         if(boundAchievements === null || boundAchievements.length <= 0)
         {
            return;
         }
         var firstBoundAchievement:Achievement = boundAchievements[boundAchievements.length - 1];
         if(firstBoundAchievement !== null)
         {
            this.sysApi.sendAction(new OpenBookAction([EnumTab.ACHIEVEMENT_TAB,{"achievementId":firstBoundAchievement.id}]));
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var categoryKey:String = null;
         if(target === this.btn_changeOrientation)
         {
            this.changeOrientation(!this._isVertical);
         }
         else if(target.name.indexOf("btn_minimize") !== -1 && target.name in this._componentsData)
         {
            categoryKey = this._componentsData[target.name];
            this.setChallengeVisibility(categoryKey,!this.isChallengeCategoryVisible(categoryKey));
         }
         else if(target.name.indexOf("ctr_challengeEntry") !== -1 && target.name in this._componentsData)
         {
            this.openAchievementTab(this._componentsData[target.name]);
         }
      }
      
      private function onFoldAll(isVisible:Boolean) : void
      {
         var challengeCategoryData:ChallengeCategoryData = null;
         if(this._challengeCategoryData === null)
         {
            return;
         }
         for each(challengeCategoryData in this._challengeCategoryData)
         {
            this.setChallengeVisibility(challengeCategoryData.categoryKey,isVisible,false);
         }
         this.displayChallenges();
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var challenge:ChallengeWrapper = null;
         var makerParam:Object = null;
         var targetMonsterId:Number = NaN;
         var targetMonsterExists:* = false;
         var turnsRequired:Number = NaN;
         if(target.name.indexOf("ctr_challengeEntry") !== -1 && target.name in this._componentsData)
         {
            challenge = this._componentsData[target.name];
            if(challenge.categoryId === EnumChallengeCategory.ACHIEVEMENT)
            {
               makerParam = {
                  "name":true,
                  "description":true,
                  "effects":false,
                  "boundAchievements":challenge.boundAchievements,
                  "results":true
               };
            }
            else
            {
               makerParam = {
                  "name":true,
                  "description":true,
                  "effects":true,
                  "results":true
               };
            }
            targetMonsterId = challenge.getTargetMonsterId();
            targetMonsterExists = Monster.getMonsterById(targetMonsterId) !== null;
            if(!isNaN(targetMonsterId) && targetMonsterExists)
            {
               makerParam.bossId = targetMonsterId;
            }
            turnsRequired = challenge.getTurnsNumberForCompletion();
            if(!isNaN(turnsRequired))
            {
               makerParam.turnsRequired = turnsRequired;
            }
            this.uiApi.showTooltip(challenge,target,false,TOOLTIP_NAME,LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPRIGHT,3,null,null,makerParam);
            this.sysApi.sendAction(new ChallengeTargetsListRequestAction([challenge.id]));
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onChallengeInfoUpdate(challenges:Object) : void
      {
         if(challenges is Array)
         {
            this.loadChallenges(challenges as Array);
            this.displayChallenges();
         }
      }
   }
}

class GridData
{
    
   
   function GridData()
   {
      super();
   }
}

import com.ankamagames.dofus.internalDatacenter.fight.ChallengeWrapper;

class ChallengeGridData extends GridData
{
    
   
   private var _challenge:ChallengeWrapper = null;
   
   function ChallengeGridData(challenge:ChallengeWrapper)
   {
      super();
      this._challenge = challenge;
   }
   
   public function get challenge() : ChallengeWrapper
   {
      return this._challenge;
   }
}

class PanelGridData extends GridData
{
    
   
   private var _categoryKey:String = null;
   
   function PanelGridData(categoryKey:String)
   {
      super();
      this._categoryKey = categoryKey;
   }
   
   public function get categoryKey() : String
   {
      return this._categoryKey;
   }
}

import com.ankamagames.dofus.internalDatacenter.fight.ChallengeWrapper;

class ChallengeCategoryData
{
    
   
   public var isVisible:Boolean;
   
   private var _categoryKey:String;
   
   private var _challenges:Vector.<ChallengeWrapper>;
   
   function ChallengeCategoryData(categoryKey:String, isVisible:Boolean)
   {
      super();
      this._categoryKey = categoryKey;
      this.isVisible = isVisible;
   }
   
   public function get categoryKey() : String
   {
      return this._categoryKey;
   }
   
   public function get challenges() : Vector.<ChallengeWrapper>
   {
      return this._challenges;
   }
   
   public function addChallenge(challenge:ChallengeWrapper) : void
   {
      if(this._challenges === null)
      {
         this._challenges = new Vector.<ChallengeWrapper>();
      }
      this._challenges.push(challenge);
   }
}
