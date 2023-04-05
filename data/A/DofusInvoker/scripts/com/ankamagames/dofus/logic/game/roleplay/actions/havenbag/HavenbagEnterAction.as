package com.ankamagames.dofus.logic.game.roleplay.actions.havenbag
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HavenbagEnterAction extends AbstractAction implements Action
   {
       
      
      public var ownerId:Number;
      
      public function HavenbagEnterAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(ownerId:Number = -1) : HavenbagEnterAction
      {
         var a:HavenbagEnterAction = new HavenbagEnterAction(arguments);
         a.ownerId = ownerId;
         return a;
      }
   }
}
