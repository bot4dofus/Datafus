package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class IdolSelectRequestAction extends AbstractAction implements Action
   {
       
      
      public var idolId:uint;
      
      public var activate:Boolean;
      
      public var party:Boolean;
      
      public function IdolSelectRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pIdolId:uint, pActivate:Boolean, pParty:Boolean) : IdolSelectRequestAction
      {
         var action:IdolSelectRequestAction = new IdolSelectRequestAction(arguments);
         action.idolId = pIdolId;
         action.activate = pActivate;
         action.party = pParty;
         return action;
      }
   }
}
