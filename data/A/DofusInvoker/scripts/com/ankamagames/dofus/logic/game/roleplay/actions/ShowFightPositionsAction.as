package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShowFightPositionsAction extends AbstractAction implements Action
   {
       
      
      public var fromShortcut:Boolean;
      
      public function ShowFightPositionsAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pFromShortcut:Boolean = true) : ShowFightPositionsAction
      {
         var a:ShowFightPositionsAction = new ShowFightPositionsAction(arguments);
         a.fromShortcut = pFromShortcut;
         return a;
      }
   }
}
