package Ankama_Grimoire.ui
{
   import Ankama_Cartography.Cartography;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.components.gridRenderer.MultiGridRenderer;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.ScrollContainer;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.dofus.datacenter.quest.QuestStep;
   import com.ankamagames.dofus.logic.game.common.actions.FollowQuestAction;
   import com.ankamagames.dofus.logic.game.common.actions.RefreshFollowedQuestsOrderAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestInfosRequestAction;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.CompassTypeEnum;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.QuestApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import flash.utils.Dictionary;
   
   public class QuestList extends AbstractQuestList
   {
      
      private static const MAX_OBJECTIVES:uint = 3;
      
      private static const QUEST_TYPE:String = "ctr_quest";
      
      private static const OBJECTIVE_TYPE:String = "ctr_objective";
      
      private static const RIGHT_MARGIN:uint = 40;
      
      private static const BOTTOM_MARGIN:uint = 15;
      
      public static const MAX_FOLLOWED_QUESTS_DATA_ID:String = "maxFollowedQuests";
      
      private static const FOLLOWED_QUESTS_RESIZE_MODE_DATA_ID:String = "followedQuestsResizeMode";
      
      private static const OPACITY_DATA_ID:String = "followedQuestsBackgroundOpacity";
      
      private static const FONT_SIZE_DATA_ID:String = "followedQuestsFontSize";
      
      private static const QUEST_LIST_MINIMIZED_DATA_ID:String = "questListMinimized";
      
      private static const AUTO_RESIZE_MODE:uint = 1;
      
      private static const FREE_RESIZE_MODE:uint = 2;
      
      private static const FONT_SMALL_SIZE:uint = 15;
      
      private static const FONT_MEDIUM_SIZE:uint = 16;
      
      private static const ITEM_ID_REGEXP:RegExp = /\d+/g;
      
      private static const ITEM_LINK_REGEX:RegExp = /{item(,|::)(.*?)}/g;
       
      
      [Api(name="QuestApi")]
      public var questApi:QuestApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Module(name="Ankama_Cartography")]
      public var modCartography:Cartography;
      
      private var _quests:Array;
      
      private var _maxQuests:uint;
      
      private var _offsetY:Number;
      
      private var _listRendered:Boolean;
      
      private var _colors:Array;
      
      private var _defaultColorTransform:ColorTransform;
      
      private var _numQuests:uint;
      
      private var _previousItemIsQuest:Boolean;
      
      private var _components:Dictionary;
      
      private var _updating:Boolean;
      
      private var _startedQuests:Vector.<uint>;
      
      private var _resizeMode:uint;
      
      private var _flagsQuestData:Dictionary;
      
      private var _opacity:Number;
      
      private var _fontSize:uint;
      
      private var _mouseScrollEvent:MouseEvent;
      
      private var _questsFollowAll:Dictionary;
      
      private var _questsObjectivesOrder:Dictionary;
      
      public var tx_minMax:TextureBitmap;
      
      public var tx_title:TextureBitmap;
      
      public var ctr_list:GraphicContainer;
      
      public var ctr_main:GraphicContainer;
      
      public var btn_options:ButtonContainer;
      
      public var btn_minimize:ButtonContainer;
      
      public var gd_quests:Grid;
      
      public var lbl_title:Label;
      
      public var gridScrollContainer:ScrollContainer;
      
      public function QuestList()
      {
         this._questsFollowAll = new Dictionary();
         this._questsObjectivesOrder = new Dictionary();
         super();
      }
      
      override public function main(params:Object) : void
      {
         var i:int = 0;
         var questParam:Object = null;
         var needInfosQuestsIds:Vector.<uint> = null;
         super.main(params);
         this._maxQuests = sysApi.getSetData(MAX_FOLLOWED_QUESTS_DATA_ID,ProtocolConstantsEnum.MAX_FOLLOWED_QUESTS,DataStoreEnum.BIND_ACCOUNT);
         this._resizeMode = sysApi.getSetData(FOLLOWED_QUESTS_RESIZE_MODE_DATA_ID,AUTO_RESIZE_MODE,DataStoreEnum.BIND_ACCOUNT);
         this.ctr_list.getResizeController().bottomResize = this._resizeMode == FREE_RESIZE_MODE;
         this._opacity = sysApi.getSetData(OPACITY_DATA_ID,0.7,DataStoreEnum.BIND_ACCOUNT);
         this.changeOpacity(this._opacity);
         this._fontSize = sysApi.getSetData(FONT_SIZE_DATA_ID,FONT_MEDIUM_SIZE,DataStoreEnum.BIND_ACCOUNT);
         this._mouseScrollEvent = new MouseEvent(MouseEvent.MOUSE_WHEEL);
         this.gridScrollContainer.verticalScrollSpeed = 20;
         this.gridScrollContainer.addContent(this.gd_quests);
         sysApi.addHook(QuestHookList.QuestValidated,this.onQuestValidated);
         sysApi.addHook(QuestHookList.QuestObjectiveValidated,this.onQuestObjectiveValidated);
         sysApi.addHook(QuestHookList.QuestStepValidated,this.onQuestStepValidated);
         sysApi.addHook(QuestHookList.QuestStarted,this.onQuestStarted);
         sysApi.addHook(QuestHookList.QuestInfosUpdated,this.onQuestInfosUpdated);
         sysApi.addHook(HookList.FontActiveTypeChanged,this.onFontActiveTypeChanged);
         sysApi.addHook(HookList.RemoveAllFlags,this.removeAllFlags);
         sysApi.addHook(CustomUiHookList.FlagRemoved,this.onFlagRemoved);
         sysApi.addHook(CustomUiHookList.FlagAdded,this.onFlagAdded);
         this._quests = new Array();
         this._startedQuests = new Vector.<uint>();
         this._components = new Dictionary();
         this._colors = [false,false,false,false,false,false,false,false,false,false];
         this._defaultColorTransform = new ColorTransform();
         this._flagsQuestData = new Dictionary();
         if(params)
         {
            for(i = params.quests.length - 1; i >= 0; i--)
            {
               questParam = params.quests[i];
               if(!questParam.hasOwnProperty("objectives"))
               {
                  if(!needInfosQuestsIds)
                  {
                     needInfosQuestsIds = new Vector.<uint>();
                  }
                  needInfosQuestsIds.push(questParam.questId);
               }
               else
               {
                  this.addQuest(params.quests[i],false);
               }
            }
            if(this._numQuests > 0)
            {
               this.update();
            }
            if(needInfosQuestsIds && needInfosQuestsIds.length)
            {
               for(i = 0; i < needInfosQuestsIds.length; i++)
               {
                  this.onQuestStarted(needInfosQuestsIds[i]);
               }
            }
            if(!params.visible && !sysApi.isFightContext())
            {
               this.minimize();
            }
         }
      }
      
      public function unload() : void
      {
      }
      
      public function update() : void
      {
         this._updating = true;
         this._listRendered = false;
         this._offsetY = 0;
         this.gd_quests.finalized = false;
         this.gd_quests.height = this._quests.length * this.gd_quests.slotHeight;
         this.gd_quests.dataProvider = this._quests;
         this.updateListSize();
         this._listRendered = true;
         this._updating = false;
         this.restrictPosition();
      }
      
      public function updateLine(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         var questOffset:Number = NaN;
         var objectiveY:Number = NaN;
         var objectiveCssClass:String = null;
         var objectiveText:String = null;
         var objective:QuestObjective = null;
         this._components[data] = componentsRef;
         if(this._listRendered)
         {
            return;
         }
         var lineType:String = this.getLineType(data,line);
         var offset:Number = 0;
         if(lineType.length)
         {
            if(lineType == QUEST_TYPE)
            {
               questOffset = this._quests.indexOf(data) > 0 ? Number(10) : Number(0);
               componentsRef.lbl_quest.setCssSize(this._fontSize,"questtitle");
               componentsRef.lbl_quest.width = this.ctr_list.width - RIGHT_MARGIN;
               componentsRef.lbl_quest.y = this._offsetY + questOffset;
               componentsRef.lbl_quest.text = this.dataApi.getQuest(data.id).name + (!!sysApi.getPlayerManager().hasRights ? " (" + data.id + ")" : "");
               offset = componentsRef.lbl_quest.textHeight - (this.gd_quests.slotHeight - 5) + questOffset;
               this._previousItemIsQuest = true;
            }
            else
            {
               objectiveY = this._offsetY;
               if(this._previousItemIsQuest)
               {
                  objectiveY -= 2;
                  this._previousItemIsQuest = false;
               }
               else
               {
                  objectiveY -= 3;
               }
               componentsRef.lbl_objective.width = this.ctr_list.width - RIGHT_MARGIN;
               componentsRef.lbl_objective.x = componentsRef.btn_loc.x + componentsRef.btn_loc.width - 5;
               componentsRef.lbl_objective.y = componentsRef.btn_loc.y = objectiveY;
               if(data.hasOwnProperty("seeLess"))
               {
                  objectiveCssClass = "seemore";
                  objectiveText = uiApi.getText("ui.quest.seeLess");
               }
               else if(data.visible)
               {
                  objective = this.dataApi.getQuestObjective(data.id);
                  objectiveCssClass = "questobjective";
                  objectiveText = objective.text + (!!sysApi.getPlayerManager().hasRights ? " (" + data.id + ")" : "");
                  objectiveText = objectiveText.replace(ITEM_LINK_REGEX,"{encyclopediaItem$1$2}");
                  this.setFlagColor(componentsRef.btn_loc,data.color,!data.follow);
               }
               else
               {
                  objectiveCssClass = "seemore";
                  objectiveText = uiApi.getText("ui.quest.seeMore");
               }
               componentsRef.lbl_objective.cssClass = objectiveCssClass;
               componentsRef.lbl_objective.setCssSize(this._fontSize,objectiveCssClass);
               componentsRef.lbl_objective.text = objectiveText;
               offset = componentsRef.lbl_objective.textHeight - (this.gd_quests.slotHeight - 5);
               componentsRef.lbl_objective.fullSize(componentsRef.lbl_objective.width);
               componentsRef.btn_loc.visible = data.visible && data.flagData;
            }
            if(offset < 0)
            {
               offset = 0;
            }
            this._offsetY += offset;
         }
      }
      
      public function getLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         return !!data.isQuest ? QUEST_TYPE : OBJECTIVE_TYPE;
      }
      
      public function addQuest(questParams:Object, toTheTop:Boolean = true) : void
      {
         var i:int = 0;
         var questData:Object = null;
         var questExists:Boolean = false;
         var flagColor:uint = 0;
         var objectiveParam:Object = null;
         var objectiveData:Object = null;
         var objectiveExists:Boolean = false;
         var objectiveIndex:int = 0;
         var maxObjectivesReached:Boolean = false;
         var objectiveDictionnaryIndex:uint = 0;
         var flag:Object = null;
         var flagExists:* = false;
         var addFlag:Boolean = false;
         var checkedObjFollow:Boolean = false;
         var newIndex:int = 0;
         var flagSavedData:* = undefined;
         var x:uint = 0;
         var questDataObj:* = undefined;
         var quest:Quest = this.dataApi.getQuest(questParams.questId);
         if(!quest.followable)
         {
            return;
         }
         var followedObjectiveId:int = questParams.followedObjectiveID;
         var followAll:Boolean = followedObjectiveId > 0 ? false : true;
         for each(questData in this._quests)
         {
            if(questData.isQuest && questData.id == questParams.questId)
            {
               questExists = true;
               break;
            }
         }
         if(!questExists)
         {
            questData = {
               "id":questParams.questId,
               "isQuest":true,
               "color":this.getUnusedColor()
            };
            questData.objectives = [];
            if(toTheTop)
            {
               this._quests.unshift(questData);
            }
            else
            {
               this._quests.push(questData);
            }
            ++this._numQuests;
            this._questsFollowAll[questData.id] = followAll;
         }
         flagColor = questData.color;
         var numObjectives:uint = questParams.objectives.length;
         for(i = 0; i < numObjectives; i++)
         {
            objectiveParam = questParams.objectives[i];
            for each(objectiveData in questData.objectives)
            {
               if(objectiveData.id == objectiveParam.id)
               {
                  objectiveExists = true;
                  break;
               }
            }
            if(!objectiveExists)
            {
               questData.objectives.push({
                  "id":objectiveParam.id,
                  "flagData":objectiveParam.flagData,
                  "isQuest":false,
                  "questId":questData.id,
                  "color":flagColor
               });
               this._questsObjectivesOrder[questData.id + "_" + i] = questData.objectives[i];
            }
         }
         var numObjectivesData:uint = questData.objectives.length;
         var objectivesStartIndex:int = this._quests.indexOf(questData) + 1;
         var singleObjectiveAdded:Boolean = false;
         var followedObjectives:int = 0;
         var displayShowOption:Boolean = false;
         var maxIndex:int = 0;
         if(followAll)
         {
            this.clearQuestDisplay(questData,this._quests.indexOf(questData) + 1);
         }
         for(i = 0; i < numObjectivesData; i++)
         {
            objectiveDictionnaryIndex = this.GetObjectiveDictionaryOrder(questData,questData.objectives[i]);
            checkedObjFollow = false;
            newIndex = 0;
            if(questData.objectives[i].flagData)
            {
               questData.objectives[i].color = questData.color;
            }
            if(followAll)
            {
               if(questData.objectives[i].flagData)
               {
                  flagSavedData = sysApi.getData(playerApi.getPlayedCharacterInfo().id + "-questFlag-" + questData.objectives[i].flagData.id);
                  questData.objectives[i].follow = flagSavedData != null ? flagSavedData === true : false;
                  if(questData.objectives[i].follow)
                  {
                     followedObjectives++;
                     checkedObjFollow = true;
                  }
               }
               else
               {
                  questData.objectives[i].follow = false;
               }
               objectiveIndex = objectivesStartIndex + i;
               if(i + 1 <= MAX_OBJECTIVES)
               {
                  questData.objectives[i].visible = true;
                  this._quests.splice(objectiveIndex,0,questData.objectives[i]);
                  if(checkedObjFollow)
                  {
                     this.changeObjectivesOrder(questData.objectives[i],true);
                  }
               }
               else
               {
                  displayShowOption = true;
                  maxIndex = objectivesStartIndex + MAX_OBJECTIVES;
                  if(checkedObjFollow)
                  {
                     if(followedObjectives > 0)
                     {
                        this.ReOrderObjectiveDictionary(objectiveDictionnaryIndex,followedObjectives - 1,questData.id);
                     }
                     newIndex = objectivesStartIndex + followedObjectives;
                     if(followedObjectives <= MAX_OBJECTIVES)
                     {
                        this._quests[maxIndex - 1].visible = false;
                        this._quests.splice(maxIndex - 1,1);
                        questData.objectives[i].visible = true;
                        this._quests.splice(newIndex - 1,0,questData.objectives[i]);
                     }
                  }
               }
            }
            else if(questData.objectives[i].id == followedObjectiveId && !questData.objectives[i].visible)
            {
               maxObjectivesReached = false;
               this.addObjective(questData,questData.objectives[i],numObjectivesData,objectiveDictionnaryIndex);
            }
            else if(questData.objectives[i].id == followedObjectiveId && questData.objectives[i].visible)
            {
               questData.objectives[i].follow = true;
               this.changeObjectivesOrder(questData.objectives[i],true);
            }
            flagExists = false;
            if(questData.objectives[i].flagData)
            {
               this._flagsQuestData[questData.objectives[i].flagData.id] = questData.objectives[i];
               flag = this.getFlag(questData.objectives[i].flagData.id,questData.objectives[i].flagData.worldMapId);
               flagExists = flag != null;
               if(!questData.objectives[i].follow)
               {
                  if(flagExists)
                  {
                     sysApi.dispatchHook(HookList.RemoveMapFlag,questData.objectives[i].flagData.id,questData.objectives[i].flagData.worldMapId);
                  }
               }
               else
               {
                  addFlag = false;
                  if(!flagExists)
                  {
                     addFlag = true;
                  }
                  else if(flag.color != questData.objectives[i].color)
                  {
                     sysApi.dispatchHook(HookList.RemoveMapFlag,questData.objectives[i].flagData.id,questData.objectives[i].flagData.worldMapId);
                     addFlag = true;
                  }
                  if(addFlag)
                  {
                     sysApi.dispatchHook(HookList.AddMapFlag,questData.objectives[i].flagData.id,questData.objectives[i].flagData.text,questData.objectives[i].flagData.worldMapId,questData.objectives[i].flagData.x,questData.objectives[i].flagData.y,questData.objectives[i].color);
                  }
               }
            }
            if(!maxObjectivesReached && (followAll && !questData.objectives[i].visible || singleObjectiveAdded))
            {
               maxObjectivesReached = true;
            }
            else if(maxObjectivesReached)
            {
               continue;
            }
            singleObjectiveAdded = !followAll && questData.objectives[i].id == followedObjectiveId;
         }
         if(displayShowOption)
         {
            this._questsObjectivesOrder[questData.id + "_" + MAX_OBJECTIVES].visible = false;
            if(this._quests[maxIndex])
            {
               this._quests.splice(maxIndex,!!this._quests[maxIndex].isQuest ? 0 : 1,this._questsObjectivesOrder[questData.id + "_" + MAX_OBJECTIVES]);
            }
            else
            {
               this._quests.splice(maxIndex,0,this._questsObjectivesOrder[questData.id + "_" + MAX_OBJECTIVES]);
            }
         }
         if(followAll && followedObjectives == 0)
         {
            for(x = 0; x < MAX_OBJECTIVES; )
            {
               if(questData.objectives[x] && questData.objectives[x].flagData)
               {
                  questData.objectives[x].follow = true;
                  questDataObj = questData.objectives[x];
                  this._flagsQuestData[questDataObj.flagData.id] = questDataObj;
                  flag = this.getFlag(questDataObj.flagData.id,questDataObj.flagData.worldMapId);
                  flagExists = flag != null;
                  addFlag = false;
                  if(!flagExists)
                  {
                     addFlag = true;
                  }
                  else if(flag.color != questDataObj.color)
                  {
                     sysApi.dispatchHook(HookList.RemoveMapFlag,questDataObj.flagData.id,questDataObj.flagData.worldMapId);
                     addFlag = true;
                  }
                  if(addFlag)
                  {
                     sysApi.dispatchHook(HookList.AddMapFlag,questDataObj.flagData.id,questDataObj.flagData.text,questDataObj.flagData.worldMapId,questDataObj.flagData.x,questDataObj.flagData.y,questDataObj.color);
                  }
               }
               x++;
            }
         }
         if(!questParams.hasOwnProperty("fromServer"))
         {
            sysApi.sendAction(new FollowQuestAction([questParams.questId,!!followAll ? -1 : questParams.objectives[0].id,true]));
         }
      }
      
      public function unfollowQuest(questId:uint) : void
      {
         this.removeQuest(questId);
         if(!this._quests.length)
         {
            if(sysApi.getData(QUEST_LIST_MINIMIZED_DATA_ID,DataStoreEnum.BIND_ACCOUNT))
            {
               uiApi.unloadUi("questListMinimized");
            }
            uiApi.unloadUi(uiApi.me().name);
         }
         else
         {
            this.update();
         }
      }
      
      public function renderUpdate() : void
      {
         var i:int = 0;
         var dataLen:uint = 0;
         this.tx_title.width = this.ctr_list.width;
         this.tx_title.x = this.ctr_list.x - 1;
         this.lbl_title.x = this.tx_title.x;
         this.lbl_title.y = 3;
         this.lbl_title.width = this.tx_title.width - 15;
         this.btn_options.x = this.tx_title.x + this.tx_title.width - this.btn_options.width - 22;
         this.btn_options.y = 0;
         this.btn_minimize.x = this.tx_title.x + this.tx_title.width - this.btn_minimize.width - 5;
         this.btn_minimize.y = 4;
         if(this._quests && !this._updating)
         {
            dataLen = this._quests.length;
            this._listRendered = false;
            for(this._offsetY = 0; i < dataLen; )
            {
               if(this._components[this._quests[i]])
               {
                  this.updateLine(this._quests[i],this._components[this._quests[i]],false,0);
               }
               i++;
            }
            this.updateListSize();
            this._listRendered = true;
         }
         this.restrictPosition();
      }
      
      public function restrictPosition() : void
      {
         var visibleBounds:Rectangle = uiApi.getVisibleStageBounds();
         var x:Number = this.ctr_main.x + this.ctr_list.x;
         if(x + this.ctr_list.width > visibleBounds.right)
         {
            this.ctr_main.x = visibleBounds.right - (this.ctr_list.x + this.ctr_list.width);
         }
         if(x < visibleBounds.left)
         {
            this.ctr_main.x = visibleBounds.left - this.ctr_list.x;
         }
         if(this.ctr_main.y < visibleBounds.top)
         {
            this.ctr_main.y = 0;
         }
         if(this.ctr_main.y + this.ctr_list.height > visibleBounds.bottom)
         {
            this.ctr_main.y = visibleBounds.bottom - Math.min(this.ctr_list.height,visibleBounds.bottom);
         }
      }
      
      public function changeObjectivesOrder(objectiveData:Object, confirmFollow:Boolean, selectedQuestID:int = -1, objectiveID:int = -1, newObj:Boolean = false) : void
      {
         var questID:uint = 0;
         var objID:int = 0;
         var objData:Object = null;
         var obj:Object = null;
         var targetObjective:Object = null;
         var nextMaskedObjective:Object = null;
         if(objectiveData != null)
         {
            questID = objectiveData.questId;
            objID = objectiveData.id;
            objData = objectiveData;
         }
         else
         {
            questID = selectedQuestID;
            objID = objectiveID;
         }
         var objectivesNumber:uint = 0;
         var visibleObjectives:uint = 0;
         var followedObjectives:uint = 0;
         for(var i:uint = 0; this._questsObjectivesOrder[questID + "_" + i] != null; )
         {
            obj = this._questsObjectivesOrder[questID + "_" + i];
            if(obj.visible)
            {
               visibleObjectives++;
            }
            if(obj.follow)
            {
               followedObjectives++;
            }
            if(objData == null && obj.id == objID)
            {
               objData = obj;
            }
            objectivesNumber++;
            i++;
         }
         if(objData == null)
         {
            return;
         }
         if(objectiveData == null && !confirmFollow)
         {
            objData.follow = false;
            followedObjectives--;
         }
         var objectiveDictionnaryIndex:uint = this.GetObjectiveOrderDictionaryNoData(questID,objectivesNumber,objID);
         var startIndex:uint = this._quests.indexOf(objData);
         var questIndex:uint = this.GetQuestOrder(questID);
         if(confirmFollow)
         {
            if(followedObjectives > 0)
            {
               this.ReOrderObjectiveDictionary(objectiveDictionnaryIndex,followedObjectives - 1,questID);
            }
            this.SwapObjectiveQuestOrder(startIndex,questIndex,followedObjectives);
         }
         else
         {
            followedObjectives++;
            targetObjective = null;
            this.ReOrderObjectiveDictionary(objectiveDictionnaryIndex,followedObjectives - 1,questID);
            if(visibleObjectives > MAX_OBJECTIVES || followedObjectives > MAX_OBJECTIVES)
            {
               if(visibleObjectives == objectivesNumber)
               {
                  if(followedObjectives > 1)
                  {
                     this.SwapObjectiveQuestOrder(startIndex,questIndex,followedObjectives);
                  }
               }
               else if(visibleObjectives < followedObjectives)
               {
                  targetObjective = this._quests[startIndex];
                  if(targetObjective == null)
                  {
                     return;
                  }
                  nextMaskedObjective = this._questsObjectivesOrder[questID + "_" + (visibleObjectives - 1)];
                  targetObjective.visible = false;
                  this._quests.splice(startIndex,1);
                  this._quests.splice(questIndex + visibleObjectives,0,nextMaskedObjective);
                  nextMaskedObjective.visible = true;
                  this._questsObjectivesOrder[questID + "_" + visibleObjectives].visible = false;
                  this._quests.splice(questIndex + visibleObjectives + 1,!!this._quests[questIndex + visibleObjectives].isQuest ? 0 : 1,this._questsObjectivesOrder[questID + "_" + visibleObjectives]);
               }
               else
               {
                  targetObjective = this._quests[startIndex];
                  targetObjective.visible = false;
                  this._quests.splice(startIndex,1);
                  this._quests.splice(questIndex + visibleObjectives,!!this._quests[questIndex + visibleObjectives].isQuest ? 0 : 1,targetObjective);
               }
            }
            else if(followedObjectives > 1)
            {
               this.SwapObjectiveQuestOrder(startIndex,questIndex,followedObjectives);
            }
         }
         this.update();
      }
      
      private function getFlag(flagId:String, worldMapId:int) : Object
      {
         var flag:Object = null;
         var flagList:* = this.modCartography.getFlags(worldMapId);
         for each(flag in flagList)
         {
            if(flag.id == flagId)
            {
               return flag;
            }
         }
         return null;
      }
      
      private function GetQuestOrder(questID:uint) : int
      {
         var maxIteration:uint = this._quests.length;
         for(var i:uint = 0; i < maxIteration; )
         {
            if(this._quests[i].isQuest && this._quests[i].id == questID)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function SwapObjectiveQuestOrder(startIndex:uint, questIndex:uint, questIndexOffset:uint = 0) : void
      {
         var stockedObjective:Object = this._quests[startIndex];
         this._quests.splice(startIndex,1);
         this._quests.splice(questIndex + questIndexOffset,0,stockedObjective);
      }
      
      private function GetObjectiveDictionaryOrder(questData:Object, Objective:Object) : int
      {
         for(var i:uint = 0; i < questData.objectives.length; )
         {
            if(this._questsObjectivesOrder[questData.id + "_" + i] == Objective)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function GetObjectiveOrderDictionaryNoData(questID:uint, questObjectiveNumber:uint, ObjectiveId:uint) : int
      {
         for(var i:uint = 0; i < questObjectiveNumber; i++)
         {
            if(this._questsObjectivesOrder[questID + "_" + i].id == ObjectiveId)
            {
               return i;
            }
         }
         return -1;
      }
      
      private function ReOrderObjectiveDictionary(formerIndex:uint, newIndex:uint, questID:uint) : void
      {
         var movedObjective:Object = this._questsObjectivesOrder[questID + "_" + formerIndex];
         var i:uint = formerIndex;
         if(formerIndex > newIndex)
         {
            while(i > newIndex)
            {
               this._questsObjectivesOrder[questID + "_" + i] = this._questsObjectivesOrder[questID + "_" + (i - 1)];
               i--;
            }
         }
         else if(formerIndex < newIndex)
         {
            while(i < newIndex)
            {
               this._questsObjectivesOrder[questID + "_" + i] = this._questsObjectivesOrder[questID + "_" + (i + 1)];
               i++;
            }
         }
         this._questsObjectivesOrder[questID + "_" + newIndex] = movedObjective;
      }
      
      private function updateListSize() : void
      {
         var useScrollBar:Boolean = false;
         var height:Number = NaN;
         this.gridScrollContainer.width = this.ctr_list.width - 11;
         if(this._resizeMode == AUTO_RESIZE_MODE)
         {
            height = this._quests.length * this.gd_quests.slotHeight + this._offsetY;
            if(this.gridScrollContainer.y + height + BOTTOM_MARGIN > uiApi.getVisibleStageBounds().height)
            {
               height = uiApi.getVisibleStageBounds().height - this.gridScrollContainer.y - BOTTOM_MARGIN;
               useScrollBar = true;
            }
            this.gridScrollContainer.useVerticalScroll = useScrollBar;
            this.gridScrollContainer.height = height;
            this.gridScrollContainer.finalize();
            this.ctr_list.height = this.gridScrollContainer.y + height + BOTTOM_MARGIN;
         }
         else if(this._resizeMode == FREE_RESIZE_MODE)
         {
            this.gridScrollContainer.height = this.ctr_list.height - this.gridScrollContainer.y - BOTTOM_MARGIN;
            this.gridScrollContainer.useVerticalScroll = true;
            this.gridScrollContainer.finalize();
         }
         if(this.gridScrollContainer.useVerticalScroll && this.gridScrollContainer.hasVerticalScrollBar)
         {
            this.gridScrollContainer.verticalScrollbarValue = this.gridScrollContainer.lastVerticalScrollValue;
         }
      }
      
      private function removeLastQuests(numQuestsToDelete:uint) : void
      {
         var numDeletedQuests:uint = 0;
         var i:int = this._quests.length - 1;
         while(numDeletedQuests < numQuestsToDelete)
         {
            if(this._quests[i].isQuest)
            {
               this.removeQuest(this._quests[i].id);
               numDeletedQuests++;
               i = this._quests.length - 1;
            }
            else
            {
               i--;
            }
         }
      }
      
      private function removeQuest(questId:uint, removeColorAndFlags:Boolean = true) : Array
      {
         var i:int = 0;
         var endIndex:int = 0;
         var questData:Object = null;
         var questExists:Boolean = false;
         var k:int = 0;
         var objRef:Object = null;
         var deletedQuest:Array = null;
         var deletedQuestLen:uint = 0;
         var j:int = 0;
         var dataLen:uint = this._quests.length;
         var numColors:uint = this._colors.length;
         var startIndex:int = -1;
         for each(questData in this._quests)
         {
            if(questData.isQuest && questData.id == questId)
            {
               questExists = true;
               break;
            }
         }
         if(!questExists)
         {
            return null;
         }
         if(removeColorAndFlags)
         {
            for(k = 0; this._questsObjectivesOrder[questId + "_" + k] != null; k++)
            {
               objRef = this._questsObjectivesOrder[questId + "_" + k];
               if(objRef.flagData)
               {
                  delete this._flagsQuestData[objRef.flagData.id];
                  sysApi.dispatchHook(HookList.RemoveMapFlag,objRef.flagData.id,objRef.flagData.worldMapId);
                  sysApi.setData(playerApi.getPlayedCharacterInfo().id + "-questFlag-" + objRef.flagData.id,null);
               }
               delete this._questsObjectivesOrder[questId + "_" + k];
            }
         }
         while(i < dataLen)
         {
            if(this._quests[i].isQuest && this._quests[i].id == questId)
            {
               startIndex = i;
            }
            if(startIndex != -1 && (this._quests[i].isQuest && i != startIndex || i == dataLen - 1))
            {
               endIndex = this._quests[i].isQuest && i < dataLen - 1 ? int(i) : int(i + 1);
               deletedQuest = this._quests.slice(startIndex,endIndex);
               deletedQuestLen = deletedQuest.length;
               this._quests.splice(startIndex,deletedQuestLen);
               if(removeColorAndFlags)
               {
                  delete this._components[deletedQuest[0]];
                  for(j = 0; j < numColors; j++)
                  {
                     if(this._colors[j] == deletedQuest[0].color)
                     {
                        this._colors[j] = false;
                        break;
                     }
                  }
                  --this._numQuests;
                  sysApi.sendAction(new FollowQuestAction([questId,-1,false]));
               }
               return deletedQuest;
            }
            i++;
         }
         return null;
      }
      
      private function removeObjective(objectiveData:Object, askInfos:Boolean = false) : void
      {
         var i:int = 0;
         var j:int = 0;
         var questData:Object = null;
         var objIndex:int = 0;
         var objStartIndex:int = 0;
         var numObjectives:uint = 0;
         var lastVisibleObjective:Object = null;
         var hiddenObjective:Object = null;
         var endIndex:int = 0;
         var objRef:Object = null;
         var dataLen:uint = this._quests.length;
         var deletedObjectiveIndex:int = -1;
         for(i = 0; i < dataLen; i++)
         {
            if(this._quests[i].isQuest && this._quests[i].id == objectiveData.questId)
            {
               questData = this._quests[i];
            }
            else if(this._quests[i].id == objectiveData.id)
            {
               deletedObjectiveIndex = i;
               break;
            }
         }
         objIndex = this.GetObjectiveDictionaryOrder(questData,objectiveData);
         this.ReOrderObjectiveDictionary(objIndex,questData.objectives.length - 1,questData.id);
         delete this._questsObjectivesOrder[questData.id + "_" + (questData.objectives.length - 1)];
         questData.objectives.splice(questData.objectives.indexOf(objectiveData),1);
         if(deletedObjectiveIndex != -1)
         {
            this._quests.splice(deletedObjectiveIndex,1);
         }
         delete this._components[objectiveData];
         if(objectiveData.flagData)
         {
            delete this._flagsQuestData[objectiveData.flagData.id];
            if(objectiveData.follow)
            {
               sysApi.dispatchHook(HookList.RemoveMapFlag,objectiveData.flagData.id,objectiveData.flagData.worldMapId);
            }
            sysApi.setData(playerApi.getPlayedCharacterInfo().id + "-questFlag-" + objectiveData.flagData.id,null);
         }
         if(questData.objectives.length)
         {
            sysApi.sendAction(new FollowQuestAction([questData.id,objectiveData.id,false]));
            objStartIndex = this._quests.indexOf(questData) + 1;
            this.clearQuestDisplay(questData,objStartIndex);
            numObjectives = questData.objectives.length;
            for(j = 0; j < numObjectives; j++)
            {
               objRef = this._questsObjectivesOrder[questData.id + "_" + j];
               if(j < MAX_OBJECTIVES)
               {
                  this._questsObjectivesOrder[questData.id + "_" + j].visible = true;
                  lastVisibleObjective = this._questsObjectivesOrder[questData.id + "_" + j];
                  this._quests.splice(objStartIndex + j,0,this._questsObjectivesOrder[questData.id + "_" + j]);
               }
               else if(!objRef.visible && !hiddenObjective)
               {
                  hiddenObjective = objRef;
               }
            }
            endIndex = this._quests.indexOf(lastVisibleObjective) + 1;
            if(hiddenObjective)
            {
               this._quests.splice(endIndex,0,hiddenObjective);
            }
         }
         if(askInfos)
         {
            sysApi.sendAction(new QuestInfosRequestAction([questData.id]));
         }
         else if(!questData.objectives.length)
         {
            this.unfollowQuest(questData.id);
         }
      }
      
      private function clearQuestDisplay(questData:Object, objStartIndex:int, clearSavedData:Boolean = false) : void
      {
         var k:int = 0;
         var j:int = 0;
         var objRef:Object = null;
         var numObj:int = questData.objectives.length;
         for(k = 0; k < numObj + 1; k++)
         {
            if(!this._quests[objStartIndex])
            {
               break;
            }
            if(this._quests[objStartIndex].seeLess)
            {
               this._quests.splice(objStartIndex,1);
            }
            else
            {
               if(!(!this._quests[objStartIndex].isQuest && this._quests[objStartIndex].questId == questData.id))
               {
                  break;
               }
               this._quests[objStartIndex].visible = false;
               this._quests.splice(objStartIndex,1);
            }
         }
         if(clearSavedData)
         {
            for(j = 0; j < numObj; j++)
            {
               objRef = this._questsObjectivesOrder[questData.id + "_" + j];
               if(objRef.flagData)
               {
                  sysApi.dispatchHook(HookList.RemoveMapFlag,objRef.flagData.id,objRef.flagData.worldMapId);
                  sysApi.setData(playerApi.getPlayedCharacterInfo().id + "-questFlag-" + objRef.flagData.id,null);
               }
               this._questsObjectivesOrder[questData.id + "_" + j].follow = false;
               this._questsObjectivesOrder[questData.id + "_" + j].visible = false;
            }
         }
      }
      
      private function addObjective(questData:Object, objAdded:Object, numObjectivesData:int, objectiveDictionnaryIndex:int) : void
      {
         var targetObjective:Object = null;
         var overrideLastIndex:* = false;
         var finalIndex:int = 0;
         objAdded.visible = true;
         objAdded.follow = true;
         var obj:Object = null;
         var objectivesStartIndex:int = this._quests.indexOf(questData) + 1;
         var newIndex:int = 0;
         var nextObjectiveIndex:int = -1;
         var nextObjectiveFound:Boolean = false;
         var followedObjectives:int = 0;
         var visibleObjectives:int = 0;
         for(var k:int = 0; k < numObjectivesData; k++)
         {
            if(this._questsObjectivesOrder[questData.id + "_" + k])
            {
               obj = this._questsObjectivesOrder[questData.id + "_" + k];
               if(obj.follow)
               {
                  followedObjectives++;
               }
               if(obj.visible)
               {
                  visibleObjectives++;
               }
               else if(!nextObjectiveFound)
               {
                  nextObjectiveIndex = k;
                  nextObjectiveFound = true;
               }
            }
         }
         var optionalLabelIndex:int = objectivesStartIndex + visibleObjectives - 1;
         var objectiveMasked:int = 0;
         newIndex = objectivesStartIndex + followedObjectives - 1;
         if(this._questsObjectivesOrder[questData.id + "_" + nextObjectiveIndex])
         {
            targetObjective = this._questsObjectivesOrder[questData.id + "_" + nextObjectiveIndex];
         }
         if(this._quests[optionalLabelIndex] != null)
         {
            overrideLastIndex = !this._quests[optionalLabelIndex].isQuest;
         }
         else
         {
            overrideLastIndex = false;
         }
         if(followedObjectives < visibleObjectives)
         {
            if(followedObjectives > 0)
            {
               this.ReOrderObjectiveDictionary(objectiveDictionnaryIndex,followedObjectives - 1,questData.id);
            }
            if(visibleObjectives > MAX_OBJECTIVES)
            {
               targetObjective = this._questsObjectivesOrder[questData.id + "_" + (visibleObjectives - 1)];
               targetObjective.visible = false;
               nextObjectiveFound = true;
               objectiveMasked = 1;
               this._quests.splice(optionalLabelIndex - objectiveMasked,!this._quests[optionalLabelIndex - objectiveMasked].isQuest ? 1 : 0);
               this._quests.splice(newIndex,0,objAdded);
            }
            else
            {
               this._quests.splice(newIndex,0,objAdded);
            }
         }
         else if(followedObjectives == visibleObjectives)
         {
            if(followedObjectives > 0)
            {
               this.ReOrderObjectiveDictionary(objectiveDictionnaryIndex,followedObjectives - 1,questData.id);
            }
            if(visibleObjectives > MAX_OBJECTIVES)
            {
               this._quests.splice(optionalLabelIndex,!!overrideLastIndex ? 1 : 0,objAdded);
            }
            else
            {
               this._quests.splice(newIndex,0,objAdded);
            }
         }
         else
         {
            this._quests.splice(optionalLabelIndex,!!overrideLastIndex ? 1 : 0,objAdded);
            this.ReOrderObjectiveDictionary(objectiveDictionnaryIndex,visibleObjectives - 1,questData.id);
         }
         if(visibleObjectives + 1 - objectiveMasked > MAX_OBJECTIVES)
         {
            if(nextObjectiveFound)
            {
               finalIndex = optionalLabelIndex + 1 - objectiveMasked;
               if(targetObjective != null)
               {
                  if(this._quests[finalIndex])
                  {
                     this._quests.splice(finalIndex,!this._quests[finalIndex].isQuest ? 1 : 0,targetObjective);
                  }
                  else
                  {
                     this._quests.splice(finalIndex,0,targetObjective);
                  }
               }
            }
            else if(questData.objectives.length != MAX_OBJECTIVES)
            {
               this._quests.splice(optionalLabelIndex + 1,0,{
                  "isQuest":false,
                  "seeLess":true,
                  "questId":questData.id
               });
            }
         }
         this.renderUpdate();
         this.toggleObjectivesFlag(objAdded,false,questData.color);
      }
      
      private function getUnusedColor() : int
      {
         var i:int = 0;
         var color:uint = 0;
         var numColors:uint = this._colors.length;
         for(i = 0; i < numColors; i++)
         {
            if(this._colors[i] == false)
            {
               color = parseInt(sysApi.getConfigEntry("colors.flag.quest" + (i + 1)));
               this._colors[i] = color;
               return color;
            }
         }
         return -1;
      }
      
      private function setFlagColor(target:Object, color:uint, remove:Boolean = false) : void
      {
         var R:* = 0;
         var G:* = 0;
         var B:* = 0;
         if(!remove)
         {
            R = color >> 16 & 255;
            G = color >> 8 & 255;
            B = color >> 0 & 255;
            target.transform.colorTransform = new ColorTransform(0.6,0.6,0.6,1,R - 80,G - 80,B - 80);
         }
         else
         {
            target.transform.colorTransform = this._defaultColorTransform;
         }
      }
      
      private function getDataFromTarget(target:Object) : Object
      {
         var i:int = (this.gd_quests.renderer as MultiGridRenderer).getItemIndex(target);
         if(i != -1 && i <= this._quests.length - 1)
         {
            return this._quests[i];
         }
         return null;
      }
      
      private function moveQuestToTheTop(questId:uint) : void
      {
         var i:int = 0;
         var deletedQuest:Array = this.removeQuest(questId,false);
         for(i = deletedQuest.length - 1; i >= 0; i--)
         {
            this._quests.unshift(deletedQuest[i]);
         }
         this.update();
         var questsIds:Vector.<uint> = new Vector.<uint>();
         var dataLen:uint = this._quests.length;
         for(i = 0; i < dataLen; i++)
         {
            if(this._quests[i].isQuest)
            {
               questsIds.push(this._quests[i].id);
            }
         }
         sysApi.sendAction(new RefreshFollowedQuestsOrderAction([questsIds]));
      }
      
      private function removeAllFlags() : void
      {
         var i:int = 0;
         var j:int = 0;
         var numObjectives:uint = 0;
         var dataLen:uint = this._quests.length;
         for(i = 0; i < dataLen; i++)
         {
            if(this._quests[i].isQuest)
            {
               numObjectives = this._quests[i].objectives.length;
               for(j = 0; j < numObjectives; j++)
               {
                  if(this._quests[i].objectives[j].flagData)
                  {
                     sysApi.dispatchHook(HookList.RemoveMapFlag,this._quests[i].objectives[j].flagData.id,this._quests[i].objectives[j].flagData.worldMapId);
                  }
               }
            }
         }
      }
      
      private function changeMaxDisplayedQuests(max:uint) : void
      {
         if(this._numQuests > max)
         {
            this.removeLastQuests(this._numQuests - max);
            this.update();
         }
         this._maxQuests = max;
         sysApi.setData(MAX_FOLLOWED_QUESTS_DATA_ID,this._maxQuests,DataStoreEnum.BIND_ACCOUNT);
      }
      
      private function changeResizeMode() : void
      {
         this._resizeMode = this._resizeMode == FREE_RESIZE_MODE ? uint(AUTO_RESIZE_MODE) : uint(FREE_RESIZE_MODE);
         this.ctr_list.getResizeController().bottomResize = this._resizeMode == FREE_RESIZE_MODE;
         sysApi.setData(FOLLOWED_QUESTS_RESIZE_MODE_DATA_ID,this._resizeMode,DataStoreEnum.BIND_ACCOUNT);
         this.updateListSize();
      }
      
      private function changeOpacity(opacity:Number) : void
      {
         this.ctr_list.bgAlpha = opacity;
         this._opacity = opacity;
         sysApi.setData(OPACITY_DATA_ID,this._opacity,DataStoreEnum.BIND_ACCOUNT);
      }
      
      private function changeFontSize(fontSize:uint) : void
      {
         this._fontSize = fontSize;
         sysApi.setData(FONT_SIZE_DATA_ID,this._fontSize,DataStoreEnum.BIND_ACCOUNT);
         this.update();
      }
      
      private function minimize() : void
      {
         if(!sysApi.getData(QUEST_LIST_MINIMIZED_DATA_ID,DataStoreEnum.BIND_ACCOUNT))
         {
            uiApi.me().visible = false;
            uiApi.me().isMagnetic = false;
            this.ctr_list.isMagnetic = false;
            sysApi.setData(QUEST_LIST_MINIMIZED_DATA_ID,true,DataStoreEnum.BIND_ACCOUNT);
         }
      }
      
      public function maximize() : void
      {
         if(sysApi.getData(QUEST_LIST_MINIMIZED_DATA_ID,DataStoreEnum.BIND_ACCOUNT))
         {
            uiApi.me().visible = true;
            uiApi.me().isMagnetic = true;
            this.ctr_list.isMagnetic = true;
            sysApi.setData(QUEST_LIST_MINIMIZED_DATA_ID,false,DataStoreEnum.BIND_ACCOUNT);
         }
      }
      
      private function hasFlags() : Boolean
      {
         var i:int = 0;
         var dataLen:uint = this._quests.length;
         for(i = 0; i < dataLen; i++)
         {
            if(!this._quests[i].isQuest && this._quests[i].flagData && this._quests[i].follow)
            {
               return true;
            }
         }
         return false;
      }
      
      private function getQuestActiveObjectivesData(questId:uint) : Array
      {
         var questObjectives:Array = null;
         var i:int = 0;
         var objective:QuestObjective = null;
         var objectiveFlagInfos:Object = null;
         var questInfos:Object = this.questApi.getQuestInformations(questId);
         if(!questInfos)
         {
            return null;
         }
         var step:QuestStep = this.dataApi.getQuestStep(questInfos.stepId);
         if(step && step.objectives.length)
         {
            questObjectives = new Array();
            for(i = 0; i < step.objectives.length; i++)
            {
               objective = this.dataApi.getQuestObjective(step.objectives[i].id);
               if(questInfos.objectives[objective.id])
               {
                  objectiveFlagInfos = objective.coords || objective.mapId ? this.questApi.getQuestObjectiveFlagInfos(questId,objective.id) : null;
                  questObjectives.push({
                     "id":objective.id,
                     "flagData":(!!objectiveFlagInfos ? {
                        "id":objectiveFlagInfos.id,
                        "text":objectiveFlagInfos.text,
                        "worldMapId":objectiveFlagInfos.worldMapId,
                        "x":objectiveFlagInfos.x,
                        "y":objectiveFlagInfos.y
                     } : null),
                     "isQuest":false,
                     "questId":questId
                  });
               }
            }
         }
         return questObjectives;
      }
      
      override protected function setVisible(value:Boolean) : void
      {
         var isInTutorial:Boolean = false;
         var hasQuest:Boolean = false;
         if(!sysApi.getData(QUEST_LIST_MINIMIZED_DATA_ID,DataStoreEnum.BIND_ACCOUNT))
         {
            isInTutorial = playerApi.isInTutorialArea();
            hasQuest = this._quests && this._quests.length > 0;
            super.setVisible(value && !isInTutorial && hasQuest);
            this.ctr_list.isMagnetic = value && !isInTutorial;
         }
      }
      
      private function toggleObjectivesFlag(objectiveData:Object, changeOrder:Boolean = true, color:int = -1, forceFollow:Boolean = false, forceFollowValue:Boolean = false) : void
      {
         var confirmFollow:Boolean = false;
         var followed:Boolean = false;
         if(objectiveData.flagData)
         {
            followed = objectiveData.follow;
            objectiveData.color = color != -1 ? color : objectiveData.color;
            objectiveData.questId;
            sysApi.dispatchHook(HookList.AddMapFlag,objectiveData.flagData.id,objectiveData.flagData.text,objectiveData.flagData.worldMapId,objectiveData.flagData.x,objectiveData.flagData.y,objectiveData.color,true);
            if(forceFollow)
            {
               if(forceFollowValue)
               {
                  if(objectiveData.follow && this._components[objectiveData])
                  {
                     this.setFlagColor(this._components[objectiveData].btn_loc,objectiveData.color);
                  }
                  sysApi.setData(playerApi.getPlayedCharacterInfo().id + "-questFlag-" + objectiveData.flagData.id,objectiveData.follow);
                  objectiveData.follow = true;
                  confirmFollow = true;
               }
               else
               {
                  sysApi.dispatchHook(HookList.RemoveMapFlag,objectiveData.flagData.id,objectiveData.flagData.worldMapId);
                  objectiveData.follow = false;
                  confirmFollow = false;
               }
            }
            else if(objectiveData.follow == followed)
            {
               if(objectiveData.follow && this._components[objectiveData])
               {
                  this.setFlagColor(this._components[objectiveData].btn_loc,objectiveData.color);
               }
               sysApi.setData(playerApi.getPlayedCharacterInfo().id + "-questFlag-" + objectiveData.flagData.id,objectiveData.follow);
               objectiveData.follow = true;
               confirmFollow = true;
            }
            else
            {
               sysApi.dispatchHook(HookList.RemoveMapFlag,objectiveData.flagData.id,objectiveData.flagData.worldMapId);
               objectiveData.follow = false;
               confirmFollow = false;
            }
            if(changeOrder)
            {
               this.changeObjectivesOrder(objectiveData,confirmFollow);
            }
         }
      }
      
      private function questHasFlags(questData:Object) : Boolean
      {
         var i:int = 0;
         var objectiveData:Object = null;
         var numObjectives:uint = questData.objectives.length;
         for(i = 0; i < numObjectives; i++)
         {
            objectiveData = questData.objectives[i];
            if(objectiveData.flagData)
            {
               return true;
            }
         }
         return false;
      }
      
      private function showQuestFlags(questData:Object, show:Boolean) : void
      {
         var i:int = 0;
         var objKey:String = null;
         var objectiveData:Object = null;
         var numObjectives:uint = questData.objectives.length;
         if(show)
         {
            this.clearQuestDisplay(questData,this._quests.indexOf(questData) + 1,true);
         }
         for(i = 0; i < numObjectives; i++)
         {
            objKey = questData.id + "_" + (!!show ? i : numObjectives - 1 - i);
            objectiveData = this._questsObjectivesOrder[objKey];
            if(objectiveData.flagData)
            {
               if(show)
               {
                  this.addObjective(questData,objectiveData,numObjectives,this.GetObjectiveDictionaryOrder(questData,objectiveData));
               }
               else if(objectiveData.follow)
               {
                  sysApi.dispatchHook(HookList.RemoveMapFlag,objectiveData.flagData.id,objectiveData.flagData.worldMapId);
                  this.toggleObjectivesFlag(objectiveData,true,-1,true,false);
               }
            }
         }
         this.update();
      }
      
      public function onWheel(target:Object, delta:int) : void
      {
         if(this.gridScrollContainer.useVerticalScroll && this.gridScrollContainer.hasVerticalScrollBar)
         {
            this._mouseScrollEvent.delta = delta;
            this.gridScrollContainer.verticalScrollBar.onWheel(this._mouseScrollEvent);
         }
      }
      
      public function onQuestValidated(questId:uint) : void
      {
         var followedQuests:Object = this.questApi.getFollowedQuests();
         if(followedQuests.indexOf(questId) != -1)
         {
            this.unfollowQuest(questId);
         }
      }
      
      public function onQuestObjectiveValidated(questId:uint, objectiveId:uint) : void
      {
         var i:int = 0;
         var dataLen:uint = 0;
         var objectiveData:Object = null;
         var followedQuests:Object = this.questApi.getFollowedQuests();
         if(followedQuests.indexOf(questId) != -1)
         {
            dataLen = this._quests.length;
            for(i = 0; i < dataLen; i++)
            {
               if(this._quests[i].isQuest && this._quests[i].id == questId)
               {
                  for each(objectiveData in this._quests[i].objectives)
                  {
                     if(objectiveData.id == objectiveId)
                     {
                        this.removeObjective(objectiveData,true);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      public function onQuestStepValidated(questId:uint, stepId:uint) : void
      {
         var i:int = 0;
         var dataLen:uint = 0;
         var followedQuests:Object = this.questApi.getFollowedQuests();
         if(followedQuests.indexOf(questId) != -1)
         {
            dataLen = this._quests.length;
            for(i = 0; i < dataLen; i++)
            {
               if(this._quests[i].isQuest && this._quests[i].id == questId)
               {
                  while(this._quests[i].objectives.length)
                  {
                     this.removeObjective(this._quests[i].objectives[0],true);
                  }
                  return;
               }
            }
         }
      }
      
      public function onQuestStarted(questId:uint) : void
      {
         var followedQuests:Object = null;
         var requestInfos:Boolean = false;
         var followQuest:Boolean = this.configApi.getConfigProperty("dofus","followQuestOnStarted");
         if(followQuest)
         {
            followedQuests = this.questApi.getFollowedQuests();
            if(followedQuests.indexOf(questId) != -1)
            {
               requestInfos = true;
            }
            else if(this._numQuests + this._startedQuests.length + 1 <= this._maxQuests)
            {
               this._startedQuests.push(questId);
               requestInfos = true;
            }
            if(requestInfos)
            {
               sysApi.sendAction(new QuestInfosRequestAction([questId]));
            }
         }
      }
      
      public function onQuestInfosUpdated(questId:uint, infosAvailable:Boolean) : void
      {
         var questObjectives:Array = null;
         var questData:Object = null;
         var numNewObjectives:int = 0;
         var numCurrentObjectives:int = 0;
         var objChangeNumber:int = 0;
         var followedObjectives:int = 0;
         var visibleObjectives:int = 0;
         var objectivesStartIndex:int = 0;
         var objDisplay:int = 0;
         var k:int = 0;
         var i:int = 0;
         var obj:Object = null;
         var objStillValid:Boolean = false;
         var j:int = 0;
         if(this.questApi.getFollowedQuests().indexOf(questId) != -1)
         {
            for each(questData in this._quests)
            {
               if(questData.isQuest && questData.id == questId)
               {
                  questObjectives = this.getQuestActiveObjectivesData(questId);
                  if(infosAvailable && questObjectives && questObjectives.length)
                  {
                     numNewObjectives = questObjectives.length;
                     numCurrentObjectives = questData.objectives.length;
                     objChangeNumber = 0;
                     followedObjectives = 0;
                     visibleObjectives = 0;
                     objectivesStartIndex = this._quests.indexOf(questData) + 1;
                     k = 0;
                     while(true)
                     {
                        if(k < numCurrentObjectives)
                        {
                           if(this._questsObjectivesOrder[questData.id + "_" + k])
                           {
                              obj = this._questsObjectivesOrder[questData.id + "_" + k];
                              objStillValid = false;
                              for(j = 0; j < numCurrentObjectives; j++)
                              {
                                 if(obj.id == questObjectives[j].id)
                                 {
                                    objStillValid = true;
                                    break;
                                 }
                              }
                              if(!objStillValid)
                              {
                                 break;
                              }
                              if(obj.follow)
                              {
                                 followedObjectives++;
                              }
                              if(obj.visible)
                              {
                                 visibleObjectives++;
                              }
                           }
                           continue;
                        }
                        for(i = 0; i < numNewObjectives; i++)
                        {
                           if(!questData.objectives[i] || questObjectives[i].id != questData.objectives[i].id)
                           {
                              questObjectives[i].follow = false;
                              questObjectives[i].visible = false;
                              questObjectives[i].color = questData.color;
                              questData.objectives.splice(i,0,questObjectives[i]);
                              this._questsObjectivesOrder[questData.id + "_" + (numCurrentObjectives + objChangeNumber)] = questObjectives[i];
                              objDisplay = followedObjectives + objChangeNumber;
                              if(objDisplay < MAX_OBJECTIVES)
                              {
                                 if(questObjectives[i].flagData)
                                 {
                                    questObjectives[i].follow = true;
                                    sysApi.sendAction(new FollowQuestAction([questId,questObjectives[i].id,true]));
                                 }
                                 questObjectives[i].visible = true;
                                 this.addObjective(questData,questObjectives[i],numNewObjectives,this.GetObjectiveDictionaryOrder(questData,questData.objectives[i]));
                              }
                              else if(objDisplay == MAX_OBJECTIVES)
                              {
                                 if(!this._quests[objectivesStartIndex + objDisplay] || this._quests[objectivesStartIndex + objDisplay].isQuest)
                                 {
                                    this._quests.splice(objectivesStartIndex + objDisplay,0,questObjectives[i]);
                                 }
                                 else if(this._quests[objectivesStartIndex + objDisplay].seeLess)
                                 {
                                    this._quests.splice(objectivesStartIndex + objDisplay,1,questObjectives[i]);
                                 }
                              }
                              objChangeNumber++;
                           }
                        }
                        this.update();
                     }
                     this.removeObjective(obj,true);
                     return;
                  }
                  this.unfollowQuest(questId);
                  break;
               }
            }
         }
         else if(this._startedQuests.length && this._startedQuests.indexOf(questId) != -1)
         {
            if(infosAvailable && this._numQuests + 1 <= this._maxQuests)
            {
               questObjectives = this.getQuestActiveObjectivesData(questId);
               if(questObjectives && questObjectives.length)
               {
                  this.addQuest({
                     "questId":questId,
                     "objectives":questObjectives
                  },false);
                  this.update();
                  if(!sysApi.getData(QUEST_LIST_MINIMIZED_DATA_ID,DataStoreEnum.BIND_ACCOUNT))
                  {
                     this.maximize();
                  }
               }
            }
            this._startedQuests.splice(this._startedQuests.indexOf(questId),1);
         }
      }
      
      public function onRelease(target:Object) : void
      {
         var targetData:Object = null;
         var visibleObjectives:uint = 0;
         var questId:int = 0;
         var numObjectives:uint = 0;
         var i:int = 0;
         var param:Object = null;
         var data:Object = null;
         var j:int = 0;
         var startIndex:int = 0;
         var tmpIndex:int = 0;
         var invisibleObjectivesNumber:uint = 0;
         var currentObjective:Object = null;
         var menu:Array = null;
         var followQuestOnStarted:Boolean = false;
         var nResizeMode:uint = 0;
         var fontSizes:Array = null;
         var opacities:Array = null;
         var questListMinimized:* = undefined;
         var k:uint = 0;
         if(target.name.indexOf("btn_quest") == 0 || target.name.indexOf("btn_objective") == 0)
         {
            targetData = this.getDataFromTarget(target);
            if(targetData)
            {
               questId = !!targetData.isQuest ? int(targetData.id) : int(targetData.questId);
               if(targetData.isQuest)
               {
                  param = {
                     "quest":this.dataApi.getQuest(questId),
                     "forceOpen":true
                  };
                  sysApi.dispatchHook(HookList.OpenBook,"questTab",param);
               }
               else if(targetData.hasOwnProperty("seeLess"))
               {
                  for each(data in this._quests)
                  {
                     if(data.isQuest && data.id == questId)
                     {
                        numObjectives = data.objectives.length;
                        visibleObjectives = 0;
                        for(i = 0; i < numObjectives; i++)
                        {
                           if(data.objectives[i].visible)
                           {
                              visibleObjectives++;
                           }
                        }
                        for(i = MAX_OBJECTIVES; i < visibleObjectives; i++)
                        {
                           this._questsObjectivesOrder[data.id + "_" + i].visible = false;
                        }
                        startIndex = this._quests.indexOf(data) + 1 + MAX_OBJECTIVES;
                        this._quests.splice(startIndex,numObjectives - MAX_OBJECTIVES);
                        this._quests[startIndex] = this._questsObjectivesOrder[data.id + "_" + MAX_OBJECTIVES];
                        break;
                     }
                  }
                  this.update();
               }
               else if(!targetData.visible)
               {
                  for each(data in this._quests)
                  {
                     if(data.isQuest && data.id == questId)
                     {
                        invisibleObjectivesNumber = 0;
                        startIndex = this._quests.indexOf(data) + 1;
                        numObjectives = data.objectives.length;
                        visibleObjectives = 0;
                        for(k = 0; k < numObjectives; k++)
                        {
                           if(data.objectives[k].visible)
                           {
                              visibleObjectives++;
                           }
                        }
                        invisibleObjectivesNumber = numObjectives - visibleObjectives;
                        for(j = 0; j < invisibleObjectivesNumber; j++)
                        {
                           tmpIndex = startIndex + visibleObjectives + j;
                           currentObjective = this._questsObjectivesOrder[data.id + "_" + (visibleObjectives + j)];
                           currentObjective.visible = true;
                           currentObjective.follow = currentObjective.flagData && this.getFlag(currentObjective.flagData.id,currentObjective.flagData.worldMapId) != null;
                           this._quests.splice(tmpIndex,0,currentObjective);
                        }
                        this._quests.splice(tmpIndex + 1,1,{
                           "isQuest":false,
                           "seeLess":true,
                           "questId":data.id
                        });
                        break;
                     }
                  }
                  this.update();
               }
            }
         }
         else if(target.name.indexOf("btn_loc") == 0)
         {
            targetData = this.getDataFromTarget(target);
            if(targetData)
            {
               this.toggleObjectivesFlag(targetData,true,-1,true,!targetData.follow);
            }
         }
         else
         {
            switch(target)
            {
               case this.btn_options:
                  menu = new Array();
                  menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.followMaxQuests",3),this.changeMaxDisplayedQuests,[3],false,null,this._maxQuests == 3));
                  menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.followMaxQuests",5),this.changeMaxDisplayedQuests,[5],false,null,this._maxQuests == 5));
                  menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.followMaxQuests",10),this.changeMaxDisplayedQuests,[10],false,null,this._maxQuests == 10));
                  menu.push(this.modContextMenu.createContextMenuSeparatorObject());
                  followQuestOnStarted = this.configApi.getConfigProperty("dofus","followQuestOnStarted");
                  menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.followOnStarted"),this.configApi.setConfigProperty,["dofus","followQuestOnStarted",!followQuestOnStarted],false,null,followQuestOnStarted == true,false));
                  menu.push(this.modContextMenu.createContextMenuSeparatorObject());
                  if(this._resizeMode == AUTO_RESIZE_MODE)
                  {
                     nResizeMode = FREE_RESIZE_MODE;
                  }
                  else if(this._resizeMode == FREE_RESIZE_MODE)
                  {
                     nResizeMode = AUTO_RESIZE_MODE;
                  }
                  menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.followedQuests.autoResize"),this.changeResizeMode,null,false,null,this._resizeMode == AUTO_RESIZE_MODE,false));
                  menu.push(this.modContextMenu.createContextMenuSeparatorObject());
                  menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.removeAllFlags"),this.removeAllFlags,null,!this.hasFlags()));
                  menu.push(this.modContextMenu.createContextMenuSeparatorObject());
                  fontSizes = new Array();
                  fontSizes.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.option.small"),this.changeFontSize,[FONT_SMALL_SIZE],false,null,this._fontSize == FONT_SMALL_SIZE));
                  fontSizes.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.option.medium"),this.changeFontSize,[FONT_MEDIUM_SIZE],false,null,this._fontSize == FONT_MEDIUM_SIZE));
                  menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.option.fontSize"),null,null,false,fontSizes));
                  menu.push(this.modContextMenu.createContextMenuSeparatorObject());
                  opacities = new Array();
                  opacities.push(this.modContextMenu.createContextMenuItemObject("50%",this.changeOpacity,[0.5],false,null,this._opacity == 0.5));
                  opacities.push(this.modContextMenu.createContextMenuItemObject("70%",this.changeOpacity,[0.7],false,null,this._opacity == 0.7));
                  opacities.push(this.modContextMenu.createContextMenuItemObject("90%",this.changeOpacity,[0.9],false,null,this._opacity == 0.9));
                  menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.cartography.opacitymenu"),null,null,false,opacities));
                  this.modContextMenu.createContextMenu(menu);
                  break;
               case this.btn_minimize:
                  this.minimize();
                  questListMinimized = uiApi.getUi(UIEnum.QUEST_LIST_MINIMIZED);
                  if(questListMinimized && questListMinimized.uiClass)
                  {
                     questListMinimized.uiClass.visible = true;
                  }
                  else
                  {
                     uiApi.loadUi(UIEnum.QUEST_LIST_MINIMIZED,UIEnum.QUEST_LIST_MINIMIZED,null,StrataEnum.STRATA_TOP);
                  }
            }
         }
      }
      
      public function onRightClick(target:Object) : void
      {
         var menu:Array = null;
         var objective:QuestObjective = null;
         var targetData:Object = this.getDataFromTarget(target);
         if(targetData && (targetData.isQuest || targetData.visible && !targetData.hasOwnProperty("seeLess")))
         {
            if(target.name.indexOf("btn_quest") == 0)
            {
               menu = new Array();
               menu.push(this.modContextMenu.createContextMenuTitleObject(this.dataApi.getQuest(targetData.id).name));
               menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.unfollow"),this.unfollowQuest,[targetData.id]));
               if(this._quests.indexOf(targetData) > 0)
               {
                  menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.moveToTheTop"),this.moveQuestToTheTop,[targetData.id]));
               }
               if(this.questHasFlags(targetData))
               {
                  menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.showQuestObjectivesFlags"),this.showQuestFlags,[targetData,true]));
                  menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.hideQuestObjectivesFlags"),this.showQuestFlags,[targetData,false]));
               }
               this.modContextMenu.createContextMenu(menu);
            }
            else if(target.name.indexOf("btn_objective") == 0)
            {
               objective = this.dataApi.getQuestObjective(targetData.id);
               menu = new Array();
               if(targetData.flagData)
               {
                  if(targetData.follow)
                  {
                     menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.removeFlag"),this.toggleObjectivesFlag,[targetData,true,-1,true,false]));
                  }
                  else
                  {
                     menu.push(this.modContextMenu.createContextMenuItemObject(uiApi.getText("ui.quest.addFlag"),this.toggleObjectivesFlag,[targetData,true,-1,true,true]));
                  }
               }
               this.modContextMenu.createContextMenu(menu);
            }
         }
      }
      
      public function onRollOver(target:Object) : void
      {
         var targetData:Object = this.getDataFromTarget(target);
         if(targetData && (targetData.hasOwnProperty("seeLess") || !targetData.visible))
         {
            Mouse.cursor = MouseCursor.BUTTON;
         }
      }
      
      public function onRollOut(target:Object) : void
      {
         var targetData:Object = this.getDataFromTarget(target);
         if(targetData && (targetData.hasOwnProperty("seeLess") || !targetData.visible))
         {
            Mouse.cursor = MouseCursor.AUTO;
         }
      }
      
      public function onFontActiveTypeChanged() : void
      {
         this.renderUpdate();
      }
      
      public function onFlagRemoved(flagId:String, worldmapId:int) : void
      {
         var objectiveData:Object = null;
         if(flagId.indexOf("flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST) == 0)
         {
            objectiveData = this._flagsQuestData[flagId];
            if(objectiveData && this._quests.indexOf(objectiveData) != -1)
            {
               objectiveData.follow = false;
               this.setFlagColor(this._components[objectiveData].btn_loc,objectiveData.color,true);
               sysApi.setData(playerApi.getPlayedCharacterInfo().id + "-questFlag-" + flagId,false);
            }
         }
      }
      
      public function onFlagAdded(flagId:String, worldmapId:int, x:int, y:int, color:int, flagLegend:String, canBeManuallyRemoved:Boolean = true, allowDuplicate:Boolean = false) : void
      {
         var objectiveData:Object = null;
         if(flagId.indexOf("flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST) == 0)
         {
            objectiveData = this._flagsQuestData[flagId];
            if(objectiveData && this._quests.indexOf(objectiveData) != -1)
            {
               sysApi.setData(playerApi.getPlayedCharacterInfo().id + "-questFlag-" + flagId,true);
            }
         }
      }
   }
}
