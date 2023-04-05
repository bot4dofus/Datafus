package com.ankamagames.dofus.logic.connection.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class NicknameChoiceRequestAction extends AbstractAction implements Action
   {
       
      
      public var nickname:String;
      
      public function NicknameChoiceRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(nickname:String) : NicknameChoiceRequestAction
      {
         var a:NicknameChoiceRequestAction = new NicknameChoiceRequestAction(arguments);
         a.nickname = nickname;
         return a;
      }
   }
}
