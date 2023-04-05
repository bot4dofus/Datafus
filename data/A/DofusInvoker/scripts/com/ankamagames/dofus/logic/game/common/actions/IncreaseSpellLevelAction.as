package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class IncreaseSpellLevelAction extends AbstractAction implements Action
   {
       
      
      public var spellId:uint;
      
      public var spellLevel:uint;
      
      public function IncreaseSpellLevelAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pSpellId:uint, pSpellLevel:uint) : IncreaseSpellLevelAction
      {
         var a:IncreaseSpellLevelAction = new IncreaseSpellLevelAction(arguments);
         a.spellId = pSpellId;
         a.spellLevel = pSpellLevel;
         return a;
      }
   }
}
