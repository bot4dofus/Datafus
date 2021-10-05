package mx.binding.utils
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import mx.core.EventPriority;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.utils.DescribeTypeCache;
   
   use namespace mx_internal;
   
   public class ChangeWatcher
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      private var host:Object;
      
      private var name:String;
      
      private var getter:Function;
      
      private var handler:Function;
      
      private var commitOnly:Boolean;
      
      private var next:ChangeWatcher;
      
      private var events:Object;
      
      private var isExecuting:Boolean;
      
      public var useWeakReference:Boolean;
      
      public function ChangeWatcher(access:Object, handler:Function, commitOnly:Boolean = false, next:ChangeWatcher = null)
      {
         super();
         this.host = null;
         this.name = access is String ? access as String : access.name;
         this.getter = access is String ? null : access.getter;
         this.handler = handler;
         this.commitOnly = commitOnly;
         this.next = next;
         this.events = {};
         this.useWeakReference = false;
         this.isExecuting = false;
      }
      
      public static function watch(host:Object, chain:Object, handler:Function, commitOnly:Boolean = false, useWeakReference:Boolean = false) : ChangeWatcher
      {
         var w:ChangeWatcher = null;
         if(!(chain is Array))
         {
            chain = [chain];
         }
         if(chain.length > 0)
         {
            w = new ChangeWatcher(chain[0],handler,commitOnly,watch(null,chain.slice(1),handler,commitOnly));
            w.useWeakReference = useWeakReference;
            w.reset(host);
            return w;
         }
         return null;
      }
      
      public static function canWatch(host:Object, name:String, commitOnly:Boolean = false) : Boolean
      {
         return !isEmpty(getEvents(host,name,commitOnly));
      }
      
      public static function getEvents(host:Object, name:String, commitOnly:Boolean = false) : Object
      {
         var allEvents:Object = null;
         var commitOnlyEvents:Object = null;
         var ename:* = null;
         if(host is IEventDispatcher)
         {
            allEvents = DescribeTypeCache.describeType(host).bindabilityInfo.getChangeEvents(name);
            if(commitOnly)
            {
               commitOnlyEvents = {};
               for(ename in allEvents)
               {
                  if(allEvents[ename])
                  {
                     commitOnlyEvents[ename] = true;
                  }
               }
               return commitOnlyEvents;
            }
            return allEvents;
         }
         return {};
      }
      
      private static function isEmpty(obj:Object) : Boolean
      {
         var p:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = obj;
         for(p in _loc4_)
         {
            return false;
         }
         return true;
      }
      
      public function unwatch() : void
      {
         this.reset(null);
      }
      
      public function getValue() : Object
      {
         return this.host == null ? null : (this.next == null ? this.getHostPropertyValue() : this.next.getValue());
      }
      
      public function setHandler(handler:Function) : void
      {
         this.handler = handler;
         if(this.next)
         {
            this.next.setHandler(handler);
         }
      }
      
      public function isWatching() : Boolean
      {
         return !isEmpty(this.events) && (this.next == null || this.next.isWatching());
      }
      
      public function reset(newHost:Object) : void
      {
         var p:* = null;
         if(this.host != null)
         {
            for(p in this.events)
            {
               this.host.removeEventListener(p,this.wrapHandler);
            }
            this.events = {};
         }
         this.host = newHost;
         if(this.host != null)
         {
            this.events = getEvents(this.host,this.name,this.commitOnly);
            for(p in this.events)
            {
               this.host.addEventListener(p,this.wrapHandler,false,EventPriority.BINDING,this.useWeakReference);
            }
         }
         if(this.next)
         {
            this.next.reset(this.getHostPropertyValue());
         }
      }
      
      private function getHostPropertyValue() : Object
      {
         return this.host == null ? null : (this.getter != null ? this.getter(this.host) : this.host[this.name]);
      }
      
      private function wrapHandler(event:Event) : void
      {
         if(this.isExecuting)
         {
         }
      }
   }
}
