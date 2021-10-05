package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.dofus.scripts.api.FxApi;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class SpellScript8 extends SpellScriptBase
   {
       
      
      public function SpellScript8(spellFxRunner:SpellFxRunner)
      {
         var entryPortalCell:MapPoint = null;
         var exitPortalCell:MapPoint = null;
         super(spellFxRunner);
         var targetCell:MapPoint = FxApi.GetCurrentTargetedCell(runner);
         var casterCell:MapPoint = FxApi.GetEntityCell(caster);
         var portalsCells:Vector.<MapPoint> = SpellFxApi.GetPortalCells(runner);
         if(portalsCells && portalsCells.length > 1)
         {
            entryPortalCell = portalsCells[0];
            exitPortalCell = portalsCells[portalsCells.length - 1];
         }
         var tmpTargetCell:MapPoint = !!entryPortalCell ? entryPortalCell : targetCell;
         var tmpCasterCell:MapPoint = !!exitPortalCell ? exitPortalCell : casterCell;
         addCasterSetDirectionStep(tmpTargetCell);
         addCasterAnimationStep();
         if(SpellFxApi.HasSpellParam(spell,"casterGfxId"))
         {
            addNewGfxEntityStep(casterCell,casterCell,tmpTargetCell,PREFIX_CASTER,"",caster);
            if(entryPortalCell && tmpTargetCell == entryPortalCell)
            {
               addPortalAnimationSteps(SpellFxApi.GetPortalIds(runner));
               addNewGfxEntityStep(exitPortalCell,exitPortalCell,targetCell,PREFIX_CASTER);
            }
         }
         if(SpellFxApi.HasSpellParam(spell,"targetGfxId"))
         {
            addNewGfxEntityStep(targetCell,tmpCasterCell,targetCell,PREFIX_TARGET);
         }
         addAnimHitSteps();
         addFBackgroundSteps();
         destroy();
      }
   }
}
