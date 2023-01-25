package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class GuildTagsType implements IDataCenter
   {
      
      public static const MODULE:String = "GuildTagsTypes";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildTag));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getGuildTagsTypeById,getGuildTagsTypes);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      private var _name:String;
      
      public function GuildTagsType()
      {
         super();
      }
      
      public static function getGuildTagsTypeById(id:int) : GuildTagsType
      {
         return GameData.getObject(MODULE,id) as GuildTagsType;
      }
      
      public static function getGuildTagsTypes() : Array
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
   }
}
