package com.ankamagames.dofus.datacenter.mounts
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Mount implements IDataCenter
   {
      
      public static const MODULE:String = "Mounts";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getMountById,getMounts);
       
      
      public var id:uint;
      
      public var familyId:uint;
      
      public var nameId:uint;
      
      public var look:String;
      
      public var certificateId:uint;
      
      public var effects:Vector.<EffectInstance>;
      
      private var _name:String;
      
      public function Mount()
      {
         super();
      }
      
      public static function getMountById(id:uint) : Mount
      {
         return GameData.getObject(MODULE,id) as Mount;
      }
      
      public static function getMounts() : Array
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
