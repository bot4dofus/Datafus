package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ForgettableSpellClientAction extends AbstractAction implements Action
   {
       
      
      public var spellId:uint;
      
      public var action:uint;
      
      public function ForgettableSpellClientAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(spellId:uint, action:uint) : ForgettableSpellClientAction
      {
         var forgettableSpellClientAction:ForgettableSpellClientAction = new ForgettableSpellClientAction(arguments);
         forgettableSpellClientAction.spellId = spellId;
         forgettableSpellClientAction.action = action;
         return forgettableSpellClientAction;
      }
   }
}
