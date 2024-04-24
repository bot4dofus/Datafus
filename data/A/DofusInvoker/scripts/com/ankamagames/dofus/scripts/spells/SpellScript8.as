package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.dofus.scripts.SpellScriptRunner;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.dofus.scripts.api.SpellScriptRunnerUtils;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class SpellScript8 extends SpellScriptBase
   {
       
      
      public function SpellScript8(spellFxRunner:SpellScriptRunner)
      {
         var entryPortalCell:MapPoint = null;
         var exitPortalCell:MapPoint = null;
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
            if(entryPortalCell && tmpTargetCell == entryPortalCell)
            {
               addPortalAnimationSteps(SpellFxApi.GetPortalIds(runner));
               addNewGfxEntityStep(exitPortalCell,exitPortalCell,targetCell,PREFIX_CASTER);
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
