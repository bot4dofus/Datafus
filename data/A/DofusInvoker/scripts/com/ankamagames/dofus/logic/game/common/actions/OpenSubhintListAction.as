package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenSubhintListAction extends AbstractAction implements Action
   {
       
      
      public function OpenSubhintListAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : OpenSubhintListAction
      {
         return new OpenSubhintListAction(arguments);
      }
   }
}
