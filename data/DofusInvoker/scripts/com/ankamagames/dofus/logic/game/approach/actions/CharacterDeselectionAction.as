package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterDeselectionAction extends AbstractAction implements Action
   {
       
      
      public function CharacterDeselectionAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : CharacterDeselectionAction
      {
         return new CharacterDeselectionAction(arguments);
      }
   }
}
