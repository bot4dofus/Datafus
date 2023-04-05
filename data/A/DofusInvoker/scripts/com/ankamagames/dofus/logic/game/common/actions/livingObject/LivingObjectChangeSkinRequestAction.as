package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LivingObjectChangeSkinRequestAction extends AbstractAction implements Action
   {
       
      
      public var livingUID:uint;
      
      public var livingPosition:uint;
      
      public var skinId:uint;
      
      public function LivingObjectChangeSkinRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(livingUID:uint, livingPosition:uint, skinId:uint) : LivingObjectChangeSkinRequestAction
      {
         var action:LivingObjectChangeSkinRequestAction = new LivingObjectChangeSkinRequestAction(arguments);
         action.livingUID = livingUID;
         action.livingPosition = livingPosition;
         action.skinId = skinId;
         return action;
      }
   }
}
