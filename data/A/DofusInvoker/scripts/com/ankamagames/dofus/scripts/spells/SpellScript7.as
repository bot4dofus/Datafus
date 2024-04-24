package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.scripts.SpellScriptRunner;
   import com.ankamagames.dofus.scripts.api.SequenceApi;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class SpellScript7 extends SpellScriptBase
   {
       
      
      public function SpellScript7(spellFxRunner:SpellScriptRunner)
      {
         super(spellFxRunner);
         var target:MapPoint = MapPoint.fromCellId(runner.targetedCellId);
         addCasterSetDirectionStep(target,spellFxRunner.castSequenceContext.direction);
         var animName:String = "AnimArme";
         if(spell.isCriticalFail)
         {
            animName = "AnimArmeEC";
         }
         var usedWeaponType:* = spell.weaponId > 0 ? Item.getItemById(spell.weaponId).typeId : 0;
         var animationStep:ISequencable = SequenceApi.CreatePlayAnimationStep(caster,animName + usedWeaponType,true,true,"SHOT");
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
