package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ServerTypeItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function ServerTypeItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean
      {
         if(_operator.compare(PlayerManager.getInstance().serverGameType,_criterionValue))
         {
            return true;
         }
         return false;
      }
      
      override public function get text() : String
      {
         return "";
      }
      
      override public function clone() : IItemCriterion
      {
         return new ServerTypeItemCriterion(this.basicText);
      }
   }
}
