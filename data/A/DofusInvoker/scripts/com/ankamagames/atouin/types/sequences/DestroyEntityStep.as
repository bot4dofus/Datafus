package com.ankamagames.atouin.types.sequences
{
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   
   public class DestroyEntityStep extends AbstractSequencable
   {
       
      
      protected var _entity:IEntity;
      
      private var _waitAnim:Boolean;
      
      private var _waitAnimForCallback:Boolean;
      
      public function DestroyEntityStep(entity:IEntity, waitAnim:Boolean = false, waitAnimForCallback:Boolean = false)
      {
         super();
         this._entity = entity;
         this._waitAnim = waitAnim;
         this._waitAnimForCallback = waitAnimForCallback;
      }
      
      override public function start() : void
      {
         var entitySprite:TiphonSprite = this._entity as TiphonSprite;
         EntitiesManager.getInstance().entitiesScheduledForDestruction[this._entity.id] = true;
         if(this._waitAnim && entitySprite)
         {
            if(entitySprite.isPlayingAnimation())
            {
               this.addAnimEndListeners();
            }
            else if(!entitySprite.libraryIsAvailable)
            {
               this.addAnimEndListeners();
               entitySprite.addEventListener(TiphonEvent.SPRITE_INIT_FAILED,this.destroyEntity);
            }
            else
            {
               this.destroyEntity();
            }
         }
         else
         {
            this.destroyEntity();
         }
         if(!this._waitAnimForCallback)
         {
            executeCallbacks();
         }
      }
      
      private function addAnimEndListeners() : void
      {
         (this._entity as TiphonSprite).addEventListener(TiphonEvent.ANIMATION_END,this.destroyEntity);
         (this._entity as TiphonSprite).addEventListener(TiphonEvent.ANIMATION_TRANSITION_END,this.destroyEntity);
         (this._entity as TiphonSprite).addEventListener(TiphonEvent.ANIMATION_CHANGED,this.destroyEntity);
      }
      
      private function destroyEntity(pEvent:TiphonEvent = null) : void
      {
         if(pEvent)
         {
            pEvent.currentTarget.removeEventListener(TiphonEvent.ANIMATION_END,this.destroyEntity);
            pEvent.currentTarget.removeEventListener(TiphonEvent.ANIMATION_TRANSITION_END,this.destroyEntity);
            pEvent.currentTarget.removeEventListener(TiphonEvent.SPRITE_INIT_FAILED,this.destroyEntity);
            pEvent.currentTarget.removeEventListener(TiphonEvent.ANIMATION_CHANGED,this.destroyEntity);
         }
         if(EntitiesManager.getInstance().entitiesScheduledForDestruction[this._entity.id])
         {
            if(this._entity is TiphonSprite)
            {
               (this._entity as TiphonSprite).destroy();
            }
            else if(this._entity is IDisplayable)
            {
               (this._entity as IDisplayable).remove();
            }
         }
         if(pEvent && this._waitAnimForCallback)
         {
            executeCallbacks();
         }
      }
   }
}
