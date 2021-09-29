package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.dofus.scripts.api.FxApi;
   import com.ankamagames.dofus.scripts.api.SequenceApi;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.dofus.types.entities.ExplosionEntity;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class SpellScript6 extends SpellScriptBase
   {
       
      
      public function SpellScript6(spellFxRunner:SpellFxRunner)
      {
         var orientation:uint = 0;
         var orientationStep:ISequencable = null;
         var casterGfxAngle:int = 0;
         var spellGfxCasterYOffset:int = 0;
         var spellGfxCasterShowUnder:Boolean = false;
         var gfxCasterStep:ISequencable = null;
         var targetGfxAngle:int = 0;
         var spellGfxTargetYOffset:int = 0;
         var spellGfxTargetShowUnder:Boolean = false;
         var gfxTargetStep:ISequencable = null;
         var missileGfx:Projectile = null;
         var levelChange:Boolean = false;
         var subExplo:Boolean = false;
         var explo:ExplosionEntity = null;
         super(spellFxRunner);
         var target:MapPoint = FxApi.GetCurrentTargetedCell(runner);
         if(!caster)
         {
            return;
         }
         addCasterSetDirectionStep(target);
         if(!FxApi.IsPositionsEquals(FxApi.GetEntityCell(caster),target))
         {
            orientation = FxApi.GetOrientationTo(FxApi.GetEntityCell(caster),target);
            orientationStep = SequenceApi.CreateSetDirectionStep(caster,orientation);
            SpellFxApi.AddFrontStep(runner,orientationStep);
            latestStep = orientationStep;
         }
         var animationStep:ISequencable = SequenceApi.CreatePlayAnimationStep(caster,"AnimAttaque403",true,true,"SHOT");
         if(!latestStep)
         {
            SpellFxApi.AddFrontStep(runner,animationStep);
         }
         else
         {
            SpellFxApi.AddStepAfter(runner,latestStep,animationStep);
         }
         latestStep = animationStep;
         if(SpellFxApi.HasSpellParam(spell,"casterGfxId"))
         {
            casterGfxAngle = 0;
            if(SpellFxApi.HasSpellParam(spell,"casterGfxOriented"))
            {
               if(SpellFxApi.GetSpellParam(spell,"casterGfxOriented"))
               {
                  casterGfxAngle = FxApi.GetAngleTo(FxApi.GetEntityCell(caster),FxApi.GetCurrentTargetedCell(runner));
               }
            }
            spellGfxCasterYOffset = 0;
            if(SpellFxApi.HasSpellParam(spell,"casterGfxYOffset"))
            {
               spellGfxCasterYOffset = SpellFxApi.GetSpellParam(spell,"casterGfxYOffset");
            }
            spellGfxCasterShowUnder = false;
            if(SpellFxApi.HasSpellParam(spell,"casterGfxShowUnder"))
            {
               spellGfxCasterShowUnder = SpellFxApi.GetSpellParam(spell,"casterGfxShowUnder");
            }
            gfxCasterStep = SequenceApi.CreateAddGfxEntityStep(runner,SpellFxApi.GetSpellParam(spell,"casterGfxId"),FxApi.GetEntityCell(caster),casterGfxAngle,spellGfxCasterYOffset,SpellFxApi.GetSpellParam(spell,"casterGfxDisplayType"),FxApi.GetEntityCell(caster),FxApi.GetCurrentTargetedCell(runner),spellGfxCasterShowUnder,caster);
            if(!latestStep)
            {
               SpellFxApi.AddFrontStep(runner,gfxCasterStep);
            }
            else
            {
               SpellFxApi.AddStepAfter(runner,latestStep,gfxCasterStep);
            }
            latestStep = gfxCasterStep;
         }
         if(SpellFxApi.HasSpellParam(spell,"targetGfxId"))
         {
            targetGfxAngle = 0;
            if(SpellFxApi.HasSpellParam(spell,"targetGfxOriented"))
            {
               if(SpellFxApi.GetSpellParam(spell,"targetGfxOriented"))
               {
                  targetGfxAngle = FxApi.GetAngleTo(FxApi.GetEntityCell(caster),FxApi.GetCurrentTargetedCell(runner));
               }
            }
            spellGfxTargetYOffset = 0;
            if(SpellFxApi.HasSpellParam(spell,"targetGfxYOffset"))
            {
               spellGfxTargetYOffset = SpellFxApi.GetSpellParam(spell,"targetGfxYOffset");
            }
            spellGfxTargetShowUnder = false;
            if(SpellFxApi.HasSpellParam(spell,"targetGfxShowUnder"))
            {
               spellGfxTargetShowUnder = SpellFxApi.GetSpellParam(spell,"targetGfxShowUnder");
            }
            gfxTargetStep = SequenceApi.CreateAddGfxEntityStep(runner,SpellFxApi.GetSpellParam(spell,"targetGfxId"),target,targetGfxAngle,spellGfxTargetYOffset,SpellFxApi.GetSpellParam(spell,"targetGfxDisplayType"),FxApi.GetEntityCell(caster),FxApi.GetCurrentTargetedCell(runner),spellGfxTargetShowUnder,caster);
            if(!latestStep)
            {
               SpellFxApi.AddFrontStep(runner,gfxTargetStep);
            }
            else if(SpellFxApi.HasSpellParam(spell,"playTargetGfxFirst") && SpellFxApi.GetSpellParam(spell,"playTargetGfxFirst"))
            {
               SpellFxApi.AddStepBefore(runner,latestStep,gfxTargetStep);
            }
            else
            {
               SpellFxApi.AddStepAfter(runner,latestStep,gfxTargetStep);
            }
            latestStep = gfxTargetStep;
         }
         if(SpellFxApi.HasSpellParam(spell,"animId"))
         {
            missileGfx = FxApi.CreateGfxEntity(SpellFxApi.GetSpellParam(spell,"animId"),FxApi.GetCurrentTargetedCell(runner),-10,10,true) as Projectile;
            levelChange = false;
            if(SpellFxApi.HasSpellParam(spell,"levelChange"))
            {
               levelChange = SpellFxApi.GetSpellParam(spell,"levelChange");
            }
            subExplo = false;
            if(SpellFxApi.HasSpellParam(spell,"subExplo"))
            {
               subExplo = SpellFxApi.GetSpellParam(spell,"subExplo");
            }
            orientationStep = SequenceApi.CreateSetDirectionStep(missileGfx,1);
            SpellFxApi.AddStepAfter(runner,latestStep,orientationStep);
            latestStep = orientationStep;
            explo = SpellFxApi.CreateExplosionEntity(runner,SpellFxApi.GetSpellParam(spell,"particleGfxId"),SpellFxApi.GetSpellParam(spell,"particleColor"),SpellFxApi.GetSpellParam(spell,"particleCount"),levelChange,subExplo,SpellFxApi.GetSpellParam(spell,"explosionType"));
            FxApi.SetSubEntity(missileGfx,explo,2,1);
            gfxTargetStep = SequenceApi.CreateAddWorldEntityStep(missileGfx);
            if(!latestStep)
            {
               SpellFxApi.AddFrontStep(runner,gfxTargetStep);
            }
            else if(SpellFxApi.HasSpellParam(spell,"playTargetGfxFirst2") && SpellFxApi.GetSpellParam(spell,"playTargetGfxFirst2"))
            {
               SpellFxApi.AddStepBefore(runner,latestStep,gfxTargetStep);
            }
            else
            {
               SpellFxApi.AddStepAfter(runner,latestStep,gfxTargetStep);
            }
            latestStep = gfxTargetStep;
         }
         addFBackgroundSteps();
         destroy();
      }
   }
}
