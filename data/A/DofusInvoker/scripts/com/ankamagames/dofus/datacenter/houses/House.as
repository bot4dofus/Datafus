package com.ankamagames.dofus.datacenter.houses
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class House implements IDataCenter
   {
      
      public static const MODULE:String = "Houses";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(House));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getGuildHouseById,null);
       
      
      public var typeId:int;
      
      public var defaultPrice:uint;
      
      public var nameId:int;
      
      public var descriptionId:int;
      
      public var gfxId:int;
      
      private var _name:String;
      
      private var _description:String;
      
      public function House()
      {
         super();
      }
      
      public static function getGuildHouseById(id:int) : House
      {
         return GameData.getObject(MODULE,id) as House;
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get description() : String
      {
         if(!this._description)
         {
            this._description = I18n.getText(this.descriptionId);
         }
         return this._description;
      }
   }
}
