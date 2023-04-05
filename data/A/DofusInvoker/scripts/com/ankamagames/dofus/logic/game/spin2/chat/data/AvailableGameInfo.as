package com.ankamagames.dofus.logic.game.spin2.chat.data
{
   public class AvailableGameInfo
   {
       
      
      public var name:String;
      
      public var id:uint;
      
      public var languages:Vector.<String>;
      
      public var fallback:String;
      
      public var basePath:String;
      
      public function AvailableGameInfo(_name:String, _id:uint, _languages:Array, _fallback:String, _basePath:String)
      {
         super();
         this.name = _name;
         this.id = _id;
         this.languages = Vector.<String>(_languages);
         this.fallback = _fallback;
         this.basePath = _basePath;
      }
      
      public function hasLang(_lang:String) : Boolean
      {
         var language:String = null;
         for each(language in this.languages)
         {
            if(_lang == language)
            {
               return true;
            }
         }
         return false;
      }
      
      public function toString() : String
      {
         return "AvailableGameInfo : " + this.name + "[" + this.id + ":" + this.basePath + "], languages : " + this.languages.toString() + ", fallback" + " is " + this.fallback;
      }
   }
}
