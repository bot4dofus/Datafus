package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.dofus.scripts.api.FxApi;
   import com.ankamagames.dofus.scripts.api.SequenceApi;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class SpellScript7 extends SpellScriptBase
   {
       
      
      public function SpellScript7(spellFxRunner:SpellFxRunner)
      {
         super(spellFxRunner);
         var target:MapPoint = FxApi.GetCurrentTargetedCell(runner);
         addCasterSetDirectionStep(target);
         var animName:String = "AnimArme";
         if(SpellFxApi.IsCriticalFail(spell))
         {
            animName = "AnimArmeEC";
         }
         var animationStep:ISequencable = SequenceApi.CreatePlayAnimationStep(caster,animName + SpellFxApi.GetUsedWeaponType(spell),true,true,"SHOT");
         if(!latestStep)
         {
            SpellFxApi.AddFrontStep(runner,animationStep);
         }
         else
         {
            SpellFxApi.AddStepAfter(runner,latestStep,animationStep);
         }
         latestStep = animationStep;
         addAnimHitSteps();
         addFBackgroundSteps();
         destroy();
      }
   }
}
