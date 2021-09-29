package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AddIgnoredAction extends AbstractAction implements Action
   {
       
      
      public var name:String;
      
      public var tag:String;
      
      public function AddIgnoredAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(name:String, tag:String) : AddIgnoredAction
      {
         var a:AddIgnoredAction = new AddIgnoredAction(arguments);
         a.name = name;
         a.tag = tag;
         return a;
      }
   }
}
