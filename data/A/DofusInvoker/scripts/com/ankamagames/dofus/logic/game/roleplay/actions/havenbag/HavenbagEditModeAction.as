package com.ankamagames.dofus.logic.game.roleplay.actions.havenbag
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HavenbagEditModeAction extends AbstractAction implements Action
   {
       
      
      public var isActive:Boolean;
      
      public function HavenbagEditModeAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(isActive:Boolean) : HavenbagEditModeAction
      {
         var a:HavenbagEditModeAction = new HavenbagEditModeAction(arguments);
         a.isActive = isActive;
         return a;
      }
   }
}
