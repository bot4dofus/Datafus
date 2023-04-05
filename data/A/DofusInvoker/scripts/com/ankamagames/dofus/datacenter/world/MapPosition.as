package com.ankamagames.dofus.datacenter.world
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.utils.getQualifiedClassName;
   
   public class MapPosition implements IDataCenter
   {
      
      public static const MODULE:String = "MapPositions";
      
      private static const DST:DataStoreType = new DataStoreType(MODULE,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER);
      
      private static const CAPABILITY_ALLOW_CHALLENGE:int = 1;
      
      private static const CAPABILITY_ALLOW_AGGRESSION:int = 2;
      
      private static const CAPABILITY_ALLOW_TELEPORT_TO:int = 4;
      
      private static const CAPABILITY_ALLOW_TELEPORT_FROM:int = 8;
      
      private static const CAPABILITY_ALLOW_EXCHANGES_BETWEEN_PLAYERS:int = 16;
      
      private static const CAPABILITY_ALLOW_COLLECTOR:int = 64;
      
      private static const CAPABILITY_ALLOW_SOUL_CAPTURE:int = 128;
      
      private static const CAPABILITY_ALLOW_SOUL_SUMMON:int = 256;
      
      private static const CAPABILITY_ALLOW_TAVERN_REGEN:int = 512;
      
      private static const CAPABILITY_ALLOW_TOMB_MODE:int = 1024;
      
      private static const CAPABILITY_ALLOW_TELEPORT_EVERYWHERE:int = 2048;
      
      private static const CAPABILITY_ALLOW_FIGHT_CHALLENGES:int = 4096;
      
      private static const CAPABILITY_ALLOW_MONSTER_RESPAWN:int = 8192;
      
      private static const CAPABILITY_ALLOW_MONSTER_FIGHT:int = 16384;
      
      private static const CAPABILITY_ALLOW_MOUNT:int = 32768;
      
      private static const CAPABILITY_ALLOW_OBJECT_DISPOSAL:int = 65536;
      
      private static const CAPABILITY_ALLOW_UNDERWATER:int = 131072;
      
      private static const CAPABILITY_ALLOW_PVP_1V1:int = 262144;
      
      private static const CAPABILITY_ALLOW_PVP_3V3:int = 524288;
      
      private static const CAPABILITY_ALLOW_MONSTER_AGRESSION:int = 1048576;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapPosition));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getMapPositionById,getMapPositions);
       
      
      public var id:Number;
      
      public var posX:int;
      
      public var posY:int;
      
      public var outdoor:Boolean;
      
      public var capabilities:int;
      
      public var nameId:int;
      
      public var playlists:Vector.<Vector.<int>>;
      
      public var subAreaId:int;
      
      public var worldMap:int;
      
      public var hasPriorityOnWorldmap:Boolean;
      
      public var allowPrism:Boolean;
      
      public var isTransition:Boolean;
      
      public var mapHasTemplate:Boolean;
      
      public var tacticalModeTemplateId:uint;
      
      public var hasPublicPaddock:Boolean;
      
      private var _name:String;
      
      private var _subArea:SubArea;
      
      public function MapPosition()
      {
         super();
      }
      
      public static function getMapPositionById(id:Number) : MapPosition
      {
         return GameData.getObject(MODULE,id) as MapPosition;
      }
      
      public static function getMapPositions() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public static function getMapIdByCoord(x:int, y:int) : Vector.<Number>
      {
         var mc:MapCoordinates = MapCoordinates.getMapCoordinatesByCoords(x,y);
         if(mc)
         {
            return mc.mapIds;
         }
         return null;
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get subArea() : SubArea
      {
         if(!this._subArea)
         {
            this._subArea = SubArea.getSubAreaById(this.subAreaId);
         }
         return this._subArea;
      }
      
      public function get allowChallenge() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_CHALLENGE) != 0;
      }
      
      public function get allowAggression() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_AGGRESSION) != 0;
      }
      
      public function get allowTeleportTo() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_TELEPORT_TO) != 0;
      }
      
      public function get allowTeleportFrom() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_TELEPORT_FROM) != 0;
      }
      
      public function get allowExchanges() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_EXCHANGES_BETWEEN_PLAYERS) != 0;
      }
      
      public function get allowTaxCollector() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_COLLECTOR) != 0;
      }
      
      public function get allowSoulCapture() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_SOUL_CAPTURE) != 0;
      }
      
      public function get allowSoulSummon() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_SOUL_SUMMON) != 0;
      }
      
      public function get allowTavernRegen() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_TAVERN_REGEN) != 0;
      }
      
      public function get allowTombMode() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_TOMB_MODE) != 0;
      }
      
      public function get allowTeleportEverywhere() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_TELEPORT_EVERYWHERE) != 0;
      }
      
      public function get allowFightChallenges() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_FIGHT_CHALLENGES) != 0;
      }
      
      public function get allowMonsterRespawn() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_MONSTER_RESPAWN) != 0;
      }
      
      public function get allowMonsterFight() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_MONSTER_FIGHT) != 0;
      }
      
      public function get allowMount() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_MOUNT) != 0;
      }
      
      public function get allowObjectDisposal() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_OBJECT_DISPOSAL) != 0;
      }
      
      public function get isUnderWater() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_UNDERWATER) != 0;
      }
      
      public function get allowPvp1v1() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_PVP_1V1) != 0;
      }
      
      public function get allowPvp3v3() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_PVP_3V3) != 0;
      }
      
      public function get allowMonsterAggression() : Boolean
      {
         return (this.capabilities & CAPABILITY_ALLOW_MONSTER_AGRESSION) != 0;
      }
   }
}
