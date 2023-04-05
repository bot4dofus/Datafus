package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import flash.utils.Dictionary;
   
   public class ChatAutocompleteNameManager
   {
      
      private static var _instance:ChatAutocompleteNameManager;
       
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      private var _dict:Dictionary;
      
      private var _cache:Vector.<String>;
      
      private var _subStringCache:String = "";
      
      public function ChatAutocompleteNameManager()
      {
         this._dict = new Dictionary();
         super();
      }
      
      public static function getInstance() : ChatAutocompleteNameManager
      {
         if(!_instance)
         {
            _instance = new ChatAutocompleteNameManager();
         }
         return _instance;
      }
      
      public function addEntry(name:String, priority:int) : void
      {
         var entry:Object = null;
         this.emptyCache();
         var list:Vector.<Object> = this.getListByName(name);
         var idx:int = this.indexOf(list,name);
         if(idx != -1)
         {
            entry = list[idx];
            if(entry.priority > priority)
            {
               return;
            }
            list.splice(idx,1);
         }
         entry = new Object();
         entry.name = name;
         entry.priority = priority;
         this.insertEntry(entry);
      }
      
      public function autocomplete(subString:String, count:uint) : String
      {
         var names:Vector.<String> = null;
         if(this._subStringCache == subString)
         {
            names = this._cache;
         }
         else
         {
            names = this.generateNameList(subString);
         }
         if(names.length > count)
         {
            return names[count];
         }
         return null;
      }
      
      private function emptyCache() : void
      {
         this._subStringCache = "";
      }
      
      private function generateNameList(subString:String) : Vector.<String>
      {
         var entry:Object = null;
         var name:String = null;
         var lcName:String = null;
         var lcSubString:String = subString.toLowerCase();
         var list:Vector.<Object> = this.getListByName(subString);
         var ret:Vector.<String> = new Vector.<String>();
         this._subStringCache = subString;
         this._cache = ret;
         for each(entry in list)
         {
            name = entry.name;
            lcName = name.toLowerCase();
            if(entry.name.length >= lcSubString.length && lcName.substr(0,lcSubString.length) == lcSubString && name != PlayedCharacterApi.getInstance().getPlayedCharacterInfo().name)
            {
               ret.push(name);
            }
         }
         return ret;
      }
      
      private function getListByName(name:String) : Vector.<Object>
      {
         var key:String = name.charAt(0).toLowerCase();
         if(!this._dict.hasOwnProperty(key))
         {
            this._dict[key] = new Vector.<Object>();
         }
         return this._dict[key];
      }
      
      private function indexOf(list:Vector.<Object>, name:String) : int
      {
         var i:uint = 0;
         while(i < list.length)
         {
            if(list[i].name == name)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function insertEntry(entry:Object) : void
      {
         var list:Vector.<Object> = this.getListByName(entry.name);
         var i:uint = 0;
         while(i < list.length && list[i].priority > entry.priority)
         {
            i++;
         }
         list.splice(i,0,entry);
      }
   }
}
