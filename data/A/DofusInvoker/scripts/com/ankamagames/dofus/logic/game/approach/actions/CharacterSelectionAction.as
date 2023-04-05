package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterSelectionAction extends AbstractAction implements Action
   {
       
      
      public var characterId:Number;
      
      public var btutoriel:Boolean;
      
      public function CharacterSelectionAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(characterId:Number, btutoriel:Boolean) : CharacterSelectionAction
      {
         var a:CharacterSelectionAction = new CharacterSelectionAction(arguments);
         a.characterId = characterId;
         a.btutoriel = btutoriel;
         return a;
      }
   }
}
