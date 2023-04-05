package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AccessoryPreviewRequestAction extends AbstractAction implements Action
   {
       
      
      public var itemGIDs:Vector.<uint>;
      
      public function AccessoryPreviewRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(itemGIDs:Vector.<uint>) : AccessoryPreviewRequestAction
      {
         var action:AccessoryPreviewRequestAction = new AccessoryPreviewRequestAction(arguments);
         action.itemGIDs = itemGIDs;
         return action;
      }
   }
}
