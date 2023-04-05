package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StartZoomAction extends AbstractAction implements Action
   {
       
      
      public var playerId:Number;
      
      public var value:Number;
      
      public function StartZoomAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(playerId:Number, value:Number) : StartZoomAction
      {
         var action:StartZoomAction = new StartZoomAction(arguments);
         action.playerId = playerId;
         action.value = value;
         return action;
      }
   }
}
