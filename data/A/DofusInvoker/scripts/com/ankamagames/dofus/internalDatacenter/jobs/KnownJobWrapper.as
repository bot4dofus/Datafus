package com.ankamagames.dofus.internalDatacenter.jobs
{
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobDescription;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class KnownJobWrapper implements IDataCenter
   {
       
      
      public var id:int;
      
      public var jobDescription:JobDescription;
      
      public var name:String;
      
      public var iconId:int;
      
      public var jobLevel:uint = 0;
      
      public var jobXP:Number = 0;
      
      public var jobXpLevelFloor:Number = 0;
      
      public var jobXpNextLevelFloor:Number = 0;
      
      public var jobBookSubscriber:Boolean = false;
      
      public function KnownJobWrapper()
      {
         super();
      }
      
      public static function create(id:int) : KnownJobWrapper
      {
         var obj:KnownJobWrapper = new KnownJobWrapper();
         obj.id = id;
         var job:Job = Job.getJobById(id);
         if(job)
         {
            obj.name = job.name;
            obj.iconId = job.iconId;
         }
         return obj;
      }
   }
}
