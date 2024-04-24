package com.ankamagames.dofus.datacenter.communication
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class Emoticon implements IDataCenter
   {
      
      public static const MODULE:String = "Emoticons";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Emoticon));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getEmoticonById,getEmoticons);
       
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var shortcutId:uint;
      
      public var order:uint;
      
      public var animName:String;
      
      public var persistancy:Boolean;
      
      public var eight_directions:Boolean;
      
      public var aura:Boolean;
      
      public var cooldown:uint = 1000;
      
      public var duration:uint = 0;
      
      public var weight:uint;
      
      public var spellLevelId:uint = 0;
      
      private var _name:String;
      
      private var _shortcut:String;
      
      public function Emoticon()
      {
         super();
      }
      
      public static function getEmoticonById(id:int) : Emoticon
      {
         return GameData.getObject(MODULE,id) as Emoticon;
      }
      
      public static function getEmoticons() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get shortcut() : String
      {
         if(!this._shortcut)
         {
            this._shortcut = I18n.getText(this.shortcutId);
         }
         return this._shortcut;
      }
      
      public function getAnimName() : String
      {
         var allPossibilities:Array = null;
         if(this.spellLevelId != 0)
         {
            return null;
         }
         var finalAnimName:String = this.animName;
         if(finalAnimName.indexOf("random") == 0)
         {
            allPossibilities = finalAnimName.substring(finalAnimName.indexOf("("),finalAnimName.indexOf(")")).split(",");
            finalAnimName = allPossibilities[Math.floor(allPossibilities.length * Math.random())];
         }
         return finalAnimName;
      }
   }
}
