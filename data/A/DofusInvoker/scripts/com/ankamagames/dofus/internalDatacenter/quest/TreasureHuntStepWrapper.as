package com.ankamagames.dofus.internalDatacenter.quest
{
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.datacenter.quest.treasureHunt.PointOfInterest;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.world.WorldMap;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.types.enums.TreasureHuntStepTypeEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import flash.utils.getQualifiedClassName;
   
   public class TreasureHuntStepWrapper implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TreasureHuntStepWrapper));
       
      
      public var index:uint;
      
      public var type:uint;
      
      public var direction:int = -1;
      
      public var mapId:Number = -1;
      
      public var poiLabel:uint = 0;
      
      public var flagState:int = -1;
      
      public var count:uint = 0;
      
      private var _stepText:String;
      
      private var _stepRolloverText:String;
      
      public function TreasureHuntStepWrapper()
      {
         super();
      }
      
      public static function create(type:uint, index:uint, direction:int, mapId:Number, poiLabel:uint, flagState:int = -1, count:uint = 0) : TreasureHuntStepWrapper
      {
         var item:TreasureHuntStepWrapper = new TreasureHuntStepWrapper();
         item.type = type;
         item.index = index;
         item.direction = direction;
         item.mapId = mapId;
         item.poiLabel = poiLabel;
         item.flagState = flagState;
         item.count = count;
         return item;
      }
      
      public function get text() : String
      {
         var map:WorldPointWrapper = null;
         var p:MapPosition = null;
         var wm:WorldMap = null;
         var poi:PointOfInterest = null;
         var npc:Npc = null;
         if(!this._stepText)
         {
            if(this.type == TreasureHuntStepTypeEnum.START)
            {
               map = new WorldPointWrapper(this.mapId);
               this._stepText = I18n.getUiText("ui.common.start") + " [" + map.outdoorX + "," + map.outdoorY + "]";
               p = MapPosition.getMapPositionById(this.mapId);
               if(p && p.worldMap > 1)
               {
                  wm = WorldMap.getWorldMapById(p.worldMap);
                  this._stepText += !!wm ? " " + wm.name : "";
               }
            }
            else if(this.type == TreasureHuntStepTypeEnum.DIRECTION_TO_POI)
            {
               poi = PointOfInterest.getPointOfInterestById(this.poiLabel);
               if(poi)
               {
                  this._stepText = poi.name;
               }
               else
               {
                  this._stepText = "???";
               }
            }
            else if(this.type == TreasureHuntStepTypeEnum.DIRECTION)
            {
               this._stepText = "x" + this.count;
            }
            else if(this.type == TreasureHuntStepTypeEnum.DIRECTION_TO_HINT)
            {
               npc = Npc.getNpcById(this.count);
               this._stepText = npc.name;
            }
            else if(this.type == TreasureHuntStepTypeEnum.FIGHT)
            {
               this._stepText = "";
            }
            else if(this.type == TreasureHuntStepTypeEnum.UNKNOWN)
            {
               this._stepText = "?";
            }
         }
         return this._stepText;
      }
      
      public function get overText() : String
      {
         var directionName:String = null;
         var subArea:SubArea = null;
         var area:Area = null;
         if(!this._stepRolloverText)
         {
            if(this.type == TreasureHuntStepTypeEnum.START)
            {
               subArea = SubArea.getSubAreaByMapId(this.mapId);
               if(subArea)
               {
                  area = subArea.area;
                  if(area)
                  {
                     this._stepRolloverText = area.name + " (" + subArea.name + ")";
                  }
               }
            }
            else if(this.type == TreasureHuntStepTypeEnum.DIRECTION_TO_POI || this.type == TreasureHuntStepTypeEnum.DIRECTION_TO_HINT)
            {
               if(this.direction == DirectionsEnum.RIGHT)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theEast");
               }
               else if(this.direction == DirectionsEnum.DOWN)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theSouth");
               }
               else if(this.direction == DirectionsEnum.LEFT)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theWest");
               }
               else if(this.direction == DirectionsEnum.UP)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theNorth");
               }
               else if(this.direction == DirectionsEnum.DOWN_LEFT)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theSouthWest");
               }
               else if(this.direction == DirectionsEnum.DOWN_RIGHT)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theSouthEast");
               }
               else if(this.direction == DirectionsEnum.UP_LEFT)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theNorthWest");
               }
               else if(this.direction == DirectionsEnum.UP_RIGHT)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theNorthEast");
               }
               this._stepRolloverText = I18n.getUiText("ui.treasureHunt.followDirectionToPOI",[directionName,"[" + this._stepText + "]"]);
            }
            else if(this.type == TreasureHuntStepTypeEnum.DIRECTION)
            {
               if(this.direction == DirectionsEnum.RIGHT)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theEast");
               }
               else if(this.direction == DirectionsEnum.DOWN)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theSouth");
               }
               else if(this.direction == DirectionsEnum.LEFT)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theWest");
               }
               else if(this.direction == DirectionsEnum.UP)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theNorth");
               }
               else if(this.direction == DirectionsEnum.DOWN_LEFT)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theSouthWest");
               }
               else if(this.direction == DirectionsEnum.DOWN_RIGHT)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theSouthEast");
               }
               else if(this.direction == DirectionsEnum.UP_LEFT)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theNorthWest");
               }
               else if(this.direction == DirectionsEnum.UP_RIGHT)
               {
                  directionName = I18n.getUiText("ui.treasureHunt.theNorthEast");
               }
               this._stepRolloverText = PatternDecoder.combine(I18n.getUiText("ui.treasureHunt.followDirection",[this.count,directionName]),"n",this.count <= 1);
            }
         }
         return this._stepRolloverText;
      }
      
      public function update(type:uint, index:uint, direction:int, mapId:Number, poiLabel:uint, flagState:int = -1, count:uint = 0) : void
      {
         this.type = type;
         this.index = index;
         this.direction = direction;
         this.mapId = mapId;
         this.poiLabel = poiLabel;
         this.flagState = flagState;
         this.count = count;
      }
   }
}
