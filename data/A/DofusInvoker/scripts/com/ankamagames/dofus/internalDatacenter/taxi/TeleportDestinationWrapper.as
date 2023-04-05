package com.ankamagames.dofus.internalDatacenter.taxi
{
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.datacenter.world.Hint;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.network.enums.TeleporterTypeEnum;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   
   public class TeleportDestinationWrapper implements IDataCenter
   {
      
      private static var _hints:Dictionary;
      
      private static var _hintsRealMap:Dictionary;
       
      
      public var teleporterType:uint;
      
      public var mapId:Number;
      
      public var subArea:SubArea;
      
      public var destinationType:uint;
      
      public var cost:uint;
      
      public var level:uint;
      
      public var spawn:Boolean;
      
      public var known:Boolean;
      
      public var subAreaNameId:uint;
      
      public var nameId:uint;
      
      public var areaName:String;
      
      public var subAreaName:String;
      
      public var hintName:String;
      
      public var coord:String;
      
      public var hintMapId:Number;
      
      public var category:int;
      
      public function TeleportDestinationWrapper(teleporterGenericType:uint, mapId:Number, subareaId:uint, destType:uint, level:uint, cost:uint, spawn:Boolean = false, hint:Hint = null, known:Boolean = true)
      {
         var area:Area = null;
         super();
         this.teleporterType = teleporterGenericType;
         this.mapId = mapId;
         this.subArea = SubArea.getSubAreaById(subareaId);
         this.subAreaName = this.subArea.name;
         this.destinationType = destType;
         this.level = level;
         this.cost = cost;
         this.spawn = spawn;
         this.known = known;
         if(this.teleporterType == TeleporterTypeEnum.TELEPORTER_SUBWAY)
         {
            if(hint)
            {
               this.category = hint.categoryId;
               this.areaName = hint.name;
               this.nameId = hint.nameId;
            }
            else
            {
               this.category = -1;
            }
         }
         else
         {
            area = Area.getAreaById(this.subArea.areaId);
            this.areaName = area.name;
            this.nameId = area.nameId;
            this.subAreaNameId = this.subArea.nameId;
         }
         var p:Object = new WorldPointWrapper(mapId);
         this.coord = p.outdoorX + "," + p.outdoorY;
      }
      
      public static function getHintsFromMapId(mapId:Number) : Vector.<Hint>
      {
         var ret:Vector.<Hint> = null;
         generateHintsDictionary();
         if(_hintsRealMap.hasOwnProperty(mapId.toString()))
         {
            ret = _hintsRealMap[mapId];
         }
         else
         {
            ret = new Vector.<Hint>();
         }
         if(_hints.hasOwnProperty(mapId.toString()))
         {
            return ret.concat(_hints[mapId]);
         }
         return ret;
      }
      
      private static function generateHintsDictionary() : void
      {
         var hints:Array = null;
         var hint:Hint = null;
         if(!_hints)
         {
            hints = Hint.getHints();
            _hints = new Dictionary();
            _hintsRealMap = new Dictionary();
            for each(hint in hints)
            {
               if(_hints.hasOwnProperty(hint.mapId.toString()))
               {
                  _hints[hint.mapId].push(hint);
               }
               else
               {
                  _hints[hint.mapId] = new Vector.<Hint>();
                  _hints[hint.mapId].push(hint);
               }
               if(_hintsRealMap.hasOwnProperty(hint.realMapId.toString()))
               {
                  _hintsRealMap[hint.realMapId].push(hint);
               }
               else
               {
                  _hintsRealMap[hint.realMapId] = new Vector.<Hint>();
                  _hintsRealMap[hint.realMapId].push(hint);
               }
            }
         }
      }
   }
}
