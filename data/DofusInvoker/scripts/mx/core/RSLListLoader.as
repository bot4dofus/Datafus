package mx.core
{
   import flash.events.Event;
   
   use namespace mx_internal;
   
   [ExcludeClass]
   public class RSLListLoader
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      private var currentIndex:int = 0;
      
      private var rslList:Array;
      
      private var chainedProgressHandler:Function;
      
      private var chainedCompleteHandler:Function;
      
      private var chainedIOErrorHandler:Function;
      
      private var chainedSecurityErrorHandler:Function;
      
      private var chainedRSLErrorHandler:Function;
      
      public function RSLListLoader(rslList:Array)
      {
         this.rslList = [];
         super();
         this.rslList = rslList;
      }
      
      public function load(progressHandler:Function, completeHandler:Function, ioErrorHandler:Function, securityErrorHandler:Function, rslErrorHandler:Function) : void
      {
         this.chainedProgressHandler = progressHandler;
         this.chainedCompleteHandler = completeHandler;
         this.chainedIOErrorHandler = ioErrorHandler;
         this.chainedSecurityErrorHandler = securityErrorHandler;
         this.chainedRSLErrorHandler = rslErrorHandler;
         this.currentIndex = -1;
         this.loadNext();
      }
      
      private function loadNext() : void
      {
         if(!this.isDone())
         {
            ++this.currentIndex;
            if(this.currentIndex < this.rslList.length)
            {
               this.rslList[this.currentIndex].load(this.chainedProgressHandler,this.listCompleteHandler,this.listIOErrorHandler,this.listSecurityErrorHandler,this.chainedRSLErrorHandler);
            }
         }
      }
      
      public function getItem(index:int) : RSLItem
      {
         if(index < 0 || index >= this.rslList.length)
         {
            return null;
         }
         return this.rslList[index];
      }
      
      public function getIndex() : int
      {
         return this.currentIndex;
      }
      
      public function getItemCount() : int
      {
         return this.rslList.length;
      }
      
      public function isDone() : Boolean
      {
         return this.currentIndex >= this.rslList.length;
      }
      
      private function listCompleteHandler(event:Event) : void
      {
         if(this.chainedCompleteHandler != null)
         {
            this.chainedCompleteHandler(event);
         }
         this.loadNext();
      }
      
      private function listIOErrorHandler(event:Event) : void
      {
         if(this.chainedIOErrorHandler != null)
         {
            this.chainedIOErrorHandler(event);
         }
      }
      
      private function listSecurityErrorHandler(event:Event) : void
      {
         if(this.chainedSecurityErrorHandler != null)
         {
            this.chainedSecurityErrorHandler(event);
         }
      }
   }
}
