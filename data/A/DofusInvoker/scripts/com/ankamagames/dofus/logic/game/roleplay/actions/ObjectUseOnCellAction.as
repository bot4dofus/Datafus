package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ObjectUseOnCellAction extends AbstractAction implements Action
   {
       
      
      public var targetedCell:uint;
      
      public var objectUID:uint;
      
      public function ObjectUseOnCellAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(objectUID:uint, targetedCell:uint) : ObjectUseOnCellAction
      {
         var o:ObjectUseOnCellAction = new ObjectUseOnCellAction(arguments);
         o.targetedCell = targetedCell;
         o.objectUID = objectUID;
         return o;
      }
   }
}
