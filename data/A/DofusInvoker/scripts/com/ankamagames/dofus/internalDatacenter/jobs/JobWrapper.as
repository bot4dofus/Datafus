package com.ankamagames.dofus.internalDatacenter.jobs
{
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   public class JobWrapper extends Proxy implements IDataCenter, ISlotData
   {
      
      private static var _cache:Array = new Array();
       
      
      private var _uri:Uri;
      
      private var _id:uint = 0;
      
      private var _gfxId:uint = 0;
      
      public function JobWrapper()
      {
         super();
      }
      
      public static function create(jobID:uint, useCache:Boolean = true) : JobWrapper
      {
         var job:JobWrapper = null;
         if(!_cache[jobID] || !useCache)
         {
            job = new JobWrapper();
            job.jobId = jobID;
            if(useCache)
            {
               _cache[jobID] = job;
            }
         }
         else
         {
            job = _cache[jobID];
         }
         job.jobId = jobID;
         job.gfxId = jobID;
         return job;
      }
      
      public function get iconUri() : Uri
      {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/jobs/").concat(this._id).concat(".png"));
         }
         return this._uri;
      }
      
      public function get fullSizeIconUri() : Uri
      {
         return this.iconUri;
      }
      
      public function get errorIconUri() : Uri
      {
         return null;
      }
      
      public function get info1() : String
      {
         return null;
      }
      
      public function get startTime() : int
      {
         return 0;
      }
      
      public function get endTime() : int
      {
         return 0;
      }
      
      public function set endTime(t:int) : void
      {
      }
      
      public function get timer() : int
      {
         return 0;
      }
      
      public function get active() : Boolean
      {
         return true;
      }
      
      public function addHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function removeHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function set jobId(val:uint) : void
      {
         this._id = this.jobId;
      }
      
      public function get jobId() : uint
      {
         return this._id;
      }
      
      public function set gfxId(val:uint) : void
      {
         this._gfxId = val;
      }
      
      public function get gfxId() : uint
      {
         return this._gfxId;
      }
      
      public function get job() : Job
      {
         return Job.getJobById(this._id);
      }
      
      override flash_proxy function getProperty(name:*) : *
      {
         var l:* = undefined;
         var r:* = undefined;
         if(isAttribute(name))
         {
            return this[name];
         }
         l = this.job;
         if(!l)
         {
            r = "";
         }
         try
         {
            return l[name];
         }
         catch(e:Error)
         {
            return "Error_on_job_" + name;
         }
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean
      {
         return isAttribute(name);
      }
   }
}
