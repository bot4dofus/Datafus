package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import flash.display.Sprite;
   
   public class FightVisibilityStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _fighterId:Number;
      
      private var _visibility:Boolean;
      
      public function FightVisibilityStep(fighterId:Number, visibility:Boolean)
      {
         super();
         this._fighterId = fighterId;
         this._visibility = visibility;
      }
      
      public function get stepType() : String
      {
         return "visibility";
      }
      
      override public function start() : void
      {
         var entity:Sprite = DofusEntities.getEntity(this._fighterId) as Sprite;
         if(entity)
         {
            entity.visible = this._visibility;
         }
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._fighterId];
      }
   }
}
