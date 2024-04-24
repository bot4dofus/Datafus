package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.logic.game.fight.miscs.CarrierAnimationModifier;
   import com.ankamagames.dofus.logic.game.fight.miscs.CarrierSubEntityBehaviour;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.entities.AnimStatiqueSubEntityBehavior;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.entities.RiderBehavior;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.display.Rectangle2;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import damageCalculation.damageManagement.EffectOutput;
   import damageCalculation.damageManagement.Teleport;
   import damageCalculation.fighterManagement.HaxeFighter;
   import damageCalculation.tools.Const;
   import flash.utils.Dictionary;
   import haxe.ds._List.ListNode;
   import mapTools.MapDirection;
   
   public class FightTeleportationPreview
   {
       
      
      private var _previews:Vector.<AnimatedCharacter>;
      
      private var _previewIdEntityIdAssoc:Dictionary;
      
      private var _movedFighters:Vector.<HaxeFighter>;
      
      private var _removed:Boolean;
      
      public function FightTeleportationPreview(movedFighters:Vector.<HaxeFighter>)
      {
         super();
         this.init(movedFighters);
         this._previewIdEntityIdAssoc = new Dictionary();
      }
      
      public static function getParentEntity(pEntity:TiphonSprite) : TiphonSprite
      {
         var parentEntity:TiphonSprite = null;
         var parent:TiphonSprite = pEntity.parentSprite;
         while(parent)
         {
            parentEntity = parent;
            parent = parent.parentSprite;
         }
         return !parentEntity ? pEntity : parentEntity;
      }
      
      private static function cloneFighter(originalEntity:AnimatedCharacter) : AnimatedCharacter
      {
         var animModifier:IAnimationModifier = null;
         var previewEntity:AnimatedCharacter = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(),originalEntity.look,null,null);
         if(OptionManager.getOptionManager("atouin").getOption("useLowDefSkin"))
         {
            previewEntity.setAlternativeSkinIndex(0,true);
         }
         for each(animModifier in originalEntity.animationModifiers)
         {
            previewEntity.addAnimationModifier(animModifier);
         }
         previewEntity.skinModifier = originalEntity.skinModifier;
         addPreviewSubEntities(originalEntity,previewEntity);
         previewEntity.mouseEnabled = previewEntity.mouseChildren = false;
         return previewEntity;
      }
      
      private static function addPreviewSubEntities(pActualEntity:TiphonSprite, pPreviewEntity:TiphonSprite) : void
      {
         var carriedPreviewEntity:TiphonSprite = null;
         var animModifier:IAnimationModifier = null;
         var subEntities:Array = pActualEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET);
         if(subEntities && subEntities.length)
         {
            pPreviewEntity.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET,new AnimStatiqueSubEntityBehavior());
         }
         var isRider:Boolean = false;
         subEntities = pActualEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER);
         if(subEntities && subEntities.length)
         {
            isRider = true;
            pPreviewEntity.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,new RiderBehavior());
         }
         var carryingEntity:TiphonSprite = pActualEntity;
         if(isRider && pActualEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0))
         {
            carryingEntity = pActualEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
         }
         var carryingPreviewEntity:TiphonSprite = pPreviewEntity;
         if(isRider && pPreviewEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0))
         {
            carryingPreviewEntity = pPreviewEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
         }
         var carriedEntity:TiphonSprite = carryingEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_LIFTED_ENTITY,0) as TiphonSprite;
         addTeamCircle(pActualEntity,pPreviewEntity);
         if(carriedEntity)
         {
            carriedPreviewEntity = new TiphonSprite(carriedEntity.look);
            if(OptionManager.getOptionManager("atouin").getOption("useLowDefSkin"))
            {
               carriedPreviewEntity.setAlternativeSkinIndex(0,true);
            }
            for each(animModifier in carriedEntity.animationModifiers)
            {
               carriedPreviewEntity.addAnimationModifier(animModifier);
            }
            carriedPreviewEntity.skinModifier = carriedEntity.skinModifier;
            carryingPreviewEntity.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_LIFTED_ENTITY,new CarrierSubEntityBehaviour());
            carryingPreviewEntity.isCarrying = true;
            carryingPreviewEntity.addAnimationModifier(CarrierAnimationModifier.getInstance());
            carryingPreviewEntity.addSubEntity(carriedPreviewEntity,SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_LIFTED_ENTITY,0);
            carriedPreviewEntity.setAnimation(AnimationEnum.ANIM_STATIQUE);
            carryingPreviewEntity.setAnimation(AnimationEnum.ANIM_STATIQUE_CARRYING);
            addPreviewSubEntities(carriedEntity,carriedPreviewEntity);
         }
      }
      
      private static function addTeamCircle(pActualEntity:TiphonSprite, pEntity:TiphonSprite) : void
      {
         var entityId:Number = NaN;
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         for each(entityId in entitiesFrame.getEntitiesIdsList())
         {
            if(DofusEntities.getEntity(entityId) == pActualEntity)
            {
               entitiesFrame.addCircleToFighter(pEntity,FightEntitiesFrame.getTeamCircleColor((entitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations).spawnInfo.teamId));
               return;
            }
         }
      }
      
      private static function updateEntityTooltip(pActualEntityId:Number, pEntity:AnimatedCharacter) : void
      {
         var entityInfos:GameFightFighterInformations = null;
         var ttCacheName:String = null;
         var offsetRect:IRectangle = null;
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var hasIcon:Boolean = fightContextFrame.entitiesFrame.hasIcon(pActualEntityId);
         var ttName:String = "tooltipOverEntity_" + pActualEntityId;
         if(TooltipManager.isVisible(ttName))
         {
            entityInfos = fightContextFrame.entitiesFrame.getEntityInfos(pActualEntityId) as GameFightFighterInformations;
            ttCacheName = entityInfos is GameFightCharacterInformations ? "PlayerShortInfos" + pActualEntityId : "EntityShortInfos" + pActualEntityId;
            offsetRect = !!hasIcon ? new Rectangle2(0,-(fightContextFrame.entitiesFrame.getIcon(pActualEntityId).height * Atouin.getInstance().currentZoom + 10 * Atouin.getInstance().currentZoom),0,0) : null;
            TooltipManager.updatePosition(ttCacheName,ttName,pEntity.absoluteBounds,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,true,pEntity.position.cellId,offsetRect);
         }
         else if(hasIcon)
         {
            fightContextFrame.entitiesFrame.getIcon(pActualEntityId).place(fightContextFrame.entitiesFrame.getIconEntityBounds(pEntity));
         }
      }
      
      public function init(movedFighters:Vector.<HaxeFighter>) : void
      {
         this._movedFighters = movedFighters;
         this._removed = false;
      }
      
      public function getEntitiesIds() : Vector.<Number>
      {
         var fighter:HaxeFighter = null;
         var cursor:ListNode = null;
         var output:EffectOutput = null;
         var entitiesIds:Vector.<Number> = new Vector.<Number>(0);
         for each(fighter in this._movedFighters)
         {
            if(entitiesIds.indexOf(fighter.id) == -1)
            {
               entitiesIds.push(fighter.id);
            }
            cursor = fighter.totalEffects.h;
            while(cursor != null)
            {
               output = cursor.item as EffectOutput;
               if(output.carriedBy != HaxeFighter.INVALID_ID && entitiesIds.indexOf(output.carriedBy) == -1)
               {
                  entitiesIds.push(output.carriedBy);
               }
               if(output.throwedBy != HaxeFighter.INVALID_ID && entitiesIds.indexOf(output.throwedBy) == -1)
               {
                  entitiesIds.push(output.throwedBy);
               }
               cursor = cursor.next;
            }
         }
         return entitiesIds;
      }
      
      public function isPreview(pEntityId:Number) : Boolean
      {
         var previewEntity:AnimatedCharacter = null;
         for each(previewEntity in this._previews)
         {
            if(previewEntity.id == pEntityId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function show(frame:FightSpellCastFrame) : void
      {
         var entity:AnimatedCharacter = null;
         var currentFighterPreview:AnimatedCharacter = null;
         var direction:uint = 0;
         var carrierId:Number = NaN;
         var throwerId:Number = NaN;
         var cursor:ListNode = null;
         var fighter:HaxeFighter = null;
         var output:EffectOutput = null;
         var carrierEntity:AnimatedCharacter = null;
         var carrierPreview:AnimatedCharacter = null;
         var throwerEntity:AnimatedCharacter = null;
         var throwerPreview:AnimatedCharacter = null;
         var carriedEntity:TiphonSprite = null;
         if(this._removed)
         {
            return;
         }
         for each(fighter in this._movedFighters)
         {
            entity = DofusEntities.getEntity(fighter.id) as AnimatedCharacter;
            if(!entity)
            {
               entity = frame.getSummonPreview(fighter.id);
               if(!entity)
               {
                  continue;
               }
            }
            direction = entity.getDirection();
            carrierId = HaxeFighter.INVALID_ID;
            throwerId = HaxeFighter.INVALID_ID;
            cursor = fighter.totalEffects.h;
            while(cursor != null)
            {
               output = cursor.item as EffectOutput;
               if(output.movement != null)
               {
                  if(MapDirection.isValidDirection(output.movement.direction) && MapDirection.isOrthogonal(output.movement.direction))
                  {
                     direction = output.movement.direction;
                  }
                  else if(output.movement.direction == Teleport.OPPOSITE_DIRECTION)
                  {
                     direction = MapDirection.getOppositeDirection(direction);
                  }
                  if(output.carriedBy != HaxeFighter.INVALID_ID)
                  {
                     carrierId = output.carriedBy;
                  }
                  if(output.throwedBy != HaxeFighter.INVALID_ID && throwerId == HaxeFighter.INVALID_ID)
                  {
                     carrierId = HaxeFighter.INVALID_ID;
                     throwerId = output.throwedBy;
                  }
               }
               cursor = cursor.next;
            }
            currentFighterPreview = this.createFighterPreview(fighter.id,MapPoint.fromCellId(fighter.getCurrentPositionCell()),entity,direction);
            if(fighter.hasState(Const.STATE_CARRIED) && carrierId != HaxeFighter.INVALID_ID)
            {
               carrierEntity = DofusEntities.getEntity(carrierId) as AnimatedCharacter;
               carrierPreview = this.createFighterPreview(carrierId,MapPoint.fromCellId(fighter.getCurrentPositionCell()),carrierEntity,carrierEntity.getDirection());
               carrierPreview.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_LIFTED_ENTITY,new CarrierSubEntityBehaviour());
               carrierPreview.isCarrying = true;
               carrierPreview.addAnimationModifier(CarrierAnimationModifier.getInstance());
               carrierPreview.addSubEntity(currentFighterPreview,SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_LIFTED_ENTITY,0);
               carrierPreview.setAnimation(AnimationEnum.ANIM_STATIQUE_CARRYING);
               addPreviewSubEntities(entity,currentFighterPreview);
            }
            if(throwerId != HaxeFighter.INVALID_ID)
            {
               throwerEntity = DofusEntities.getEntity(throwerId) as AnimatedCharacter;
               throwerPreview = this.createFighterPreview(throwerId,throwerEntity.position,throwerEntity,throwerEntity.getDirection());
               carriedEntity = throwerPreview.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_LIFTED_ENTITY,0) as TiphonSprite;
               throwerPreview.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_LIFTED_ENTITY,null);
               throwerPreview.removeSubEntity(carriedEntity);
               throwerPreview.removeAnimationModifier(CarrierAnimationModifier.getInstance());
               throwerPreview.setAnimation(AnimationEnum.ANIM_STATIQUE);
            }
         }
      }
      
      public function remove(destroy:Boolean = true) : void
      {
         var entityId:Number = NaN;
         var ac:AnimatedCharacter = null;
         var parentEntity:AnimatedCharacter = null;
         if(this._removed)
         {
            if(destroy && this._previews)
            {
               for each(ac in this._previews)
               {
                  ac.quickDestroy();
               }
            }
            return;
         }
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var showPermanentTooltips:Boolean = fightContextFrame && fightContextFrame.showPermanentTooltips && fightContextFrame.battleFrame.targetedEntities.length > 0;
         var overEntity:AnimatedCharacter = EntitiesManager.getInstance().getEntityOnCell(FightContextFrame.currentCell,AnimatedCharacter) as AnimatedCharacter;
         overEntity = !!overEntity ? getParentEntity(overEntity) as AnimatedCharacter : null;
         for each(entityId in this.getEntitiesIds())
         {
            parentEntity = DofusEntities.getEntity(entityId) as AnimatedCharacter;
            if(parentEntity)
            {
               if(!overEntity || overEntity.id != parentEntity.id)
               {
                  TooltipManager.hide("tooltipOverEntity_" + parentEntity.id);
                  if(showPermanentTooltips && fightContextFrame.battleFrame.targetedEntities.indexOf(parentEntity.id) != -1)
                  {
                     fightContextFrame.displayEntityTooltip(parentEntity.id);
                  }
               }
               parentEntity.restoreVisibilityState();
            }
         }
         if(this._previews)
         {
            for each(ac in this._previews)
            {
               if(destroy)
               {
                  ac.quickDestroy();
               }
               else
               {
                  ac.hide(false);
               }
               if(fightContextFrame)
               {
                  fightContextFrame.entitiesFrame.updateEntityIconPosition(this._previewIdEntityIdAssoc[ac.id]);
               }
            }
         }
         this._removed = true;
      }
      
      public function getPreview(pEntityId:Number) : AnimatedCharacter
      {
         var previewEntityId:* = undefined;
         var previewEntity:AnimatedCharacter = null;
         if(this._previewIdEntityIdAssoc[pEntityId])
         {
            for each(previewEntity in this._previews)
            {
               if(previewEntity.id == pEntityId)
               {
                  return previewEntity;
               }
            }
         }
         else
         {
            for(previewEntityId in this._previewIdEntityIdAssoc)
            {
               if(this._previewIdEntityIdAssoc[previewEntityId] == pEntityId)
               {
                  for each(previewEntity in this._previews)
                  {
                     if(previewEntity.id == previewEntityId)
                     {
                        return previewEntity;
                     }
                  }
               }
            }
         }
         return null;
      }
      
      private function createFighterPreview(pTargetId:Number, pDestPos:MapPoint, originalEntity:AnimatedCharacter, direction:int) : AnimatedCharacter
      {
         originalEntity.saveVisibilityState();
         originalEntity.alpha = 0.5;
         var previewEntity:AnimatedCharacter = this.getPreview(pTargetId);
         if(!previewEntity)
         {
            previewEntity = cloneFighter(originalEntity);
            if(!this._previews)
            {
               this._previews = new Vector.<AnimatedCharacter>(0);
            }
            this._previews.push(previewEntity);
            this._previewIdEntityIdAssoc[previewEntity.id] = pTargetId;
         }
         previewEntity.show(false);
         previewEntity.position = pDestPos;
         previewEntity.setAnimationAndDirection(originalEntity.getAnimation(),direction,true);
         previewEntity.display(PlacementStrataEnums.STRATA_PLAYER);
         previewEntity.setCanSeeThrough(true);
         var originalEntityId:Number = !!this._previewIdEntityIdAssoc[pTargetId] ? Number(this._previewIdEntityIdAssoc[pTargetId]) : Number(pTargetId);
         updateEntityTooltip(originalEntityId,previewEntity);
         return previewEntity;
      }
   }
}
