package com.ankamagames.performance.tests
{
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import com.ankamagames.performance.Benchmark;
   import com.ankamagames.performance.IBenchmarkTest;
   import flash.utils.getTimer;
   
   public class TestReadDisk implements IBenchmarkTest
   {
      
      private static var _results:Array;
       
      
      public function TestReadDisk()
      {
         super();
      }
      
      public function run() : void
      {
         var startTime:Number = NaN;
         var cso:CustomSharedObject = null;
         try
         {
            CustomSharedObject.clearCache("benchmark");
            startTime = getTimer();
            cso = CustomSharedObject.getLocal("benchmark");
            if(!_results)
            {
               _results = [];
            }
            _results.push(getTimer() - startTime);
            cso.clear();
         }
         catch(error:Error)
         {
            _results.push("error");
         }
         Benchmark.onTestCompleted(this);
      }
      
      public function cancel() : void
      {
      }
      
      public function getResults() : String
      {
         var averageTime:Number = NaN;
         var i:int = 0;
         if(_results)
         {
            averageTime = 0;
            for(i = 0; i < _results.length; i++)
            {
               if(_results[i] == "error")
               {
                  return "readDiskTest:error";
               }
               averageTime += _results[i];
            }
            averageTime /= _results.length;
            return "readDiskTest:" + averageTime.toString();
         }
         return "readDiskTest:none";
      }
   }
}
