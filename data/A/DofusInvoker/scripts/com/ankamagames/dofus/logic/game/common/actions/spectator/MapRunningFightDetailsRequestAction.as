package com.ankamagames.dofus.logic.game.common.actions.spectator
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MapRunningFightDetailsRequestAction extends AbstractAction implements Action
   {
       
      
      public var fightId:uint;
      
      public function MapRunningFightDetailsRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(fightId:uint) : MapRunningFightDetailsRequestAction
      {
         var a:MapRunningFightDetailsRequestAction = new MapRunningFightDetailsRequestAction(arguments);
         a.fightId = fightId;
         return a;
      }
   }
}
