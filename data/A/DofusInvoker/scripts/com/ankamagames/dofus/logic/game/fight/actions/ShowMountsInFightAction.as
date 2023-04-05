package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShowMountsInFightAction extends AbstractAction implements Action
   {
       
      
      private var _visibility:Boolean;
      
      public function ShowMountsInFightAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pVisibility:Boolean) : ShowMountsInFightAction
      {
         var action:ShowMountsInFightAction = new ShowMountsInFightAction(arguments);
         action._visibility = pVisibility;
         return action;
      }
      
      public function get visibility() : Boolean
      {
         return this._visibility;
      }
   }
}
