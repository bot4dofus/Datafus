package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenGuidebookAction extends AbstractAction implements Action
   {
       
      
      public var tab:String;
      
      public var params:Object;
      
      public function OpenGuidebookAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(tab:String, featureId:uint = 0, dataAccessType:String = "") : OpenGuidebookAction
      {
         var a:OpenGuidebookAction = new OpenGuidebookAction(arguments);
         a.tab = tab;
         a.params = featureId != 0 ? [featureId,dataAccessType] : null;
         return a;
      }
   }
}
