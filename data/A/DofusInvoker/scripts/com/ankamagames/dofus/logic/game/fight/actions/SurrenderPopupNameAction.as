package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SurrenderPopupNameAction extends AbstractAction implements Action
   {
       
      
      private var _surrenderPopupName:String;
      
      public function SurrenderPopupNameAction(parameters:Array = null)
      {
         super(parameters);
      }
      
      public static function create(name:String) : SurrenderPopupNameAction
      {
         var action:SurrenderPopupNameAction = new SurrenderPopupNameAction(arguments);
         action._surrenderPopupName = name;
         return action;
      }
      
      public function get popupName() : String
      {
         return this._surrenderPopupName;
      }
   }
}
