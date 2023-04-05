package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ObjectUseAction extends AbstractAction implements Action
   {
       
      
      public var objectUID:uint;
      
      public var useOnCell:Boolean;
      
      public var quantity:int;
      
      public function ObjectUseAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(objectUID:uint, quantity:int = 1, useOnCell:Boolean = false) : ObjectUseAction
      {
         var a:ObjectUseAction = new ObjectUseAction(arguments);
         a.objectUID = objectUID;
         a.quantity = quantity;
         a.useOnCell = useOnCell;
         return a;
      }
   }
}
