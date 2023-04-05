package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenCurrentFightAction extends AbstractAction implements Action
   {
       
      
      public var value:String;
      
      public function OpenCurrentFightAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : OpenCurrentFightAction
      {
         return new OpenCurrentFightAction(arguments);
      }
   }
}
