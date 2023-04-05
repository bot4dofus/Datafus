package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TabsUpdateAction extends AbstractAction implements Action
   {
       
      
      public var tabs:Array;
      
      public var tabsNames:Array;
      
      public function TabsUpdateAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(tabs:Array = null, tabsNames:Array = null) : TabsUpdateAction
      {
         var a:TabsUpdateAction = new TabsUpdateAction(arguments);
         a.tabs = tabs;
         a.tabsNames = tabsNames;
         return a;
      }
   }
}
