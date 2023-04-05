package com.ankamagames.dofus.datacenter.breeds
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class BreedRole implements IDataCenter
   {
      
      public static const MODULE:String = "BreedRoles";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BreedRole));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getBreedRoleById,getBreedRoles);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var descriptionId:uint;
      
      public var assetId:int;
      
      public var color:int;
      
      private var _name:String;
      
      private var _description:String;
      
      public function BreedRole()
      {
         super();
      }
      
      public static function getBreedRoleById(id:int) : BreedRole
      {
         return GameData.getObject(MODULE,id) as BreedRole;
      }
      
      public static function getBreedRoles() : Array
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
