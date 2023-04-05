package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HighlightInteractiveElementsAction extends AbstractAction implements Action
   {
       
      
      public var fromShortcut:Boolean;
      
      public function HighlightInteractiveElementsAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pFromShortcut:Boolean = true) : HighlightInteractiveElementsAction
      {
         var a:HighlightInteractiveElementsAction = new HighlightInteractiveElementsAction(arguments);
         a.fromShortcut = pFromShortcut;
         return a;
      }
   }
}
