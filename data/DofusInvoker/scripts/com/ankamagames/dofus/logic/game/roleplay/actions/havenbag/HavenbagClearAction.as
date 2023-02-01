package com.ankamagames.dofus.logic.game.roleplay.actions.havenbag
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HavenbagClearAction extends AbstractAction implements Action
   {
       
      
      public function HavenbagClearAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : HavenbagClearAction
      {
         return new HavenbagClearAction(arguments);
      }
   }
}
