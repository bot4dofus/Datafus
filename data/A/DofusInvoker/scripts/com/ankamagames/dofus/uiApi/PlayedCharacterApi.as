package com.ankamagames.dofus.uiApi
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.dofus.datacenter.appearance.Ornament;
   import com.ankamagames.dofus.datacenter.appearance.Title;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.optionalFeatures.CustomModeBreedSpell;
   import com.ankamagames.dofus.datacenter.optionalFeatures.ForgettableSpell;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.internalDatacenter.mount.MountData;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   import com.ankamagames.dofus.logic.game.common.frames.HouseFrame;
   import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SpellInventoryManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.TinselFrame;
   import com.ankamagames.dofus.logic.game.common.managers.DebtManager;
   import com.ankamagames.dofus.logic.game.common.managers.EntitiesLooksManager;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightPreparationFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.SpellManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.HavenbagFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.types.CharacterTooltipInformation;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.enums.AlignmentSideEnum;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.dofus.network.types.game.character.restriction.ActorRestrictionsInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionTitle;
   import com.ankamagames.dofus.network.types.game.data.items.ForgettableSpellItem;
   import com.ankamagames.dofus.network.types.game.social.application.SocialApplicationInformation;
   import com.ankamagames.dofus.types.data.PlayerSetInfo;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class PlayedCharacterApi implements IApi
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PlayedCharacterApi));
      
      private static var _instance:PlayedCharacterApi;
       
      
      public function PlayedCharacterApi()
      {
         super();
         MEMORY_LOG[this] = 1;
         _instance = this;
      }
      
      public static function getInstance() : PlayedCharacterApi
      {
         return _instance;
      }
      
      public function characteristics() : CharacterCharacteristicsInformations
      {
         return PlayedCharacterManager.getInstance().characteristics;
      }
      
      public function stats() : EntityStats
      {
         return StatsManager.getInstance().getStats(PlayedCharacterManager.getInstance().id);
      }
      
      public function getPlayedCharacterInfo() : Object
      {
         var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
         if(!i)
         {
            return null;
         }
         var o:Object = {};
         o.id = i.id;
         o.breed = i.breed;
         o.level = i.level;
         o.limitedLevel = PlayedCharacterManager.getInstance().limitedLevel;
         o.sex = i.sex;
         o.name = i.name;
         if(PlayedCharacterManager.getInstance().realEntityLook)
         {
            o.entityLook = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().realEntityLook);
         }
         else
         {
            o.entityLook = EntityLookAdapter.fromNetwork(i.entityLook);
         }
         o.realEntityLook = (o.entityLook as TiphonEntityLook).clone();
         if(this.isCreature() && PlayedCharacterManager.getInstance().realEntityLook)
         {
            o.entityLook = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().realEntityLook);
         }
         var ridderLook:TiphonEntityLook = TiphonEntityLook(o.entityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         if(ridderLook)
         {
            if(ridderLook.getBone() == 2)
            {
               ridderLook.setBone(1);
            }
            o.entityLook = ridderLook;
         }
         return o;
      }
      
      public function getInventory() : Vector.<ItemWrapper>
      {
         return InventoryManager.getInstance().realInventory;
      }
      
      public function getEquipment() : Array
      {
         var item:* = undefined;
         var equipment:Array = [];
         for each(item in PlayedCharacterManager.getInstance().inventory)
         {
            if(item.position <= CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD)
            {
               equipment.push(item);
            }
         }
         return equipment;
      }
      
      public function getSpellInventory() : Array
      {
         return PlayedCharacterManager.getInstance().spellsInventory;
      }
      
      public function getSpells(returnBreedSpells:Boolean) : Array
      {
         var spim:SpellInventoryManagementFrame = Kernel.getWorker().getFrame(SpellInventoryManagementFrame) as SpellInventoryManagementFrame;
         if(returnBreedSpells)
         {
            return spim.getBreedSpellsInVariantsArray();
         }
         return spim.getCommonSpellsInVariantsArray();
      }
      
      public function getPlayerForgettableSpells() : Dictionary
      {
         return PlayedCharacterManager.getInstance().playerForgettableSpellDictionary;
      }
      
      public function getPlayerMaxForgettableSpellsNumber() : int
      {
         return PlayedCharacterManager.getInstance().playerMaxForgettableSpellsNumber;
      }
      
      public function getForgettableSpells() : Array
      {
         return ForgettableSpell.getForgettableSpells();
      }
      
      public function getForgettableSpellById(id:int) : ForgettableSpell
      {
         return ForgettableSpell.getForgettableSpellById(id);
      }
      
      public function isForgettableSpellAvailable(id:int) : Boolean
      {
         var forgettableSpellItems:Dictionary = PlayedCharacterManager.getInstance().playerForgettableSpellDictionary;
         if(forgettableSpellItems === null)
         {
            return false;
         }
         var forgettableSpellItem:ForgettableSpellItem = forgettableSpellItems[id];
         if(forgettableSpellItem === null)
         {
            return false;
         }
         return forgettableSpellItem.available;
      }
      
      public function isForgettableSpell(spellId:int) : Boolean
      {
         return SpellManager.isForgettableSpell(spellId);
      }
      
      public function getCustomModeBreedSpellById(id:int) : CustomModeBreedSpell
      {
         return CustomModeBreedSpell.getCustomModeBreedSpellById(id);
      }
      
      public function getCustomModeSpellIds() : Array
      {
         return CustomModeBreedSpell.getAllCustomModeBreedSpellIds();
      }
      
      public function getCustomModeBreedSpellList(breedId:int) : Array
      {
         return CustomModeBreedSpell.getCustomModeBreedSpellList(breedId);
      }
      
      public function getBreedSpellActivatedIds() : Array
      {
         var spellWrapper:SpellWrapper = null;
         var spellsInventory:Array = PlayedCharacterManager.getInstance().spellsInventory;
         var activatedSpellIds:Array = [];
         var playerBreedId:int = PlayedCharacterManager.getInstance().infos.breed;
         var breedData:Breed = Breed.getBreedById(playerBreedId);
         var breedSpellsId:Array = breedData.allSpellsId;
         for each(spellWrapper in spellsInventory)
         {
            if(spellWrapper !== null)
            {
               if(spellWrapper.variantActivated && breedSpellsId.indexOf(spellWrapper.id) != -1)
               {
                  activatedSpellIds.push(spellWrapper.id);
               }
            }
         }
         return activatedSpellIds;
      }
      
      public function getMount() : MountData
      {
         return PlayedCharacterManager.getInstance().mount;
      }
      
      public function getPetsMount() : ItemWrapper
      {
         return PlayedCharacterManager.getInstance().petsMount;
      }
      
      public function getTitle() : Title
      {
         var title:Title = null;
         var playerInfo:GameRolePlayCharacterInformations = null;
         var option:* = undefined;
         var title2:Title = null;
         var titleId:int = (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).currentTitle;
         if(titleId)
         {
            return Title.getTitleById(titleId);
         }
         playerInfo = this.getEntityInfos();
         if(playerInfo && playerInfo.humanoidInfo)
         {
            for each(option in playerInfo.humanoidInfo.options)
            {
               if(option is HumanOptionTitle)
               {
                  titleId = option.titleId;
               }
            }
            return Title.getTitleById(titleId);
         }
         return null;
      }
      
      public function getOrnament() : Ornament
      {
         var ornament:Ornament = null;
         var ornamentId:int = (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).currentOrnament;
         if(ornamentId)
         {
            return Ornament.getOrnamentById(ornamentId);
         }
         return null;
      }
      
      public function getKnownTitles() : Vector.<uint>
      {
         return (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).knownTitles;
      }
      
      public function getKnownOrnaments() : Vector.<uint>
      {
         return (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).knownOrnaments;
      }
      
      public function titlesOrnamentsAskedBefore() : Boolean
      {
         return (Kernel.getWorker().getFrame(TinselFrame) as TinselFrame).titlesOrnamentsAskedBefore;
      }
      
      public function getEntityInfos() : GameRolePlayCharacterInformations
      {
         var entitiesFrame:AbstractEntitiesFrame = null;
         if(this.isInFight())
         {
            entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as AbstractEntitiesFrame;
         }
         else
         {
            entitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as AbstractEntitiesFrame;
         }
         if(!entitiesFrame)
         {
            return null;
         }
         return entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayCharacterInformations;
      }
      
      public function getEntityTooltipInfos() : CharacterTooltipInformation
      {
         var playerInfo:GameRolePlayCharacterInformations = this.getEntityInfos();
         if(!playerInfo)
         {
            return null;
         }
         return new CharacterTooltipInformation(playerInfo,0);
      }
      
      public function getKamasMaxLimit() : Number
      {
         var playedCharacterFrame:PlayedCharacterUpdatesFrame = Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame) as PlayedCharacterUpdatesFrame;
         if(playedCharacterFrame)
         {
            return playedCharacterFrame.kamasLimit;
         }
         return 0;
      }
      
      public function inventoryWeight() : uint
      {
         return PlayedCharacterManager.getInstance().inventoryWeight;
      }
      
      public function inventoryWeightMax() : uint
      {
         return PlayedCharacterManager.getInstance().inventoryWeightMax;
      }
      
      public function isIncarnation() : Boolean
      {
         return PlayedCharacterManager.getInstance().isIncarnation;
      }
      
      public function isMutated() : Boolean
      {
         return PlayedCharacterManager.getInstance().isMutated;
      }
      
      public function isInHouse() : Boolean
      {
         return PlayedCharacterManager.getInstance().isInHouse;
      }
      
      public function isIndoor() : Boolean
      {
         return PlayedCharacterManager.getInstance().isIndoor;
      }
      
      public function isInExchange() : Boolean
      {
         return PlayedCharacterManager.getInstance().isInExchange;
      }
      
      public function isInFight() : Boolean
      {
         return Kernel.getWorker().getFrame(FightContextFrame) != null;
      }
      
      public function isInPreFight() : Boolean
      {
         return Kernel.getWorker().contains(FightPreparationFrame) || Kernel.getWorker().isBeingAdded(FightPreparationFrame);
      }
      
      public function isSpectator() : Boolean
      {
         return PlayedCharacterManager.getInstance().isSpectator;
      }
      
      public function isInParty() : Boolean
      {
         return PlayedCharacterManager.getInstance().isInParty;
      }
      
      public function isPartyLeader() : Boolean
      {
         return PlayedCharacterManager.getInstance().isPartyLeader;
      }
      
      public function isRiding() : Boolean
      {
         return PlayedCharacterManager.getInstance().isRiding;
      }
      
      public function isPetsMounting() : Boolean
      {
         return PlayedCharacterManager.getInstance().isPetsMounting;
      }
      
      public function hasAutoPilot() : Boolean
      {
         var capacityCount:int = 0;
         var i:int = 0;
         var eff:EffectInstance = null;
         var mountInfo:MountData = this.getMount();
         var petsMountInfo:ItemWrapper = this.getPetsMount();
         if(this.isRiding() && mountInfo || this.isPetsMounting() && petsMountInfo)
         {
            if(PlayerManager.getInstance().hasFreeAutopilot)
            {
               return true;
            }
            if(this.isRiding())
            {
               capacityCount = mountInfo.ability.length;
               i = 0;
               if(capacityCount)
               {
                  for(i = 0; i < capacityCount; i++)
                  {
                     if(mountInfo.ability[i].id == DataEnum.MOUNT_CAPACITY_AUTOPILOT)
                     {
                        return true;
                     }
                  }
               }
            }
            else if(this.isPetsMounting())
            {
               if(petsMountInfo.effects.length)
               {
                  for each(eff in petsMountInfo.effects)
                  {
                     if(eff.effectId == ActionIds.ACTION_SELF_PILOTING)
                     {
                        return true;
                     }
                  }
               }
            }
         }
         return false;
      }
      
      public function hasCompanion() : Boolean
      {
         return PlayedCharacterManager.getInstance().hasCompanion;
      }
      
      public function id() : Number
      {
         return PlayedCharacterManager.getInstance().id;
      }
      
      public function restrictions() : ActorRestrictionsInformations
      {
         return PlayedCharacterManager.getInstance().restrictions;
      }
      
      public function isMutant() : Boolean
      {
         var rcf:RoleplayContextFrame = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
         var infos:GameRolePlayActorInformations = rcf.entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameRolePlayActorInformations;
         return infos is GameRolePlayMutantInformations;
      }
      
      public function publicMode() : Boolean
      {
         return PlayedCharacterManager.getInstance().publicMode;
      }
      
      public function artworkId() : int
      {
         return PlayedCharacterManager.getInstance().artworkId;
      }
      
      public function isCreature() : Boolean
      {
         return EntitiesLooksManager.getInstance().isCreature(this.id());
      }
      
      public function getBone() : uint
      {
         var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
         return EntityLookAdapter.fromNetwork(i.entityLook).getBone();
      }
      
      public function getSkin() : uint
      {
         var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
         if(EntityLookAdapter.fromNetwork(i.entityLook) && EntityLookAdapter.fromNetwork(i.entityLook).getSkins() && EntityLookAdapter.fromNetwork(i.entityLook).getSkins().length > 0)
         {
            return EntityLookAdapter.fromNetwork(i.entityLook).getSkins()[0];
         }
         return 0;
      }
      
      public function getColors() : Array
      {
         var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
         return EntityLookAdapter.fromNetwork(i.entityLook).getColors();
      }
      
      public function getSubentityColors() : Array
      {
         var i:CharacterBaseInformations = PlayedCharacterManager.getInstance().infos;
         var subTel:TiphonEntityLook = EntityLookAdapter.fromNetwork(i.entityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         if(!subTel && PlayedCharacterManager.getInstance().realEntityLook)
         {
            subTel = EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().realEntityLook).getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         }
         return !!subTel ? subTel.getColors() : null;
      }
      
      public function getAlignmentSide() : int
      {
         if(PlayedCharacterManager.getInstance().characteristics)
         {
            return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentSide;
         }
         return AlignmentSideEnum.ALIGNMENT_NEUTRAL;
      }
      
      public function getAlignmentValue() : uint
      {
         return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentValue;
      }
      
      public function getAlignmentAggressableStatus() : uint
      {
         return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable;
      }
      
      public function getAlignmentGrade() : uint
      {
         return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentGrade;
      }
      
      public function getMaxSummonedCreature() : uint
      {
         return CurrentPlayedFighterManager.getInstance().getMaxSummonedCreature();
      }
      
      public function getCurrentSummonedCreature() : uint
      {
         return CurrentPlayedFighterManager.getInstance().getCurrentSummonedCreature();
      }
      
      public function canSummon() : Boolean
      {
         return CurrentPlayedFighterManager.getInstance().canSummon();
      }
      
      public function getSpell(spellId:uint) : SpellWrapper
      {
         return CurrentPlayedFighterManager.getInstance().getSpellById(spellId);
      }
      
      public function canCastThisSpell(spellId:uint, lvl:uint) : Boolean
      {
         return CurrentPlayedFighterManager.getInstance().canCastThisSpell(spellId,lvl);
      }
      
      public function canCastThisSpellWithResult(spellId:uint, lvl:uint, target:Number = 0) : String
      {
         var resultA:Array = ["."];
         CurrentPlayedFighterManager.getInstance().canCastThisSpell(spellId,lvl,target,resultA);
         return resultA[0];
      }
      
      public function canCastThisSpellOnTarget(spellId:uint, lvl:uint, pTargetId:Number) : Boolean
      {
         return CurrentPlayedFighterManager.getInstance().canCastThisSpell(spellId,lvl,pTargetId);
      }
      
      public function isInHisHouse() : Boolean
      {
         return PlayedCharacterManager.getInstance().isInHisHouse;
      }
      
      public function getPlayerHouses() : Vector.<HouseWrapper>
      {
         return (Kernel.getWorker().getFrame(HouseFrame) as HouseFrame).accountHouses;
      }
      
      public function currentMap() : WorldPointWrapper
      {
         return PlayedCharacterManager.getInstance().currentMap;
      }
      
      public function previousMap() : WorldPointWrapper
      {
         return PlayedCharacterManager.getInstance().previousMap;
      }
      
      public function previousWorldMapId() : int
      {
         return PlayedCharacterManager.getInstance().previousWorldMapId;
      }
      
      public function previousSubArea() : SubArea
      {
         return PlayedCharacterManager.getInstance().previousSubArea;
      }
      
      public function currentSubArea() : SubArea
      {
         return PlayedCharacterManager.getInstance().currentSubArea;
      }
      
      public function isInTutorialArea() : Boolean
      {
         var subarea:SubArea = PlayedCharacterManager.getInstance().currentSubArea;
         return subarea && subarea.id == DataEnum.SUBAREA_TUTORIAL;
      }
      
      public function state() : uint
      {
         return PlayedCharacterManager.getInstance().state;
      }
      
      public function isAlive() : Boolean
      {
         return PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING;
      }
      
      public function getFollowingPlayerIds() : Vector.<Number>
      {
         return PlayedCharacterManager.getInstance().followingPlayerIds;
      }
      
      public function getPlayerSet(objectGID:uint) : PlayerSetInfo
      {
         return PlayedCharacterUpdatesFrame(Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame)).getPlayerSet(objectGID);
      }
      
      public function getWeapon() : WeaponWrapper
      {
         var build:BuildWrapper = null;
         var iw:ItemWrapper = null;
         if(InventoryManager.getInstance().currentBuildId != -1)
         {
            for each(build in InventoryManager.getInstance().builds)
            {
               if(build.id == InventoryManager.getInstance().currentBuildId)
               {
                  break;
               }
            }
            for each(iw in build.equipment)
            {
               if(iw is WeaponWrapper)
               {
                  break;
               }
            }
            if(iw as WeaponWrapper)
            {
               return iw as WeaponWrapper;
            }
            return null;
         }
         return PlayedCharacterManager.getInstance().currentWeapon;
      }
      
      public function getExperienceBonusPercent() : int
      {
         return PlayedCharacterManager.getInstance().experiencePercent + 100;
      }
      
      public function getAchievementPoints() : int
      {
         return PlayedCharacterManager.getInstance().achievementPoints;
      }
      
      public function getWaitingGifts() : Array
      {
         return PlayedCharacterManager.getInstance().waitingGifts;
      }
      
      public function isInHisHavenbag() : Boolean
      {
         return PlayedCharacterManager.getInstance().isInHisHavenbag;
      }
      
      public function isInHavenbag() : Boolean
      {
         return PlayedCharacterManager.getInstance().isInHavenbag;
      }
      
      public function havenbagSharePermissions() : uint
      {
         var hbFrame:HavenbagFrame = Kernel.getWorker().getFrame(HavenbagFrame) as HavenbagFrame;
         return hbFrame.sharePermissions;
      }
      
      public function isInBreach() : Boolean
      {
         return PlayedCharacterManager.getInstance().isInBreach;
      }
      
      public function isInBreachSubArea() : Boolean
      {
         return PlayedCharacterManager.getInstance().currentSubArea.id == 904 || PlayedCharacterManager.getInstance().currentSubArea.id == 938;
      }
      
      public function isInAnomaly() : Boolean
      {
         return PlayedCharacterManager.getInstance().isInAnomaly;
      }
      
      public function hasDebt() : Boolean
      {
         return DebtManager.getInstance().hasDebt();
      }
      
      public function getKamaDebt() : uint
      {
         return DebtManager.getInstance().getTotalKamaDebt();
      }
      
      public function getApplicationInfo() : SocialApplicationInformation
      {
         return PlayedCharacterManager.getInstance().applicationInfo;
      }
      
      public function getGuildApplicationInfo() : GuildInformations
      {
         return PlayedCharacterManager.getInstance().guildApplicationInfo;
      }
      
      public function getPlayerApplicationInformation() : Object
      {
         return {
            "guildInfo":PlayedCharacterManager.getInstance().guildApplicationInfo,
            "applicationInfo":PlayedCharacterManager.getInstance().applicationInfo
         };
      }
      
      public function isInKoli() : Boolean
      {
         return PlayedCharacterManager.getInstance().isInKoli;
      }
      
      public function guildChestLastContributionDate() : Number
      {
         return PlayedCharacterManager.getInstance().guildChestLastContributionDate;
      }
   }
}
