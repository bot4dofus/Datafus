package com.ankamagames.dofus.datacenter.alliance
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class KothRole implements IDataCenter
   {
      
      public static const MODULE:String = "KothRoles";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(KothRole));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getKothRoleById,getKothRoles);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var isDefault:Boolean;
      
      private var _name:String;
      
      public function KothRole()
      {
         super();
      }
      
      public static function getKothRoleById(id:int) : KothRole
      {
         return GameData.getObject(MODULE,id) as KothRole;
      }
      
      public static function getKothRoles() : Array
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
