package com.ankamagames.dofus.logic.game.fight.steps.abstract
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   
   public class AbstractDodgePointLossStep extends AbstractSequencable
   {
       
      
      protected var _fighterId:Number;
      
      protected var _amount:int;
      
      public function AbstractDodgePointLossStep(fighterId:Number, amount:int)
      {
         super();
         this._fighterId = fighterId;
         this._amount = amount;
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._fighterId];
      }
   }
}
