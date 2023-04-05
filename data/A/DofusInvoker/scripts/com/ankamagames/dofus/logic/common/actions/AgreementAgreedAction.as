package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AgreementAgreedAction extends AbstractAction implements Action
   {
       
      
      public var fileName:String;
      
      public function AgreementAgreedAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(fileName:String) : AgreementAgreedAction
      {
         var a:AgreementAgreedAction = new AgreementAgreedAction(arguments);
         a.fileName = fileName;
         return a;
      }
   }
}
