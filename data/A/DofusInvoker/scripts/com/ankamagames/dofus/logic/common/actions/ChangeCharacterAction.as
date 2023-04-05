package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChangeCharacterAction extends AbstractAction implements Action
   {
       
      
      public var serverId:uint;
      
      public function ChangeCharacterAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(serverId:uint) : ChangeCharacterAction
      {
         var a:ChangeCharacterAction = new ChangeCharacterAction(arguments);
         a.serverId = serverId;
         return a;
      }
   }
}
