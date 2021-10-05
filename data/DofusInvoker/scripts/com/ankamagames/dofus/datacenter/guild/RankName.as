package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class RankName implements IDataCenter
   {
      
      public static const MODULE:String = "RankNames";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RankName));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getRankNameById,getRankNames);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var order:int;
      
      private var _name:String;
      
      public function RankName()
      {
         super();
      }
      
      public static function getRankNameById(id:int) : RankName
      {
         return GameData.getObject(MODULE,id) as RankName;
      }
      
      public static function getRankNames() : Array
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
