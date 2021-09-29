package mx.formatters
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   [ExcludeClass]
   public class StringFormatter
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      private var extractToken:Function;
      
      private var reqFormat:String;
      
      private var patternInfo:Array;
      
      public function StringFormatter(format:String, tokens:String, extractTokenFunc:Function)
      {
         super();
         this.formatPattern(format,tokens);
         this.extractToken = extractTokenFunc;
      }
      
      public function formatValue(value:Object) : String
      {
         var curTokenInfo:Object = this.patternInfo[0];
         var result:String = this.reqFormat.substring(0,curTokenInfo.begin) + this.extractToken(value,curTokenInfo);
         var lastTokenInfo:Object = curTokenInfo;
         var n:int = this.patternInfo.length;
         for(var i:int = 1; i < n; i++)
         {
            curTokenInfo = this.patternInfo[i];
            result += this.reqFormat.substring(lastTokenInfo.end,curTokenInfo.begin) + this.extractToken(value,curTokenInfo);
            lastTokenInfo = curTokenInfo;
         }
         if(lastTokenInfo.end > 0 && lastTokenInfo.end != this.reqFormat.length)
         {
            result += this.reqFormat.substring(lastTokenInfo.end);
         }
         return result;
      }
      
      private function formatPattern(format:String, tokens:String) : void
      {
         var start:int = 0;
         var finish:int = 0;
         var index:int = 0;
         var tokenArray:Array = tokens.split(",");
         this.reqFormat = format;
         this.patternInfo = [];
         var n:int = tokenArray.length;
         for(var i:int = 0; i < n; i++)
         {
            start = this.reqFormat.indexOf(tokenArray[i]);
            if(start >= 0 && start < this.reqFormat.length)
            {
               finish = this.reqFormat.lastIndexOf(tokenArray[i]);
               finish = finish >= 0 ? int(finish + 1) : int(start + 1);
               this.patternInfo.splice(index,0,{
                  "token":tokenArray[i],
                  "begin":start,
                  "end":finish
               });
               index++;
            }
         }
         this.patternInfo.sort(this.compareValues);
      }
      
      private function compareValues(a:Object, b:Object) : int
      {
         if(a.begin > b.begin)
         {
            return 1;
         }
         if(a.begin < b.begin)
         {
            return -1;
         }
         return 0;
      }
   }
}
