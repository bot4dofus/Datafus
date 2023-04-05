package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GiftAssignAllRequestAction extends AbstractAction implements Action
   {
       
      
      public var characterId:Number;
      
      public function GiftAssignAllRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(characterId:Number) : GiftAssignAllRequestAction
      {
         var a:GiftAssignAllRequestAction = new GiftAssignAllRequestAction(arguments);
         a.characterId = characterId;
         return a;
      }
   }
}
