package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DirectSelectionCharacterAction extends AbstractAction implements Action
   {
       
      
      public var serverId:uint;
      
      public var characterId:Number;
      
      public function DirectSelectionCharacterAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(serverId:uint, characterId:Number) : DirectSelectionCharacterAction
      {
         var a:DirectSelectionCharacterAction = new DirectSelectionCharacterAction(arguments);
         a.serverId = serverId;
         a.characterId = characterId;
         return a;
      }
   }
}
