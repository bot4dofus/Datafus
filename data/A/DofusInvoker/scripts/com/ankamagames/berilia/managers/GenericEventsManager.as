package com.ankamagames.berilia.managers
{
   import com.ankamagames.berilia.types.listener.GenericListener;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class GenericEventsManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GenericEventsManager));
       
      
      protected var _aEvent:Array;
      
      public function GenericEventsManager()
      {
         this._aEvent = new Array();
         super();
      }
      
      public function initialize() : void
      {
         this._aEvent = new Array();
      }
      
      public function registerEvent(ge:GenericListener) : void
      {
         if(this._aEvent[ge.event] == null)
         {
            this._aEvent[ge.event] = new Array();
         }
         this._aEvent[ge.event].push(ge);
         (this._aEvent[ge.event] as Array).sortOn("sortIndex",Array.NUMERIC | Array.DESCENDING);
      }
      
      public function removeEventListener(ge:GenericListener) : void
      {
         var i:* = null;
         var j:int = 0;
         var genericListener:GenericListener = null;
         for(i in this._aEvent)
         {
            if(this._aEvent[i])
            {
               for(j = 0; j < this._aEvent[i].length; j++)
               {
                  genericListener = this._aEvent[i][j];
                  if(genericListener)
                  {
                     if(genericListener == ge)
                     {
                        genericListener.destroy();
                        (this._aEvent[i] as Array).splice(j,1);
                        j--;
                     }
                  }
               }
               if(!this._aEvent[i].length)
               {
                  this._aEvent[i] = null;
                  delete this._aEvent[i];
               }
            }
         }
      }
      
      public function removeAllEventListeners(sListener:*) : void
      {
         var i:* = null;
         var j:int = 0;
         var genericListener:GenericListener = null;
         for(i in this._aEvent)
         {
            if(this._aEvent[i])
            {
               for(j = 0; j < this._aEvent[i].length; j++)
               {
                  genericListener = this._aEvent[i][j];
                  if(genericListener)
                  {
                     if(genericListener.listener == sListener)
                     {
                        genericListener.destroy();
                        (this._aEvent[i] as Array).splice(j,1);
                        j--;
                     }
                  }
               }
               if(!this._aEvent[i].length)
               {
                  this._aEvent[i] = null;
                  delete this._aEvent[i];
               }
            }
         }
      }
   }
}
