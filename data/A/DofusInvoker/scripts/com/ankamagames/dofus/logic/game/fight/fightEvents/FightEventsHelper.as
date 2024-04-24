package com.ankamagames.dofus.logic.game.fight.fightEvents
{
   import com.ankamagames.berilia.managers.HtmlManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.utils.GameDebugManager;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import tools.enumeration.ElementEnum;
   
   public class FightEventsHelper
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightEventsHelper));
      
      private static var _fightEvents:Vector.<FightEvent> = new Vector.<FightEvent>();
      
      private static var _events:Vector.<Vector.<FightEvent>> = new Vector.<Vector.<FightEvent>>();
      
      private static var _joinedEvents:Vector.<FightEvent>;
      
      private static var sysApi:SystemApi = new SystemApi();
      
      public static var _detailsActive:Boolean;
      
      private static var _lastSpellId:int;
      
      private static const NOT_GROUPABLE_BY_TYPE_EVENTS:Array = [FightEventEnum.FIGHTER_CASTED_SPELL];
      
      private static const SKIP_ENTITY_ALIVE_CHECK_EVENTS:Array = [FightEventEnum.FIGHTER_GOT_KILLED,FightEventEnum.FIGHTER_DEATH];
       
      
      public function FightEventsHelper()
      {
         super();
      }
      
      public static function reset() : void
      {
         _fightEvents = new Vector.<FightEvent>();
         _events = new Vector.<Vector.<FightEvent>>();
         _joinedEvents = new Vector.<FightEvent>();
         _lastSpellId = -1;
      }
      
      public static function sendFightEvent(name:String, params:Array, fighterId:Number, pCastingSpellId:int, sendNow:Boolean = false, checkParams:int = 0, pFirstParamToCheck:int = 1, buff:BasicBuff = null) : void
      {
         var feTackle:FightEvent = null;
         var fe:FightEvent = null;
         var fightEvent:FightEvent = new FightEvent(name,params,fighterId,checkParams,pCastingSpellId,_fightEvents.length,pFirstParamToCheck,buff);
         if(sendNow)
         {
            KernelEventsManager.getInstance().processCallback(HookList.FightEvent,fightEvent.name,fightEvent.params,[fightEvent.targetId]);
            sendFightLogToChat(fightEvent);
         }
         else
         {
            if(name)
            {
               _fightEvents.splice(0,0,fightEvent);
            }
            if(_joinedEvents && _joinedEvents.length > 0)
            {
               if(_joinedEvents[0].name == FightEventEnum.FIGHTER_GOT_TACKLED)
               {
                  if(name == FightEventEnum.FIGHTER_MP_LOST || name == FightEventEnum.FIGHTER_AP_LOST)
                  {
                     _joinedEvents.splice(0,0,fightEvent);
                     return;
                  }
                  if(name != FightEventEnum.FIGHTER_VISIBILITY_CHANGED)
                  {
                     feTackle = _joinedEvents.shift();
                     for each(fe in _joinedEvents)
                     {
                        if(fe.name == FightEventEnum.FIGHTER_AP_LOST)
                        {
                           feTackle.params[1] = fe.params[1];
                        }
                        else
                        {
                           feTackle.params[2] = fe.params[1];
                        }
                     }
                     addFightText(feTackle);
                     _joinedEvents = null;
                  }
               }
            }
            else if(name == FightEventEnum.FIGHTER_GOT_TACKLED)
            {
               _joinedEvents = new Vector.<FightEvent>();
               _joinedEvents.push(fightEvent);
               return;
            }
            if(name)
            {
               addFightText(fightEvent);
            }
         }
      }
      
      private static function addFightText(fightEvent:FightEvent) : void
      {
         var i:int = 0;
         var targetEvent:Vector.<FightEvent> = null;
         var eventList:Vector.<FightEvent> = null;
         var event:FightEvent = null;
         var num:int = _events.length;
         var groupByType:* = NOT_GROUPABLE_BY_TYPE_EVENTS.indexOf(fightEvent.name) == -1;
         if(GameDebugManager.getInstance().detailedFightLog_unGroupEffects)
         {
            groupByType = false;
         }
         if(fightEvent.name == FightEventEnum.FIGHTER_CASTED_SPELL)
         {
            _lastSpellId = fightEvent.params[3];
         }
         if(fightEvent.name == FightEventEnum.FIGHTER_LIFE_LOSS || fightEvent.name == FightEventEnum.FIGHTER_LIFE_GAIN || fightEvent.name == FightEventEnum.FIGHTER_SHIELD_LOSS)
         {
            fightEvent.params.push(_lastSpellId);
         }
         if(fightEvent.name == FightEventEnum.FIGHTER_LIFE_LOSS)
         {
            for(i = 0; i < num; i++)
            {
               event = _events[i][0];
               if(event.name == FightEventEnum.FIGHTER_REDUCED_DAMAGES && event.castingSpellId == fightEvent.castingSpellId && event.targetId == fightEvent.targetId)
               {
                  groupByType = false;
                  break;
               }
            }
         }
         if(groupByType)
         {
            for(i = 0; i < num; i++)
            {
               eventList = _events[i];
               event = eventList[0];
               if(event.name == fightEvent.name && (event.castingSpellId == fightEvent.castingSpellId || fightEvent.castingSpellId == -1))
               {
                  if((event.name == FightEventEnum.FIGHTER_LIFE_LOSS || fightEvent.name == FightEventEnum.FIGHTER_LIFE_GAIN || fightEvent.name == FightEventEnum.FIGHTER_SHIELD_LOSS) && event.params[event.params.length - 1] != fightEvent.params[fightEvent.params.length - 1])
                  {
                     break;
                  }
                  targetEvent = eventList;
                  break;
               }
            }
         }
         if(targetEvent == null)
         {
            targetEvent = new Vector.<FightEvent>();
            _events.push(targetEvent);
         }
         targetEvent.push(fightEvent);
      }
      
      public static function sendAllFightEvent(now:Boolean = false) : void
      {
         if(now)
         {
            sendEvents(null);
         }
         else
         {
            EnterFrameDispatcher.addEventListener(sendEvents,EnterFrameConst.SEND_FIGHT_EVENTS_HELPER);
         }
      }
      
      private static function sendEvents(pEvt:Event = null) : void
      {
         EnterFrameDispatcher.removeEventListener(sendEvents);
         sendFightEvent(null,null,0,-1);
         sendAllFightEvents();
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var entitiesList:Dictionary = !!entitiesFrame ? entitiesFrame.entities : new Dictionary();
         _detailsActive = sysApi.getOption("showLogPvDetails","dofus");
         groupAllEventsForDisplay(entitiesList);
      }
      
      public static function groupAllEventsForDisplay(entitiesList:Dictionary) : void
      {
         var eventList:Vector.<FightEvent> = null;
         var eventBase:FightEvent = null;
         var fightEvent:FightEvent = null;
         var groupedByElementsEventList:Vector.<FightEvent> = null;
         var targetsId:Vector.<Number> = null;
         var eventsGroupedTargets:Vector.<String> = null;
         var targetEvents:* = null;
         var numTargets:uint = 0;
         var i:int = 0;
         var typeEvent:int = 0;
         var tmpevt:FightEvent = null;
         var copy:Vector.<FightEvent> = null;
         var isLastDamage:Boolean = false;
         var playerTeamId:int = PlayedCharacterManager.getInstance().teamId;
         var deadTargetsDescr:Object = getDeadTargetsDescr();
         var deadTargets:Dictionary = deadTargetsDescr["deadTargets"];
         var lastDamageMap:Dictionary = deadTargetsDescr["lastDamageMap"];
         var eventsGroupedByTarget:Dictionary = new Dictionary();
         while(_events.length > 0)
         {
            eventList = _events[0];
            if(eventList == null || eventList.length == 0)
            {
               _events.splice(0,1);
            }
            else
            {
               eventBase = eventList[0];
               targetsId = extractTargetsId(eventList);
               eventsGroupedByTarget = groupFightEventsByTarget(eventList);
               eventsGroupedTargets = new Vector.<String>(0);
               for(targetEvents in eventsGroupedByTarget)
               {
                  if(eventsGroupedByTarget[targetEvents].length > 1)
                  {
                     eventsGroupedTargets.unshift(targetEvents);
                  }
                  else
                  {
                     eventsGroupedTargets.push(targetEvents);
                  }
               }
               numTargets = eventsGroupedTargets.length;
               for(i = 0; i < numTargets; i++)
               {
                  targetEvents = eventsGroupedTargets[i];
                  eventBase = eventsGroupedByTarget[targetEvents][0];
                  if(eventsGroupedByTarget[targetEvents].length > 1 && (eventBase.name == FightEventEnum.FIGHTER_LIFE_LOSS || eventBase.name == FightEventEnum.FIGHTER_LIFE_GAIN || eventBase.name == FightEventEnum.FIGHTER_SHIELD_LOSS))
                  {
                     switch(eventBase.name)
                     {
                        case FightEventEnum.FIGHTER_LIFE_LOSS:
                        case FightEventEnum.FIGHTER_SHIELD_LOSS:
                           typeEvent = -1;
                           break;
                        case FightEventEnum.FIGHTER_LIFE_GAIN:
                        default:
                           typeEvent = 1;
                     }
                     fightEvent = groupByElements(eventsGroupedByTarget[targetEvents],typeEvent,_detailsActive,deadTargets[eventBase.targetId],eventBase.castingSpellId);
                     if(!groupedByElementsEventList)
                     {
                        groupedByElementsEventList = new Vector.<FightEvent>();
                     }
                     groupedByElementsEventList.push(fightEvent);
                     for each(tmpevt in eventsGroupedByTarget[targetEvents])
                     {
                        eventList.splice(eventList.indexOf(tmpevt),1);
                     }
                  }
                  else
                  {
                     copy = eventList.concat();
                     for each(eventBase in copy)
                     {
                        if(eventBase.name == FightEventEnum.FIGHTER_DEATH && deadTargets[eventBase.targetId])
                        {
                           eventList.splice(eventList.indexOf(eventBase),1);
                        }
                     }
                     groupByTeam(playerTeamId,targetsId,eventList,entitiesList,deadTargets);
                     copy = eventList.concat();
                     for each(eventBase in copy)
                     {
                        isLastDamage = eventBase.name == FightEventEnum.FIGHTER_LIFE_LOSS && lastDamageMap[eventBase.targetId] === eventBase.id && deadTargets[eventBase.targetId];
                        sendFightLogToChat(eventBase,"",null,_detailsActive,isLastDamage);
                        eventList.splice(eventList.indexOf(eventBase),1);
                     }
                     copy = null;
                  }
               }
               if(groupedByElementsEventList && groupedByElementsEventList.length > 0)
               {
                  groupByTeam(playerTeamId,targetsId,groupedByElementsEventList,entitiesList,deadTargets,false);
                  if(groupedByElementsEventList.length > 0)
                  {
                     for each(fightEvent in groupedByElementsEventList)
                     {
                        sendFightLogToChat(fightEvent,"",null,false,fightEvent.name == FightEventEnum.FIGHTER_LIFE_LOSS && deadTargets[fightEvent.targetId]);
                     }
                  }
                  groupedByElementsEventList = null;
               }
            }
         }
      }
      
      public static function extractTargetsId(eventList:Vector.<FightEvent>) : Vector.<Number>
      {
         var event:FightEvent = null;
         var targetList:Vector.<Number> = new Vector.<Number>();
         for each(event in eventList)
         {
            if(targetList.indexOf(event.targetId) == -1)
            {
               targetList.push(event.targetId);
            }
         }
         return targetList;
      }
      
      public static function groupFightEventsByTarget(eventList:Vector.<FightEvent>) : Dictionary
      {
         var event:FightEvent = null;
         var dico:Dictionary = new Dictionary();
         for each(event in eventList)
         {
            if(dico[event.targetId.toString()] == null)
            {
               dico[event.targetId.toString()] = new Array();
            }
            dico[event.targetId.toString()].push(event);
         }
         return dico;
      }
      
      public static function getDeadTargetsDescr() : Object
      {
         var eventList:Vector.<FightEvent> = null;
         var j:uint = 0;
         var fightEvent:FightEvent = null;
         var deadTargets:Dictionary = new Dictionary();
         var lastDamageMap:Dictionary = new Dictionary();
         var events:Vector.<Vector.<FightEvent>> = _events.concat();
         for(var eventListIndex:uint = 0; eventListIndex < events.length; eventListIndex++)
         {
            eventList = events[eventListIndex];
            for(j = 0; j < eventList.length; j++)
            {
               fightEvent = eventList[j];
               if(fightEvent.name == FightEventEnum.FIGHTER_LIFE_LOSS && !deadTargets[fightEvent.targetId])
               {
                  lastDamageMap[fightEvent.targetId] = fightEvent.id;
               }
               else if(fightEvent.name == FightEventEnum.FIGHTER_DEATH)
               {
                  deadTargets[fightEvent.targetId] = true;
               }
            }
         }
         return {
            "deadTargets":deadTargets,
            "lastDamageMap":lastDamageMap
         };
      }
      
      private static function groupByElements(pvgroup:Array, pType:int, activeDetails:Boolean = true, pAddDeathInTheSameMsg:Boolean = false, pCastingSpellId:int = -1) : FightEvent
      {
         var previousElement:int = 0;
         var fe:FightEvent = null;
         var fightEventName:String = null;
         var fightEventText:String = null;
         var ttptsStr:String = "";
         var ttpts:int = 0;
         var isSameElement:Boolean = true;
         for each(fe in pvgroup)
         {
            if(!(pCastingSpellId != -1 && pCastingSpellId != fe.castingSpellId))
            {
               if(previousElement && fe.params[2] != previousElement)
               {
                  isSameElement = false;
               }
               previousElement = fe.params[2];
               ttpts += fe.params[1];
               if(pType == -1)
               {
                  ttptsStr += formateColorsForFightDamages(fe.params[1],fe.params[2]) + " + ";
               }
               else
               {
                  ttptsStr += fe.params[1] + " + ";
               }
            }
         }
         fightEventName = !!pAddDeathInTheSameMsg ? "fightLifeLossAndDeath" : pvgroup[0].name;
         var newparams:Array = new Array();
         newparams[0] = pvgroup[0].params[0];
         if(pType == -1)
         {
            fightEventText = formateColorsForFightDamages("-" + ttpts.toString(),!!isSameElement ? int(previousElement) : int(ElementEnum.ELEMENT_MULTI));
         }
         else
         {
            fightEventText = ttpts.toString();
         }
         if(activeDetails && pvgroup.length > 1)
         {
            fightEventText += "</b> (" + ttptsStr.substr(0,ttptsStr.length - 3) + ")<b>";
         }
         newparams[1] = fightEventText;
         return new FightEvent(fightEventName,newparams,newparams[0],2,pvgroup[0].castingSpellId,pvgroup.length,1);
      }
      
      private static function groupByTeam(playerTeamId:int, targets:Vector.<Number>, pEventList:Vector.<FightEvent>, pEntitiesList:Dictionary, deadTargets:Dictionary, pEnableColoration:Boolean = true) : Boolean
      {
         var event:FightEvent = null;
         var list:Vector.<Number> = null;
         var listToConcat:Vector.<FightEvent> = null;
         var evt:FightEvent = null;
         var team:String = null;
         var tmpEffect:EffectInstance = null;
         var buffStackCount:int = 0;
         var tmpDiceNum:int = 0;
         var t:Object = null;
         var teamId:int = 0;
         if(pEventList.length == 0)
         {
            return false;
         }
         var tmpEventList:Vector.<FightEvent> = pEventList.concat();
         while(tmpEventList.length > 1)
         {
            listToConcat = getGroupedListEvent(tmpEventList);
            if(listToConcat.length <= 1)
            {
               continue;
            }
            list = new Vector.<Number>();
            for each(event in listToConcat)
            {
               list.push(event.targetId);
               if(event != listToConcat[0] && event.targetId == listToConcat[0].targetId && listToConcat[0] is StatBuff)
               {
                  listToConcat[0].params[1] += event.params[1];
               }
            }
            evt = listToConcat[0];
            if(evt.buff is StatBuff)
            {
               tmpEffect = evt.buff.effect.clone();
               if(tmpEffect is EffectInstanceDice)
               {
                  buffStackCount = 1;
                  tmpDiceNum = int(evt.buff.rawParam1);
                  for each(event in listToConcat)
                  {
                     if(event.targetId == evt.targetId && event.buff.id !== evt.buff.id)
                     {
                        if(evt.buff.castingSpell.spellLevelData.maxStack && buffStackCount >= evt.buff.castingSpell.spellLevelData.maxStack)
                        {
                           break;
                        }
                        buffStackCount++;
                        tmpDiceNum += int(event.buff.rawParam1);
                     }
                  }
                  EffectInstanceDice(tmpEffect).diceNum = tmpDiceNum;
               }
               evt.params[1] = tmpEffect.description;
            }
            team = groupEntitiesByTeam(playerTeamId,list,pEntitiesList,SKIP_ENTITY_ALIVE_CHECK_EVENTS.indexOf(pEventList[0].name) == -1);
            switch(team)
            {
               case "all":
               case "allies":
               case "enemies":
                  removeEventFromEventsList(pEventList,listToConcat);
                  if(evt.name == "fighterLifeLoss" && deadTargets[listToConcat[0].targetId])
                  {
                     sendFightLogToChat(evt,team,null,pEnableColoration,true);
                  }
                  else
                  {
                     sendFightLogToChat(evt,team,null,pEnableColoration);
                  }
                  break;
               case "other":
                  removeEventFromEventsList(pEventList,listToConcat);
                  if(evt.name == "fighterLifeLoss" && deadTargets[listToConcat[0].targetId])
                  {
                     sendFightLogToChat(evt,"",list,pEnableColoration,true);
                  }
                  else
                  {
                     sendFightLogToChat(evt,"",list,pEnableColoration);
                  }
                  break;
               case "none":
                  _log.warn("Failed to group FightEvents for the team \'none\'");
                  break;
               default:
                  for each(t in pEntitiesList)
                  {
                     if(t is GameFightFighterInformations)
                     {
                        teamId = (t as GameFightFighterInformations).spawnInfo.teamId;
                     }
                     else
                     {
                        teamId = t.teamId;
                     }
                     if(team.indexOf("allies") != -1 && teamId == playerTeamId || team.indexOf("enemies") != -1 && teamId != playerTeamId)
                     {
                        list.splice(list.indexOf(t.contextualId),1);
                     }
                  }
                  removeEventFromEventsList(pEventList,listToConcat);
                  if(evt.name == "fighterLifeLoss" && deadTargets[listToConcat[0].targetId])
                  {
                     sendFightLogToChat(evt,team,list,pEnableColoration,true);
                  }
                  else
                  {
                     sendFightLogToChat(evt,team,list,pEnableColoration);
                  }
                  break;
            }
         }
         return false;
      }
      
      public static function getGroupedListEvent(pInEventList:Vector.<FightEvent>) : Vector.<FightEvent>
      {
         var event:FightEvent = null;
         var baseEvent:FightEvent = pInEventList[0];
         var listToConcat:Vector.<FightEvent> = new Vector.<FightEvent>();
         listToConcat.push(baseEvent);
         for each(event in pInEventList)
         {
            if(listToConcat.indexOf(event) == -1 && needToGroupFightEventsData(getNumberOfParametersToCheck(baseEvent),event,baseEvent))
            {
               listToConcat.push(event);
            }
         }
         removeEventFromEventsList(pInEventList,listToConcat);
         return listToConcat;
      }
      
      public static function removeEventFromEventsList(pEventList:Vector.<FightEvent>, pListToRemove:Vector.<FightEvent>) : void
      {
         var event:FightEvent = null;
         for each(event in pListToRemove)
         {
            pEventList.splice(pEventList.indexOf(event),1);
         }
      }
      
      public static function groupEntitiesByTeam(playerTeamId:int, targetList:Vector.<Number>, entitiesList:Dictionary, checkAlive:Boolean = true) : String
      {
         var fighterInfos:GameFightFighterInformations = null;
         var returnData:* = null;
         var alliesCount:int = 0;
         var enemiesCount:int = 0;
         var nbTotalAllies:int = 0;
         var nbTotalEnemies:int = 0;
         for each(fighterInfos in entitiesList)
         {
            if(fighterInfos != null)
            {
               if(fighterInfos.spawnInfo.teamId == playerTeamId)
               {
                  nbTotalAllies++;
               }
               else
               {
                  nbTotalEnemies++;
               }
               if((!checkAlive || checkAlive && fighterInfos.spawnInfo.alive) && targetList.indexOf(fighterInfos.contextualId) != -1)
               {
                  if(fighterInfos.spawnInfo.teamId == playerTeamId)
                  {
                     alliesCount++;
                  }
                  else
                  {
                     enemiesCount++;
                  }
               }
            }
         }
         returnData = "";
         if(nbTotalAllies == alliesCount && nbTotalEnemies == enemiesCount)
         {
            return "all";
         }
         if(alliesCount > 1 && alliesCount == nbTotalAllies)
         {
            returnData += (returnData != "" ? "," : "") + "allies";
            if(enemiesCount > 0 && enemiesCount < nbTotalEnemies)
            {
               returnData += ",other";
            }
         }
         if(enemiesCount > 1 && enemiesCount == nbTotalEnemies)
         {
            returnData += (returnData != "" ? "," : "") + "enemies";
            if(alliesCount > 0 && alliesCount < nbTotalAllies)
            {
               returnData += ",other";
            }
         }
         if(returnData == "" && targetList.length > 1)
         {
            returnData += (returnData != "" ? "," : "") + "other";
         }
         return returnData == "" ? "none" : returnData;
      }
      
      private static function getNumberOfParametersToCheck(baseEvent:FightEvent) : int
      {
         var numParam:int = baseEvent.params.length;
         if(numParam > baseEvent.checkParams)
         {
            numParam = baseEvent.checkParams;
         }
         return numParam;
      }
      
      private static function needToGroupFightEventsData(pNbParams:int, pFightEvent:FightEvent, pBaseEvent:FightEvent) : Boolean
      {
         var paramId:int = 0;
         if(pFightEvent.castingSpellId != pBaseEvent.castingSpellId || GameDebugManager.getInstance().detailedFightLog_unGroupEffects || pFightEvent.buff && pFightEvent.buff.disabled !== pBaseEvent.buff.disabled)
         {
            return false;
         }
         for(paramId = pFightEvent.firstParamToCheck; paramId < pNbParams; paramId++)
         {
            if(pFightEvent.params[paramId] != pBaseEvent.params[paramId])
            {
               return false;
            }
         }
         return true;
      }
      
      private static function sendAllFightEvents() : void
      {
         for(var i:int = _fightEvents.length - 1; i >= 0; i--)
         {
            if(_fightEvents[i])
            {
               KernelEventsManager.getInstance().processCallback(HookList.FightEvent,_fightEvents[i].name,_fightEvents[i].params,[_fightEvents[i].targetId]);
            }
         }
         clearData();
      }
      
      public static function clearData() : void
      {
         _fightEvents = new Vector.<FightEvent>();
         FightEvent.reset();
      }
      
      private static function sendFightLogToChat(pFightEvent:FightEvent, pTargetsTeam:String = "", pTargetsList:Vector.<Number> = null, pActiveColoration:Boolean = true, pAddDeathInTheSameMsg:Boolean = false) : void
      {
         var name:String = pFightEvent.name == FightEventEnum.FIGHTER_LIFE_LOSS && pAddDeathInTheSameMsg ? FightEventEnum.FIGHTER_LIFE_LOSS_AND_DEATH : pFightEvent.name;
         var params:Array = pFightEvent.params.concat();
         if(pActiveColoration)
         {
            if(pFightEvent.name == FightEventEnum.FIGHTER_LIFE_LOSS || pFightEvent.name == FightEventEnum.FIGHTER_SHIELD_LOSS)
            {
               params[1] = formateColorsForFightDamages("-" + params[1],params[2]);
            }
         }
         KernelEventsManager.getInstance().processCallback(HookList.FightText,name,params,pTargetsList,pTargetsTeam,GameDebugManager.getInstance().detailedFightLog_showIds);
      }
      
      private static function formateColorsForFightDamages(inText:String, elementId:int) : String
      {
         var color:String = null;
         switch(elementId)
         {
            case ElementEnum.ELEMENT_MULTI:
               color = XmlConfig.getInstance().getEntry("colors.fight.text.multi");
               break;
            case ElementEnum.ELEMENT_NEUTRAL:
               color = XmlConfig.getInstance().getEntry("colors.fight.text.neutral");
               break;
            case ElementEnum.ELEMENT_EARTH:
               color = XmlConfig.getInstance().getEntry("colors.fight.text.earth");
               break;
            case ElementEnum.ELEMENT_FIRE:
               color = XmlConfig.getInstance().getEntry("colors.fight.text.fire");
               break;
            case ElementEnum.ELEMENT_WATER:
               color = XmlConfig.getInstance().getEntry("colors.fight.text.water");
               break;
            case ElementEnum.ELEMENT_AIR:
               color = XmlConfig.getInstance().getEntry("colors.fight.text.air");
               break;
            case ElementEnum.ELEMENT_NONE:
            default:
               color = "";
         }
         if(color != "")
         {
            return HtmlManager.addTag(inText,HtmlManager.SPAN,{"color":color});
         }
         return inText;
      }
      
      public static function get fightEvents() : Vector.<FightEvent>
      {
         return _fightEvents;
      }
      
      public static function get events() : Vector.<Vector.<FightEvent>>
      {
         return _events;
      }
      
      public static function get joinedEvents() : Vector.<FightEvent>
      {
         return _joinedEvents;
      }
   }
}
