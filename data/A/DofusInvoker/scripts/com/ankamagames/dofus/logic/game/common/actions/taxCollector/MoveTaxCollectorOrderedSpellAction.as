package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MoveTaxCollectorOrderedSpellAction extends AbstractAction implements Action
   {
       
      
      public var uId:Number;
      
      public var movedFrom:uint;
      
      public var movedTo:uint;
      
      public function MoveTaxCollectorOrderedSpellAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(uId:Number, movedFrom:uint, movedTo:uint) : MoveTaxCollectorOrderedSpellAction
      {
         var a:MoveTaxCollectorOrderedSpellAction = new MoveTaxCollectorOrderedSpellAction(arguments);
         a.uId = uId;
         a.movedFrom = movedFrom;
         a.movedTo = movedTo;
         return a;
      }
   }
}
