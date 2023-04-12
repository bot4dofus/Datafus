package com.ankamagames.dofus.logic.game.roleplay.actions.havenbag
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HavenbagResetAction extends AbstractAction implements Action
   {
       
      
      public function HavenbagResetAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : HavenbagResetAction
      {
         return new HavenbagResetAction(arguments);
      }
   }
}
