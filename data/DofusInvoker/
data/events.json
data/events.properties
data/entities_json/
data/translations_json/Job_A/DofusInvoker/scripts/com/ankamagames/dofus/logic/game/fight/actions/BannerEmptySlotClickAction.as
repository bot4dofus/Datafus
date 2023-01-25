package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BannerEmptySlotClickAction extends AbstractAction implements Action
   {
       
      
      public function BannerEmptySlotClickAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : BannerEmptySlotClickAction
      {
         return new BannerEmptySlotClickAction(arguments);
      }
   }
}
