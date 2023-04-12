package com.ankamagames.dofus.logic.game.fight.behaviours
{
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.behaviours.IEntityDeleteBehavior;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightTurnFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   
   public class FightEntityDeleteBehavior implements IEntityDeleteBehavior
   {
      
      private static var _self:FightEntityDeleteBehavior;
       
      
      public function FightEntityDeleteBehavior()
      {
         super();
      }
      
      public static function getInstance() : FightEntityDeleteBehavior
      {
         if(!_self)
         {
            _self = new FightEntityDeleteBehavior();
         }
         return _self;
      }
      
      public function entityDeleted(pEntity:AnimatedCharacter) : void
      {
         var castFrame:FightSpellCastFrame = null;
         var entitiesFrame:FightEntitiesFrame = null;
         var casterInfos:GameFightFighterInformations = null;
         var selection:Selection = null;
         var fightTurnFrame:FightTurnFrame = null;
         if(pEntity.rootEntity == pEntity)
         {
            castFrame = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
            entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            if(!entitiesFrame || !castFrame)
            {
               return;
            }
            casterInfos = !!entitiesFrame ? entitiesFrame.getEntityInfos(CurrentPlayedFighterManager.getInstance().currentFighterId) as GameFightFighterInformations : null;
            selection = SelectionManager.getInstance().getSelection("SpellCastRange");
            if(casterInfos && !castFrame.isSummoningPreviewEntity(pEntity.id) && !castFrame.isTeleportationPreviewEntity(pEntity.id) && selection && selection.cells && selection.cells.length && pEntity.position && SelectionManager.getInstance().isInside(pEntity.position.cellId,"SpellCastLos"))
            {
               FightSpellCastFrame.updateRangeAndTarget();
            }
            fightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            if(fightTurnFrame && fightTurnFrame.myTurn)
            {
               fightTurnFrame.updatePath();
            }
         }
      }
   }
}
