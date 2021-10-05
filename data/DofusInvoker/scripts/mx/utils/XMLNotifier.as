package mx.utils
{
   import flash.utils.Dictionary;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class XMLNotifier
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      private static var instance:XMLNotifier;
       
      
      public function XMLNotifier(x:XMLNotifierSingleton)
      {
         super();
      }
      
      public static function getInstance() : XMLNotifier
      {
         if(!instance)
         {
            instance = new XMLNotifier(new XMLNotifierSingleton());
         }
         return instance;
      }
      
      mx_internal static function initializeXMLForNotification() : Function
      {
         var notificationFunction:Function = function(currentTarget:Object, ty:String, tar:Object, value:Object, detail:Object):void
         {
            var notifiable:* = null;
            var xmlWatchers:Dictionary = arguments.callee.watched;
            if(xmlWatchers != null)
            {
               for(notifiable in xmlWatchers)
               {
                  IXMLNotifiable(notifiable).xmlNotification(currentTarget,ty,tar,value,detail);
               }
            }
         };
         return notificationFunction;
      }
      
      public function watchXML(xml:Object, notifiable:IXMLNotifiable, uid:String = null) : void
      {
         var item:Object = null;
         var xmlItem:XML = null;
         var watcherFunction:Object = null;
         var xmlWatchers:Dictionary = null;
         if(xml is XMLList && xml.length() > 1)
         {
            for each(item in xml)
            {
               this.watchXML(item,notifiable,uid);
            }
         }
         else
         {
            xmlItem = XML(xml);
            watcherFunction = xmlItem.notification();
            if(!(watcherFunction is Function))
            {
               watcherFunction = initializeXMLForNotification();
               xmlItem.setNotification(watcherFunction as Function);
               if(uid && watcherFunction["uid"] == null)
               {
                  watcherFunction["uid"] = uid;
               }
            }
            if(watcherFunction["watched"] == undefined)
            {
               watcherFunction["watched"] = xmlWatchers = new Dictionary(true);
            }
            else
            {
               xmlWatchers = watcherFunction["watched"];
            }
            xmlWatchers[notifiable] = true;
         }
      }
      
      public function unwatchXML(xml:Object, notifiable:IXMLNotifiable) : void
      {
         var item:Object = null;
         var xmlItem:XML = null;
         var watcherFunction:Object = null;
         var xmlWatchers:Dictionary = null;
         if(xml is XMLList && xml.length() > 1)
         {
            for each(item in xml)
            {
               this.unwatchXML(item,notifiable);
            }
         }
         else
         {
            xmlItem = XML(xml);
            watcherFunction = xmlItem.notification();
            if(!(watcherFunction is Function))
            {
               return;
            }
            if(watcherFunction["watched"] != undefined)
            {
               xmlWatchers = watcherFunction["watched"];
               delete xmlWatchers[notifiable];
            }
         }
      }
   }
}

class XMLNotifierSingleton
{
    
   
   function XMLNotifierSingleton()
   {
      super();
   }
}
