package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class DofusApiAction
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static var _apiActionNameList:Array = new Array();
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DofusApiAction));
       
      
      protected var _name:String;
      
      protected var _actionClass:Class;
      
      public function DofusApiAction(name:String, actionClass:Class)
      {
         super();
         if(!_apiActionNameList)
         {
            _apiActionNameList = new Array();
         }
         if(_apiActionNameList[name])
         {
            throw new BeriliaError("DofusApiAction name (" + name + ") already used, please rename it.");
         }
         this._name = name;
         this._actionClass = actionClass;
         _apiActionNameList[name] = this;
         MEMORY_LOG[this] = 1;
      }
      
      public static function getApiActionByName(name:String) : DofusApiAction
      {
         return _apiActionNameList[name];
      }
      
      public static function getApiActionsList() : Array
      {
         return _apiActionNameList;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get actionClass() : Class
      {
         return this._actionClass;
      }
   }
}
