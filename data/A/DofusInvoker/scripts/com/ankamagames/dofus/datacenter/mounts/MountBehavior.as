package com.ankamagames.dofus.datacenter.mounts
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class MountBehavior implements IDataCenter
   {
      
      public static const MODULE:String = "MountBehaviors";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getMountBehaviorById,getMountBehaviors);
       
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var descriptionId:uint;
      
      private var _name:String;
      
      private var _description:String;
      
      public function MountBehavior()
      {
         super();
      }
      
      public static function getMountBehaviorById(id:uint) : MountBehavior
      {
         return GameData.getObject(MODULE,id) as MountBehavior;
      }
      
      public static function getMountBehaviors() : Array
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
