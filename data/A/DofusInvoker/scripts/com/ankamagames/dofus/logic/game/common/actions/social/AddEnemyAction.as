package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AddEnemyAction extends AbstractAction implements Action
   {
       
      
      public var name:String;
      
      public var tag:String;
      
      public function AddEnemyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(name:String, tag:String) : AddEnemyAction
      {
         var a:AddEnemyAction = new AddEnemyAction(arguments);
         a.name = name;
         a.tag = tag;
         return a;
      }
   }
}
