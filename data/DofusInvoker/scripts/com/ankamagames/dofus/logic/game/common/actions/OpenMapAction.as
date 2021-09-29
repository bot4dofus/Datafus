package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenMapAction extends AbstractAction implements Action
   {
       
      
      public var ignoreSetting:Boolean;
      
      public var fromShortcut:Boolean;
      
      public var conquest:Boolean;
      
      public function OpenMapAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(ignoreSetting:Boolean = false, fromShortcut:Boolean = false, conquest:Boolean = false) : OpenMapAction
      {
         var a:OpenMapAction = new OpenMapAction(arguments);
         a.ignoreSetting = ignoreSetting;
         a.fromShortcut = fromShortcut;
         a.conquest = conquest;
         return a;
      }
   }
}
