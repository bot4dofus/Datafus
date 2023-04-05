package com.ankamagames.dofus.logic.connection.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ReleaseAccountAction extends AbstractAction implements Action
   {
       
      
      public function ReleaseAccountAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ReleaseAccountAction
      {
         return new ReleaseAccountAction();
      }
   }
}
