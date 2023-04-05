package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterDeletionAction extends AbstractAction implements Action
   {
       
      
      public var id:Number;
      
      public var answer:String;
      
      public function CharacterDeletionAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(id:Number, answer:String) : CharacterDeletionAction
      {
         var a:CharacterDeletionAction = new CharacterDeletionAction(arguments);
         a.id = id;
         a.answer = answer;
         return a;
      }
   }
}
