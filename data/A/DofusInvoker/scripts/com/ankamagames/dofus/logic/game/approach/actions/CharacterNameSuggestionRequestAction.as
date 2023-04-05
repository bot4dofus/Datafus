package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterNameSuggestionRequestAction extends AbstractAction implements Action
   {
       
      
      public function CharacterNameSuggestionRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : CharacterNameSuggestionRequestAction
      {
         return new CharacterNameSuggestionRequestAction(arguments);
      }
   }
}
