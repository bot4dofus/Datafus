package com.ankamagames.dofus.datacenter.playlists
{
   import com.ankamagames.dofus.datacenter.ambientSounds.PlaylistSound;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Playlist implements IDataCenter
   {
      
      public static const AMBIENT_TYPE_ROLEPLAY:int = 1;
      
      public static const AMBIENT_TYPE_AMBIENT:int = 2;
      
      public static const AMBIENT_TYPE_FIGHT:int = 3;
      
      public static const AMBIENT_TYPE_BOSS:int = 4;
      
      public static const MODULE:String = "Playlists";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getPlaylistById,null);
       
      
      public var id:int;
      
      public var type:int;
      
      public var sounds:Vector.<PlaylistSound>;
      
      public var startRandom:Boolean;
      
      public var startRandomOnce:Boolean;
      
      public var crossfadeDuration:int;
      
      public var random:Boolean;
      
      public function Playlist()
      {
         this.sounds = new Vector.<PlaylistSound>();
         super();
      }
      
      public static function getPlaylistById(id:uint) : Playlist
      {
         return GameData.getObject(MODULE,id) as Playlist;
      }
   }
}
