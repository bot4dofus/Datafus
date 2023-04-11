package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.items.Weapon;
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.datacenter.items.criterion.IItemCriterion;
   import com.ankamagames.dofus.datacenter.items.criterion.ItemCriterionOperator;
   import com.ankamagames.dofus.datacenter.items.criterion.StateCriterion;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.spell.SpellModifiers;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
   import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.SpellManager;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
   import com.ankamagames.dofus.network.enums.ShortcutBarEnum;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import damageCalculation.tools.StatIds;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public final class CurrentPlayedFighterManager
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(CurrentPlayedFighterManager));
      
      private static var _self:CurrentPlayedFighterManager;
       
      
      private var _currentFighterId:Number = 0;
      
      private var _currentFighterIsRealPlayer:Boolean = true;
      
      private var _characteristicsInformationsList:Dictionary;
      
      private var _spellCastInFightManagerList:Dictionary;
      
      private var _currentSummonedCreature:Dictionary;
      
      private var _currentSummonedBomb:Dictionary;
      
      public function CurrentPlayedFighterManager()
      {
         this._characteristicsInformationsList = new Dictionary();
         this._spellCastInFightManagerList = new Dictionary();
         this._currentSummonedCreature = new Dictionary();
         this._currentSummonedBomb = new Dictionary();
         super();
      }
      
      public static function getInstance() : CurrentPlayedFighterManager
      {
         if(_self == null)
         {
            _self = new CurrentPlayedFighterManager();
            _self.currentFighterId = PlayedCharacterManager.getInstance().id;
         }
         return _self;
      }
      
      public function get currentFighterId() : Number
      {
         return this._currentFighterId;
      }
      
      public function set currentFighterId(id:Number) : void
      {
         if(id == this._currentFighterId)
         {
            return;
         }
         var lastFighterId:Number = this._currentFighterId;
         this._currentFighterId = id;
         var playerManager:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         this._currentFighterIsRealPlayer = this._currentFighterId == playerManager.id;
         var lastFighterEntity:AnimatedCharacter = DofusEntities.getEntity(lastFighterId) as AnimatedCharacter;
         if(lastFighterEntity)
         {
            lastFighterEntity.setCanSeeThrough(false);
            lastFighterEntity.setCanWalkThrough(false);
            lastFighterEntity.setCanWalkTo(false);
         }
         var currentFighterEntity:AnimatedCharacter = DofusEntities.getEntity(this._currentFighterId) as AnimatedCharacter;
         if(currentFighterEntity)
         {
            currentFighterEntity.setCanSeeThrough(true);
            currentFighterEntity.setCanWalkThrough(true);
            currentFighterEntity.setCanWalkTo(true);
         }
         if(playerManager.isFighting)
         {
            this.updatePortrait(currentFighterEntity);
            if(playerManager.id != id || lastFighterId)
            {
               KernelEventsManager.getInstance().processCallback(FightHookList.SlaveStatsList,this.getCharacteristicsInformations());
            }
         }
      }
      
      public function checkPlayableEntity(id:Number) : Boolean
      {
         if(id == PlayedCharacterManager.getInstance().id)
         {
            return true;
         }
         return this._characteristicsInformationsList[id] != null;
      }
      
      public function isRealPlayer() : Boolean
      {
         return this._currentFighterIsRealPlayer;
      }
      
      public function resetPlayerSpellList() : void
      {
         var playerManager:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         var inventoryManager:InventoryManager = InventoryManager.getInstance();
         if(playerManager.spellsInventory != playerManager.playerSpellList)
         {
            _log.info("Remise à jour de la liste des sorts du joueur");
            playerManager.spellsInventory = playerManager.playerSpellList;
            KernelEventsManager.getInstance().processCallback(HookList.SpellListUpdate,playerManager.playerSpellList);
            if(Kernel.getWorker().contains(FightSpellCastFrame))
            {
               Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(FightSpellCastFrame));
            }
         }
         if(inventoryManager.shortcutBarSpells != playerManager.playerShortcutList)
         {
            inventoryManager.shortcutBarSpells = playerManager.playerShortcutList;
            KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,ShortcutBarEnum.SPELL_SHORTCUT_BAR);
         }
      }
      
      public function setCharacteristicsInformations(id:Number, characteristics:CharacterCharacteristicsInformations) : void
      {
         this._characteristicsInformationsList[id] = characteristics;
      }
      
      public function getCharacteristicsInformations(id:Number = 0) : CharacterCharacteristicsInformations
      {
         var player:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if(id)
         {
            if(id == player.id)
            {
               return player.characteristics;
            }
            return this._characteristicsInformationsList[id];
         }
         if(this._currentFighterIsRealPlayer || !player.isFighting)
         {
            return player.characteristics;
         }
         return this._characteristicsInformationsList[this._currentFighterId];
      }
      
      public function getStats(targetId:Number = NaN) : EntityStats
      {
         if(isNaN(targetId))
         {
            targetId = this._currentFighterId;
         }
         return StatsManager.getInstance().getStats(targetId);
      }
      
      public function getBasicTurnDuration() : int
      {
         var apBase:Number = NaN;
         var apAdditional:Number = NaN;
         var apBonus:Number = NaN;
         var mpBase:Number = NaN;
         var mpAdditional:Number = NaN;
         var mpBonus:Number = NaN;
         var totalTurnDurationInSeconds:int = 15;
         var stats:EntityStats = this.getStats(this._currentFighterId);
         if(stats)
         {
            apBase = stats.getStatBaseValue(StatIds.ACTION_POINTS);
            apAdditional = stats.getStatBaseValue(StatIds.ACTION_POINTS);
            apBonus = stats.getStatBaseValue(StatIds.ACTION_POINTS);
            mpBase = stats.getStatBaseValue(StatIds.ACTION_POINTS);
            mpAdditional = stats.getStatBaseValue(StatIds.ACTION_POINTS);
            mpBonus = stats.getStatBaseValue(StatIds.ACTION_POINTS);
            totalTurnDurationInSeconds += apBase + apAdditional + apBonus + mpBase + mpAdditional + mpBonus;
         }
         return totalTurnDurationInSeconds;
      }
      
      public function getSpellById(spellId:uint) : SpellWrapper
      {
         var thisSpell:SpellWrapper = null;
         var spellKnown:SpellWrapper = null;
         var player:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         for each(spellKnown in player.spellsInventory)
         {
            if(spellKnown.id == spellId)
            {
               return spellKnown;
            }
         }
         return null;
      }
      
      public function getSpellCastManager() : SpellCastInFightManager
      {
         var scm:SpellCastInFightManager = this._spellCastInFightManagerList[this._currentFighterId];
         if(!scm)
         {
            scm = new SpellCastInFightManager(this._currentFighterId);
            this._spellCastInFightManagerList[this._currentFighterId] = scm;
         }
         return scm;
      }
      
      public function getSpellCastManagerById(id:Number) : SpellCastInFightManager
      {
         var scm:SpellCastInFightManager = this._spellCastInFightManagerList[id];
         if(!scm)
         {
            scm = new SpellCastInFightManager(id);
            this._spellCastInFightManagerList[id] = scm;
         }
         return scm;
      }
      
      public function canCastThisSpell(spellId:uint, lvl:uint, pTargetId:Number = 0, result:Array = null) : Boolean
      {
         var thisSpell:SpellWrapper = null;
         var spellName:* = null;
         var spellKnown:SpellWrapper = null;
         var apCost:uint = 0;
         var maxCastPerTurn:uint = 0;
         var state:int = 0;
         var gic:GroupItemCriterion = null;
         var characteristics:CharacterCharacteristicsInformations = null;
         var weapon:Weapon = null;
         var currentState:SpellState = null;
         var weapon2:Weapon = null;
         var criterion:GroupItemCriterion = null;
         var isRequired:Boolean = false;
         var requiredStateCriterion:IItemCriterion = null;
         var cooldown:int = 0;
         var numberCastOnTarget:uint = 0;
         var spellModifiers:SpellModifiers = null;
         var bonus:Number = NaN;
         var spell:Spell = Spell.getSpellById(spellId);
         var spellLevel:SpellLevel = spell.getSpellLevel(lvl);
         if(spellLevel == null)
         {
            if(result)
            {
               result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.noSpell",[spellName]);
            }
            return false;
         }
         var player:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if(this._currentFighterIsRealPlayer)
         {
            if(spellId == 0)
            {
               if(player.currentWeapon)
               {
                  spellName = player.currentWeapon.name;
               }
               else
               {
                  spellName = spell.name;
               }
            }
            else
            {
               spellName = "{spell," + spellId + "," + lvl + "}";
            }
            if(spellLevel.minPlayerLevel > player.infos.level)
            {
               if(result)
               {
                  if(player.infos.level > ProtocolConstantsEnum.MAX_LEVEL)
                  {
                     result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.prestigeTooLow",[spellName,player.infos.level - ProtocolConstantsEnum.MAX_LEVEL]);
                  }
                  else
                  {
                     result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.levelTooLow",[spellName,player.infos.level]);
                  }
               }
               return false;
            }
            characteristics = this.getCharacteristicsInformations();
            if(!characteristics)
            {
               if(result)
               {
                  result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.notAvailableWithoutStats",[spellName]);
               }
               return false;
            }
         }
         for each(spellKnown in player.spellsInventory)
         {
            if(spellKnown && spellKnown.id == spellId)
            {
               thisSpell = spellKnown;
               break;
            }
         }
         if(!thisSpell)
         {
            if(result)
            {
               result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.notAvailable",[spellName]);
            }
            return false;
         }
         var entityStats:EntityStats = StatsManager.getInstance().getStats(this.currentFighterId);
         var currentPA:int = entityStats !== null ? int(entityStats.getStatTotalValue(StatIds.ACTION_POINTS)) : 0;
         if(spellId == 0 && player.currentWeapon != null)
         {
            weapon = Item.getItemById(player.currentWeapon.objectGID) as Weapon;
            if(!weapon)
            {
               if(result)
               {
                  result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.notAWeapon",[spellName]);
               }
               return false;
            }
            apCost = weapon.apCost;
            maxCastPerTurn = weapon.maxCastPerTurn;
         }
         else
         {
            apCost = thisSpell.apCost;
            maxCastPerTurn = thisSpell.maxCastPerTurn;
         }
         if(apCost > currentPA)
         {
            if(result)
            {
               result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.needAP",[spellName,apCost]);
            }
            return false;
         }
         var states:Array = FightersStateManager.getInstance().getStates(this._currentFighterId);
         if(!states)
         {
            states = new Array();
         }
         var _loc31_:int = 0;
         var _loc32_:* = states;
         loop1:
         while(true)
         {
            for each(state in _loc32_)
            {
               currentState = SpellState.getSpellStateById(state);
               if(currentState.preventsFight && spellId == 0)
               {
                  if(result)
                  {
                     result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.stateForbidden",[spellName,currentState.name]);
                  }
                  return false;
               }
               if(currentState.id == DataEnum.SPELL_STATE_ARCHER && spellId == 0)
               {
                  weapon2 = Item.getItemById(player.currentWeapon.objectGID) as Weapon;
                  if(weapon2.typeId != DataEnum.ITEM_TYPE_BOW)
                  {
                     if(result)
                     {
                        result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.stateForbidden",[spellName,currentState.name]);
                     }
                     return false;
                  }
               }
               if(currentState.preventsSpellCast)
               {
                  if(!spellLevel.statesCriterion || spellLevel.statesCriterion == "")
                  {
                     if(result)
                     {
                        result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.stateForbidden",[spellName,currentState.name]);
                     }
                     return false;
                  }
                  criterion = new GroupItemCriterion(spellLevel.statesCriterion);
                  isRequired = false;
                  for each(requiredStateCriterion in criterion.criteria)
                  {
                     if(requiredStateCriterion is StateCriterion && StateCriterion(requiredStateCriterion).operatorText == ItemCriterionOperator.EQUAL)
                     {
                        if(int(StateCriterion(requiredStateCriterion).criterionValue) == currentState.id)
                        {
                           isRequired = true;
                           break;
                        }
                     }
                  }
                  if(!isRequired)
                  {
                     break loop1;
                  }
               }
            }
            gic = new GroupItemCriterion(spellLevel.statesCriterion);
            if(!gic.isRespected)
            {
               if(result)
               {
                  result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.notAvailable",[spellName]);
               }
               return false;
            }
            if(!spell.bypassSummoningLimit && spellLevel.canSummon && !this.canSummon())
            {
               if(result)
               {
                  result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.tooManySummon",[spellName]);
               }
               return false;
            }
            if(spellLevel.canBomb && !this.canBomb())
            {
               if(result)
               {
                  result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.tooManyBomb",[spellName]);
               }
               return false;
            }
            if(!player.isFighting)
            {
               if(result)
               {
                  result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.available",[spellName]);
               }
               return true;
            }
            var spellCastManager:SpellCastInFightManager = this.getSpellCastManager();
            var spellManager:SpellManager = spellCastManager.getSpellManagerBySpellId(spellId);
            if(spellManager == null)
            {
               if(result)
               {
                  result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.available",[spellName]);
               }
               return true;
            }
            if(maxCastPerTurn <= spellManager.numberCastThisTurn && maxCastPerTurn > 0)
            {
               if(result)
               {
                  result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.castPerTurn",[spellName,maxCastPerTurn]);
               }
               return false;
            }
            if(spellManager.cooldown > 0 || thisSpell.actualCooldown > 0)
            {
               cooldown = Math.max(spellManager.cooldown,thisSpell.actualCooldown);
               if(result)
               {
                  if(cooldown == 63)
                  {
                     result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.noCast",[spellName]);
                  }
                  else
                  {
                     result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.cooldown",[spellName,cooldown]);
                  }
               }
               return false;
            }
            if(pTargetId != 0)
            {
               numberCastOnTarget = spellManager.getCastOnEntity(pTargetId);
               spellModifiers = SpellModifiersManager.getInstance().getSpellModifiers(this.currentFighterId,spellId);
               bonus = !!spellModifiers ? Number(spellModifiers.getModifierValue(CharacterSpellModificationTypeEnum.MAX_CAST_PER_TARGET)) : Number(0);
               if(spellLevel.maxCastPerTarget + bonus <= numberCastOnTarget && spellLevel.maxCastPerTarget > 0)
               {
                  if(result)
                  {
                     result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.castPerTarget",[spellName]);
                  }
                  return false;
               }
            }
            if(result)
            {
               result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.available",[spellName]);
            }
            return true;
         }
         if(result)
         {
            result[0] = I18n.getUiText("ui.fightAutomsg.spellcast.stateForbidden",[spellName,currentState.name]);
         }
         return false;
      }
      
      public function endFight() : void
      {
         if(PlayedCharacterManager.getInstance().id != this._currentFighterId)
         {
            this.currentFighterId = PlayedCharacterManager.getInstance().id;
            this.resetPlayerSpellList();
            this.updatePortrait(DofusEntities.getEntity(this._currentFighterId) as AnimatedCharacter);
         }
         this._currentFighterId = 0;
         this._characteristicsInformationsList = new Dictionary();
         this._spellCastInFightManagerList = new Dictionary();
         this._currentSummonedCreature = new Dictionary();
         this._currentSummonedBomb = new Dictionary();
      }
      
      public function getCurrentSummonedCreature(id:Number = NaN) : uint
      {
         if(isNaN(id))
         {
            id = this._currentFighterId;
         }
         return this._currentSummonedCreature[id];
      }
      
      public function setCurrentSummonedCreature(value:uint, id:Number = NaN) : void
      {
         if(isNaN(id))
         {
            id = this._currentFighterId;
         }
         this._currentSummonedCreature[id] = value;
      }
      
      public function getCurrentSummonedBomb(id:Number = 0) : uint
      {
         if(!id)
         {
            id = this._currentFighterId;
         }
         return this._currentSummonedBomb[id];
      }
      
      public function setCurrentSummonedBomb(value:uint, id:Number = 0) : void
      {
         if(!id)
         {
            id = this._currentFighterId;
         }
         this._currentSummonedBomb[id] = value;
      }
      
      public function resetSummonedCreature(id:Number = NaN) : void
      {
         this.setCurrentSummonedCreature(0,id);
      }
      
      public function addSummonedCreature(id:Number = NaN) : void
      {
         this.setCurrentSummonedCreature(this.getCurrentSummonedCreature(id) + 1,id);
      }
      
      public function removeSummonedCreature(id:Number = NaN) : void
      {
         if(this.getCurrentSummonedCreature(id) > 0)
         {
            this.setCurrentSummonedCreature(this.getCurrentSummonedCreature(id) - 1,id);
         }
      }
      
      public function getMaxSummonedCreature(id:Number = NaN) : uint
      {
         var stats:EntityStats = this.getStats(id);
         if(stats === null)
         {
            return 0;
         }
         return stats.getStatTotalValue(StatIds.MAX_SUMMONED_CREATURES_BOOST) - stats.getStatAdditionalValue(StatIds.MAX_SUMMONED_CREATURES_BOOST);
      }
      
      public function canSummon(id:Number = NaN) : Boolean
      {
         return this.getMaxSummonedCreature(id) > this.getCurrentSummonedCreature(id);
      }
      
      public function resetSummonedBomb(id:Number = 0) : void
      {
         this.setCurrentSummonedBomb(0,id);
      }
      
      public function addSummonedBomb(id:Number = 0) : void
      {
         this.setCurrentSummonedBomb(this.getCurrentSummonedBomb(id) + 1,id);
      }
      
      public function removeSummonedBomb(id:Number = 0) : void
      {
         if(this.getCurrentSummonedBomb(id) > 0)
         {
            this.setCurrentSummonedBomb(this.getCurrentSummonedBomb(id) - 1,id);
         }
      }
      
      public function canBomb(id:Number = 0) : Boolean
      {
         return this.getMaxSummonedBomb() > this.getCurrentSummonedBomb(id);
      }
      
      private function getMaxSummonedBomb() : uint
      {
         return 3;
      }
      
      private function updatePortrait(currentFighterEntity:AnimatedCharacter) : void
      {
         if(this._currentFighterIsRealPlayer)
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.ShowMonsterArtwork,0);
         }
         else if(currentFighterEntity)
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.ShowMonsterArtwork,currentFighterEntity.look.getBone());
         }
      }
   }
}
