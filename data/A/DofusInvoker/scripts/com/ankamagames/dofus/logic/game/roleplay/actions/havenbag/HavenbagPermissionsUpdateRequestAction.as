package com.ankamagames.dofus.logic.game.roleplay.actions.havenbag
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HavenbagPermissionsUpdateRequestAction extends AbstractAction implements Action
   {
       
      
      public var permissions:uint;
      
      public function HavenbagPermissionsUpdateRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(permissions:uint) : HavenbagPermissionsUpdateRequestAction
      {
         var a:HavenbagPermissionsUpdateRequestAction = new HavenbagPermissionsUpdateRequestAction(arguments);
         a.permissions = permissions;
         return a;
      }
   }
}
