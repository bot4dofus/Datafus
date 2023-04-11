package com.ankamagames.dofus.logic.game.roleplay.actions.havenbag
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HavenbagExitAction extends AbstractAction implements Action
   {
       
      
      public function HavenbagExitAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : HavenbagExitAction
      {
         return new HavenbagExitAction(arguments);
      }
   }
}
