package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenSocialAction extends AbstractAction implements Action
   {
       
      
      public var id:int;
      
      public function OpenSocialAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(id:int = -1) : OpenSocialAction
      {
         var a:OpenSocialAction = new OpenSocialAction(arguments);
         a.id = id;
         return a;
      }
   }
}
