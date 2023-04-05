package com.ankamagames.dofus.themes.utils.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ThemeListRequestAction extends AbstractAction implements Action
   {
       
      
      public var listUrl:String;
      
      public function ThemeListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(url:String) : ThemeListRequestAction
      {
         var action:ThemeListRequestAction = new ThemeListRequestAction(arguments);
         action.listUrl = url;
         return action;
      }
   }
}
