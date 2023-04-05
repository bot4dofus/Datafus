package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightSpellCastAction extends AbstractAction implements Action
   {
       
      
      public var entityId:Number = 1.7976931348623157E308;
      
      public var spellId:uint;
      
      public var slot:int;
      
      public function GameFightSpellCastAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(entityId:Number, spellId:uint, slot:int) : GameFightSpellCastAction
      {
         var a:GameFightSpellCastAction = new GameFightSpellCastAction(arguments);
         a.entityId = entityId;
         a.spellId = spellId;
         a.slot = slot;
         return a;
      }
   }
}
