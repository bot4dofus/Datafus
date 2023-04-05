package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenSmileysAction extends AbstractAction implements Action
   {
       
      
      public var type:int;
      
      public var forceOpen:String;
      
      public function OpenSmileysAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pType:int, pForceOpen:String = "") : OpenSmileysAction
      {
         var a:OpenSmileysAction = new OpenSmileysAction(arguments);
         a.type = pType;
         a.forceOpen = pForceOpen;
         return a;
      }
   }
}
