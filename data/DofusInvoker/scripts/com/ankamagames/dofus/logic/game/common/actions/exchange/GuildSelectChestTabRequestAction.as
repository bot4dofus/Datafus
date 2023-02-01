package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildSelectChestTabRequestAction extends AbstractAction implements Action
   {
       
      
      public var tabNumber:uint = 1;
      
      public function GuildSelectChestTabRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pTabNumber:uint) : GuildSelectChestTabRequestAction
      {
         var a:GuildSelectChestTabRequestAction = new GuildSelectChestTabRequestAction(arguments);
         a.tabNumber = pTabNumber;
         return a;
      }
   }
}
