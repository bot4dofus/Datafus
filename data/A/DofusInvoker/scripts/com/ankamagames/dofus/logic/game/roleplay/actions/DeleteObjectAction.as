package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DeleteObjectAction extends AbstractAction implements Action
   {
       
      
      public var objectUID:uint;
      
      public var quantity:uint;
      
      public function DeleteObjectAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(objectUID:uint, quantity:uint) : DeleteObjectAction
      {
         var a:DeleteObjectAction = new DeleteObjectAction(arguments);
         a.objectUID = objectUID;
         a.quantity = quantity;
         return a;
      }
   }
}
