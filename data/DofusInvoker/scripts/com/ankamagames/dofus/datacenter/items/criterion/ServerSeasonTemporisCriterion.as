package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.servers.ServerTemporisSeason;
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
         var serverSeason:ServerTemporisSeason = ServerTemporisSeason.getCurrentSeason();
         return serverSeason != null ? int(serverSeason.seasonNumber) : 0;
      }
   }
}
