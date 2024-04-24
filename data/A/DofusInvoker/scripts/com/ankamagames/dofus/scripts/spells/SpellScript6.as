package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.dofus.scripts.SpellScriptRunner;
   import com.ankamagames.dofus.scripts.api.SequenceApi;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.dofus.scripts.api.SpellScriptRunnerUtils;
   import com.ankamagames.dofus.types.entities.ExplosionEntity;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class SpellScript6 extends SpellScriptBase
   {
       
      
      public function SpellScript6(spellFxRunner:SpellScriptRunner)
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
         var target:MapPoint = MapPoint.fromCellId(runner.targetedCellId);
         if(!caster)
         {
            return;
         }
         addCasterSetDirectionStep(target,spellFxRunner.castSequenceContext.direction);
         if(!SpellScriptRunnerUtils.IsPositionsEquals(SpellScriptRunnerUtils.GetEntityCell(caster),target))
         {
            orientation = SpellScriptRunnerUtils.GetEntityCell(caster).advancedOrientationTo(target,true);
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
         if(runner.scriptData.hasParam("casterGfxId"))
         {
            casterGfxAngle = 0;
            if(runner.scriptData.hasParam("casterGfxOriented"))
            {
               if(runner.scriptData.getBoolParam("casterGfxOriented"))
               {
                  casterGfxAngle = SpellScriptRunnerUtils.GetAngleTo(SpellScriptRunnerUtils.GetEntityCell(caster),MapPoint.fromCellId(runner.targetedCellId));
               }
            }
            spellGfxCasterYOffset = 0;
            if(runner.scriptData.hasParam("casterGfxYOffset"))
            {
               spellGfxCasterYOffset = runner.scriptData.getNumberParam("casterGfxYOffset");
            }
            spellGfxCasterShowUnder = false;
            if(runner.scriptData.hasParam("casterGfxShowUnder"))
            {
               spellGfxCasterShowUnder = runner.scriptData.getBoolParam("casterGfxShowUnder");
            }
            gfxCasterStep = SequenceApi.CreateAddGfxEntityStep(runner,runner.scriptData.getNumberParam("casterGfxId"),SpellScriptRunnerUtils.GetEntityCell(caster),casterGfxAngle,spellGfxCasterYOffset,runner.scriptData.getNumberParam("casterGfxDisplayType"),SpellScriptRunnerUtils.GetEntityCell(caster),MapPoint.fromCellId(runner.targetedCellId),spellGfxCasterShowUnder,caster);
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
         if(runner.scriptData.hasParam("targetGfxId"))
         {
            targetGfxAngle = 0;
            if(runner.scriptData.hasParam("targetGfxOriented"))
            {
               if(runner.scriptData.getBoolParam("targetGfxOriented"))
               {
                  targetGfxAngle = SpellScriptRunnerUtils.GetAngleTo(SpellScriptRunnerUtils.GetEntityCell(caster),MapPoint.fromCellId(runner.targetedCellId));
               }
            }
            spellGfxTargetYOffset = 0;
            if(runner.scriptData.hasParam("targetGfxYOffset"))
            {
               spellGfxTargetYOffset = runner.scriptData.getNumberParam("targetGfxYOffset");
            }
            spellGfxTargetShowUnder = false;
            if(runner.scriptData.hasParam("targetGfxShowUnder"))
            {
               spellGfxTargetShowUnder = runner.scriptData.getBoolParam("targetGfxShowUnder");
            }
            gfxTargetStep = SequenceApi.CreateAddGfxEntityStep(runner,runner.scriptData.getNumberParam("targetGfxId"),target,targetGfxAngle,spellGfxTargetYOffset,runner.scriptData.getNumberParam("targetGfxDisplayType"),SpellScriptRunnerUtils.GetEntityCell(caster),MapPoint.fromCellId(runner.targetedCellId),spellGfxTargetShowUnder,caster);
            if(!latestStep)
            {
               SpellFxApi.AddFrontStep(runner,gfxTargetStep);
            }
            else if(runner.scriptData.hasParam("playTargetGfxFirst") && runner.scriptData.getBoolParam("playTargetGfxFirst"))
            {
               SpellFxApi.AddStepBefore(runner,latestStep,gfxTargetStep);
            }
            else
            {
               SpellFxApi.AddStepAfter(runner,latestStep,gfxTargetStep);
            }
            latestStep = gfxTargetStep;
         }
         if(runner.scriptData.hasParam("animId"))
         {
            missileGfx = SpellScriptRunnerUtils.CreateGfxEntity(runner.scriptData.getNumberParam("animId"),MapPoint.fromCellId(runner.targetedCellId),-10,10,true) as Projectile;
            levelChange = false;
            if(runner.scriptData.hasParam("levelChange"))
            {
               levelChange = runner.scriptData.getBoolParam("levelChange");
            }
            subExplo = false;
            if(runner.scriptData.hasParam("subExplo"))
            {
               subExplo = runner.scriptData.getBoolParam("subExplo");
            }
            orientationStep = SequenceApi.CreateSetDirectionStep(missileGfx,1);
            SpellFxApi.AddStepAfter(runner,latestStep,orientationStep);
            latestStep = orientationStep;
            explo = SpellFxApi.CreateExplosionEntity(runner,runner.scriptData.getNumberParam("particleGfxId"),runner.scriptData.getStringParam("particleColor"),runner.scriptData.getNumberParam("particleCount"),levelChange,subExplo,runner.scriptData.getNumberParam("explosionType"));
            SpellScriptRunnerUtils.SetSubEntity(missileGfx,explo,2,1);
            gfxTargetStep = SequenceApi.CreateAddWorldEntityStep(missileGfx);
            if(!latestStep)
            {
               SpellFxApi.AddFrontStep(runner,gfxTargetStep);
            }
            else if(runner.scriptData.hasParam("playTargetGfxFirst2") && runner.scriptData.getBoolParam("playTargetGfxFirst2"))
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
