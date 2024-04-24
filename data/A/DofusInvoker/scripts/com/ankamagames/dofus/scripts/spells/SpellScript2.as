package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.atouin.types.sequences.AddWorldEntityStep;
   import com.ankamagames.atouin.types.sequences.DestroyEntityStep;
   import com.ankamagames.atouin.types.sequences.ParableGfxMovementStep;
   import com.ankamagames.dofus.scripts.SpellScriptRunner;
   import com.ankamagames.dofus.scripts.api.SequenceApi;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.dofus.scripts.api.SpellScriptRunnerUtils;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class SpellScript2 extends SpellScriptBase
   {
       
      
      public function SpellScript2(spellFxRunner:SpellScriptRunner)
      {
         var entryPortalCell:MapPoint = null;
         var exitPortalCell:MapPoint = null;
         var missileGfx:Projectile = null;
         var addMissileGfxStep:AddWorldEntityStep = null;
         var speed:Number = NaN;
         var curvature:Number = NaN;
         var missileOrientedToCurve:Boolean = false;
         var missileGfxYOffset:Number = NaN;
         var missileStep:ParableGfxMovementStep = null;
         var destroyMissileStep:DestroyEntityStep = null;
         var missileGfx2:Projectile = null;
         var addMissileGfxStep2:AddWorldEntityStep = null;
         var missileStep2:ParableGfxMovementStep = null;
         var destroyMissileStep2:DestroyEntityStep = null;
         super(spellFxRunner);
         var targetCell:MapPoint = MapPoint.fromCellId(runner.targetedCellId);
         var casterCell:MapPoint = SpellScriptRunnerUtils.GetEntityCell(caster);
         var portalsCells:Vector.<MapPoint> = SpellFxApi.GetPortalCells(runner);
         if(portalsCells && portalsCells.length > 1)
         {
            entryPortalCell = portalsCells[0];
            exitPortalCell = portalsCells[portalsCells.length - 1];
         }
         var tmpTargetCell:MapPoint = !!entryPortalCell ? entryPortalCell : targetCell;
         var tmpCasterCell:MapPoint = !!exitPortalCell ? exitPortalCell : casterCell;
         addCasterSetDirectionStep(tmpTargetCell,spellFxRunner.castSequenceContext.direction);
         addCasterAnimationStep();
         if(runner.scriptData.hasParam("casterGfxId"))
         {
            addNewGfxEntityStep(casterCell,casterCell,tmpTargetCell,PREFIX_CASTER,"",caster);
         }
         if(runner.scriptData.hasParam("missileGfxId") && tmpTargetCell && caster)
         {
            missileGfx = SpellScriptRunnerUtils.CreateGfxEntity(runner.scriptData.getNumberParam("missileGfxId"),casterCell) as Projectile;
            addMissileGfxStep = SequenceApi.CreateAddWorldEntityStep(missileGfx);
            speed = 100;
            if(runner.scriptData.hasParam("missileSpeed"))
            {
               speed = (runner.scriptData.getNumberParam("missileSpeed") + 10) * 10;
            }
            curvature = 0.5;
            if(runner.scriptData.hasParam("missileCurvature"))
            {
               curvature = runner.scriptData.getNumberParam("missileCurvature") / 10;
            }
            missileOrientedToCurve = true;
            if(runner.scriptData.hasParam("missileOrientedToCurve"))
            {
               missileOrientedToCurve = runner.scriptData.getBoolParam("missileOrientedToCurve");
            }
            missileGfxYOffset = 0;
            if(runner.scriptData.hasParam("missileGfxYOffset"))
            {
               missileGfxYOffset = runner.scriptData.getNumberParam("missileGfxYOffset");
            }
            missileStep = SequenceApi.CreateParableGfxMovementStep(runner,missileGfx,tmpTargetCell,speed,curvature,missileGfxYOffset,missileOrientedToCurve);
            destroyMissileStep = SequenceApi.CreateDestroyEntityStep(missileGfx);
            if(entryPortalCell && tmpTargetCell == entryPortalCell)
            {
               missileGfx2 = SpellScriptRunnerUtils.CreateGfxEntity(runner.scriptData.getNumberParam("missileGfxId"),exitPortalCell) as Projectile;
               addMissileGfxStep2 = SequenceApi.CreateAddWorldEntityStep(missileGfx2);
               missileStep2 = SequenceApi.CreateParableGfxMovementStep(runner,missileGfx2,targetCell,speed,curvature,missileGfxYOffset,missileOrientedToCurve);
               destroyMissileStep2 = SequenceApi.CreateDestroyEntityStep(missileGfx2);
            }
            if(!latestStep)
            {
               SpellFxApi.AddFrontStep(runner,addMissileGfxStep);
               SpellFxApi.AddStepAfter(runner,addMissileGfxStep,missileStep);
               SpellFxApi.AddStepAfter(runner,missileStep,destroyMissileStep);
            }
            else
            {
               SpellFxApi.AddStepAfter(runner,latestStep,addMissileGfxStep);
               SpellFxApi.AddStepAfter(runner,addMissileGfxStep,missileStep);
               SpellFxApi.AddStepAfter(runner,missileStep,destroyMissileStep);
            }
            latestStep = missileStep;
            if(missileGfx2)
            {
               latestStep = destroyMissileStep;
               addPortalAnimationSteps(SpellFxApi.GetPortalIds(runner));
               SpellFxApi.AddStepAfter(runner,latestStep,addMissileGfxStep2);
               SpellFxApi.AddStepAfter(runner,addMissileGfxStep2,missileStep2);
               SpellFxApi.AddStepAfter(runner,missileStep2,destroyMissileStep2);
               latestStep = missileStep2;
            }
         }
         if(runner.scriptData.hasParam("targetGfxId"))
         {
            addNewGfxEntityStep(targetCell,tmpCasterCell,targetCell,PREFIX_TARGET);
         }
         addAnimHitSteps();
         addFBackgroundSteps();
         destroy();
      }
   }
}
