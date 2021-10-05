package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.items.Incarnation;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.SwitchCreatureModeAction;
   import com.ankamagames.dofus.logic.game.common.managers.EntitiesLooksManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.types.EntityIcon;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.utils.LookCleaner;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.look.SubEntity;
   import com.ankamagames.dofus.types.entities.AnimStatiqueSubEntityBehavior;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.entities.BreedSkinModifier;
   import com.ankamagames.dofus.types.entities.CustomBreedAnimationModifier;
   import com.ankamagames.dofus.types.entities.RiderBehavior;
   import com.ankamagames.dofus.types.entities.UnderWaterAnimationModifier;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.types.enums.EntityIconEnum;
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.enum.OptionEnum;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.Rectangle2;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.tiphon.types.ISkinModifier;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class AbstractEntitiesFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractEntitiesFrame));
      
      protected static const ICONS_FILEPATH_CONQUEST:String = XmlConfig.getInstance().getEntry("config.content.path") + "gfx/icons/conquestIcon.swf|";
      
      protected static const ICONS_FILEPATH_STATE:String = XmlConfig.getInstance().getEntry("config.content.path") + "gfx/icons/stateBuffs.swf|";
      
      protected static const ICONS_FILEPATH:String = XmlConfig.getInstance().getEntry("config.content.path") + "gfx/icons/icons.swf|";
      
      protected static const MAX_LOOP_COUNT:Number = 50;
       
      
      protected var _entities:Dictionary;
      
      protected var _entitiesTotal:int;
      
      protected var _creaturesMode:Boolean = false;
      
      protected var _creaturesLimit:int = -1;
      
      protected var _entitiesVisibleNumber:uint = 0;
      
      protected var _customBreedAnimationModifier:IAnimationModifier;
      
      protected var _underWaterAnimationModifier:IAnimationModifier;
      
      protected var _skinModifier:ISkinModifier;
      
      protected var _untargetableEntities:Boolean = false;
      
      protected var _interactiveElements:Vector.<InteractiveElement>;
      
      protected var _currentSubAreaId:uint;
      
      protected var _worldPoint:WorldPointWrapper;
      
      protected var _creaturesFightMode:Boolean = false;
      
      protected var _justSwitchingCreaturesFightMode:Boolean = false;
      
      protected var _entitiesIconsCounts:Dictionary;
      
      protected var _entitiesIconsNames:Dictionary;
      
      protected var _entitiesIcons:Dictionary;
      
      protected var _entitiesIconsOffsets:Dictionary;
      
      protected var _carriedEntities:Dictionary;
      
      protected var _pendingCarriedEntities:Dictionary;
      
      protected var _updateAllIcons:Boolean;
      
      protected var _showIcons:Boolean = true;
      
      protected var _isShowIconsChanged:Boolean = false;
      
      public function AbstractEntitiesFrame()
      {
         this._customBreedAnimationModifier = new CustomBreedAnimationModifier();
         this._underWaterAnimationModifier = new UnderWaterAnimationModifier();
         this._skinModifier = new BreedSkinModifier();
         this._entitiesIconsCounts = new Dictionary();
         this._entitiesIconsNames = new Dictionary();
         this._entitiesIcons = new Dictionary();
         this._entitiesIconsOffsets = new Dictionary();
         this._carriedEntities = new Dictionary();
         this._pendingCarriedEntities = new Dictionary();
         super();
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function set untargetableEntities(enabled:Boolean) : void
      {
         var infos:GameContextActorInformations = null;
         var entity:AnimatedCharacter = null;
         this._untargetableEntities = enabled;
         for each(infos in this._entities)
         {
            entity = DofusEntities.getEntity(infos.contextualId) as AnimatedCharacter;
            if(entity)
            {
               entity.mouseEnabled = !enabled;
            }
         }
      }
      
      public function get untargetableEntities() : Boolean
      {
         return this._untargetableEntities;
      }
      
      public function get interactiveElements() : Vector.<InteractiveElement>
      {
         return this._interactiveElements;
      }
      
      public function get justSwitchingCreaturesFightMode() : Boolean
      {
         return this._justSwitchingCreaturesFightMode;
      }
      
      public function get creaturesLimit() : int
      {
         return this._creaturesLimit;
      }
      
      public function get entitiesNumber() : int
      {
         return this._entitiesVisibleNumber;
      }
      
      public function get creaturesMode() : Boolean
      {
         return this._creaturesMode;
      }
      
      public function get entities() : Dictionary
      {
         return this._entities;
      }
      
      public function pushed() : Boolean
      {
         this._entities = new Dictionary();
         this._entitiesTotal = 0;
         this._skinModifier = new BreedSkinModifier();
         this._showIcons = OptionManager.getOptionManager("dofus").getOption("toggleEntityIcons");
         this._creaturesLimit = OptionManager.getOptionManager("tiphon").getOption("creaturesMode");
         EntitiesLooksManager.getInstance().entitiesFrame = this;
         OptionManager.getOptionManager("atouin").addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onAtouinOptionChange);
         OptionManager.getOptionManager("dofus").addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onDofusOptionsChange);
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         throw new AbstractMethodCallError();
      }
      
      public function pulled() : Boolean
      {
         this.removeAllIcons();
         this._entities = null;
         this._entitiesTotal = 0;
         Atouin.getInstance().clearEntities();
         OptionManager.getOptionManager("atouin").removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onAtouinOptionChange);
         OptionManager.getOptionManager("dofus").removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onDofusOptionsChange);
         return true;
      }
      
      public function getEntityInfos(entityId:Number) : GameContextActorInformations
      {
         if(entityId == 0 || isNaN(entityId))
         {
            return null;
         }
         if(!this._entities || !this._entitiesTotal)
         {
            return null;
         }
         if(!this._entities[entityId])
         {
            if(entityId <= EntitiesManager.RANDOM_ENTITIES_ID_START)
            {
               return null;
            }
            _log.error("Entity " + entityId + " is unknown.");
            return null;
         }
         return this._entities[entityId];
      }
      
      public function getEntitiesIdsList() : Vector.<Number>
      {
         var gcai:GameContextActorInformations = null;
         var entitiesList:Vector.<Number> = new Vector.<Number>(0,false);
         for each(gcai in this._entities)
         {
            entitiesList.push(gcai.contextualId);
         }
         return entitiesList;
      }
      
      public function getEntitiesDictionnary() : Dictionary
      {
         return this._entities;
      }
      
      public function hasEntity(entityId:Number) : Boolean
      {
         return this._entities !== null && this._entitiesTotal > 0 && entityId in this._entities;
      }
      
      public function registerActor(infos:GameContextActorInformations) : void
      {
         this.registerActorWithId(infos,infos.contextualId);
      }
      
      public function registerActorWithId(infos:GameContextActorInformations, actorId:Number) : void
      {
         if(this._entities == null)
         {
            this._entities = new Dictionary();
         }
         if(!this._entities[actorId])
         {
            ++this._entitiesTotal;
         }
         this._entities[actorId] = infos;
         if(infos is GameFightFighterInformations)
         {
            StatsManager.getInstance().addRawStats(actorId,(infos as GameFightFighterInformations).stats.characteristics.characteristics);
         }
      }
      
      public function unregisterActor(actorId:Number) : void
      {
         var entity:IEntity = null;
         if(this._entities[actorId])
         {
            entity = DofusEntities.getEntity(actorId);
            if(entity != null && entity is AnimatedCharacter)
            {
               (entity as AnimatedCharacter).removeEventListener(TiphonEvent.PLAYANIM_EVENT,this.onPlayAnim);
            }
            --this._entitiesTotal;
         }
         delete this._entities[actorId];
         StatsManager.getInstance().deleteStats(actorId);
      }
      
      public function addOrUpdateActor(infos:GameContextActorInformations, animationModifier:IAnimationModifier = null) : AnimatedCharacter
      {
         var newLook:TiphonEntityLook = null;
         var positionUpdated:Boolean = false;
         var entitylook:EntityLook = null;
         var humanoid:GameRolePlayHumanoidInformations = null;
         var characterEntity:AnimatedCharacter = DofusEntities.getEntity(infos.contextualId) as AnimatedCharacter;
         var justCreated:Boolean = true;
         var merchantCreature:Boolean = this._creaturesMode && infos is GameRolePlayMerchantInformations;
         var playerCreature:Boolean = infos.contextualId == PlayedCharacterManager.getInstance().id && (this._creaturesMode || this._creaturesFightMode);
         var mapPosition:MapPosition = MapPosition.getMapPositionById(PlayedCharacterManager.getInstance().currentMap.mapId);
         if(mapPosition && mapPosition.isUnderWater)
         {
            this.addUnderwaterBubblesToEntityLook(infos.look);
         }
         this.registerActor(infos);
         if(infos is GameFightFighterInformations)
         {
            StatsManager.getInstance().addRawStats(infos.contextualId,(infos as GameFightFighterInformations).stats.characteristics.characteristics);
         }
         if(!characterEntity || merchantCreature || playerCreature)
         {
            newLook = EntitiesLooksManager.getInstance().getLookFromContextInfos(infos);
         }
         PlayedCharacterManager.getInstance().realEntityLook = PlayedCharacterManager.getInstance().infos.entityLook;
         if(characterEntity == null)
         {
            newLook.skinModifier = this._skinModifier;
            characterEntity = new AnimatedCharacter(infos.contextualId,newLook);
            characterEntity.addEventListener(TiphonEvent.PLAYANIM_EVENT,this.onPlayAnim);
            if(OptionManager.getOptionManager("atouin").getOption("useLowDefSkin"))
            {
               characterEntity.setAlternativeSkinIndex(0,true);
            }
            if(newLook.getBone() == 1)
            {
               if(animationModifier)
               {
                  characterEntity.addAnimationModifier(animationModifier);
               }
               else
               {
                  characterEntity.addAnimationModifier(this._customBreedAnimationModifier);
               }
               if(mapPosition && mapPosition.isUnderWater)
               {
                  characterEntity.addAnimationModifier(this._underWaterAnimationModifier);
               }
            }
            characterEntity.skinModifier = this._skinModifier;
            if(infos is GameFightMonsterInformations)
            {
               characterEntity.speedAdjust = Monster.getMonsterById(GameFightMonsterInformations(infos).creatureGenericId).speedAdjust;
            }
            if(infos.contextualId == PlayedCharacterManager.getInstance().id)
            {
               entitylook = EntityLookAdapter.toNetwork(newLook);
               if(!EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook).equals(newLook))
               {
                  PlayedCharacterManager.getInstance().infos.entityLook = entitylook;
                  KernelEventsManager.getInstance().processCallback(HookList.PlayedCharacterLookChange,newLook);
               }
            }
         }
         else
         {
            justCreated = false;
            if(merchantCreature)
            {
               characterEntity.look.updateFrom(newLook);
            }
            else
            {
               this.updateActorLook(infos.contextualId,infos.look,true);
            }
         }
         if(infos is GameRolePlayHumanoidInformations)
         {
            humanoid = infos as GameRolePlayHumanoidInformations;
            if(infos.contextualId == PlayedCharacterManager.getInstance().id)
            {
               PlayedCharacterManager.getInstance().restrictions = humanoid.humanoidInfo.restrictions;
            }
         }
         if(!this._creaturesFightMode && !this._creaturesMode && characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER) && characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER).length)
         {
            characterEntity.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,new RiderBehavior());
         }
         if(!this._creaturesFightMode && !this._creaturesMode && characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET) && characterEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET).length)
         {
            characterEntity.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET,new AnimStatiqueSubEntityBehavior());
         }
         if(infos.disposition.cellId != -1 && !(characterEntity.parentSprite && characterEntity.parentSprite.carriedEntity == characterEntity))
         {
            if(!characterEntity.position || characterEntity.position.cellId != infos.disposition.cellId)
            {
               positionUpdated = true;
            }
            characterEntity.position = MapPoint.fromCellId(infos.disposition.cellId);
         }
         if((justCreated || !characterEntity.root || positionUpdated) && !characterEntity.isMoving)
         {
            characterEntity.setDirection(infos.disposition.direction);
            characterEntity.display(PlacementStrataEnums.STRATA_PLAYER);
         }
         if(PlayedCharacterManager.getInstance().id == characterEntity.id)
         {
            SoundManager.getInstance().manager.setSoundSourcePosition(characterEntity.id,new Point(characterEntity.x,characterEntity.y));
         }
         characterEntity.visibleAura = !characterEntity.isMoving && OptionManager.getOptionManager("tiphon").getOption("auraMode") >= OptionEnum.AURA_ALWAYS;
         characterEntity.mouseEnabled = !this.untargetableEntities;
         return characterEntity;
      }
      
      protected function updateActorLook(actorId:Number, newLook:EntityLook, smoke:Boolean = false) : AnimatedCharacter
      {
         var tel:TiphonEntityLook = null;
         var entity:GameContextActorInformations = null;
         var oldBone:int = 0;
         var sequencer:SerialSequencer = null;
         var addGfxStep:AddGfxEntityStep = null;
         var mapPosition:MapPosition = null;
         var animatedCarriedCharacter:AnimatedCharacter = null;
         if(this._entities[actorId])
         {
            entity = this._entities[actorId] as GameContextActorInformations;
            oldBone = entity.look.bonesId;
            entity.look = newLook;
            if(smoke && newLook.bonesId != oldBone)
            {
               sequencer = new SerialSequencer();
               addGfxStep = new AddGfxEntityStep(1165,DofusEntities.getEntity(actorId).position.cellId);
               sequencer.addStep(addGfxStep);
               sequencer.start();
            }
         }
         else
         {
            _log.warn("Cannot update unknown actor look (" + actorId + ") in informations.");
         }
         var ac:AnimatedCharacter = DofusEntities.getEntity(actorId) as AnimatedCharacter;
         if(ac)
         {
            ac.addEventListener(TiphonEvent.RENDER_FAILED,this.onUpdateEntityFail,false,0,false);
            ac.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onUpdateEntitySuccess,false,0,false);
            tel = EntitiesLooksManager.getInstance().getLookFromContextInfos(this._entities[actorId]);
            if(tel.getBone() != 1)
            {
               ac.removeAnimationModifier(this._customBreedAnimationModifier);
            }
            else
            {
               ac.addAnimationModifier(this._customBreedAnimationModifier);
               mapPosition = MapPosition.getMapPositionById(PlayedCharacterManager.getInstance().currentMap.mapId);
               if(mapPosition.isUnderWater)
               {
                  ac.addAnimationModifier(this._underWaterAnimationModifier);
               }
            }
            ac.enableSubCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,!this._creaturesFightMode);
            ac.look.updateFrom(tel);
            if(this._creaturesMode || this._creaturesFightMode)
            {
               ac.setAnimation(AnimationEnum.ANIM_STATIQUE);
            }
            else
            {
               ac.setAnimation(ac.getAnimation());
            }
            if(ac.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET) && ac.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET).length)
            {
               ac.setSubEntityBehaviour(1,new AnimStatiqueSubEntityBehavior());
            }
            if(ac.carriedEntity)
            {
               animatedCarriedCharacter = ac.carriedEntity as AnimatedCharacter;
               if(animatedCarriedCharacter)
               {
                  this._carriedEntities[animatedCarriedCharacter.id] = ac;
               }
            }
         }
         else
         {
            _log.warn("Cannot update unknown actor look (" + actorId + ") in the game world.");
         }
         if(actorId == PlayedCharacterManager.getInstance().id && tel)
         {
            PlayedCharacterManager.getInstance().realEntityLook = PlayedCharacterManager.getInstance().infos.entityLook;
            PlayedCharacterManager.getInstance().infos.entityLook = newLook;
            KernelEventsManager.getInstance().processCallback(HookList.PlayedCharacterLookChange,LookCleaner.clean(tel));
         }
         return ac;
      }
      
      protected function updateActorDisposition(actorId:Number, newDisposition:EntityDispositionInformations) : void
      {
         if(this._entities[actorId])
         {
            (this._entities[actorId] as GameContextActorInformations).disposition = newDisposition;
         }
         else
         {
            _log.warn("Cannot update unknown actor disposition (" + actorId + ") in informations.");
         }
         var actor:IEntity = DofusEntities.getEntity(actorId);
         if(actor)
         {
            if(actor is IMovable && newDisposition.cellId >= 0)
            {
               if(actor is TiphonSprite && (actor as TiphonSprite).rootEntity && (actor as TiphonSprite).rootEntity != actor)
               {
                  _log.debug("PAS DE SYNCHRO pour " + (actor as TiphonSprite).name + " car entité portée");
               }
               else
               {
                  IMovable(actor).jump(MapPoint.fromCellId(newDisposition.cellId));
               }
            }
            if(actor is IAnimated)
            {
               IAnimated(actor).setDirection(newDisposition.direction);
            }
         }
         else
         {
            _log.warn("Cannot update unknown actor disposition (" + actorId + ") in the game world.");
         }
      }
      
      protected function updateActorOrientation(actorId:Number, newOrientation:uint) : void
      {
         var displayAura:Boolean = false;
         if(this._entities[actorId])
         {
            (this._entities[actorId] as GameContextActorInformations).disposition.direction = newOrientation;
         }
         else
         {
            _log.warn("Cannot update unknown actor orientation (" + actorId + ") in informations.");
         }
         var ac:AnimatedCharacter = DofusEntities.getEntity(actorId) as AnimatedCharacter;
         if(ac)
         {
            displayAura = false;
            if(OptionManager.getOptionManager("tiphon").getOption("auraMode") >= OptionEnum.AURA_ALWAYS && OptionManager.getOptionManager("tiphon").getOption("alwaysShowAuraOnFront") && newOrientation == DirectionsEnum.DOWN)
            {
               displayAura = true;
            }
            ac.visibleAura = displayAura;
            ac.setDirection(newOrientation);
         }
         else
         {
            _log.warn("Cannot update unknown actor orientation (" + actorId + ") in the game world.");
         }
      }
      
      protected function hideActor(actorId:Number) : void
      {
         var disp:IDisplayable = DofusEntities.getEntity(actorId) as IDisplayable;
         if(disp)
         {
            disp.remove();
         }
         else
         {
            _log.warn("Cannot remove an unknown actor (" + actorId + ").");
         }
      }
      
      protected function removeActor(actorId:Number) : void
      {
         this.hideActor(actorId);
         var tiphonSprite:TiphonSprite = DofusEntities.getEntity(actorId) as TiphonSprite;
         if(tiphonSprite)
         {
            tiphonSprite.destroy();
         }
         this.updateCreaturesLimit();
         this.unregisterActor(actorId);
         if(this.switchPokemonMode())
         {
            _log.debug("switch pokemon/normal mode");
         }
      }
      
      protected function switchPokemonMode() : Boolean
      {
         var action:SwitchCreatureModeAction = null;
         this._entitiesVisibleNumber = EntitiesManager.getInstance().entitiesCount;
         if(this._creaturesLimit > -1 && this._creaturesMode != (!Kernel.getWorker().getFrame(FightEntitiesFrame) && this._creaturesLimit < 50 && this._entitiesVisibleNumber >= this._creaturesLimit))
         {
            action = SwitchCreatureModeAction.create(!this._creaturesMode);
            Kernel.getWorker().process(action);
            return true;
         }
         return false;
      }
      
      protected function updateCreaturesLimit() : void
      {
         var vingtpourcent:Number = NaN;
         this._creaturesLimit = OptionManager.getOptionManager("tiphon").getOption("creaturesMode");
         if(this._creaturesMode && this._creaturesLimit > 0)
         {
            vingtpourcent = this._creaturesLimit * 20 / 100;
            this._creaturesLimit = Math.ceil(this._creaturesLimit - vingtpourcent);
         }
      }
      
      public function addEntityIcon(pEntityId:Number, pIconName:String, pIconCategory:int = 0, offsetX:Number = 0, offsetY:Number = 0, turnsRemaining:Number = -1) : void
      {
         if(!this._entitiesIconsNames[pEntityId])
         {
            this._entitiesIconsNames[pEntityId] = new Dictionary();
            this._entitiesIconsNames[pEntityId][EntityIconEnum.TURN_REMAINING] = new Dictionary();
            this._entitiesIconsCounts[pEntityId] = new Dictionary();
         }
         if(!this._entitiesIconsNames[pEntityId][pIconCategory])
         {
            this._entitiesIconsNames[pEntityId][pIconCategory] = new Vector.<String>(0);
         }
         if(this._entitiesIconsNames[pEntityId][pIconCategory].indexOf(pIconName) == -1)
         {
            this._entitiesIconsNames[pEntityId][pIconCategory].push(pIconName);
         }
         if(!this._entitiesIconsCounts[pEntityId][pIconName])
         {
            this._entitiesIconsCounts[pEntityId][pIconName] = 1;
         }
         else
         {
            ++this._entitiesIconsCounts[pEntityId][pIconName];
         }
         if(this._entitiesIcons[pEntityId])
         {
            this._entitiesIcons[pEntityId].needUpdate = true;
         }
         if((offsetX != 0 || offsetY != 0) && !this._entitiesIconsOffsets[pIconName])
         {
            this._entitiesIconsOffsets[pIconName] = new Point(offsetX,offsetY);
         }
         if(turnsRemaining != -1)
         {
            this._entitiesIconsNames[pEntityId][EntityIconEnum.TURN_REMAINING][pIconName] = turnsRemaining;
         }
         EnterFrameDispatcher.addEventListener(this.showIcons,EnterFrameConst.SHOW_ICONS,250);
      }
      
      public function updateAllIcons() : void
      {
         this._updateAllIcons = true;
         this.showIcons();
      }
      
      public function forceIconUpdate(pEntityId:Number) : void
      {
         if(this._entitiesIcons[pEntityId])
         {
            this._entitiesIcons[pEntityId].needUpdate = true;
         }
      }
      
      protected function removeAllIcons() : void
      {
         var id:* = undefined;
         var ids:Array = [];
         for(id in this._entitiesIconsNames)
         {
            ids.push(id);
         }
         for each(id in ids)
         {
            this.removeIcon(id,null,true);
         }
         EnterFrameDispatcher.removeEventListener(this.showIcons);
      }
      
      public function removeIcon(pEntityId:Number, pIconName:String = null, pForce:Boolean = false) : void
      {
         var id:* = undefined;
         var iconName:* = undefined;
         var charac:AnimatedCharacter = null;
         var numIcons:uint = 0;
         var pasmisS:* = null;
         var cat:* = undefined;
         var index:int = 0;
         var i:int = 0;
         var entity:AnimatedCharacter = null;
         if(pIconName && this._entitiesIconsCounts[pEntityId] && this._entitiesIconsCounts[pEntityId][pIconName] && this._entitiesIconsCounts[pEntityId][pIconName] > 1)
         {
            --this._entitiesIconsCounts[pEntityId][pIconName];
            if(!pForce)
            {
               return;
            }
         }
         if(!this._entitiesIconsCounts[pEntityId] || pIconName && !this._entitiesIconsCounts[pEntityId][pIconName])
         {
            return;
         }
         if(this._entitiesIconsCounts[pEntityId])
         {
            if(!pIconName)
            {
               delete this._entitiesIconsCounts[pEntityId];
               delete this._entitiesIconsNames[pEntityId];
               if(this._entitiesIcons[pEntityId])
               {
                  charac = DofusEntities.getEntity(pEntityId) as AnimatedCharacter;
                  if(charac)
                  {
                     charac.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.updateIconAfterRender);
                     charac.removeEventListener(TiphonEvent.ANIMATION_PICKUP_END,this.onAnimationPickupEnd);
                     charac.removeEventListener(TiphonEvent.ANIMATION_PICKUP_START,this.onAnimationPickupStart);
                  }
                  this._entitiesIcons[pEntityId].remove();
               }
               delete this._entitiesIcons[pEntityId];
            }
            else
            {
               delete this._entitiesIconsCounts[pEntityId][pIconName];
               numIcons = 0;
               for(pasmisS in this._entitiesIconsCounts[pEntityId])
               {
                  numIcons++;
               }
               if(!numIcons)
               {
                  delete this._entitiesIconsCounts[pEntityId];
               }
               for(cat in this._entitiesIconsNames[pEntityId])
               {
                  if(cat !== EntityIconEnum.TURN_REMAINING && this._entitiesIconsNames[pEntityId][cat] && this._entitiesIconsNames[pEntityId][cat].length > 0)
                  {
                     for(i = 0; i < this._entitiesIconsNames[pEntityId][cat].length; i++)
                     {
                        if(this._entitiesIconsNames[pEntityId][cat][i] == pIconName)
                        {
                           index = i;
                        }
                     }
                     this._entitiesIconsNames[pEntityId][cat].splice(index,1);
                  }
               }
               if(this._entitiesIcons[pEntityId])
               {
                  this._entitiesIcons[pEntityId].removeIcon(pIconName);
               }
            }
         }
         var count:int = 0;
         var countEntity:int = 0;
         for(id in this._entitiesIconsCounts)
         {
            count++;
            if(id == pEntityId)
            {
               for(iconName in this._entitiesIconsCounts[id])
               {
                  countEntity++;
               }
            }
         }
         if(countEntity == 0)
         {
            entity = DofusEntities.getEntity(pEntityId) as AnimatedCharacter;
            if(entity)
            {
               entity.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.updateIconAfterRender);
            }
            delete this._entitiesIconsCounts[pEntityId];
            delete this._entitiesIconsNames[pEntityId];
            delete this._entitiesIcons[pEntityId];
         }
         if(count == 0)
         {
            EnterFrameDispatcher.removeEventListener(this.showIcons);
         }
      }
      
      public function getIconNamesByCategory(pEntityId:Number, pIconCategory:int) : Vector.<String>
      {
         var iconNames:Vector.<String> = null;
         if(this._entitiesIconsNames[pEntityId] && this._entitiesIconsNames[pEntityId][pIconCategory])
         {
            iconNames = this._entitiesIconsNames[pEntityId][pIconCategory];
         }
         return iconNames;
      }
      
      public function removeIconsCategory(pEntityId:Number, pIconCategory:int) : void
      {
         var iconName:String = null;
         var entity:AnimatedCharacter = null;
         var count:int = 0;
         var id:* = undefined;
         if(this._entitiesIconsNames[pEntityId] && this._entitiesIconsNames[pEntityId][pIconCategory])
         {
            if(this._entitiesIcons[pEntityId])
            {
               for each(iconName in this._entitiesIconsNames[pEntityId][pIconCategory])
               {
                  this._entitiesIcons[pEntityId].removeIcon(iconName);
                  --this._entitiesIconsCounts[pEntityId][iconName];
               }
            }
            delete this._entitiesIconsNames[pEntityId][pIconCategory];
            if(this._entitiesIcons[pEntityId] && this._entitiesIcons[pEntityId].length == 0)
            {
               delete this._entitiesIconsNames[pEntityId];
               delete this._entitiesIconsCounts[pEntityId];
               this.removeIcon(pEntityId,null,true);
               entity = DofusEntities.getEntity(pEntityId) as AnimatedCharacter;
               if(entity)
               {
                  entity.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.updateIconAfterRender);
               }
               count = 0;
               for(id in this._entitiesIcons)
               {
                  count++;
               }
               if(count == 0)
               {
                  EnterFrameDispatcher.removeEventListener(this.showIcons);
               }
            }
         }
      }
      
      public function hasIcon(pEntityId:Number, pIconName:String = null) : Boolean
      {
         var hasIcon:Boolean = false;
         if(this._entitiesIcons[pEntityId])
         {
            if(pIconName)
            {
               hasIcon = this._entitiesIcons[pEntityId].hasIcon(pIconName);
            }
            else
            {
               hasIcon = true;
            }
         }
         return hasIcon;
      }
      
      public function getIcon(pEntityId:Number) : EntityIcon
      {
         return this._entitiesIcons[pEntityId];
      }
      
      public function getIconEntityBounds(pEntity:TiphonSprite, isCountAllEntities:Boolean = true) : IRectangle
      {
         var targetBounds:IRectangle = null;
         var tiphonspr:TiphonSprite = null;
         var head:DisplayObject = null;
         var r1:Rectangle = null;
         var r2:Rectangle2 = null;
         var currentLoopCount:Number = NaN;
         var foot:DisplayObject = null;
         var entity:TiphonSprite = pEntity;
         var carriedEntity:TiphonSprite = null;
         var carried:TiphonSprite = pEntity.carriedEntity;
         if(isCountAllEntities)
         {
            currentLoopCount = 0;
            while(carried && currentLoopCount < MAX_LOOP_COUNT)
            {
               carriedEntity = carried;
               carried = carried.carriedEntity;
               currentLoopCount++;
            }
            if(currentLoopCount === MAX_LOOP_COUNT)
            {
            }
            entity = !carriedEntity ? entity : carriedEntity;
         }
         tiphonspr = entity as TiphonSprite;
         if(entity.getSubEntitySlot(2,0) && !this._creaturesMode)
         {
            tiphonspr = entity.getSubEntitySlot(2,0) as TiphonSprite;
         }
         head = tiphonspr.getSlot("Tete");
         if(head && tiphonspr.getSlot("Pied"))
         {
            r1 = head.getBounds(StageShareManager.stage);
            r2 = new Rectangle2(r1.x,r1.y,r1.width,r1.height);
            targetBounds = r2;
            if(targetBounds.y - 30 - 10 < 0)
            {
               foot = tiphonspr.getSlot("Pied");
               if(foot)
               {
                  r1 = foot.getBounds(StageShareManager.stage);
                  r2 = new Rectangle2(r1.x,r1.y + targetBounds.height + 30,r1.width,r1.height);
                  targetBounds = r2;
               }
            }
         }
         else
         {
            if(tiphonspr is IDisplayable)
            {
               if(this._creaturesFightMode && tiphonspr is AnimatedCharacter)
               {
                  targetBounds = (tiphonspr as AnimatedCharacter).getCreatureBounds();
               }
               if(targetBounds === null)
               {
                  targetBounds = (tiphonspr as IDisplayable).absoluteBounds;
               }
            }
            else
            {
               r1 = tiphonspr.getBounds(StageShareManager.stage);
               r2 = new Rectangle2(r1.x,r1.y,r1.width,r1.height);
               targetBounds = r2;
            }
            if(targetBounds.y - 30 - 10 < 0)
            {
               targetBounds.y += targetBounds.height + 30;
            }
         }
         return targetBounds;
      }
      
      protected function getEntityIconParent(entity:AnimatedCharacter) : DisplayObjectContainer
      {
         if(entity && entity.rootEntity && entity.rootEntity.parent)
         {
            return entity.rootEntity.parent;
         }
         return null;
      }
      
      protected function showIcons(pEvent:Event = null) : void
      {
         var entityId:* = undefined;
         var entity:AnimatedCharacter = null;
         var targetBounds:IRectangle = null;
         var ei:EntityIcon = null;
         var isCarried:* = false;
         var baseCarrier:AnimatedCharacter = null;
         var baseCarrierTmp:TiphonSprite = null;
         var currentLoopCount:Number = NaN;
         var currentCarrier:* = undefined;
         var iconCat:* = undefined;
         var iconName:String = null;
         var newIcon:Boolean = false;
         var entityAnimation:String = null;
         var eiParent:DisplayObjectContainer = null;
         var turnsRemaining:Number = NaN;
         var i:Number = NaN;
         var parent:DisplayObjectContainer = null;
         if(!this._showIcons && !this._isShowIconsChanged)
         {
            return;
         }
         var entitiesToDelete:Array = [];
         for(entityId in this._entitiesIconsNames)
         {
            ei = this._entitiesIcons[entityId];
            if(!this._showIcons)
            {
               if(ei)
               {
                  ei.visible = false;
               }
            }
            else
            {
               if(this._isShowIconsChanged)
               {
                  if(ei)
                  {
                     ei.visible = true;
                  }
               }
               entity = DofusEntities.getEntity(entityId) as AnimatedCharacter;
               if(!entity)
               {
                  entitiesToDelete.push(entityId);
               }
               else
               {
                  isCarried = !!this._carriedEntities[entity.id];
                  baseCarrier = null;
                  if(isCarried)
                  {
                     currentLoopCount = 0;
                     if(this._carriedEntities[entity.id])
                     {
                        currentCarrier = entity;
                        while(this._carriedEntities[currentCarrier.id] && currentLoopCount < MAX_LOOP_COUNT)
                        {
                           currentCarrier = this._carriedEntities[currentCarrier.id];
                           currentLoopCount++;
                        }
                        baseCarrierTmp = currentCarrier as TiphonSprite;
                     }
                     else
                     {
                        baseCarrierTmp = entity.parentSprite as TiphonSprite;
                        while(baseCarrierTmp.parent is TiphonSprite && currentLoopCount < MAX_LOOP_COUNT)
                        {
                           baseCarrierTmp = baseCarrierTmp.parent as TiphonSprite;
                           currentLoopCount++;
                        }
                     }
                     if(currentLoopCount === MAX_LOOP_COUNT)
                     {
                     }
                     baseCarrier = baseCarrierTmp as AnimatedCharacter;
                     isCarried = Boolean(isCarried && baseCarrier !== null);
                  }
                  targetBounds = null;
                  if(this._updateAllIcons || entity.getAnimation() && entity.getAnimation().indexOf(AnimationEnum.ANIM_STATIQUE) == -1 || !this._entitiesIcons[entityId] || this._entitiesIcons[entityId].needUpdate)
                  {
                     if(this._entitiesIcons[entityId] && this._entitiesIcons[entityId].rendering)
                     {
                        continue;
                     }
                     targetBounds = this.getIconEntityBounds(entity,false);
                  }
                  if(targetBounds)
                  {
                     if(!ei)
                     {
                        this._entitiesIcons[entityId] = new EntityIcon(entity);
                        ei = this._entitiesIcons[entityId];
                        if(entityId in this._pendingCarriedEntities)
                        {
                           this.addCarrier(this._pendingCarriedEntities[entityId].carrierEntity,this._pendingCarriedEntities[entityId].carriedEntity);
                           delete this._pendingCarriedEntities[entityId];
                        }
                     }
                     newIcon = false;
                     for(iconCat in this._entitiesIconsNames[entityId])
                     {
                        for each(iconName in this._entitiesIconsNames[entityId][iconCat])
                        {
                           if(iconCat != EntityIconEnum.TURN_REMAINING)
                           {
                              if(!ei.hasIcon(iconName))
                              {
                                 newIcon = true;
                                 if(iconCat == EntityIconEnum.FIGHT_STATE_CATEGORY)
                                 {
                                    turnsRemaining = -1;
                                    if(!!this._entitiesIconsNames[entityId][EntityIconEnum.TURN_REMAINING] && this._entitiesIconsNames[entityId][EntityIconEnum.TURN_REMAINING][iconName])
                                    {
                                       turnsRemaining = this._entitiesIconsNames[entityId][EntityIconEnum.TURN_REMAINING][iconName];
                                    }
                                    ei.addIcon(ICONS_FILEPATH_STATE + "" + iconName,iconName,this._entitiesIconsOffsets[iconName],turnsRemaining);
                                 }
                                 else if(iconCat == EntityIconEnum.AGGRO_CATEGORY)
                                 {
                                    ei.addIcon(ICONS_FILEPATH + "" + iconName,iconName,this._entitiesIconsOffsets[iconName]);
                                 }
                                 else
                                 {
                                    ei.addIcon(ICONS_FILEPATH_CONQUEST + "" + iconName,iconName,this._entitiesIconsOffsets[iconName]);
                                 }
                              }
                           }
                        }
                     }
                     if(!newIcon)
                     {
                        if(!(!(entityId in this._entitiesIcons) || !entity))
                        {
                           entityAnimation = entity.getAnimation();
                           if(this._entitiesIcons[entityId].needUpdate && !entity.isMoving && entityAnimation !== null && entityAnimation.indexOf(AnimationEnum.ANIM_STATIQUE) == 0 && !this._entitiesIcons[entityId].isPickUpAnimation && !isCarried)
                           {
                              this._entitiesIcons[entityId].needUpdate = false;
                           }
                           else if(isCarried || this._entitiesIcons[entityId].isPickUpAnimation)
                           {
                              this._entitiesIcons[entityId].needUpdate = true;
                              if(baseCarrier !== null && baseCarrier.id in this._entitiesIcons)
                              {
                                 this._entitiesIcons[baseCarrier.id].needUpdate = true;
                              }
                           }
                           eiParent = this.getEntityIconParent(entity);
                           if(!entity || !eiParent || !entity.displayed)
                           {
                              if(ei.parent)
                              {
                                 ei.parent.removeChild(ei);
                              }
                           }
                           else
                           {
                              eiParent.addChildAt(ei,eiParent.numChildren);
                              if(entity.rendered)
                              {
                                 if(!isCarried)
                                 {
                                    ei.place(targetBounds);
                                 }
                                 else
                                 {
                                    i = 0;
                                    parent = entity.parent;
                                    while(i < MAX_LOOP_COUNT && parent !== null && !(parent is AnimatedCharacter))
                                    {
                                       parent = parent.parent;
                                    }
                                    if(parent is AnimatedCharacter)
                                    {
                                       ei.place(targetBounds,baseCarrier,this._entitiesIcons[(parent as AnimatedCharacter).id]);
                                    }
                                    else
                                    {
                                       ei.place(targetBounds,baseCarrier);
                                    }
                                 }
                              }
                              else
                              {
                                 ei.rendering = true;
                                 entity.addEventListener(TiphonEvent.RENDER_SUCCEED,this.updateIconAfterRender);
                              }
                              if(!entity.hasEventListener(TiphonEvent.ANIMATION_PICKUP_END))
                              {
                                 entity.addEventListener(TiphonEvent.ANIMATION_PICKUP_END,this.onAnimationPickupEnd);
                              }
                              if(!entity.hasEventListener(TiphonEvent.ANIMATION_PICKUP_START))
                              {
                                 entity.addEventListener(TiphonEvent.ANIMATION_PICKUP_START,this.onAnimationPickupStart);
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         for each(entityId in entitiesToDelete)
         {
            if(this._entitiesIcons[entityId])
            {
               this.removeIcon(entityId,null,true);
            }
         }
         this._updateAllIcons = false;
         this._isShowIconsChanged = false;
      }
      
      public function onDofusOptionsChange(event:PropertyChangeEvent) : void
      {
         var pEntityId:* = null;
         if(event.propertyName === "showTurnsRemaining")
         {
            for(pEntityId in this._entitiesIcons)
            {
               this._entitiesIcons[pEntityId].updateAllTurnRemainingIcons();
            }
         }
         else if(event.propertyName === "toggleEntityIcons")
         {
            this._showIcons = event.propertyValue;
            this._isShowIconsChanged = true;
         }
      }
      
      private function onAnimationPickupStart(tiphonEvent:TiphonEvent) : void
      {
         var carrierEntity:AnimatedCharacter = AnimatedCharacter.getFirstAnimatedParent(tiphonEvent.sprite as TiphonSprite);
         var carriedEntity:AnimatedCharacter = AnimatedCharacter.getFirstAnimatedParent(tiphonEvent.currentTarget as TiphonSprite);
         this.addCarrier(carrierEntity,carriedEntity);
      }
      
      private function onAnimationPickupEnd(tiphonEvent:TiphonEvent) : void
      {
         var carrierEntity:AnimatedCharacter = AnimatedCharacter.getFirstAnimatedParent(tiphonEvent.sprite as TiphonSprite);
         var carriedEntity:AnimatedCharacter = AnimatedCharacter.getFirstAnimatedParent(tiphonEvent.currentTarget as TiphonSprite);
         this.removeCarrier(carrierEntity,carriedEntity);
      }
      
      public function addCarrier(carrierEntity:AnimatedCharacter, carriedEntity:AnimatedCharacter, isPending:Boolean = false) : void
      {
         if(carrierEntity === null || carriedEntity === null)
         {
            return;
         }
         if(carriedEntity.id in this._pendingCarriedEntities)
         {
            delete this._pendingCarriedEntities[carriedEntity.id];
         }
         if(carriedEntity.id in this._entitiesIcons)
         {
            this._entitiesIcons[carriedEntity.id].isPickUpAnimation = true;
            this._carriedEntities[carriedEntity.id] = carrierEntity;
            this._entitiesIcons[carriedEntity.id].needUpdate = true;
         }
         else if(isPending)
         {
            this._pendingCarriedEntities[carriedEntity.id] = {
               "carrierEntity":carrierEntity,
               "carriedEntity":carriedEntity
            };
         }
         if(carrierEntity.id in this._entitiesIcons)
         {
            this._entitiesIcons[carrierEntity.id].needUpdate = true;
         }
      }
      
      public function removeCarrier(carrierEntity:AnimatedCharacter, carriedEntity:AnimatedCharacter) : void
      {
         if(carriedEntity !== null)
         {
            if(carrierEntity !== null && carriedEntity.id in this._entitiesIcons)
            {
               this._entitiesIcons[carriedEntity.id].isPickUpAnimation = true;
               this._entitiesIcons[carriedEntity.id].needUpdate = false;
               delete this._carriedEntities[carriedEntity.id];
            }
            if(carriedEntity.id in this._pendingCarriedEntities)
            {
               delete this._pendingCarriedEntities[carriedEntity.id];
            }
         }
         if(carrierEntity !== null && carrierEntity.id in this._entitiesIcons)
         {
            this._entitiesIcons[carrierEntity.id].needUpdate = false;
         }
      }
      
      public function updateTurnRemaining(pEntityId:Number, pIconName:String, turnRemaining:Number) : void
      {
         if(!this._entitiesIconsNames[pEntityId] || !this._entitiesIconsNames[pEntityId][EntityIconEnum.TURN_REMAINING])
         {
            return;
         }
         this._entitiesIconsNames[pEntityId][EntityIconEnum.TURN_REMAINING][pIconName] = turnRemaining;
         if(this._entitiesIcons[pEntityId])
         {
            this._entitiesIcons[pEntityId].updateTurnRemaining(pIconName,turnRemaining);
         }
      }
      
      protected function updateIconAfterRender(pEvent:TiphonEvent) : void
      {
         var entity:AnimatedCharacter = pEvent.currentTarget as AnimatedCharacter;
         entity.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.updateIconAfterRender);
         if(this._entitiesIcons[entity.id])
         {
            this._entitiesIcons[entity.id].rendering = false;
            this._entitiesIcons[entity.id].needUpdate = true;
         }
      }
      
      public function onPlayAnim(e:TiphonEvent) : void
      {
         var animsRandom:Array = null;
         var tempStr:String = e.params.substring(6,e.params.length - 1);
         animsRandom = tempStr.split(",");
         e.sprite.setAnimation(animsRandom[int(animsRandom.length * Math.random())]);
      }
      
      private function onAtouinOptionChange(e:PropertyChangeEvent) : void
      {
         var entities:Array = null;
         var entitie:* = undefined;
         var entityId:* = undefined;
         if(e.propertyName == "useLowDefSkin")
         {
            entities = EntitiesManager.getInstance().entities;
            for each(entitie in entities)
            {
               if(entitie is TiphonSprite)
               {
                  TiphonSprite(entitie).setAlternativeSkinIndex(!!e.propertyValue ? 0 : -1,true);
               }
            }
         }
         if(e.propertyName == "transparentOverlayMode")
         {
            for(entityId in this._entitiesIconsNames)
            {
               this.forceIconUpdate(entityId);
            }
         }
      }
      
      public function isInCreaturesFightMode() : Boolean
      {
         return this._creaturesFightMode;
      }
      
      private function onUpdateEntitySuccess(e:TiphonEvent) : void
      {
         e.sprite.removeEventListener(TiphonEvent.RENDER_FAILED,this.onUpdateEntityFail);
         e.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onUpdateEntitySuccess);
      }
      
      private function onUpdateEntityFail(e:TiphonEvent) : void
      {
         e.sprite.removeEventListener(TiphonEvent.RENDER_FAILED,this.onUpdateEntityFail);
         e.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onUpdateEntitySuccess);
         TiphonSprite(e.sprite).setAnimation("AnimStatique");
      }
      
      private function isIncarnation(entity:String) : Boolean
      {
         var incarnation:Incarnation = null;
         var boneIdMale:String = null;
         var boneIdFemale:String = null;
         var incarnations:Array = Incarnation.getAllIncarnation();
         var boneId:String = entity.slice(1,entity.indexOf("|"));
         for each(incarnation in incarnations)
         {
            boneIdMale = incarnation.lookMale.slice(1,incarnation.lookMale.indexOf("|"));
            boneIdFemale = incarnation.lookFemale.slice(1,incarnation.lookFemale.indexOf("|"));
            if(boneId == boneIdMale || boneId == boneIdFemale)
            {
               return true;
            }
         }
         return false;
      }
      
      private function addUnderwaterBubblesToEntityLook(entityLook:EntityLook) : void
      {
         var bubbles:SubEntity = new SubEntity();
         bubbles.bindingPointCategory = SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_UNDERWATER_BUBBLES;
         bubbles.bindingPointIndex = 0;
         bubbles.subEntityLook.bonesId = 3580;
         entityLook.subentities.push(bubbles);
      }
      
      protected function onPropertyChanged(e:PropertyChangeEvent) : void
      {
         if(e.propertyName == "mapCoordinates")
         {
            KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData,this._worldPoint,this._currentSubAreaId,e.propertyValue);
         }
      }
   }
}
