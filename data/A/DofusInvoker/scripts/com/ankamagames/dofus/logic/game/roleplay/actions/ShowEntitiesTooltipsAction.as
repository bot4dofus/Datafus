package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShowEntitiesTooltipsAction extends AbstractAction implements Action
   {
       
      
      public var fromShortcut:Boolean;
      
      public function ShowEntitiesTooltipsAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pFromShortcut:Boolean = true) : ShowEntitiesTooltipsAction
      {
         var a:ShowEntitiesTooltipsAction = new ShowEntitiesTooltipsAction(arguments);
         a.fromShortcut = pFromShortcut;
         return a;
      }
   }
}
