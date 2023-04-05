package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PlayerFightRequestAction extends AbstractAction implements Action
   {
       
      
      public var targetedPlayerId:Number;
      
      public var cellId:int;
      
      public var friendly:Boolean;
      
      public var launch:Boolean;
      
      public var ava:Boolean;
      
      public function PlayerFightRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(targetedPlayerId:Number, ava:Boolean, friendly:Boolean = true, launch:Boolean = false, cellId:int = -1) : PlayerFightRequestAction
      {
         var o:PlayerFightRequestAction = new PlayerFightRequestAction(arguments);
         o.ava = ava;
         o.friendly = friendly;
         o.cellId = cellId;
         o.targetedPlayerId = targetedPlayerId;
         o.launch = launch;
         return o;
      }
   }
}
