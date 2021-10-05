package Ankama_Grimoire.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.progression.ActivitySuggestion;
   import com.ankamagames.dofus.datacenter.progression.ActivitySuggestionsCategory;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.logic.game.common.actions.ActivityHideRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.ActivityLockRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.ActivitySuggestionsRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   
   public class GameSuggestion
   {
      
      public static var CACHE:Dictionary = new Dictionary();
       
      
      private const CACHE_ACTIVITY:String = "Cact";
      
      private const CACHE_LOCATION:String = "Cloc";
      
      private const CACHE_LEVELFROM:String = "Cfro";
      
      private const CACHE_LEVELTO:String = "Cto";
      
      private const CACHE_CURRENTCHARACTER:String = "Ccha";
      
      private const CACHE_LASTCARDS:String = "Clas";
      
      private const CACHE_LOCKEDCARDS:String = "Clock";
      
      private const LOCK_URI:String = "lock";
      
      private const UNLOCK_URI:String = "unlock";
      
      private const LOCKED:String = "locked";
      
      private const HIDED:String = "hided";
      
      private const FILTERED:String = "filtered";
      
      private const INTERFACE:String = "interface";
      
      private const MAX_LEVEL:int = 200;
      
      private const EVENT_CATEGORY_ID:int = 13;
      
      private const EVENT_CATEGORY_NAME:String = ActivitySuggestionsCategory.getActivitySuggestionsCategoryById(this.EVENT_CATEGORY_ID).name;
      
      private const ASKED_CARDS:int = 50;
      
      private const MAX_LOCKS:int = 4;
      
      private const BLACK_HEADER:int = 1579032;
      
      private const GREEN_HEADER:int = 7504924;
      
      private const MAX_SHORT:int = 32767;
      
      private const HIDDEN_CARDS_BEFORE_REFRESH:int = 30;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      private var _everyArea:String;
      
      private var _everyActivity:String;
      
      public var gd_cards:Grid;
      
      public var inp_levelFrom:Input;
      
      public var inp_levelTo:Input;
      
      public var cb_sortActivities:ComboBox;
      
      public var cb_sortLocation:ComboBox;
      
      public var lbl_sortLevelTo:Label;
      
      public var lbl_sortLevelFrom:Label;
      
      public var lbl_refreshActivities:Label;
      
      public var btn_refreshActivities:ButtonContainer;
      
      private var _filterTimer:BenchmarkTimer;
      
      private var _compHookData:Dictionary;
      
      private var _forceRefresh:Boolean = true;
      
      private var _nbCardsHidden:int = 0;
      
      private var _currentCardsDatas:Array;
      
      private var _suggestionCategories:Array;
      
      private var _areas:Array;
      
      private var _lastInput:Input;
      
      private var _refreshed:Boolean = false;
      
      public function GameSuggestion()
      {
         this._filterTimer = new BenchmarkTimer(500,1,"GameSuggestion._filterTimer");
         this._compHookData = new Dictionary();
         this._lastInput = this.inp_levelTo;
         super();
      }
      
      public function main(params:Object) : void
      {
         var area:Area = null;
         var cat:ActivitySuggestionsCategory = null;
         this.sysApi.startStats("suggestions");
         this.sysApi.addHook(HookList.ActivitySuggestions,this.onActivitySuggestions);
         this._everyArea = this.uiApi.getText("ui.guidebook.everyArea");
         this._everyActivity = this.uiApi.getText("ui.guidebook.everyActivity");
         this.resizeLabels();
         if(CACHE[this.CACHE_CURRENTCHARACTER] && CACHE[this.CACHE_CURRENTCHARACTER] != this.playerApi.id())
         {
            CACHE = new Dictionary();
         }
         if(!CACHE[this.CACHE_LOCKEDCARDS])
         {
            CACHE[this.CACHE_LOCKEDCARDS] = [];
         }
         this._areas = Area.getAllArea().sortOn("name");
         var locationsList:Array = [this._everyArea];
         for each(area in this._areas)
         {
            if(area.hasSuggestion)
            {
               locationsList.push(area.name);
            }
         }
         this.cb_sortLocation.dataProvider = locationsList;
         if(CACHE[this.CACHE_LOCATION])
         {
            this.cb_sortLocation.selectedIndex = CACHE[this.CACHE_LOCATION];
         }
         else
         {
            this.cb_sortLocation.selectedIndex = 0;
         }
         this._suggestionCategories = ActivitySuggestionsCategory.getActivitySuggestionsCategories().sort(this.compareActivityCategoriesNames);
         var categoriesList:Array = [this._everyActivity];
         for each(cat in this._suggestionCategories)
         {
            if(!cat.parentId && cat.id != this.EVENT_CATEGORY_ID)
            {
               categoriesList.push(cat.name);
            }
         }
         this.cb_sortActivities.dataProvider = categoriesList;
         if(CACHE[this.CACHE_ACTIVITY])
         {
            this.cb_sortActivities.selectedIndex = CACHE[this.CACHE_ACTIVITY];
         }
         else
         {
            this.cb_sortActivities.selectedIndex = 0;
         }
         this._filterTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onFilterTimer);
         this.inp_levelFrom.textfield.text = !!CACHE[this.CACHE_LEVELFROM] ? CACHE[this.CACHE_LEVELFROM] : "1";
         this.inp_levelTo.textfield.text = !!CACHE[this.CACHE_LEVELTO] ? CACHE[this.CACHE_LEVELTO] : Math.min(this.playerApi.getPlayedCharacterInfo().level,this.MAX_LEVEL).toString();
         this.uiApi.addComponentHook(this.cb_sortLocation,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_sortActivities,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.inp_levelFrom,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.inp_levelTo,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.btn_refreshActivities,ComponentHookList.ON_RELEASE);
         if(CACHE[this.CACHE_LASTCARDS] && CACHE[this.CACHE_LASTCARDS].length)
         {
            this._currentCardsDatas = CACHE[this.CACHE_LASTCARDS];
            this.gd_cards.dataProvider = this.cardsToGridDatas(CACHE[this.CACHE_LASTCARDS],2);
         }
         else
         {
            this.onFilterTimer(null);
         }
      }
      
      public function unload() : void
      {
         CACHE[this.CACHE_ACTIVITY] = this.cb_sortActivities.selectedIndex;
         CACHE[this.CACHE_LOCATION] = this.cb_sortLocation.selectedIndex;
         CACHE[this.CACHE_LEVELFROM] = this.inp_levelFrom.text;
         CACHE[this.CACHE_LEVELTO] = this.inp_levelTo.text;
         CACHE[this.CACHE_CURRENTCHARACTER] = this.playerApi.id();
         this._filterTimer.stop();
         this._filterTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onFilterTimer);
      }
      
      public function updateCard(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         var type:String = this.getCardType(data,line);
         if(type.indexOf("empty") == -1)
         {
            this.sendStat(data as CustomCardData);
            componentsRef.lbl_cardType.htmlText = data.category;
            if(data.startDate)
            {
               componentsRef.lbl_cardDate.htmlText = this.timeApi.getDate(data.startDate) + " - " + this.timeApi.getDate(data.endDate);
            }
            else
            {
               componentsRef.lbl_cardDate.htmlText = "";
            }
            if(componentsRef.tx_cardLock)
            {
               componentsRef.tx_cardLock.uri = this.uiApi.createUri((this.uiApi.me() as Object).getConstant(!!data.locked ? this.LOCK_URI : this.UNLOCK_URI));
            }
            componentsRef.tx_cardPicture.uri = this.uiApi.createUri(this.uiApi.me().getConstant("gfxs") + data.iconID + ".png");
            componentsRef.lbl_cardDescription.htmlText = data.description;
            componentsRef.lbl_cardName.htmlText = data.name;
            if(componentsRef.lbl_cardName.textfield.numLines == 1)
            {
               componentsRef.lbl_cardDescription.y = 50;
            }
            else
            {
               componentsRef.lbl_cardDescription.y = 62;
            }
            if(data.isEvent)
            {
               componentsRef.ctr_cardHeader.bgColor = this.GREEN_HEADER;
               if(componentsRef.tx_cardHeaderBg)
               {
                  componentsRef.tx_cardHeaderBg.visible = false;
               }
            }
            else
            {
               componentsRef.ctr_cardHeader.bgColor = this.BLACK_HEADER;
               if(componentsRef.tx_cardHeaderBg)
               {
                  componentsRef.tx_cardHeaderBg.visible = true;
               }
            }
            if(data.startLocation)
            {
               componentsRef.lbl_cardStartingPoint.htmlText = "{map," + data.startLocation.posX + "," + data.startLocation.posY + "," + (data.startLocation.worldMap > 0 ? data.startLocation.worldMap : data.startLocation.subArea.area.worldmap.id) + "," + data.startLocation.subArea.name + " }";
            }
            else
            {
               componentsRef.lbl_cardStartingPoint.htmlText = "";
            }
            if(data.level > 0)
            {
               componentsRef.lbl_cardLevel.htmlText = this.uiApi.getText("ui.common.level") + " " + data.level;
            }
            else
            {
               componentsRef.lbl_cardLevel.htmlText = "";
            }
            if(componentsRef.btn_cardHide)
            {
               this._compHookData[componentsRef.btn_cardHide] = data;
               this.uiApi.addComponentHook(componentsRef.btn_cardHide,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(componentsRef.btn_cardHide,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.btn_cardHide,ComponentHookList.ON_ROLL_OUT);
            }
            if(componentsRef.btn_cardLock)
            {
               this._compHookData[componentsRef.btn_cardLock] = data;
               if(!data.locked)
               {
                  this.uiApi.addComponentHook(componentsRef.btn_cardLock,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(componentsRef.btn_cardLock,ComponentHookList.ON_ROLL_OUT);
                  if(CACHE[this.CACHE_LOCKEDCARDS].length == this.MAX_LOCKS)
                  {
                     this.uiApi.removeComponentHook(componentsRef.btn_cardLock,ComponentHookList.ON_RELEASE);
                  }
                  else
                  {
                     this.uiApi.addComponentHook(componentsRef.btn_cardLock,ComponentHookList.ON_RELEASE);
                  }
               }
               else
               {
                  this.uiApi.addComponentHook(componentsRef.btn_cardLock,ComponentHookList.ON_RELEASE);
                  this.uiApi.removeComponentHook(componentsRef.btn_cardLock,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.removeComponentHook(componentsRef.btn_cardLock,ComponentHookList.ON_ROLL_OUT);
               }
            }
         }
      }
      
      public function getCardType(data:*, line:uint) : String
      {
         if(data)
         {
            if(data.large)
            {
               return "ctr_largeCard";
            }
            return "ctr_card";
         }
         return "ctr_emptyCard";
      }
      
      private function cardsToGridDatas(cardsDatas:Array, nbLinesWanted:int = -1) : Array
      {
         var card:CustomCardData = null;
         var nbEvents:int = 0;
         var largeStartIndex:uint = 0;
         var smallStartIndex:uint = 0;
         var nbLines:uint = 0;
         var lineLength:uint = 0;
         var i:int = 0;
         var gridDatas:Array = [];
         for each(card in cardsDatas)
         {
            if(card.category == this.EVENT_CATEGORY_NAME)
            {
               if(card.large)
               {
                  gridDatas.insertAt(0,null);
                  gridDatas.insertAt(0,card);
               }
               else
               {
                  gridDatas.push(card);
               }
            }
         }
         nbEvents = gridDatas.length;
         largeStartIndex = 0;
         smallStartIndex = 0;
         nbLines = Math.floor(nbEvents / 3);
         lineLength = nbEvents - 3 * nbLines;
         if(nbLines >= nbLinesWanted)
         {
            gridDatas.length = nbLinesWanted * 3;
         }
         while(nbLines < nbLinesWanted && largeStartIndex < cardsDatas.length)
         {
            while(lineLength < 2 && largeStartIndex < cardsDatas.length)
            {
               card = cardsDatas[largeStartIndex];
               if(gridDatas.indexOf(card) == -1 && (card.large || largeStartIndex >= smallStartIndex))
               {
                  gridDatas.push(card);
                  lineLength++;
                  if(card.large)
                  {
                     gridDatas.push(null);
                     lineLength++;
                  }
               }
               largeStartIndex++;
            }
            smallStartIndex = Math.max(smallStartIndex,largeStartIndex);
            while(lineLength < 3 && smallStartIndex < cardsDatas.length)
            {
               if(gridDatas.indexOf(cardsDatas[smallStartIndex]) == -1 && !cardsDatas[smallStartIndex].large)
               {
                  gridDatas.push(cardsDatas[smallStartIndex]);
                  lineLength++;
               }
               else if(smallStartIndex == cardsDatas.length - 1)
               {
                  gridDatas.push(null);
               }
               smallStartIndex++;
            }
            nbLines++;
            lineLength = 0;
         }
         var cardTypes:Dictionary = new Dictionary();
         for(var j:int = nbEvents; j < gridDatas.length; j++)
         {
            card = gridDatas[j];
            if(card != null)
            {
               if(!cardTypes[card.category])
               {
                  cardTypes[card.category] = true;
               }
               else if(!card.locked)
               {
                  if(card.large)
                  {
                     for(i = largeStartIndex; i < cardsDatas.length; i++)
                     {
                        if(cardsDatas[i].large && !cardTypes[cardsDatas[i].category] && gridDatas.indexOf(cardsDatas[i]) == -1)
                        {
                           gridDatas[gridDatas.indexOf(card)] = cardsDatas[i];
                           cardsDatas[cardsDatas.indexOf(card)] = cardsDatas[i];
                           cardTypes[cardsDatas[i].category] = true;
                           cardsDatas[i] = card;
                           break;
                        }
                     }
                     largeStartIndex = Math.min(i + 1,cardsDatas.length);
                  }
                  else
                  {
                     for(i = smallStartIndex; i < cardsDatas.length; i++)
                     {
                        if(!cardsDatas[i].large && !cardTypes[cardsDatas[i].category] && gridDatas.indexOf(cardsDatas[i]) == -1)
                        {
                           gridDatas[gridDatas.indexOf(card)] = cardsDatas[i];
                           cardsDatas[cardsDatas.indexOf(card)] = cardsDatas[i];
                           cardTypes[cardsDatas[i].category] = true;
                           cardsDatas[i] = card;
                           break;
                        }
                     }
                     smallStartIndex = Math.min(i + 1,cardsDatas.length);
                  }
               }
            }
         }
         return gridDatas;
      }
      
      private function resizeLabels() : void
      {
         this.lbl_sortLevelTo.fullWidth();
         this.lbl_sortLevelFrom.fullWidth();
         this.lbl_refreshActivities.fullWidth();
      }
      
      private function compareActivityCategoriesNames(catA:ActivitySuggestionsCategory, catB:ActivitySuggestionsCategory) : int
      {
         var labelA:String = StringUtils.noAccent(catA.name);
         var labelB:String = StringUtils.noAccent(catB.name);
         if(labelA > labelB)
         {
            return 1;
         }
         if(labelA < labelB)
         {
            return -1;
         }
         return 0;
      }
      
      private function onActivitySuggestions(lockedActivities:Vector.<uint>, unlockedActivities:Vector.<uint>) : void
      {
         var suggId:uint = 0;
         var cardData:CustomCardData = null;
         var length:int = 0;
         var randomPos:Number = NaN;
         var i:int = 0;
         if(this._forceRefresh)
         {
            this._currentCardsDatas = [];
         }
         else
         {
            this._forceRefresh = true;
         }
         this._nbCardsHidden = 0;
         var dataCopy:Array = [];
         var currentIds:Array = [];
         var hasLarge:Boolean = false;
         var largeCard:CustomCardData = null;
         for each(cardData in this._currentCardsDatas)
         {
            if(cardData.large)
            {
               hasLarge = true;
               largeCard = cardData;
            }
            currentIds.push(cardData.id);
         }
         if(hasLarge)
         {
            this._currentCardsDatas.removeAt(this._currentCardsDatas.indexOf(largeCard));
         }
         for each(suggId in lockedActivities)
         {
            if(currentIds.indexOf(suggId) == -1)
            {
               cardData = new CustomCardData(ActivitySuggestion.getActivitySuggestionById(suggId),true);
               if(CACHE[this.CACHE_LOCKEDCARDS].indexOf(suggId) == -1)
               {
                  CACHE[this.CACHE_LOCKEDCARDS].push(suggId);
               }
               if(cardData.large)
               {
                  if(!hasLarge)
                  {
                     largeCard = cardData;
                     hasLarge = true;
                  }
               }
               else
               {
                  this._currentCardsDatas.push(cardData);
               }
            }
         }
         for each(suggId in unlockedActivities)
         {
            if(currentIds.indexOf(suggId) == -1)
            {
               cardData = new CustomCardData(ActivitySuggestion.getActivitySuggestionById(suggId));
               if(cardData.large)
               {
                  if(!hasLarge)
                  {
                     largeCard = cardData;
                     hasLarge = true;
                  }
               }
               else
               {
                  dataCopy.push(cardData);
               }
            }
         }
         length = dataCopy.length;
         randomPos = 0;
         for(i = 0; i < length; i++)
         {
            randomPos = Math.floor(Math.random() * dataCopy.length);
            this._currentCardsDatas.push(dataCopy.splice(randomPos,1)[0]);
         }
         if(hasLarge)
         {
            this._currentCardsDatas.insertAt(0,largeCard);
         }
         this.gd_cards.dataProvider = this.cardsToGridDatas(this._currentCardsDatas,2);
         CACHE[this.CACHE_LASTCARDS] = this._currentCardsDatas;
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(selectMethod != 0)
         {
            return;
         }
         this._refreshed = false;
         switch(target)
         {
            case this.cb_sortLocation:
            case this.cb_sortActivities:
               this._filterTimer.reset();
               this._filterTimer.start();
         }
      }
      
      public function onRelease(target:*) : void
      {
         var index:int = 0;
         var gridIndex:int = 0;
         var cardsTypes:Array = null;
         var nbCards:int = 0;
         var card:CustomCardData = null;
         var hasOtherType:Boolean = false;
         var i:int = 0;
         this.uiApi.hideTooltip();
         switch(target)
         {
            case this.btn_refreshActivities:
               this._refreshed = true;
               this.onFilterTimer(null);
               break;
            default:
               if(target.name.indexOf("Lock") != -1)
               {
                  this._compHookData[target].locked = !this._compHookData[target].locked;
                  if(this._compHookData[target].locked)
                  {
                     CACHE[this.CACHE_LOCKEDCARDS].push(this._compHookData[target].id);
                  }
                  else
                  {
                     CACHE[this.CACHE_LOCKEDCARDS].removeAt(CACHE[this.CACHE_LOCKEDCARDS].indexOf(this._compHookData[target].id));
                  }
                  this.sysApi.sendAction(new ActivityLockRequestAction([this._compHookData[target].id,this._compHookData[target].locked]));
                  this.gd_cards.dataProvider = this.cardsToGridDatas(this._currentCardsDatas,2);
               }
               else if(target.name.indexOf("Hide") != -1)
               {
                  this.sendStat(this._compHookData[target],true);
                  this.sysApi.sendAction(new ActivityHideRequestAction([this._compHookData[target].id]));
                  index = this._currentCardsDatas.indexOf(this._compHookData[target]);
                  gridIndex = this.gd_cards.dataProvider.indexOf(this._compHookData[target]);
                  cardsTypes = [];
                  nbCards = 0;
                  for each(card in this.gd_cards.dataProvider)
                  {
                     if(card != null)
                     {
                        if(card != this._compHookData[target])
                        {
                           cardsTypes.push(card.category);
                        }
                        nbCards++;
                     }
                  }
                  if(nbCards >= this._currentCardsDatas.length)
                  {
                     this._currentCardsDatas.removeAt(index);
                     this.gd_cards.dataProvider = this.cardsToGridDatas(this._currentCardsDatas,2);
                  }
                  else
                  {
                     hasOtherType = false;
                     for(i = 0; i < this._currentCardsDatas.length; i++)
                     {
                        if(cardsTypes.indexOf(this._currentCardsDatas[i].category) == -1)
                        {
                           hasOtherType = true;
                           break;
                        }
                     }
                     this._currentCardsDatas[index] = this._currentCardsDatas[this._currentCardsDatas.length - 1];
                     this._currentCardsDatas.pop();
                     if(hasOtherType)
                     {
                        this.gd_cards.dataProvider = this.cardsToGridDatas(this._currentCardsDatas,2);
                     }
                     else
                     {
                        this.gd_cards.dataProvider[gridIndex] = this._currentCardsDatas[index];
                        this.gd_cards.dataProvider = this.gd_cards.dataProvider;
                     }
                  }
                  if(this._compHookData[target].locked)
                  {
                     CACHE[this.CACHE_LOCKEDCARDS].removeAt(CACHE[this.CACHE_LOCKEDCARDS].indexOf(this._compHookData[target].id));
                  }
                  ++this._nbCardsHidden;
                  if(this._nbCardsHidden == this.HIDDEN_CARDS_BEFORE_REFRESH)
                  {
                     this._forceRefresh = false;
                     this.onFilterTimer(null);
                  }
               }
         }
      }
      
      public function onRollOver(target:Object) : void
      {
         var txt:String = null;
         var _loc3_:* = target;
         switch(0)
         {
         }
         if(target.name.indexOf("Lock") != -1)
         {
            if(CACHE[this.CACHE_LOCKEDCARDS].length == this.MAX_LOCKS)
            {
               txt = this.uiApi.getText("ui.guidebook.maxCards");
            }
            else
            {
               txt = this.uiApi.getText("ui.guidebook.lockCard");
            }
         }
         if(target.name.indexOf("Hide") != -1)
         {
            txt = this.uiApi.getText("ui.guidebook.hideCardTooltip");
         }
         if(txt)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt),target,false,"standard",LocationEnum.POINT_BOTTOMRIGHT,LocationEnum.POINT_TOPRIGHT,0,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onChange(target:Object) : void
      {
         this._refreshed = false;
         switch(target)
         {
            case this.inp_levelTo:
               this._lastInput = this.inp_levelTo;
               this._filterTimer.reset();
               this._filterTimer.start();
               break;
            case this.inp_levelFrom:
               this._lastInput = this.inp_levelFrom;
               this._filterTimer.reset();
               this._filterTimer.start();
         }
      }
      
      private function onFilterTimer(e:TimerEvent) : void
      {
         var area:Area = null;
         var catId:uint = 0;
         var cat:ActivitySuggestionsCategory = null;
         var areaId:uint = this.MAX_SHORT;
         for each(area in this._areas)
         {
            if(area.name == this.cb_sortLocation.selectedItem)
            {
               areaId = area.id;
               break;
            }
         }
         catId = 0;
         for each(cat in this._suggestionCategories)
         {
            if(cat.name == this.cb_sortActivities.selectedItem)
            {
               catId = cat.id;
               break;
            }
         }
         if(parseInt(this.inp_levelTo.text) < parseInt(this.inp_levelFrom.text))
         {
            if(this._lastInput == this.inp_levelTo)
            {
               this.inp_levelTo.text = this.inp_levelFrom.text;
            }
            else if(this._lastInput == this.inp_levelFrom)
            {
               this.inp_levelFrom.text = this.inp_levelTo.text;
            }
            return;
         }
         this.sysApi.sendAction(new ActivitySuggestionsRequestAction([parseInt(this.inp_levelFrom.text),parseInt(this.inp_levelTo.text),areaId,catId,this.ASKED_CARDS]));
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case ShortcutHookListEnum.CLOSE_UI:
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      private function sendStat(card:CustomCardData, hide:Boolean = false) : void
      {
         var params:Dictionary = new Dictionary();
         params["cardId"] = card.id;
         params["categoryName"] = card.category;
         if(hide)
         {
            params["cardAction"] = this.HIDED;
         }
         else
         {
            params["cardAction"] = !!card.locked ? this.LOCKED : null;
         }
         params["activityType"] = this.cb_sortActivities.selectedIndex == 0 ? null : this.cb_sortActivities.selectedItem;
         params["filterZone"] = this.cb_sortActivities.selectedIndex == 0 ? null : this.cb_sortLocation.selectedItem;
         params["filterLevelMin"] = parseInt(this.inp_levelFrom.text) == 1 ? null : parseInt(this.inp_levelFrom.text);
         params["filterLevelMax"] = parseInt(this.inp_levelTo.text) == Math.min(this.playerApi.getPlayedCharacterInfo().level,this.MAX_LEVEL) ? null : parseInt(this.inp_levelTo.text);
         params["referehedUsed"] = this._refreshed;
         params["printSource"] = params["activityType"] == null && params["filterZone"] == null && params["filterLevelMin"] == null && params["filterLevelMax"] == null ? this.INTERFACE : this.FILTERED;
         this.sysApi.dispatchHook(HookList.SuggestionsStats,params);
      }
   }
}

import com.ankamagames.dofus.datacenter.progression.ActivitySuggestion;
import com.ankamagames.dofus.datacenter.progression.ActivitySuggestionsCategory;
import com.ankamagames.dofus.datacenter.world.MapPosition;

class CustomCardData
{
    
   
   private const EVENT_CATEGORY_ID:int = 13;
   
   public var id:int;
   
   public var large:Boolean;
   
   public var category:String;
   
   public var name:String;
   
   public var description:String;
   
   public var iconID:String;
   
   public var level:uint;
   
   public var startDate:Number;
   
   public var endDate:Number;
   
   public var startLocation:MapPosition;
   
   public var locked:Boolean;
   
   public var isEvent:Boolean;
   
   function CustomCardData(sugg:ActivitySuggestion, locked:Boolean = false)
   {
      super();
      this.id = sugg.id;
      this.name = sugg.name;
      this.description = sugg.description;
      this.level = sugg.level;
      if(sugg.mapId > 0)
      {
         this.startLocation = MapPosition.getMapPositionById(sugg.mapId);
      }
      this.category = ActivitySuggestionsCategory.getActivitySuggestionsCategoryById(sugg.categoryId).name;
      this.isEvent = sugg.categoryId == this.EVENT_CATEGORY_ID;
      this.iconID = sugg.icon;
      this.large = sugg.isLarge;
      this.startDate = sugg.startDate;
      this.endDate = sugg.endDate;
      this.locked = locked;
   }
}
