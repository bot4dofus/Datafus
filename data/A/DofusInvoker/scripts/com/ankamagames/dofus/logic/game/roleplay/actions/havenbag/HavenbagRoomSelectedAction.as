package com.ankamagames.dofus.logic.game.roleplay.actions.havenbag
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HavenbagRoomSelectedAction extends AbstractAction implements Action
   {
       
      
      public var room:uint;
      
      public function HavenbagRoomSelectedAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(room:uint) : HavenbagRoomSelectedAction
      {
         var a:HavenbagRoomSelectedAction = new HavenbagRoomSelectedAction(arguments);
         a.room = room;
         return a;
      }
   }
}
