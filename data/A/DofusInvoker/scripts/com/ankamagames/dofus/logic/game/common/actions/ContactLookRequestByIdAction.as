package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ContactLookRequestByIdAction extends AbstractAction implements Action
   {
       
      
      private var _contactType:uint;
      
      private var _entityId:Number;
      
      public function ContactLookRequestByIdAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pContactType:uint, pEntityId:Number) : ContactLookRequestByIdAction
      {
         var clrbia:ContactLookRequestByIdAction = new ContactLookRequestByIdAction(arguments);
         clrbia._contactType = pContactType;
         clrbia._entityId = pEntityId;
         return clrbia;
      }
      
      public function get contactType() : uint
      {
         return this._contactType;
      }
      
      public function get entityId() : Number
      {
         return this._entityId;
      }
   }
}
