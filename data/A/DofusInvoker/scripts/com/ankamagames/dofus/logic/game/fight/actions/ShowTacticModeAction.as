package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShowTacticModeAction extends AbstractAction implements Action
   {
       
      
      public var force:Boolean;
      
      public function ShowTacticModeAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pForce:Boolean = false) : ShowTacticModeAction
      {
         var a:ShowTacticModeAction = new ShowTacticModeAction(arguments);
         a.force = pForce;
         return a;
      }
   }
}
