package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import com.ankamagames.dofus.internalDatacenter.jobs.KnownJobWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   
   public class JobItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      private const VALUE_NOT_SPECIFIC_JOB:uint = 4.294967295E9;
      
      private var _jobId:uint;
      
      private var _jobsCount:int;
      
      private var _jobLevel:int = -1;
      
      public function JobItemCriterion(pCriterion:String)
      {
         var isValidNumber:Boolean = false;
         var _jobIdentifier:Array = null;
         super(pCriterion);
         var arrayParams:Array = String(_criterionValueText).split(",");
         if(arrayParams && arrayParams.length > 0)
         {
            if(arrayParams.length <= 2)
            {
               isValidNumber = !isNaN(parseInt(arrayParams[0])) && parseInt(arrayParams[0]) > 0;
               if(isValidNumber)
               {
                  this._jobId = uint(arrayParams[0]);
                  this._jobsCount = 1;
               }
               else
               {
                  _jobIdentifier = arrayParams[0].split("");
                  if(_jobIdentifier[0] == "a")
                  {
                     this._jobId = this.VALUE_NOT_SPECIFIC_JOB;
                     this._jobsCount = 1;
                  }
                  else if(_jobIdentifier[0] == "n")
                  {
                     this._jobId = this.VALUE_NOT_SPECIFIC_JOB;
                     this._jobsCount = parseInt(_jobIdentifier[1]);
                  }
                  else
                  {
                     this._jobId = 0;
                     this._jobsCount = 0;
                  }
               }
               this._jobLevel = int(arrayParams[1]);
            }
         }
         else
         {
            this._jobId = uint(_criterionValue);
            this._jobLevel = -1;
         }
      }
      
      override public function get isRespected() : Boolean
      {
         var knownJob:KnownJobWrapper = null;
         var knownJobCount:int = 0;
         var knownJobs:Array = PlayedCharacterManager.getInstance().jobs;
         if(this._jobsCount > 0)
         {
            if(this._jobId == this.VALUE_NOT_SPECIFIC_JOB)
            {
               knownJobCount = 0;
               for each(knownJob in knownJobs)
               {
                  if(knownJob)
                  {
                     if(this._jobLevel == -1 || knownJob.jobLevel > this._jobLevel)
                     {
                        knownJobCount++;
                     }
                     if(knownJobCount >= this._jobsCount)
                     {
                        return true;
                     }
                  }
               }
            }
            else
            {
               knownJob = knownJobs[this._jobId];
               if(!knownJob)
               {
                  return false;
               }
               if(this._jobLevel == -1 || knownJob.jobLevel > this._jobLevel)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      override public function get text() : String
      {
         var job:Job = null;
         var readableCriterionRef:String = "";
         var readableCriterionValue:String = "";
         var readableCriterion:String = "";
         if(this._jobsCount > 0)
         {
            if(this._jobsCount > 1 || this._jobId == this.VALUE_NOT_SPECIFIC_JOB)
            {
               readableCriterionValue += PatternDecoder.combine(I18n.getUiText("ui.criterion.atLeastSomeJobs",[this._jobsCount]),"n",this._jobsCount == 1,this._jobsCount == 0);
            }
            else
            {
               job = Job.getJobById(this._jobId);
               if(!job)
               {
                  return readableCriterion;
               }
               readableCriterionValue += job.name;
            }
            var optionalJobLevel:String = "";
            if(this._jobLevel >= 0)
            {
               optionalJobLevel = " " + I18n.getUiText("ui.common.short.level") + " " + String(this._jobLevel);
            }
            switch(_operator.text)
            {
               case ItemCriterionOperator.EQUAL:
                  readableCriterion = readableCriterionValue + optionalJobLevel;
                  break;
               case ItemCriterionOperator.DIFFERENT:
                  readableCriterion = I18n.getUiText("ui.common.dontBe") + readableCriterionValue + optionalJobLevel;
                  break;
               case ItemCriterionOperator.SUPERIOR:
                  readableCriterionRef = " >";
                  readableCriterion = readableCriterionValue + readableCriterionRef + optionalJobLevel;
                  break;
               case ItemCriterionOperator.INFERIOR:
                  readableCriterionRef = " <";
                  readableCriterion = readableCriterionValue + readableCriterionRef + optionalJobLevel;
            }
            return readableCriterion;
         }
         return "";
      }
      
      override public function clone() : IItemCriterion
      {
         return new JobItemCriterion(this.basicText);
      }
   }
}
