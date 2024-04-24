package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.dofus.scripts.SpellScriptRunner;
   import com.ankamagames.dofus.scripts.api.SequenceApi;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.dofus.scripts.api.SpellScriptRunnerUtils;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class SpellScript3 extends SpellScriptBase
   {
       
      
      public function SpellScript3(spellFxRunner:SpellScriptRunner)
      {
         var entryPortalCell:MapPoint = null;
         var exitPortalCell:MapPoint = null;
         var trailGfxShowUnder:Boolean = false;
         var useSpellZone:Boolean = false;
         var useOnlySpellZone:Boolean = false;
         var trailStep:ISequencable = null;
         var trailStep2:ISequencable = null;
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
            addNewGfxEntityStep(casterCell,casterCell,targetCell,PREFIX_CASTER,"",caster);
         }
         if(runner.scriptData.hasParam("trailGfxId") && tmpTargetCell)
         {
            trailGfxShowUnder = false;
            if(runner.scriptData.hasParam("trailGfxShowUnder"))
            {
               trailGfxShowUnder = runner.scriptData.getBoolParam("trailGfxShowUnder");
            }
            useSpellZone = false;
            if(runner.scriptData.hasParam("useSpellZone"))
            {
               useSpellZone = runner.scriptData.getBoolParam("useSpellZone");
            }
            useOnlySpellZone = false;
            if(runner.scriptData.hasParam("useOnlySpellZone"))
            {
               useOnlySpellZone = runner.scriptData.getBoolParam("useOnlySpellZone");
            }
            trailStep = SequenceApi.CreateAddGfxInLineStep(runner,runner.scriptData.getNumberParam("trailGfxId"),casterCell,tmpTargetCell,runner.scriptData.getNumberParam("trailGfxYOffset"),runner.scriptData.getNumberParam("trailDisplayType"),runner.scriptData.getNumberParam("trailGfxMinScale"),runner.scriptData.getNumberParam("trailGfxMaxScale"),runner.scriptData.getBoolParam("startTrailOnCaster"),runner.scriptData.getBoolParam("endTrailOnTarget"),trailGfxShowUnder,useSpellZone,useOnlySpellZone,caster);
            if(entryPortalCell && tmpTargetCell == entryPortalCell)
            {
               trailStep2 = SequenceApi.CreateAddGfxInLineStep(runner,runner.scriptData.getNumberParam("trailGfxId"),tmpCasterCell,targetCell,runner.scriptData.getNumberParam("trailGfxYOffset"),runner.scriptData.getNumberParam("trailDisplayType"),runner.scriptData.getNumberParam("trailGfxMinScale"),runner.scriptData.getNumberParam("trailGfxMaxScale"),runner.scriptData.getBoolParam("startTrailOnCaster"),runner.scriptData.getBoolParam("endTrailOnTarget"),trailGfxShowUnder,useSpellZone,useOnlySpellZone);
            }
            if(!latestStep)
            {
               SpellFxApi.AddFrontStep(runner,trailStep);
            }
            else
            {
               SpellFxApi.AddStepAfter(runner,latestStep,trailStep);
            }
            latestStep = trailStep;
            if(trailStep2)
            {
               addPortalAnimationSteps(SpellFxApi.GetPortalIds(runner));
               SpellFxApi.AddStepAfter(runner,latestStep,trailStep2);
               latestStep = trailStep2;
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
