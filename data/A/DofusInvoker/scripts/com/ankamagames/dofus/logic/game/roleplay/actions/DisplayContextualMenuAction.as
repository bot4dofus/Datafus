package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DisplayContextualMenuAction extends AbstractAction implements Action
   {
       
      
      public var playerId:Number;
      
      public function DisplayContextualMenuAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(playerId:Number) : DisplayContextualMenuAction
      {
         var o:DisplayContextualMenuAction = new DisplayContextualMenuAction(arguments);
         o.playerId = playerId;
         return o;
      }
   }
}
