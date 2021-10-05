package Ankama_GameUiCore.ui
{
   import Ankama_GameUiCore.Api;
   
   public class PrivateHistory
   {
       
      
      private var _history:Array;
      
      private var _cursor:int;
      
      private var _maxLength:int;
      
      public function PrivateHistory(maxLength:int)
      {
         super();
         this._history = [];
         this._cursor = -1;
         this._maxLength = maxLength;
         this.load();
      }
      
      public function get length() : int
      {
         return this._history.length;
      }
      
      private function load() : void
      {
         var oldHistory:Array = null;
         var n:String = null;
         var found:Boolean = false;
         var i:* = null;
         var h:String = null;
         this._history = Api.system.getData("aTchatHistoryPrivate");
         if(this._history)
         {
            if(this._history[0].indexOf("/w ") == 0)
            {
               oldHistory = this._history;
               this._history = [];
               for(i in oldHistory)
               {
                  n = oldHistory[i];
                  n = n.substr(3,n.length - 4);
                  found = false;
                  for each(h in this._history)
                  {
                     if(h.toLowerCase() == n.toLowerCase())
                     {
                        found = true;
                        break;
                     }
                  }
                  if(!found)
                  {
                     this._history.push(n);
                  }
               }
            }
         }
         else
         {
            this._history = [];
         }
      }
      
      public function addName(name:String) : void
      {
         var h:String = null;
         var found:Boolean = false;
         var i:uint = 0;
         for each(h in this._history)
         {
            if(h.toLowerCase() == name.toLowerCase())
            {
               found = true;
               break;
            }
            i++;
         }
         if(found)
         {
            this._history.splice(i,1);
         }
         this._history.push(name);
         if(this._history.length > this._maxLength)
         {
            this._history = this._history.slice(1,this._history.length);
         }
         Api.system.setData("aTchatHistoryPrivate",this._history);
      }
      
      public function previous() : String
      {
         if(this._history.length == 0)
         {
            return null;
         }
         if(this._cursor == -1 || this._cursor == 0)
         {
            this._cursor = this._history.length;
         }
         --this._cursor;
         return this._history[this._cursor];
      }
      
      public function next() : String
      {
         if(this._history.length == 0)
         {
            return null;
         }
         if(this._cursor == -1)
         {
            this._cursor = 0;
         }
         else
         {
            ++this._cursor;
            if(this._cursor == this._history.length)
            {
               this._cursor = 0;
            }
         }
         return this._history[this._cursor];
      }
      
      public function resetCursor() : void
      {
         this._cursor = -1;
      }
   }
}
