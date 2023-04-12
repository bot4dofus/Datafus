package com.ankamagames.dofus.logic.game.roleplay.actions.alterations
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class UpdateAlterationFavoriteFlagAction extends AbstractAction implements Action
   {
       
      
      public var alterationId:Number = -1;
      
      public var isFavorite:Boolean = false;
      
      public function UpdateAlterationFavoriteFlagAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(alterationId:Number, isFavorite:Boolean) : UpdateAlterationFavoriteFlagAction
      {
         var action:UpdateAlterationFavoriteFlagAction = new UpdateAlterationFavoriteFlagAction(arguments);
         action.alterationId = alterationId;
         action.isFavorite = isFavorite;
         return action;
      }
   }
}
