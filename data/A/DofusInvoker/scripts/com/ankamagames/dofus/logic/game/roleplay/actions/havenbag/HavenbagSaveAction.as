package com.ankamagames.dofus.logic.game.roleplay.actions.havenbag
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HavenbagSaveAction extends AbstractAction implements Action
   {
       
      
      public function HavenbagSaveAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : HavenbagSaveAction
      {
         return new HavenbagSaveAction(arguments);
      }
   }
}
