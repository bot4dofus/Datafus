package com.ankamagames.dofus.datacenter.sounds
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SoundUiHook implements IDataCenter
   {
      
      public static var MODULE:String = "SoundUiHook";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getSoundUiHookById,getSoundUiHooks);
       
      
      public var id:uint;
      
      public var name:String;
      
      public function SoundUiHook()
      {
         super();
      }
      
      public static function getSoundUiHookById(id:uint) : SoundUiHook
      {
         return GameData.getObject(MODULE,id) as SoundUiHook;
      }
      
      public static function getSoundUiHooks() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
