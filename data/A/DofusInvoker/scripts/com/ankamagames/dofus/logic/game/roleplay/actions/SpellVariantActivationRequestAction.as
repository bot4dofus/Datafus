package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SpellVariantActivationRequestAction extends AbstractAction implements Action
   {
       
      
      public var spellId:uint;
      
      public function SpellVariantActivationRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(spellId:uint) : SpellVariantActivationRequestAction
      {
         var a:SpellVariantActivationRequestAction = new SpellVariantActivationRequestAction(arguments);
         a.spellId = spellId;
         return a;
      }
   }
}
