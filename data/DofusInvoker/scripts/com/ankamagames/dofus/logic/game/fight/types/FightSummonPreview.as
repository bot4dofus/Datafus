package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import damageCalculation.damageManagement.EffectOutput;
   import damageCalculation.fighterManagement.HaxeFighter;
   import damageCalculation.fighterManagement.PlayerTypeEnum;
   import flash.utils.Dictionary;
   import haxe.ds._List.ListNode;
   
   public class FightSummonPreview
   {
       
      
      private var _previews:Vector.<AnimatedCharacter>;
      
      private var _previewsIdAssoc:Dictionary;
      
      private var _summonedFighters:Vector.<HaxeFighter>;
      
      public function FightSummonPreview(summonedFighters:Vector.<HaxeFighter>)
      {
         super();
         this._previewsIdAssoc = new Dictionary();
         this._summonedFighters = summonedFighters;
         this._previews = new Vector.<AnimatedCharacter>(0);
      }
      
      public function get previews() : Vector.<AnimatedCharacter>
      {
         return this._previews;
      }
      
      public function getSummonPreview(pEntityId:Number) : AnimatedCharacter
      {
         var id:Number = NaN;
         var preview:AnimatedCharacter = null;
         if(this._previewsIdAssoc[pEntityId])
         {
            id = this._previewsIdAssoc[pEntityId];
         }
         else
         {
            id = pEntityId;
         }
         for each(preview in this.previews)
         {
            if(preview.id == id)
            {
               return preview;
            }
         }
         return null;
      }
      
      public function isPreview(pEntityId:Number) : Boolean
      {
         var previewEntity:AnimatedCharacter = null;
         if(this._previewsIdAssoc[pEntityId])
         {
            return true;
         }
         for each(previewEntity in this._previews)
         {
            if(previewEntity.id == pEntityId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function show() : void
      {
         var summonedFighter:HaxeFighter = null;
         var currentCell:uint = 0;
         var entitiesOnCell:Array = null;
         var currentCellEntity:AnimatedCharacter = null;
         var direction:uint = 0;
         var lookId:Number = NaN;
         var cursor:ListNode = null;
         var casterInfos:GameFightFighterInformations = null;
         var animatedEntity:AnimatedCharacter = null;
         var entityOnCell:AnimatedCharacter = null;
         var output:EffectOutput = null;
         var look:String = null;
         var monster:Monster = null;
         var entityId:uint = 0;
         var companion:Companion = null;
         var entitiesFrame:FightEntitiesFrame = null;
         if(this._summonedFighters.length > 0)
         {
            var _loc17_:int = 0;
            var _loc18_:* = this._summonedFighters;
            while(true)
            {
               for each(summonedFighter in _loc18_)
               {
                  currentCell = summonedFighter.getCurrentPositionCell();
                  entitiesOnCell = EntitiesManager.getInstance().getEntitiesOnCell(currentCell,AnimatedCharacter);
                  if(entitiesOnCell.length > 0)
                  {
                     for each(entityOnCell in entitiesOnCell)
                     {
                        if(entityOnCell.id == summonedFighter.id)
                        {
                           currentCellEntity = entityOnCell;
                           break;
                        }
                     }
                  }
                  else
                  {
                     currentCellEntity = null;
                  }
                  direction = 0;
                  lookId = 0;
                  cursor = summonedFighter.totalEffects.h;
                  while(cursor != null)
                  {
                     output = cursor.item as EffectOutput;
                     if(output.summon != null)
                     {
                        direction = output.summon.direction;
                        lookId = output.summon.lookId;
                        if(summonedFighter.getCurrentPositionCell() != output.summon.position)
                        {
                           currentCell = output.summon.position;
                        }
                        break;
                     }
                     cursor = cursor.next;
                  }
                  if(currentCellEntity)
                  {
                     currentCellEntity.visible = false;
                     TooltipManager.hide("tooltipOverEntity_" + currentCellEntity.id);
                  }
                  casterInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(CurrentPlayedFighterManager.getInstance().currentFighterId) as GameFightFighterInformations;
                  if(summonedFighter.playerType == PlayerTypeEnum.HUMAN)
                  {
                     if(lookId == 0)
                     {
                        lookId = summonedFighter.id;
                     }
                     look = EntitiesManager.getInstance().getDeadLook(lookId);
                     if(look == null)
                     {
                        break;
                     }
                     animatedEntity = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(),new TiphonEntityLook(look));
                  }
                  else if(summonedFighter.playerType == PlayerTypeEnum.MONSTER)
                  {
                     monster = Monster.getMonsterById(summonedFighter.breed);
                     animatedEntity = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(),new TiphonEntityLook(monster.look));
                  }
                  else if(summonedFighter.playerType == PlayerTypeEnum.SIDEKICK)
                  {
                     entityId = summonedFighter.getModelId();
                     if(entityId == 0)
                     {
                        return;
                     }
                     companion = Companion.getCompanionById(entityId);
                     animatedEntity = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(),new TiphonEntityLook(companion.look));
                  }
                  if(animatedEntity)
                  {
                     animatedEntity.setCanSeeThrough(true);
                     animatedEntity.transparencyAllowed = true;
                     animatedEntity.alpha = 0.65;
                     animatedEntity.mouseEnabled = false;
                     animatedEntity.visible = true;
                     animatedEntity.position = MapPoint.fromCellId(currentCell);
                     animatedEntity.setDirection(MapPoint.fromCellId(casterInfos.disposition.cellId).advancedOrientationTo(MapPoint.fromCellId(currentCell),true));
                     animatedEntity.display(PlacementStrataEnums.STRATA_PLAYER);
                     entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                     entitiesFrame.addCircleToFighter(animatedEntity,FightEntitiesFrame.getTeamCircleColor(casterInfos.spawnInfo.teamId));
                     this._previewsIdAssoc[summonedFighter.id] = animatedEntity.id;
                     this._previews.push(animatedEntity);
                  }
                  continue;
               }
            }
            return;
         }
      }
      
      public function remove() : void
      {
         var ac:AnimatedCharacter = null;
         var pos:MapPoint = null;
         var entitiesOnCell:Array = null;
         var entityOnCell:AnimatedCharacter = null;
         if(this._previews)
         {
            for each(ac in this._previews)
            {
               pos = ac.position;
               ac.quickDestroy();
               entitiesOnCell = EntitiesManager.getInstance().getEntitiesOnCell(pos.cellId,AnimatedCharacter);
               entityOnCell = entitiesOnCell.length > 0 ? FightTeleportationPreview.getParentEntity(entitiesOnCell[0]) as AnimatedCharacter : null;
               if(entityOnCell)
               {
                  entityOnCell.visible = true;
               }
            }
            this._previews = new Vector.<AnimatedCharacter>(0);
         }
      }
   }
}
