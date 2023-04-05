package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MountRenameRequestAction extends AbstractAction implements Action
   {
       
      
      public var newName:String;
      
      public var mountId:Number;
      
      public function MountRenameRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(newName:String, mountId:Number) : MountRenameRequestAction
      {
         var o:MountRenameRequestAction = new MountRenameRequestAction(arguments);
         o.newName = newName;
         o.mountId = mountId;
         return o;
      }
   }
}
