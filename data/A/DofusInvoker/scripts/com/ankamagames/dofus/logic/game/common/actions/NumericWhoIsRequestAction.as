package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class NumericWhoIsRequestAction extends AbstractAction implements Action
   {
       
      
      public var playerId:Number;
      
      public function NumericWhoIsRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(playerId:Number) : NumericWhoIsRequestAction
      {
         var a:NumericWhoIsRequestAction = new NumericWhoIsRequestAction(arguments);
         a.playerId = playerId;
         return a;
      }
   }
}
