package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.servers.ServerSeason;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ServerSeasonTemporisCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function ServerSeasonTemporisCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         return "";
      }
      
      override public function clone() : IItemCriterion
      {
         return new ServerSeasonTemporisCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         var serverSeason:ServerSeason = ServerSeason.getCurrentSeason();
         return serverSeason != null && !serverSeason.isFinished() ? int(serverSeason.seasonNumber) : 0;
      }
      
      override public function get isRespected() : Boolean
      {
         return _operator.compare(this.getCriterion(),_criterionValue);
      }
   }
}
