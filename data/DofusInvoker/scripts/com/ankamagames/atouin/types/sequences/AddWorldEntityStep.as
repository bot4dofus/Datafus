package com.ankamagames.atouin.types.sequences
{
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.tiphon.display.TiphonSprite;
   
   public class AddWorldEntityStep extends AbstractSequencable
   {
       
      
      private var _entity:IEntity;
      
      private var _strata:int;
      
      public function AddWorldEntityStep(entity:IEntity, strata:int = 200)
      {
         super();
         this._entity = entity;
         this._strata = strata;
      }
      
      override public function start() : void
      {
         (this._entity as IDisplayable).display(this._strata);
         if(this._entity is TiphonSprite)
         {
            (this._entity as TiphonSprite).forceVisibilityRefresh();
         }
         executeCallbacks();
      }
   }
}
