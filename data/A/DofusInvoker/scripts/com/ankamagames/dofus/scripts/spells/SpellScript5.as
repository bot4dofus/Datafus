package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.dofus.scripts.SpellScriptRunner;
   import com.ankamagames.dofus.scripts.api.SequenceApi;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.dofus.scripts.api.SpellScriptRunnerUtils;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class SpellScript5 extends SpellScriptBase
   {
       
      
      public function SpellScript5(spellFxRunner:SpellScriptRunner)
      {
         var entryPortalCell:MapPoint = null;
         var exitPortalCell:MapPoint = null;
         var glyphGfxStep:ISequencable = null;
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
         if(entryPortalCell)
         {
            addPortalAnimationSteps(SpellFxApi.GetPortalIds(runner));
         }
         if(runner.scriptData.hasParam("glyphGfxId") && spell.isSilentCast == false && targetCell && spell.markId)
         {
            glyphGfxStep = SequenceApi.CreateAddGlyphGfxStep(runner,runner.scriptData.getNumberParam("glyphGfxId"),targetCell,spell.markId);
            if(!latestStep)
            {
               SpellFxApi.AddFrontStep(runner,glyphGfxStep);
            }
            else
            {
               SpellFxApi.AddStepAfter(runner,latestStep,glyphGfxStep);
            }
            latestStep = glyphGfxStep;
         }
         if(runner.scriptData.hasParam("casterGfxId"))
         {
            addNewGfxEntityStep(casterCell,tmpCasterCell,targetCell,PREFIX_CASTER,"",caster);
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
