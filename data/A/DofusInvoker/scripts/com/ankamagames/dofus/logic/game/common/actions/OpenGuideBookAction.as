package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenGuideBookAction extends AbstractAction implements Action
   {
       
      
      public var tab:String;
      
      public var params:Object;
      
      public function OpenGuideBookAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(tab:String, featureId:uint = 0, dataAccessType:String = "") : OpenGuideBookAction
      {
         var a:OpenGuideBookAction = new OpenGuideBookAction(arguments);
         a.tab = tab;
         a.params = featureId != 0 ? [featureId,dataAccessType] : null;
         return a;
      }
   }
}
