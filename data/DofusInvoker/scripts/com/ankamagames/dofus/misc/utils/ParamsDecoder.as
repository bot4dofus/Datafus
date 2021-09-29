package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.dofus.datacenter.alignments.AlignmentSide;
   import com.ankamagames.dofus.datacenter.appearance.Ornament;
   import com.ankamagames.dofus.datacenter.appearance.Title;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.datacenter.challenges.Challenge;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.monsters.MonsterRace;
   import com.ankamagames.dofus.datacenter.monsters.MonsterSuperRace;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.datacenter.world.Dungeon;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkItemManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowAchievementManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowOrnamentManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowQuestManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowTitleManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.utils.getQualifiedClassName;
   
   public class ParamsDecoder
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ParamsDecoder));
       
      
      public function ParamsDecoder()
      {
         super();
      }
      
      public static function applyParams(txt:String, params:Array, replace:String = "%") : String
      {
         var c:String = null;
         var lectureType:Boolean = false;
         var lectureId:Boolean = false;
         var type:String = "";
         var id:String = "";
         var s:String = "";
         for(var i:uint = 0; i < txt.length; i++)
         {
            c = txt.charAt(i);
            if(c == "$")
            {
               lectureType = true;
            }
            else if(c == replace)
            {
               if(i + 1 < txt.length && txt.charAt(i + 1) == replace)
               {
                  lectureId = false;
                  lectureType = false;
                  i++;
               }
               else
               {
                  lectureType = false;
                  lectureId = true;
               }
            }
            if(lectureType)
            {
               type += c;
            }
            else if(lectureId)
            {
               if(c == replace)
               {
                  if(id.length == 0)
                  {
                     id += c;
                  }
                  else
                  {
                     s += processReplace(type,id,params);
                     type = "";
                     id = "" + c;
                  }
               }
               else if(c >= "0" && c <= "9")
               {
                  id += c;
                  if(i + 1 == txt.length)
                  {
                     lectureId = false;
                     s += processReplace(type,id,params);
                     type = "";
                     id = "";
                  }
               }
               else
               {
                  lectureId = false;
                  s += processReplace(type,id,params);
                  type = "";
                  id = "";
                  s += c;
               }
            }
            else
            {
               if(id != "")
               {
                  s += processReplace(type,id,params);
                  type = "";
                  id = "";
               }
               s += c;
            }
         }
         return s;
      }
      
      private static function processReplace(type:String, id:String, params:Array) : String
      {
         var nid:int = 0;
         var item:Item = null;
         var itemType:ItemType = null;
         var job:Job = null;
         var quest:Quest = null;
         var achievement:Achievement = null;
         var title:Title = null;
         var ornament:Ornament = null;
         var spell:Spell = null;
         var spellState:SpellState = null;
         var breed:Breed = null;
         var area:Area = null;
         var subArea:SubArea = null;
         var map:MapPosition = null;
         var emote:Emoticon = null;
         var monster:Monster = null;
         var monsterRace:MonsterRace = null;
         var monsterSuperRace:MonsterSuperRace = null;
         var challenge:Challenge = null;
         var alignmentSide:AlignmentSide = null;
         var stats:Array = null;
         var dungeon:Dungeon = null;
         var time:Date = null;
         var timeToDisplay:int = 0;
         var companion:Companion = null;
         var itemw:ItemWrapper = null;
         var newString:* = "";
         nid = int(Number(id.substr(1))) - 1;
         if(type == "")
         {
            newString = params[nid];
         }
         else
         {
            switch(type)
            {
               case "$item":
                  item = Item.getItemById(params[nid]);
                  if(item)
                  {
                     itemw = ItemWrapper.create(0,0,params[nid],0,null,false);
                     newString = HyperlinkItemManager.newChatItem(itemw);
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$itemType":
                  itemType = ItemType.getItemTypeById(params[nid]);
                  if(itemType)
                  {
                     newString = itemType.name;
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$quantity":
                  newString = StringUtils.formateIntToString(Math.floor(params[nid]));
                  break;
               case "$job":
                  job = Job.getJobById(params[nid]);
                  if(job)
                  {
                     newString = job.name;
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$quest":
                  quest = Quest.getQuestById(params[nid]);
                  if(quest)
                  {
                     newString = HyperlinkShowQuestManager.addQuest(quest.id);
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$achievement":
                  achievement = Achievement.getAchievementById(params[nid]);
                  if(achievement)
                  {
                     newString = HyperlinkShowAchievementManager.addAchievement(achievement.id);
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$title":
                  title = Title.getTitleById(params[nid]);
                  if(title)
                  {
                     newString = HyperlinkShowTitleManager.addTitle(title.id);
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$ornament":
                  ornament = Ornament.getOrnamentById(params[nid]);
                  if(ornament)
                  {
                     newString = HyperlinkShowOrnamentManager.addOrnament(ornament.id);
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$spell":
                  spell = Spell.getSpellById(params[nid]);
                  if(spell)
                  {
                     newString = spell.name;
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$spellState":
                  spellState = SpellState.getSpellStateById(params[nid]);
                  if(spellState)
                  {
                     newString = spellState.name;
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$breed":
                  breed = Breed.getBreedById(params[nid]);
                  if(breed)
                  {
                     newString = breed.shortName;
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$area":
                  area = Area.getAreaById(params[nid]);
                  if(area)
                  {
                     newString = area.name;
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$subarea":
                  subArea = SubArea.getSubAreaById(params[nid]);
                  if(subArea)
                  {
                     newString = "{subArea," + params[nid] + "}";
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$map":
                  map = MapPosition.getMapPositionById(params[nid]);
                  if(map)
                  {
                     if(map.name)
                     {
                        newString = map.name;
                     }
                     else
                     {
                        newString = "{map," + int(map.posX) + "," + int(map.posY) + "," + int(map.worldMap) + "}";
                     }
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$emote":
                  emote = Emoticon.getEmoticonById(params[nid]);
                  if(emote)
                  {
                     newString = emote.name;
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$monster":
                  monster = Monster.getMonsterById(params[nid]);
                  if(monster)
                  {
                     newString = monster.name;
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$monsterRace":
                  monsterRace = MonsterRace.getMonsterRaceById(params[nid]);
                  if(monsterRace)
                  {
                     newString = monsterRace.name;
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$monsterSuperRace":
                  monsterSuperRace = MonsterSuperRace.getMonsterSuperRaceById(params[nid]);
                  if(monsterSuperRace)
                  {
                     newString = monsterSuperRace.name;
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$challenge":
                  challenge = Challenge.getChallengeById(params[nid]);
                  if(challenge)
                  {
                     newString = challenge.name;
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$alignment":
                  alignmentSide = AlignmentSide.getAlignmentSideById(params[nid]);
                  if(alignmentSide)
                  {
                     newString = alignmentSide.name;
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$stat":
                  stats = I18n.getUiText("ui.item.characteristics").split(",");
                  if(stats[params[nid]])
                  {
                     newString = stats[params[nid]];
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$dungeon":
                  dungeon = Dungeon.getDungeonById(params[nid]);
                  if(dungeon)
                  {
                     newString = dungeon.name;
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$time":
                  time = new Date();
                  timeToDisplay = params[nid] * 1000 - time.time;
                  if(timeToDisplay < 0)
                  {
                     timeToDisplay = 0;
                  }
                  newString = TimeManager.getInstance().getDuration(timeToDisplay,false,true);
                  break;
               case "$date":
                  newString = TimeManager.getInstance().formatDateIRL(params[nid] * 1000,true,false) + " " + TimeManager.getInstance().formatClock(params[nid] * 1000,false,true);
                  break;
               case "$companion":
               case "$sidekick":
                  companion = Companion.getCompanionById(params[nid]);
                  if(companion)
                  {
                     newString = companion.name;
                  }
                  else
                  {
                     _log.error(type + " " + params[nid] + " introuvable");
                     newString = "";
                  }
                  break;
               case "$breach":
                  newString = I18n.getUiText("ui.breach.roomNumber",[params[nid].room]) + ", " + I18n.getUiText("ui.breach.floor",[params[nid].floor]);
            }
         }
         return newString;
      }
   }
}
