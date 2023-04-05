package com.ankamagames.dofus.logic.game.common.actions.tinsel
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OrnamentSelectRequestAction extends AbstractAction implements Action
   {
       
      
      public var ornamentId:int;
      
      public function OrnamentSelectRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(ornamentId:int) : OrnamentSelectRequestAction
      {
         var action:OrnamentSelectRequestAction = new OrnamentSelectRequestAction(arguments);
         action.ornamentId = ornamentId;
         return action;
      }
   }
}
