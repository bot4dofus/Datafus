package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class UpdateSpellModifierAction extends AbstractAction implements Action
   {
       
      
      private var _entityId:Number = NaN;
      
      private var _spellId:Number = NaN;
      
      private var _statId:Number = NaN;
      
      public function UpdateSpellModifierAction(entityId:Number, spellId:Number, statId:Number)
      {
         super(null);
         this._entityId = entityId;
         this._spellId = spellId;
         this._statId = statId;
      }
      
      public static function create(entityId:Number, spellId:Number, statId:Number) : UpdateSpellModifierAction
      {
         return new UpdateSpellModifierAction(entityId,spellId,statId);
      }
      
      public function get entityId() : Number
      {
         return this._entityId;
      }
      
      public function get spellId() : Number
      {
         return this._spellId;
      }
      
      public function get statId() : Number
      {
         return this._statId;
      }
   }
}
