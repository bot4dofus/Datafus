package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.actions.RemoveEntityAction;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightEntitiesHolder;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   
   public class FightChangeVisibilityStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _entityId:Number;
      
      private var _visibilityState:int;
      
      private var _oldVisibilityState:int;
      
      public function FightChangeVisibilityStep(entityId:Number, visibilityState:int)
      {
         super();
         var fighterInfos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(entityId) as GameFightFighterInformations;
         this._oldVisibilityState = fighterInfos.stats.invisibilityState;
         this._entityId = entityId;
         this._visibilityState = visibilityState;
      }
      
      public function get stepType() : String
      {
         return "changeVisibility";
      }
      
      override public function start() : void
      {
         var dispatchedState:uint = 0;
         var invisibleEntity:DisplayObject = null;
         var invisibleEntityPos:MapPoint = null;
         var entitiesFrame:FightEntitiesFrame = null;
         var fightEntities:Dictionary = null;
         var entityId:* = undefined;
         var entityInfos:GameFightFighterInformations = null;
         var rea:RemoveEntityAction = null;
         switch(this._visibilityState)
         {
            case GameActionFightInvisibilityStateEnum.VISIBLE:
               if(Atouin.getInstance().options.getOption("transparentOverlayMode"))
               {
                  invisibleEntity = this.respawnEntity();
                  invisibleEntity.alpha = AtouinConstants.OVERLAY_MODE_ALPHA;
               }
               else
               {
                  invisibleEntity = this.respawnEntity();
                  invisibleEntity.alpha = 1;
               }
               if(invisibleEntity is AnimatedCharacter)
               {
                  invisibleEntityPos = AnimatedCharacter(invisibleEntity).position;
                  entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                  fightEntities = entitiesFrame.getEntitiesDictionnary();
                  for(entityId in fightEntities)
                  {
                     entityInfos = entitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations;
                     if(entitiesFrame.entityIsIllusion(entityId) && entityInfos.stats.summoner == this._entityId && entityInfos.disposition.cellId == invisibleEntityPos.cellId)
                     {
                        rea = RemoveEntityAction.create(entityId);
                        entitiesFrame.process(rea);
                        break;
                     }
                  }
               }
               if(invisibleEntity is AnimatedCharacter)
               {
                  AnimatedCharacter(invisibleEntity).setCanSeeThrough(false);
                  AnimatedCharacter(invisibleEntity).setCanWalkThrough(false);
                  AnimatedCharacter(invisibleEntity).setCanWalkTo(false);
               }
               if(this._oldVisibilityState == GameActionFightInvisibilityStateEnum.DETECTED || this._oldVisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE)
               {
                  dispatchedState = GameActionFightInvisibilityStateEnum.VISIBLE;
               }
               break;
            case GameActionFightInvisibilityStateEnum.DETECTED:
               if(this._oldVisibilityState == GameActionFightInvisibilityStateEnum.VISIBLE)
               {
                  dispatchedState = GameActionFightInvisibilityStateEnum.INVISIBLE;
               }
               invisibleEntity = this.respawnEntity();
               if(invisibleEntity is AnimatedCharacter)
               {
                  AnimatedCharacter(invisibleEntity).setCanSeeThrough(true);
                  AnimatedCharacter(invisibleEntity).setCanWalkThrough(false);
                  AnimatedCharacter(invisibleEntity).setCanWalkTo(false);
               }
               invisibleEntity.alpha = 0.5;
               break;
            case GameActionFightInvisibilityStateEnum.INVISIBLE:
               if(this._oldVisibilityState == GameActionFightInvisibilityStateEnum.VISIBLE)
               {
                  dispatchedState = GameActionFightInvisibilityStateEnum.INVISIBLE;
               }
               this.unspawnEntity();
         }
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_VISIBILITY_CHANGED,[this._entityId,dispatchedState],this._entityId,castingSpellId);
         var fcf:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(this._visibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE)
         {
            fcf.addToHiddenEntities(this._entityId);
         }
         else
         {
            fcf.removeFromHiddenEntities(this._entityId);
         }
         var fighterInfos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._entityId) as GameFightFighterInformations;
         fighterInfos.stats.invisibilityState = this._visibilityState;
         if(FightEntitiesFrame.getCurrentInstance().hasIcon(this._entityId))
         {
            FightEntitiesFrame.getCurrentInstance().forceIconUpdate(this._entityId);
         }
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._entityId];
      }
      
      private function unspawnEntity() : void
      {
         if(FightEntitiesHolder.getInstance().getEntity(this._entityId))
         {
            return;
         }
         var entity:IDisplayable = DofusEntities.getEntity(this._entityId) as IDisplayable;
         FightEntitiesHolder.getInstance().holdEntity(entity as IEntity);
         var animatedEntity:AnimatedCharacter = entity as AnimatedCharacter;
         if(animatedEntity)
         {
            animatedEntity.hide();
         }
      }
      
      private function respawnEntity() : DisplayObject
      {
         var fightEntitiesFrame:FightEntitiesFrame = null;
         var entity:IDisplayable = null;
         var animatedEntity:AnimatedCharacter = null;
         var tiphonSprite:TiphonSprite = DofusEntities.getEntity(this._entityId) as TiphonSprite;
         if(tiphonSprite && tiphonSprite.parentSprite)
         {
            fightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            if(fightEntitiesFrame)
            {
               fightEntitiesFrame.addOrUpdateActor(fightEntitiesFrame.getEntityInfos(this._entityId));
            }
            return tiphonSprite;
         }
         if(FightEntitiesHolder.getInstance().getEntity(this._entityId))
         {
            entity = DofusEntities.getEntity(this._entityId) as IDisplayable;
            animatedEntity = entity as AnimatedCharacter;
            if(animatedEntity)
            {
               animatedEntity.show();
            }
            FightEntitiesHolder.getInstance().unholdEntity(this._entityId);
         }
         return DofusEntities.getEntity(this._entityId) as DisplayObject;
      }
   }
}
