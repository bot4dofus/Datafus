package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GiftAssignRequestAction extends AbstractAction implements Action
   {
       
      
      public var giftId:uint;
      
      public var characterId:Number;
      
      public function GiftAssignRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(giftId:uint, characterId:Number) : GiftAssignRequestAction
      {
         var action:GiftAssignRequestAction = new GiftAssignRequestAction(arguments);
         action.giftId = giftId;
         action.characterId = characterId;
         return action;
      }
   }
}
