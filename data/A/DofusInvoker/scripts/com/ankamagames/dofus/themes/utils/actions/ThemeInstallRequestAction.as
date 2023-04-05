package com.ankamagames.dofus.themes.utils.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ThemeInstallRequestAction extends AbstractAction implements Action
   {
       
      
      public var url:String;
      
      public function ThemeInstallRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(url:String) : ThemeInstallRequestAction
      {
         var action:ThemeInstallRequestAction = new ThemeInstallRequestAction(arguments);
         action.url = url;
         return action;
      }
   }
}
