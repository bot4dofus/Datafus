package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMapAction;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import flash.utils.getQualifiedClassName;
   
   public class HyperlinkOpenAnomaly
   {
       
      
      public function HyperlinkOpenAnomaly()
      {
         super();
      }
      
      public static function getLink(pText:String) : String
      {
         return "{openAnomaly::" + pText + "}";
      }
      
      public static function open() : void
      {
         var openMapAction:OpenMapAction = OpenMapAction.create(false,false,false,true);
         var classInfo:Array = getQualifiedClassName(openMapAction).split("::");
         var apiAction:DofusApiAction = DofusApiAction.getApiActionByName(classInfo[classInfo.length - 1]);
         var actionToSend:Action = CallWithParameters.callR(apiAction.actionClass["create"],openMapAction.parameters);
         Kernel.getWorker().process(actionToSend);
      }
   }
}
