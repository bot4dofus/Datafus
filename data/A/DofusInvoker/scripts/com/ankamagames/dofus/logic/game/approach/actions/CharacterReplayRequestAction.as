package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterReplayRequestAction extends AbstractAction implements Action
   {
       
      
      public var characterId:Number;
      
      public function CharacterReplayRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(characterId:Number) : CharacterReplayRequestAction
      {
         var a:CharacterReplayRequestAction = new CharacterReplayRequestAction(arguments);
         a.characterId = characterId;
         return a;
      }
   }
}
