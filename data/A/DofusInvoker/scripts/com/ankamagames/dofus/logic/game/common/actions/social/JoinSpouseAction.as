package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JoinSpouseAction extends AbstractAction implements Action
   {
       
      
      public function JoinSpouseAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : JoinSpouseAction
      {
         return new JoinSpouseAction(arguments);
      }
   }
}
