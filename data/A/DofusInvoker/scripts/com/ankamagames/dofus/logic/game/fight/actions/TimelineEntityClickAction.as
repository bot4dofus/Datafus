package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TimelineEntityClickAction extends AbstractAction implements Action
   {
       
      
      public var fighterId:Number;
      
      public function TimelineEntityClickAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(id:Number) : TimelineEntityClickAction
      {
         var a:TimelineEntityClickAction = new TimelineEntityClickAction(arguments);
         a.fighterId = id;
         return a;
      }
   }
}
