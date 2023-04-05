package com.ankamagames.dofus.datacenter.ambientSounds
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class PlaylistSound implements IDataCenter
   {
      
      public static const MODULE:String = "PlaylistSounds";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getPlaylistSoundById,null);
       
      
      public var id:String;
      
      public var volume:int;
      
      public var channel:int = 0;
      
      public var soundOrder:int;
      
      public function PlaylistSound()
      {
         super();
      }
      
      public static function getPlaylistSoundById(id:uint) : PlaylistSound
      {
         return GameData.getObject(MODULE,id) as PlaylistSound;
      }
   }
}
