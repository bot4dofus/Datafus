package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenForgettableSpellsUiAction extends AbstractAction implements Action
   {
       
      
      public var isSpellSetsUi:Boolean = false;
      
      public var uiName:String = "forgettableSpellsUi";
      
      public function OpenForgettableSpellsUiAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(isSpellSetsUi:Boolean = false, uiName:String = "forgettableSpellsUi") : OpenForgettableSpellsUiAction
      {
         var newOpenForgettableSpellsUiAction:OpenForgettableSpellsUiAction = new OpenForgettableSpellsUiAction(arguments);
         newOpenForgettableSpellsUiAction.isSpellSetsUi = isSpellSetsUi;
         newOpenForgettableSpellsUiAction.uiName = uiName;
         return newOpenForgettableSpellsUiAction;
      }
   }
}
