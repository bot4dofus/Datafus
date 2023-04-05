package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenServerSelectionAction extends AbstractAction implements Action
   {
       
      
      public var value:String;
      
      public function OpenServerSelectionAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : OpenServerSelectionAction
      {
         return new OpenServerSelectionAction(arguments);
      }
   }
}
