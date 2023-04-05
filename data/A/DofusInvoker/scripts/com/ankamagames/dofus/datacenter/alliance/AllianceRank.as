package com.ankamagames.dofus.datacenter.alliance
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class AllianceRank implements IDataCenter
   {
      
      public static const MODULE:String = "AllianceRanks";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AllianceRank));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAllianceRankById,getAllianceRanks);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var order:int;
      
      public var isModifiable:Boolean;
      
      public var gfxId:uint;
      
      private var _name:String;
      
      public function AllianceRank()
      {
         super();
      }
      
      public static function getAllianceRankById(id:int) : AllianceRank
      {
         return GameData.getObject(MODULE,id) as AllianceRank;
      }
      
      public static function getAllianceRanks() : Array
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
