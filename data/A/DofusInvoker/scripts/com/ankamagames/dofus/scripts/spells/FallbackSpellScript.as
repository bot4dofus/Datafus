package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.dofus.scripts.SpellScriptRunner;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.sequencer.TimeoutStep;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class FallbackSpellScript extends SpellScriptBase
   {
       
      
      public function FallbackSpellScript(spellFxRunner:SpellScriptRunner)
      {
         super(spellFxRunner);
         var target:MapPoint = MapPoint.fromCellId(runner.targetedCellId);
         addCasterSetDirectionStep(target,spellFxRunner.castSequenceContext.direction);
         var timeoutStep:ISequencable = new TimeoutStep();
         if(!latestStep)
         {
            SpellFxApi.AddFrontStep(runner,timeoutStep);
         }
         else
         {
            SpellFxApi.AddStepAfter(runner,latestStep,timeoutStep);
         }
         latestStep = timeoutStep;
         addAnimHitSteps();
         addFBackgroundSteps();
         destroy();
      }
   }
}
