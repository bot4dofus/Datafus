package mx.messaging.config
{
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import mx.collections.ArrayCollection;
   import mx.core.mx_internal;
   import mx.messaging.Channel;
   import mx.messaging.ChannelSet;
   import mx.messaging.MessageAgent;
   import mx.messaging.errors.InvalidChannelError;
   import mx.messaging.errors.InvalidDestinationError;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   import mx.utils.ObjectUtil;
   
   use namespace mx_internal;
   
   public class ServerConfig
   {
      
      public static const CLASS_ATTR:String = "type";
      
      public static const URI_ATTR:String = "uri";
      
      private static var _resourceManager:IResourceManager;
      
      public static var serverConfigData:XML;
      
      private static var _channelSets:Object = {};
      
      private static var _clusteredChannels:Object = {};
      
      private static var _unclusteredChannels:Object = {};
      
      private static var _configFetchedChannels:Object;
      
      public static var channelSetFactory:Class = ChannelSet;
       
      
      public function ServerConfig()
      {
         super();
      }
      
      private static function get resourceManager() : IResourceManager
      {
         if(!_resourceManager)
         {
            _resourceManager = ResourceManager.getInstance();
         }
         return _resourceManager;
      }
      
      public static function get xml() : XML
      {
         if(serverConfigData == null)
         {
            serverConfigData = <services/>;
         }
         return serverConfigData;
      }
      
      public static function set xml(value:XML) : void
      {
         serverConfigData = value;
         _channelSets = {};
         _clusteredChannels = {};
         _unclusteredChannels = {};
      }
      
      public static function checkChannelConsistency(destinationA:String, destinationB:String) : void
      {
         var channelIdsA:Array = getChannelIdList(destinationA);
         var channelIdsB:Array = getChannelIdList(destinationB);
         if(ObjectUtil.compare(channelIdsA,channelIdsB) != 0)
         {
            throw new ArgumentError("Specified destinations are not channel consistent");
         }
      }
      
      public static function getChannel(id:String, clustered:Boolean = false) : Channel
      {
         var channel:Channel = null;
         if(!clustered)
         {
            if(id in _unclusteredChannels)
            {
               return _unclusteredChannels[id];
            }
            channel = createChannel(id);
            _unclusteredChannels[id] = channel;
            return channel;
         }
         if(id in _clusteredChannels)
         {
            return _clusteredChannels[id];
         }
         channel = createChannel(id);
         _clusteredChannels[id] = channel;
         return channel;
      }
      
      public static function getChannelSet(destinationId:String) : ChannelSet
      {
         var destinationConfig:XML = getDestinationConfig(destinationId);
         return internalGetChannelSet(destinationConfig,destinationId);
      }
      
      public static function getProperties(destinationId:String) : XMLList
      {
         var destination:XMLList = null;
         var message:String = null;
         destination = xml..destination.(@id == destinationId);
         if(destination.length() > 0)
         {
            return destination.properties;
         }
         message = resourceManager.getString("messaging","unknownDestination",[destinationId]);
         throw new InvalidDestinationError(message);
      }
      
      mx_internal static function channelSetMatchesDestinationConfig(channelSet:ChannelSet, destination:String) : Boolean
      {
         var csUris:Array = null;
         var csChannels:Array = null;
         var i:uint = 0;
         var ids:Array = null;
         var dsUris:Array = null;
         var dsChannels:XMLList = null;
         var channelConfig:XML = null;
         var endpoint:XML = null;
         var dsUri:String = null;
         var j:uint = 0;
         if(channelSet != null)
         {
            if(ObjectUtil.compare(channelSet.channelIds,getChannelIdList(destination)) == 0)
            {
               return true;
            }
            csUris = [];
            csChannels = channelSet.channels;
            for(i = 0; i < csChannels.length; i++)
            {
               csUris.push(csChannels[i].uri);
            }
            ids = getChannelIdList(destination);
            dsUris = [];
            for(j = 0; j < ids.length; j++)
            {
               dsChannels = xml.channels.channel.(@id == ids[j]);
               channelConfig = dsChannels[0];
               endpoint = channelConfig.endpoint;
               dsUri = endpoint.length() > 0 ? endpoint[0].attribute(URI_ATTR).toString() : null;
               if(dsUri != null)
               {
                  dsUris.push(dsUri);
               }
            }
            return ObjectUtil.compare(csUris,dsUris) == 0;
         }
         return false;
      }
      
      mx_internal static function fetchedConfig(endpoint:String) : Boolean
      {
         return _configFetchedChannels != null && _configFetchedChannels[endpoint] != null;
      }
      
      mx_internal static function getChannelIdList(destination:String) : Array
      {
         var destinationConfig:XML = getDestinationConfig(destination);
         return !!destinationConfig ? getChannelIds(destinationConfig) : getDefaultChannelIds();
      }
      
      mx_internal static function needsConfig(channel:Channel) : Boolean
      {
         var channelSets:Array = null;
         var m:int = 0;
         var i:int = 0;
         var messageAgents:Array = null;
         var n:int = 0;
         var j:int = 0;
         if(_configFetchedChannels == null || _configFetchedChannels[channel.endpoint] == null)
         {
            channelSets = channel.channelSets;
            m = channelSets.length;
            for(i = 0; i < m; i++)
            {
               if(getQualifiedClassName(channelSets[i]).indexOf("Advanced") != -1)
               {
                  return true;
               }
               messageAgents = ChannelSet(channelSets[i]).messageAgents;
               n = messageAgents.length;
               for(j = 0; j < n; j++)
               {
                  if(MessageAgent(messageAgents[j]).needsConfig)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      mx_internal static function updateServerConfigData(serverConfig:ConfigMap, endpoint:String = null) : void
      {
         var newServices:XML = null;
         var newService:XML = null;
         var newChannels:XMLList = null;
         var oldServices:XMLList = null;
         var oldDestinations:XMLList = null;
         var newDestination:XML = null;
         var oldService:XML = null;
         var oldChannels:XML = null;
         if(serverConfig != null)
         {
            if(endpoint != null)
            {
               if(_configFetchedChannels == null)
               {
                  _configFetchedChannels = {};
               }
               _configFetchedChannels[endpoint] = true;
            }
            newServices = <services></services>;
            convertToXML(serverConfig,newServices);
            xml["default-channels"] = newServices["default-channels"];
            for each(newService in newServices..service)
            {
               oldServices = xml.service.(@id == newService.@id);
               if(oldServices.length() != 0)
               {
                  oldService = oldServices[0];
                  for each(newDestination in newService..destination)
                  {
                     oldDestinations = oldService.destination.(@id == newDestination.@id);
                     if(oldDestinations.length() != 0)
                     {
                        delete oldDestinations[0];
                     }
                     oldService.appendChild(newDestination.copy());
                  }
               }
               else
               {
                  for each(newDestination in newService..destination)
                  {
                     oldDestinations = xml..destination.(@id == newDestination.@id);
                     if(oldDestinations.length() != 0)
                     {
                        oldDestinations[0] = newDestination[0].copy();
                        delete newService..destination.(@id == newDestination.@id)[0];
                     }
                  }
                  if(newService.children().length() > 0)
                  {
                     xml.appendChild(newService);
                  }
               }
            }
            newChannels = newServices.channels;
            if(newChannels.length() > 0)
            {
               oldChannels = xml.channels[0];
               if(oldChannels == null || oldChannels.length() == 0)
               {
                  xml.appendChild(newChannels);
               }
            }
         }
      }
      
      private static function createChannel(channelId:String) : Channel
      {
         var message:String = null;
         var channels:XMLList = null;
         var channelConfig:XML = null;
         var className:String = null;
         var endpoint:XMLList = null;
         var uri:String = null;
         var channel:Channel = null;
         var channelClass:Class = null;
         channels = xml.channels.channel.(@id == channelId);
         if(channels.length() == 0)
         {
            message = resourceManager.getString("messaging","unknownChannelWithId",[channelId]);
            throw new InvalidChannelError(message);
         }
         channelConfig = channels[0];
         className = channelConfig.attribute(CLASS_ATTR).toString();
         endpoint = channelConfig.endpoint;
         uri = endpoint.length() > 0 ? endpoint[0].attribute(URI_ATTR).toString() : null;
         channel = null;
         try
         {
            channelClass = getDefinitionByName(className) as Class;
            channel = new channelClass(channelId,uri);
            channel.applySettings(channelConfig);
            if(LoaderConfig.parameters != null && LoaderConfig.parameters.WSRP_ENCODED_CHANNEL != null)
            {
               channel.url = LoaderConfig.parameters.WSRP_ENCODED_CHANNEL;
            }
         }
         catch(e:ReferenceError)
         {
            message = resourceManager.getString("messaging","unknownChannelClass",[className]);
            throw new InvalidChannelError(message);
         }
         return channel;
      }
      
      private static function convertToXML(config:ConfigMap, configXML:XML) : void
      {
         var propertyKey:* = null;
         var propertyValue:Object = null;
         var propertyValueList:Array = null;
         var i:int = 0;
         var propertyXML1:XML = null;
         var propertyXML2:XML = null;
         for(propertyKey in config)
         {
            propertyValue = config[propertyKey];
            if(propertyValue is String)
            {
               if(propertyKey == "")
               {
                  configXML.appendChild(propertyValue);
               }
               else
               {
                  configXML[propertyKey] = propertyValue;
               }
            }
            else if(propertyValue is ArrayCollection || propertyValue is Array)
            {
               if(propertyValue is ArrayCollection)
               {
                  propertyValueList = ArrayCollection(propertyValue).toArray();
               }
               else
               {
                  propertyValueList = propertyValue as Array;
               }
               for(i = 0; i < propertyValueList.length; i++)
               {
                  propertyXML1 = new XML("<" + propertyKey + "></" + propertyKey + ">");
                  configXML.appendChild(propertyXML1);
                  convertToXML(propertyValueList[i] as ConfigMap,propertyXML1);
               }
            }
            else
            {
               propertyXML2 = new XML("<" + propertyKey + "></" + propertyKey + ">");
               configXML.appendChild(propertyXML2);
               convertToXML(propertyValue as ConfigMap,propertyXML2);
            }
         }
      }
      
      private static function getChannelIds(destinationConfig:XML) : Array
      {
         var result:Array = [];
         var channels:XMLList = destinationConfig.channels.channel;
         var n:int = channels.length();
         for(var i:int = 0; i < n; i++)
         {
            result.push(channels[i].@ref.toString());
         }
         return result;
      }
      
      private static function getDefaultChannelIds() : Array
      {
         var result:Array = [];
         var channels:XMLList = xml["default-channels"].channel;
         var n:int = channels.length();
         for(var i:int = 0; i < n; i++)
         {
            result.push(channels[i].@ref.toString());
         }
         return result;
      }
      
      private static function getDestinationConfig(destinationId:String) : XML
      {
         var destinations:XMLList = null;
         var destinationCount:int = 0;
         destinations = xml..destination.(@id == destinationId);
         destinationCount = destinations.length();
         if(destinationCount == 0)
         {
            return null;
         }
         return destinations[0];
      }
      
      private static function internalGetChannelSet(destinationConfig:XML, destinationId:String) : ChannelSet
      {
         var channelIds:Array = null;
         var clustered:Boolean = false;
         var message:String = null;
         var channelSet:ChannelSet = null;
         var heartbeatMillis:int = 0;
         if(destinationConfig == null)
         {
            channelIds = getDefaultChannelIds();
            if(channelIds.length == 0)
            {
               message = resourceManager.getString("messaging","noChannelForDestination",[destinationId]);
               throw new InvalidDestinationError(message);
            }
            clustered = false;
         }
         else
         {
            channelIds = getChannelIds(destinationConfig);
            clustered = destinationConfig.properties.network.cluster.length() > 0 ? true : false;
         }
         var channelSetId:String = channelIds.join(",") + ":" + clustered;
         if(channelSetId in _channelSets)
         {
            return _channelSets[channelSetId];
         }
         channelSet = new channelSetFactory(channelIds,clustered);
         heartbeatMillis = serverConfigData["flex-client"]["heartbeat-interval-millis"];
         if(heartbeatMillis > 0)
         {
            channelSet.heartbeatInterval = heartbeatMillis;
         }
         if(clustered)
         {
            channelSet.initialDestinationId = destinationId;
         }
         _channelSets[channelSetId] = channelSet;
         return channelSet;
      }
   }
}
