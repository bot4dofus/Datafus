package com.ankamagames.berilia.types.shortcut
{
   import com.ankamagames.berilia.api.ApiBinder;
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.utils.Dictionary;
   
   public class Shortcut implements IDataCenter
   {
      
      private static var _shortcuts:Array = new Array();
      
      private static var _idCount:uint = 0;
      
      private static var _configApi = null;
      
      private static var _datastoreType:DataStoreType = new DataStoreType("Module_Ankama_Config",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
       
      
      private var _name:String;
      
      private var _description:String;
      
      private var _tooltipContent:String;
      
      private var _admin:Boolean;
      
      private var _textfieldEnabled:Boolean;
      
      private var _bindable:Boolean;
      
      private var _category:ShortcutCategory;
      
      private var _unicID:uint = 0;
      
      private var _visible:Boolean;
      
      private var _disable:Boolean;
      
      private var _required:Boolean;
      
      private var _holdKeys:Boolean;
      
      private var _boundFeatureKeyword:String = null;
      
      private var _isBoundFeatureEnabled:Boolean = false;
      
      public var defaultBind:Bind;
      
      public function Shortcut(name:String, textfieldEnabled:Boolean = false, description:String = null, category:ShortcutCategory = null, bindable:Boolean = true, pVisible:Boolean = true, pRequired:Boolean = false, pHoldKeys:Boolean = false, tooltipContent:String = null, admin:Boolean = false, boundFeatureKeyword:String = null)
      {
         super();
         if(_shortcuts[name])
         {
            throw new BeriliaError("Shortcut name [" + name + "] is already use");
         }
         _shortcuts[name] = this;
         this._name = name;
         this._description = description;
         this._textfieldEnabled = textfieldEnabled;
         this._category = category;
         this._unicID = _idCount++;
         this._bindable = bindable;
         this._visible = pVisible;
         this._required = pRequired;
         this._holdKeys = pHoldKeys;
         this._tooltipContent = tooltipContent;
         this._admin = admin;
         this._disable = false;
         var isFeatureBound:* = boundFeatureKeyword !== null;
         this._boundFeatureKeyword = boundFeatureKeyword;
         this._isBoundFeatureEnabled = isFeatureBound && configApi.isFeatureWithKeywordEnabled(this._boundFeatureKeyword);
         if(isFeatureBound)
         {
            configApi.addListenerToFeatureWithKeyword(this._boundFeatureKeyword,this.onBoundFeatureUpdated);
         }
         BindsManager.getInstance().newShortcut(this);
      }
      
      public static function reset() : void
      {
         var shortcut:Shortcut = null;
         for each(shortcut in _shortcuts)
         {
            if(shortcut !== null)
            {
               shortcut.destroy();
            }
         }
         BindsManager.destroy();
         _shortcuts = [];
         _idCount = 0;
      }
      
      public static function loadSavedData() : void
      {
         var sc:Shortcut = null;
         var newData:Dictionary = null;
         var s:Shortcut = null;
         var copy:Array = null;
         var lastCat:String = null;
         var i:uint = 0;
         var len:int = 0;
         var a:Array = null;
         var copy2:Array = null;
         var len3:int = 0;
         var catIndex:int = 0;
         var nbCategoryShortcuts:int = 0;
         var j:int = 0;
         var len2:int = 0;
         var disabled:* = false;
         var savedData:Object = StoreDataManager.getInstance().getData(_datastoreType,"openShortcutsCategory");
         if(savedData)
         {
            if(savedData is Array)
            {
               newData = new Dictionary();
               copy = new Array();
               for each(s in _shortcuts)
               {
                  if(s.visible)
                  {
                     copy.push(s);
                  }
               }
               copy.sortOn("unicID",Array.NUMERIC);
               i = 0;
               len = copy.length;
               a = savedData as Array;
               copy2 = new Array();
               for(i = 0; i < len; i++)
               {
                  s = copy[i];
                  if(s.category.name != lastCat)
                  {
                     catIndex = copy2.indexOf(s.category.name);
                     if(catIndex == -1)
                     {
                        copy2.push(s.category.name);
                        copy2.push(s);
                        lastCat = s.category.name;
                     }
                     else
                     {
                        nbCategoryShortcuts = 0;
                        j = catIndex;
                        len2 = copy2.length;
                        while(++j < len2)
                        {
                           if(copy2[j] is String)
                           {
                              break;
                           }
                           nbCategoryShortcuts++;
                        }
                        copy2.splice(catIndex + nbCategoryShortcuts + 1,0,s);
                     }
                  }
                  else
                  {
                     copy2.push(s);
                  }
               }
               len3 = copy2.length;
               for(i = 0; i < len3; i++)
               {
                  if(copy2[i] is String)
                  {
                     if(a[i] != undefined)
                     {
                        newData[copy2[i]] = a[i];
                     }
                     else
                     {
                        newData[copy2[i]] = true;
                     }
                  }
               }
               savedData = newData;
               StoreDataManager.getInstance().setData(_datastoreType,"openShortcutsCategory",savedData);
            }
            for each(sc in _shortcuts)
            {
               if(sc.visible)
               {
                  if(savedData[sc.category.name] != undefined)
                  {
                     disabled = !savedData[sc.category.name];
                  }
                  else
                  {
                     savedData[sc.category.name] = true;
                     disabled = false;
                  }
                  sc.disable = disabled;
               }
            }
         }
      }
      
      public static function getShortcutByName(name:String) : Shortcut
      {
         return _shortcuts[name];
      }
      
      public static function getShortcuts() : Array
      {
         return _shortcuts;
      }
      
      private static function get configApi() : *
      {
         if(_configApi === null)
         {
            _configApi = ApiBinder.getApiInstance("ConfigApi");
         }
         return _configApi;
      }
      
      public function get unicID() : uint
      {
         return this._unicID;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function get tooltipContent() : String
      {
         return this._tooltipContent;
      }
      
      public function get admin() : Boolean
      {
         return this._admin;
      }
      
      public function get textfieldEnabled() : Boolean
      {
         return this._textfieldEnabled;
      }
      
      public function get bindable() : Boolean
      {
         return this._bindable;
      }
      
      public function get category() : ShortcutCategory
      {
         return this._category;
      }
      
      public function get visible() : Boolean
      {
         return this._visible;
      }
      
      public function set visible(value:Boolean) : void
      {
         this._visible = value;
      }
      
      public function get required() : Boolean
      {
         return this._required;
      }
      
      public function get holdKeys() : Boolean
      {
         return this._holdKeys;
      }
      
      public function get canBeEnabled() : Boolean
      {
         if(this._boundFeatureKeyword === null)
         {
            return true;
         }
         return this._isBoundFeatureEnabled;
      }
      
      public function get shortcutKeyText() : String
      {
         var bind:Bind = BindsManager.getInstance().getBindFromShortcut("toggleEntityIcons",true);
         if(bind === null || !bind.key)
         {
            return "(" + I18n.getUiText("ui.common.none") + ")";
         }
         return bind.toString();
      }
      
      public function destroy() : void
      {
         if(this._boundFeatureKeyword !== null)
         {
            configApi.removeListenerFromFeatureWithKeyword(this._boundFeatureKeyword,this.onBoundFeatureUpdated);
         }
      }
      
      private function onBoundFeatureUpdated(featureKeyword:String, featureId:int, isEnabled:Boolean) : void
      {
         this._isBoundFeatureEnabled = isEnabled;
      }
      
      public function get disable() : Boolean
      {
         return this._disable;
      }
      
      public function set disable(value:Boolean) : void
      {
         this._disable = value;
      }
   }
}
