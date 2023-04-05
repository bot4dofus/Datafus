package com.ankamagames.dofus.themes.utils.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ThemeDeleteRequestAction extends AbstractAction implements Action
   {
       
      
      public var themeDirectory:String;
      
      public function ThemeDeleteRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(directoryName:String) : ThemeDeleteRequestAction
      {
         var action:ThemeDeleteRequestAction = new ThemeDeleteRequestAction(arguments);
         action.themeDirectory = directoryName;
         return action;
      }
   }
}
