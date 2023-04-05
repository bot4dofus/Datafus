package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ObjectSetPositionAction extends AbstractAction implements Action
   {
       
      
      public var objectUID:uint;
      
      public var position:uint;
      
      public var quantity:uint;
      
      public function ObjectSetPositionAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(objectUID:uint, position:uint, quantity:uint = 1) : ObjectSetPositionAction
      {
         var a:ObjectSetPositionAction = new ObjectSetPositionAction(arguments);
         a.objectUID = objectUID;
         a.quantity = quantity;
         a.position = position;
         return a;
      }
   }
}
