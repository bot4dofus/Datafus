package com.ankamagames.performance.tests
{
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import com.ankamagames.performance.Benchmark;
   import com.ankamagames.performance.IBenchmarkTest;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class TestWriteDisk implements IBenchmarkTest
   {
      
      private static var _results:Array;
       
      
      public function TestWriteDisk()
      {
         super();
      }
      
      public function run() : void
      {
         var cso:CustomSharedObject = null;
         var contentLine:String = null;
         var fullFileContent:ByteArray = null;
         var i:int = 0;
         var startTime:Number = NaN;
         try
         {
            cso = CustomSharedObject.getLocal("benchmark");
            contentLine = "0iD0TA3AgjbguitmT3TQy0rmIdqPNmTaHSYBjAWU8qSxN3vG11DCeC4jE304txK2lwHrk4X1p0bccjA3kKf1k19A8QYVgsiQauktrEJ9r4tHbfdvu2aZuYa7sranMV0FIWZZGxrPYKRWJcP1T14MfXEK75rJxncVQhA13FZeUyQ8HurnfbLt5ASD4TqaJ8H7q39VmWUibVlSZyxFSlNqi3mhvIP2am6fNy6FWeX2RDC1qH2xLIawcgBjOorJjEZTHYDHQGkNUWLMBL5kotK3PTqaSD7LibazqpbjKREYL1RZatVKy9dqty7uGmRUwJjYRBEs72JDQeeBaQ3UsusLzJLmYQE9F7cD2zRJMxxlOuK2qsZ5e9qalqvsfyxtL8wZ165JHC3nECOMkBzgHQ0gQf0MvVpXxXod7enbGLCPCWPWLcqUy8zcRuCGlrcoVBtIJWbRMV8RiCKT2O4PS7KMpW5YmVzxQrMz7zhXmAG2BY1CeknIi73YedE0YM9wsUol2hI56Eb8vCyUQiMlt3cLnlELT9q9yKSknqB48xR78M87Bk4GPHI77oNdvVxl20jq1JwFFAqWSNP9GCbuzGch2HtozMiQSNinbs4v2rhMiG6V1dTaIbtTuHtLn2R5wxGJp1OE8IXHMV8z7tYx5fSQ1gQSDe0MFtbjTV1AAlQLB5BbwF6ejSKz1N05sRIQD0bGfQFxhGbtrhfmDpmwRmDQU4qsV9OmMjnVIU2v2RDVpwgf5ZeOWCV62pxlREvA22xJesrkl441BQLlnYpogMvENiGXZ2cxKsuZMTea71OyzwETULjJc438K4ozU0scNpAv7H4rKRECoteTHVJO5Z8G66Vfe4pNzouhJ6ATXL4IbUAQW2N2GO03sNoyNK4ZwsIQyVjzb0tSDofqMKYFzAwDsijbt2Wd1uf3ya0CC6qWhgDKYZQSTBvC2V0ZLOzr8FxjWL3rvloRoCnXSCJtjFRU6iQomQ8pmSEcKRXBc3C8HNDlUBmruzuyClG0XHpMJE4n";
            fullFileContent = new ByteArray();
            for(i = 0; i < 10000; i++)
            {
               fullFileContent.writeUTF(contentLine);
            }
            fullFileContent.position = 0;
            startTime = getTimer();
            cso.data.content = fullFileContent;
            cso.flush();
            if(!_results)
            {
               _results = [];
            }
            _results.push(getTimer() - startTime);
            fullFileContent = null;
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
                  return "writeDiskTest:error";
               }
               averageTime += _results[i];
            }
            averageTime /= _results.length;
            return "writeDiskTest:" + averageTime.toString();
         }
         return "writeDiskTest:none";
      }
   }
}
