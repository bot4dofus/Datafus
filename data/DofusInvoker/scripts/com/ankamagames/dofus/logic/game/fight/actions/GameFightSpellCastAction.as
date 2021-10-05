package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightSpellCastAction extends AbstractAction implements Action
   {
       
      
      public var spellId:uint;
      
      public var slot:int;
      
      public function GameFightSpellCastAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(spellId:uint, slot:int) : GameFightSpellCastAction
      {
         var a:GameFightSpellCastAction = new GameFightSpellCastAction(arguments);
         a.spellId = spellId;
         a.slot = slot;
         return a;
      }
   }
}
