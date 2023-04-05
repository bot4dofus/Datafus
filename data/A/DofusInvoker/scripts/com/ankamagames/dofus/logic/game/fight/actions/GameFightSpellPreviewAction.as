package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightSpellPreviewAction extends AbstractAction implements Action
   {
       
      
      public var entityId:Number = 1.7976931348623157E308;
      
      public var spellWrapper:SpellWrapper = null;
      
      public function GameFightSpellPreviewAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(entityId:Number, spellWrapper:SpellWrapper) : GameFightSpellPreviewAction
      {
         var action:GameFightSpellPreviewAction = new GameFightSpellPreviewAction(arguments);
         action.entityId = entityId;
         action.spellWrapper = spellWrapper;
         return action;
      }
   }
}
