package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristic;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   
   public class FightUpdateStatStep extends AbstractSequencable implements IFightStep
   {
       
      
      public const STEP_TYPE:String = "updateStats";
      
      private var _entityId:Number = NaN;
      
      private var _newStats:Vector.<CharacterCharacteristic> = null;
      
      private var _targets:Vector.<Number> = null;
      
      public function FightUpdateStatStep(entityId:Number, newStats:Vector.<CharacterCharacteristic>)
      {
         super();
         this._entityId = entityId;
         this._newStats = newStats;
         this._targets = new <Number>[this._entityId];
      }
      
      public function get stepType() : String
      {
         return this.STEP_TYPE;
      }
      
      public function get targets() : Vector.<Number>
      {
         return this._targets;
      }
      
      override public function start() : void
      {
         EnterFrameDispatcher.worker.addSingleTreatment(StatsManager.getInstance(),StatsManager.getInstance().addRawStats,[this._entityId,this._newStats]);
         super.start();
         executeCallbacks();
      }
   }
}
