package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MountSetXpRatioRequestAction extends AbstractAction implements Action
   {
       
      
      public var xpRatio:uint;
      
      public function MountSetXpRatioRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(xpRatio:uint) : MountSetXpRatioRequestAction
      {
         var o:MountSetXpRatioRequestAction = new MountSetXpRatioRequestAction(arguments);
         o.xpRatio = xpRatio;
         return o;
      }
   }
}
