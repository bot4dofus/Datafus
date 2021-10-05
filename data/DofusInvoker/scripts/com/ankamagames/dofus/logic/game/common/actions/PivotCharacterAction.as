package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PivotCharacterAction extends AbstractAction implements Action
   {
       
      
      public function PivotCharacterAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : PivotCharacterAction
      {
         return new PivotCharacterAction(arguments);
      }
   }
}
