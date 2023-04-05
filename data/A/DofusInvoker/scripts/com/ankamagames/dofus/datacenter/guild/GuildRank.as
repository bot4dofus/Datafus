package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class GuildRank implements IDataCenter
   {
      
      public static const MODULE:String = "GuildRanks";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildRank));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getGuildRankById,getGuildRanks);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var order:int;
      
      public var isModifiable:Boolean;
      
      public var gfxId:uint;
      
      private var _name:String;
      
      public function GuildRank()
      {
         super();
      }
      
      public static function getGuildRankById(id:int) : GuildRank
      {
         return GameData.getObject(MODULE,id) as GuildRank;
      }
      
      public static function getGuildRanks() : Array
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
