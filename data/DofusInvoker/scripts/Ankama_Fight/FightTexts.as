package Ankama_Fight
{
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.actions.chat.FightOutputAction;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.utils.Dictionary;
   
   public class FightTexts
   {
      
      public static var cacheFighterName:Dictionary = new Dictionary(true);
      
      public static var cacheSpellName:Dictionary = new Dictionary(true);
      
      private static var _targets:Vector.<Number>;
      
      private static var _targetsTeam:String;
      
      private static var _buildType:uint;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      public function FightTexts()
      {
         super();
      }
      
      private static function getSpellName(casterId:Number, targetCellId:int, sourceCellId:int, spellId:uint, spellLevelId:uint, forceDetailedLog:Boolean) : String
      {
         var spell:Spell = null;
         var spellLevel:SpellLevel = null;
         if(!cacheSpellName[spellId])
         {
            spell = Api.dataApi.getSpell(spellId);
            cacheSpellName[spellId] = spell;
         }
         else
         {
            spell = cacheSpellName[spellId];
         }
         var spellName:String = _buildType == BuildTypeEnum.INTERNAL && cacheSpellName[spellId].adminName ? cacheSpellName[spellId].adminName + " (" + cacheSpellName[spellId].name + ")" : cacheSpellName[spellId].name;
         if(spell && forceDetailedLog)
         {
            spellLevel = Api.dataApi.getSpellLevelBySpell(spell,spellLevelId);
            spellName += " (" + spellLevel.spellId + ") rang " + spellLevel.grade;
         }
         var eventParams:String = "event:spellEffectArea," + casterId + "," + targetCellId + "," + sourceCellId + "," + spellId + "," + spellLevelId;
         return Api.chatApi.addHtmlLink(spellName,eventParams);
      }
      
      private static function getFighterName(id:Number, isAllowDeadFighters:Boolean = true) : String
      {
         var teams:Array = null;
         var team:String = null;
         var fighterId:Number = NaN;
         var names:String = null;
         var fightEntitiesFrame:FightEntitiesFrame = null;
         if(!isAllowDeadFighters)
         {
            fightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         }
         var fighterName:* = "";
         if(_targetsTeam != "" || _targets.length > 0 && _targets.indexOf(id) != -1)
         {
            teams = !!_targetsTeam ? _targetsTeam.split(",") : [" "];
            for each(team in teams)
            {
               if(fighterName != "")
               {
                  fighterName += ", ";
               }
               switch(team)
               {
                  case "allies":
                     if(Api.fightApi.isSpectator())
                     {
                        fighterName += Api.uiApi.getText("ui.common.attackers");
                     }
                     else
                     {
                        fighterName += Api.uiApi.getText("ui.common.allies");
                     }
                     break;
                  case "enemies":
                     if(Api.fightApi.isSpectator())
                     {
                        fighterName += Api.uiApi.getText("ui.common.defenders");
                     }
                     else
                     {
                        fighterName += Api.uiApi.getText("ui.common.enemies");
                     }
                     break;
                  case "all":
                     fighterName += Api.uiApi.getText("ui.common.everyone");
                     break;
                  default:
                     names = "";
                     for each(fighterId in _targets)
                     {
                        if(!(!isAllowDeadFighters && (fightEntitiesFrame === null || !fightEntitiesFrame.isEntityAlive(fighterId))))
                        {
                           names += (names != "" ? ", " : "") + getFighterCacheName(fighterId);
                        }
                     }
                     fighterName += names;
                     break;
               }
            }
         }
         else
         {
            fighterName = getFighterCacheName(id);
         }
         return fighterName;
      }
      
      private static function getFighterCacheName(id:Number) : String
      {
         var fighterName:String = cacheFighterName[id];
         if(!fighterName)
         {
            if(id > 0)
            {
               fighterName = Api.chatApi.addHtmlLink(Api.fightApi.getFighterName(id),"event:entity," + id + ",1");
            }
            else if(id < 0)
            {
               fighterName = Api.chatApi.addHtmlLink(Api.fightApi.getFighterName(id),"event:monsterFight," + id);
            }
            cacheFighterName[id] = fighterName;
         }
         return fighterName;
      }
      
      public static function event(name:String, params:Object, buildType:uint, pTargets:Object = null, pTargetsTeam:String = "", forceDetailedLog:Boolean = false) : void
      {
         var roobjectdata:Number = NaN;
         var fightEndedText:* = null;
         var fightEndedLinkText:* = null;
         var delta:String = null;
         var visible:Boolean = false;
         var turnText:* = null;
         var duration:int = 0;
         var finalText:* = null;
         var statLost:Array = null;
         _buildType = buildType;
         _targets = new Vector.<Number>();
         if(pTargets != null)
         {
            for each(roobjectdata in pTargets)
            {
               if(_targets.indexOf(roobjectdata) == -1)
               {
                  _targets.push(roobjectdata);
               }
            }
         }
         _targetsTeam = pTargetsTeam;
         var txt:String = "";
         switch(name)
         {
            case FightEventEnum.FIGHTER_LIFE_LOSS_AND_DEATH:
               txt = Api.uiApi.getText("ui.fight.lifeLossAndDeath",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_LIFE_LOSS:
               txt = Api.uiApi.getText("ui.fight.lifeLoss",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_LIFE_GAIN:
               txt = Api.uiApi.getText("ui.fight.lifeGain",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_PERMANENT_DAMAGE:
               break;
            case FightEventEnum.FIGHTER_NO_CHANGE:
               txt = Api.uiApi.getText("ui.fight.noChange",getFighterName(params[0]));
               break;
            case FightEventEnum.FIGHT_END:
               fightEndedText = "{openFightResult," + params[0] + "::" + Api.uiApi.getText("ui.fight.fightEnd") + "}";
               fightEndedLinkText = "{openFightResult," + params[0] + "::" + Api.uiApi.getText("ui.fight.fightEndLink") + "}";
               txt = Api.uiApi.getText("ui.fight.fightEndChat",fightEndedText,fightEndedLinkText);
               break;
            case FightEventEnum.FIGHTER_DEATH:
               txt = Api.uiApi.getText("ui.fight.isDead",!!_targetsTeam ? getFighterName(params[0]) : params[1]);
               txt = Api.uiApi.processText(txt,"n",true);
               break;
            case FightEventEnum.FIGHTER_LEAVE:
               txt = Api.uiApi.getText("ui.fight.leave",getFighterName(params[0]));
               break;
            case FightEventEnum.FIGHTER_CHANGE_LOOK:
               break;
            case FightEventEnum.FIGHTER_GOT_DISPELLED:
               txt = Api.uiApi.getText("ui.fight.dispell",getFighterName(params[0]));
               break;
            case FightEventEnum.FIGHTER_SPELL_DISPELLED:
               txt = Api.uiApi.getText("ui.fight.dispellSpell",getFighterName(params[0]),Api.dataApi.getSpell(params[1]).name);
               break;
            case FightEventEnum.FIGHTER_EFFECTS_MODIFY_DURATION:
               txt = Api.uiApi.getText("ui.fight.effectsModifyDuration",getFighterName(params[1]),params[2]);
               break;
            case FightEventEnum.FIGHTER_SPELL_COOLDOWN_VARIATION:
               delta = params[2] < 0 ? params[2] : "+" + params[2];
               txt = Api.uiApi.getText("ui.fight.cooldownVariation",getFighterName(params[0]),Api.dataApi.getSpell(params[1]).name,delta);
               break;
            case FightEventEnum.FIGHTER_SPELL_IMMUNITY:
               txt = Api.uiApi.getText("ui.fight.noChange",getFighterName(params[0]));
               break;
            case FightEventEnum.FIGHTER_AP_LOSS_DODGED:
               txt = Api.uiApi.getText("ui.fight.dodgeAP",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_MP_LOSS_DODGED:
               txt = Api.uiApi.getText("ui.fight.dodgeMP",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTERS_POSITION_EXCHANGE:
               break;
            case FightEventEnum.FIGHTER_VISIBILITY_CHANGED:
               switch(params[1])
               {
                  case 1:
                     txt = Api.uiApi.getText("ui.fight.invisibility",getFighterName(params[0]));
                     break;
                  case 2:
                  case 3:
                     txt = Api.uiApi.getText("ui.fight.visibility",getFighterName(params[0]));
               }
               break;
            case FightEventEnum.FIGHTER_GOT_KILLED:
               if(params[0] != params[1])
               {
                  txt = Api.uiApi.getText("ui.fight.killed",getFighterCacheName(params[0]),getFighterName(params[1]));
               }
               break;
            case FightEventEnum.FIGHTER_TEMPORARY_BOOSTED:
               visible = Boolean(params[4]);
               if(visible)
               {
                  duration = int(params[2]);
                  finalText = params[1];
                  if(duration)
                  {
                     finalText = finalText + " (" + params[3] + ")";
                  }
                  txt = Api.uiApi.getText("ui.fight.effect",getFighterName(params[0]),finalText);
               }
               break;
            case FightEventEnum.FIGHTER_AP_USED:
               break;
            case FightEventEnum.FIGHTER_AP_LOST:
               txt = Api.uiApi.getText("ui.fight.lostAP",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_AP_GAINED:
               txt = Api.uiApi.getText("ui.fight.winAP",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_MP_USED:
               break;
            case FightEventEnum.FIGHTER_MP_LOST:
               txt = Api.uiApi.getText("ui.fight.lostMP",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_MP_GAINED:
               txt = Api.uiApi.getText("ui.fight.winMP",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_SHIELD_LOSS:
               txt = Api.uiApi.getText("ui.fight.lostShieldPoints",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_REDUCED_DAMAGES:
               txt = Api.uiApi.getText("ui.fight.reduceDamages",getFighterName(params[0]),params[1]);
               break;
            case FightEventEnum.FIGHTER_REFLECTED_DAMAGES:
               txt = Api.uiApi.getText("ui.fight.reflectDamages",getFighterName(params[0]));
               break;
            case FightEventEnum.FIGHTER_REFLECTED_SPELL:
               txt = Api.uiApi.getText("ui.fight.reflectSpell",getFighterName(params[0]));
               break;
            case FightEventEnum.FIGHTER_SLIDE:
               break;
            case FightEventEnum.FIGHTER_CASTED_SPELL:
               txt = Api.uiApi.getText("ui.fight.launchSpell",getFighterName(params[0]),getSpellName(params[0],params[1],params[2],params[3],params[4],forceDetailedLog));
               if(params[5] == 2)
               {
                  txt += " " + Api.uiApi.getText("ui.fight.criticalHit");
               }
               else if(params[5] == 3)
               {
                  txt += " " + Api.uiApi.getText("ui.fight.criticalMiss");
               }
               break;
            case FightEventEnum.FIGHTER_CLOSE_COMBAT:
               txt = Api.uiApi.getText("ui.fight.closeCombat",getFighterName(params[0]),Api.dataApi.getItem(params[1]).name);
               if(params[2] == 2)
               {
                  txt += " " + Api.uiApi.getText("ui.fight.criticalHit");
               }
               else if(params[2] == 3)
               {
                  txt += " " + Api.uiApi.getText("ui.fight.criticalMiss");
               }
               break;
            case FightEventEnum.FIGHTER_DID_CRITICAL_HIT:
               break;
            case FightEventEnum.FIGHTER_ENTERING_STATE:
               turnText = "";
               if(params.length == 3 && params[2])
               {
                  turnText = "</b> (" + params[2] + ")<b>";
               }
               txt = Api.uiApi.getText("ui.fight.enterState",getFighterName(params[0],false),Api.dataApi.getSpellState(params[1]).name + turnText);
               break;
            case FightEventEnum.FIGHTER_LEAVING_STATE:
               txt = Api.uiApi.getText("ui.fight.exitState",getFighterName(params[0],false),Api.dataApi.getSpellState(params[1]).name);
               break;
            case FightEventEnum.FIGHTER_STEALING_KAMAS:
               txt = Api.uiApi.getText("ui.fight.stealMoney",getFighterCacheName(params[0]),params[2],getFighterName(params[1]));
               txt = Api.uiApi.processText(txt,"n",params[2] <= 1,params[2] == 0);
               break;
            case FightEventEnum.FIGHTER_SUMMONED:
               break;
            case FightEventEnum.FIGHTER_GOT_TACKLED:
               txt = Api.uiApi.getText("ui.fight.dodgeFailed");
               if(params.length > 1)
               {
                  statLost = [];
                  if(params[1] && params[1] != 0)
                  {
                     statLost.push("-" + params[1] + " " + Api.uiApi.getText("ui.common.ap"));
                  }
                  if(params[2] && params[2] != 0)
                  {
                     statLost.push("-" + params[2] + " " + Api.uiApi.getText("ui.common.mp"));
                  }
                  txt += " (" + statLost.join(",") + ")";
               }
               break;
            case FightEventEnum.FIGHTER_TELEPORTED:
               break;
            case FightEventEnum.FIGHTER_TRIGGERED_GLYPH:
               txt = Api.uiApi.getText("ui.fight.startTrap",getFighterName(params[0]),Api.dataApi.getSpell(params[2]).name,getFighterName(params[1]));
               break;
            case FightEventEnum.FIGHTER_TRIGGERED_TRAP:
               txt = Api.uiApi.getText("ui.fight.startTrap",getFighterName(params[0]),Api.dataApi.getSpell(params[2]).name,getFighterName(params[1]));
               break;
            case FightEventEnum.FIGHTER_TRIGGERED_PORTAL:
               break;
            case FightEventEnum.GLYPH_APPEARED:
               break;
            case FightEventEnum.GLYPH_DISAPPEARED:
               break;
            case FightEventEnum.TRAP_APPEARED:
               break;
            case FightEventEnum.TRAP_DISAPPEARED:
               break;
            case FightEventEnum.PORTAL_APPEARED:
               break;
            case FightEventEnum.RUNE_APPEARED:
               return;
            case FightEventEnum.PORTAL_DISAPPEARED:
               break;
            case FightEventEnum.RUNE_DISAPPEARED:
               return;
            case FightEventEnum.FIGHTER_CARRY:
               break;
            case FightEventEnum.FIGHTER_THROW:
               break;
            default:
               Api.sysApi.log(16,"Unknown fight event " + name + " received.");
               return;
         }
         if(txt && txt.length > 0)
         {
            Api.sysApi.sendAction(new FightOutputAction([txt,11]));
         }
      }
   }
}
