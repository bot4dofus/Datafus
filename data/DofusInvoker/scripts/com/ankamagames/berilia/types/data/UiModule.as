package com.ankamagames.berilia.types.data
{
   import com.ankamagames.berilia.BeriliaConstants;
   import com.ankamagames.berilia.managers.UiGroupManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class UiModule implements IModuleUtil
   {
      
      private static var ID_COUNT:uint = 0;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UiModule));
       
      
      public var shortcutsXml:XML;
      
      private var _instanceId:uint;
      
      private var _id:String;
      
      private var _name:String;
      
      private var _version:String;
      
      private var _gameVersion:String;
      
      private var _author:String;
      
      private var _shortDescription:String;
      
      private var _description:String;
      
      private var _iconUri:Uri;
      
      private var _script:String;
      
      private var _shortcuts:String;
      
      private var _uis:Array;
      
      private var _rootPath:String;
      
      private var _storagePath:String;
      
      private var _mainClass:Object;
      
      private var _cachedFiles:Array;
      
      private var _apiList:Vector.<Object>;
      
      private var _groups:Vector.<UiGroup>;
      
      var _scriptClass:Class;
      
      private var _enable:Boolean = true;
      
      private var _rawXml:XML;
      
      private var _priority:int;
      
      public function UiModule(id:String = null, name:String = null, version:String = null, gameVersion:String = null, author:String = null, shortDescription:String = null, description:String = null, iconUri:String = null, script:String = null, shortcuts:String = null, priority:int = 0, uis:Array = null, cachedFiles:Array = null)
      {
         var ui:UiData = null;
         this._instanceId = ++ID_COUNT;
         super();
         this._name = name;
         this._version = version;
         this._gameVersion = gameVersion;
         this._author = author;
         this._shortDescription = shortDescription;
         this._description = description;
         this._iconUri = new Uri(iconUri);
         this._script = script;
         this._shortcuts = shortcuts;
         this._priority = priority;
         this._id = id;
         this._uis = [];
         this._cachedFiles = !!cachedFiles ? cachedFiles : [];
         for each(ui in uis)
         {
            this._uis[ui.name] = ui;
         }
         this._apiList = new Vector.<Object>();
      }
      
      public static function createFromXml(xml:XML, nativePath:String, id:String) : UiModule
      {
         var um:UiModule = new UiModule();
         um.fillFromXml(xml,nativePath,id);
         return um;
      }
      
      public function set scriptClass(c:Class) : void
      {
         if(!this._scriptClass)
         {
            this._scriptClass = c;
         }
      }
      
      public function get scriptClass() : Class
      {
         return this._scriptClass;
      }
      
      public function get instanceId() : uint
      {
         return this._instanceId;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get version() : String
      {
         return this._version;
      }
      
      public function get gameVersion() : String
      {
         return this._gameVersion;
      }
      
      public function get author() : String
      {
         return this._author;
      }
      
      public function get shortDescription() : String
      {
         return this._shortDescription;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function get iconUri() : Uri
      {
         return this._iconUri;
      }
      
      public function get script() : String
      {
         return this._script;
      }
      
      public function get shortcuts() : String
      {
         return this._shortcuts;
      }
      
      public function get priority() : int
      {
         return this._priority;
      }
      
      public function get uis() : Array
      {
         return this._uis;
      }
      
      public function get enable() : Boolean
      {
         return this._enable;
      }
      
      public function set enable(v:Boolean) : void
      {
         var uiGroup:UiGroup = null;
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_MOD,this.id,v);
         if(!this._enable && v)
         {
            this._enable = true;
            UiModuleManager.getInstance().loadModule(this.id);
         }
         else
         {
            this._enable = false;
            for each(uiGroup in this._groups)
            {
               UiGroupManager.getInstance().removeGroup(uiGroup.name);
            }
            UiModuleManager.getInstance().unloadModule(this.id);
         }
      }
      
      public function get rootPath() : String
      {
         return this._rootPath;
      }
      
      public function get storagePath() : String
      {
         return this._storagePath;
      }
      
      public function get cachedFiles() : Array
      {
         return this._cachedFiles;
      }
      
      public function get apiList() : Vector.<Object>
      {
         return this._apiList;
      }
      
      public function bindUiClasses() : void
      {
         var ui:UiData = null;
         var uiClass:Class = null;
         for each(ui in this.uis)
         {
            uiClass = getDefinitionByName(ui.uiClassName) as Class;
            if(uiClass)
            {
               ui.uiClass = uiClass;
            }
            else
            {
               _log.error(ui.uiClassName + " cannot be found");
            }
         }
      }
      
      public function get mainClass() : Object
      {
         return this._mainClass;
      }
      
      public function set mainClass(instance:Object) : void
      {
         this._mainClass = instance;
      }
      
      public function get groups() : Vector.<UiGroup>
      {
         return this._groups;
      }
      
      public function get rawXml() : XML
      {
         return this._rawXml;
      }
      
      public function getUi(name:String) : UiData
      {
         return this._uis[name];
      }
      
      public function toString() : String
      {
         var result:String = "ID:" + this._id;
         if(this._name)
         {
            result += "\nName:" + this._name;
         }
         if(this._author)
         {
            result += "\nAuthor:" + this._author;
         }
         if(this._description)
         {
            result += "\nDescription:" + this._description;
         }
         return result;
      }
      
      public function destroy() : void
      {
      }
      
      protected function fillFromXml(xml:XML, nativePath:String, id:String) : void
      {
         var uiGroup:UiGroup = null;
         var group:XML = null;
         var uiData:UiData = null;
         var uis:XML = null;
         var path:XML = null;
         var uiNames:Array = null;
         var groupName:String = null;
         var uisXML:XMLList = null;
         var uiName:XML = null;
         var uisGroup:String = null;
         var ui:XML = null;
         var file:String = null;
         var mod:String = null;
         var fileuri:String = null;
         var header:XMLList = xml.child("header");
         this.setProperty("name",header.child("name"));
         this.setProperty("version",header.child("version"));
         this.setProperty("gameVersion",header.child("gameVersion"));
         this.setProperty("author",header.child("author"));
         this.setProperty("description",header.child("description"));
         this.setProperty("shortDescription",header.child("shortDescription"));
         this.setProperty("priority",header.child("priority"));
         this.setProperty("script",xml.child("script"));
         this.setProperty("shortcuts",xml.child("shortcuts"));
         this._rawXml = xml;
         var nativePath:String = nativePath.split("app:/").join("");
         if(nativePath.indexOf("file://") == -1 && nativePath.substr(0,2) != "\\\\")
         {
            nativePath = "file://" + nativePath;
         }
         this._id = id;
         if(this.script)
         {
            this._script = nativePath + "/" + this.script;
         }
         if(this.shortcuts)
         {
            this._shortcuts = nativePath + "/" + this.shortcuts;
         }
         this._rootPath = nativePath + "/";
         this._storagePath = unescape(this._rootPath + "storage/").replace("file://","");
         var iconPath:String = header.child("icon");
         if(iconPath && iconPath.length)
         {
            this._iconUri = new Uri(this._rootPath + iconPath);
         }
         this._groups = new Vector.<UiGroup>();
         for each(group in xml.uiGroup)
         {
            uiNames = [];
            groupName = group..@name;
            try
            {
               uisXML = xml.uis.(@group == groupName);
               for each(uiName in uisXML..@name)
               {
                  uiNames.push(uiName.toString());
               }
            }
            catch(e:Error)
            {
            }
            uiGroup = new UiGroup(group.@name,group.@exclusive.toString() == "true",group.@permanent.toString() == "true",uiNames);
            UiGroupManager.getInstance().registerGroup(uiGroup);
            this._groups.push(uiGroup);
         }
         for each(uis in xml.uis)
         {
            uisGroup = uis.@group.toString();
            for each(ui in uis..ui)
            {
               file = null;
               if(ui.@file.toString().length)
               {
                  if(ui.@file.indexOf("::") != -1)
                  {
                     mod = nativePath.split("Ankama")[0];
                     fileuri = ui.@file;
                     fileuri = fileuri.replace("::","/");
                     file = mod + fileuri;
                  }
                  else
                  {
                     file = nativePath + "/" + ui.@file;
                  }
               }
               uiData = new UiData(this,ui.@name,file,ui["class"],uisGroup);
               this._uis[uiData.name] = uiData;
            }
         }
         for each(path in xml.cachedFiles..path)
         {
            this.cachedFiles.push(path.children().toString());
         }
      }
      
      private function setProperty(key:String, value:String) : void
      {
         if(value && value.length)
         {
            this["_" + key] = value;
         }
         else
         {
            this["_" + key] = null;
         }
      }
   }
}
