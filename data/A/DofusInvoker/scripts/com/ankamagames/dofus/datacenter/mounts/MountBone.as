package com.ankamagames.dofus.datacenter.mounts
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class MountBone implements IDataCenter
   {
      
      private static const MODULE:String = "MountBones";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getMountBoneById,getMountBones);
       
      
      public var id:uint;
      
      public function MountBone()
      {
         super();
      }
      
      public static function getMountBoneById(id:uint) : MountBone
      {
         return GameData.getObject(MODULE,id) as MountBone;
      }
      
      public static function getMountBones() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
