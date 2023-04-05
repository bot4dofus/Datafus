package com.ankamagames.atouin.data.map
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.IDataInput;
   import flash.utils.getQualifiedClassName;
   
   public class CellData
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CellData));
       
      
      public var id:uint;
      
      public var speed:int;
      
      public var mapChangeData:uint;
      
      public var moveZone:uint;
      
      private var _losmov:int = 3;
      
      private var _floor:int;
      
      private var _map:Map;
      
      private var _arrow:int = 0;
      
      private var _linkedZone:int;
      
      private var _mov:Boolean;
      
      private var _los:Boolean;
      
      private var _nonWalkableDuringFight:Boolean;
      
      private var _red:Boolean;
      
      private var _blue:Boolean;
      
      private var _farmCell:Boolean;
      
      private var _havenbagCell:Boolean;
      
      private var _visible:Boolean;
      
      private var _nonWalkableDuringRP:Boolean;
      
      public function CellData(map:Map, cellId:uint)
      {
         super();
         this.id = cellId;
         this._map = map;
      }
      
      public function get map() : Map
      {
         return this._map;
      }
      
      public function get mov() : Boolean
      {
         return this._mov;
      }
      
      public function get los() : Boolean
      {
         return this._los;
      }
      
      public function get nonWalkableDuringFight() : Boolean
      {
         return this._nonWalkableDuringFight;
      }
      
      public function get red() : Boolean
      {
         return this._red;
      }
      
      public function get blue() : Boolean
      {
         return this._blue;
      }
      
      public function get farmCell() : Boolean
      {
         return this._farmCell;
      }
      
      public function get havenbagCell() : Boolean
      {
         return this._havenbagCell;
      }
      
      public function get visible() : Boolean
      {
         return this._visible;
      }
      
      public function get nonWalkableDuringRP() : Boolean
      {
         return this._nonWalkableDuringRP;
      }
      
      public function get floor() : int
      {
         return this._floor;
      }
      
      public function get useTopArrow() : Boolean
      {
         return (this._arrow & 1) != 0;
      }
      
      public function get useBottomArrow() : Boolean
      {
         return (this._arrow & 2) != 0;
      }
      
      public function get useRightArrow() : Boolean
      {
         return (this._arrow & 4) != 0;
      }
      
      public function get useLeftArrow() : Boolean
      {
         return (this._arrow & 8) != 0;
      }
      
      public function hasLinkedZoneRP() : Boolean
      {
         return this.mov && !this.farmCell;
      }
      
      public function get linkedZoneRP() : int
      {
         return (this._linkedZone & 240) >> 4;
      }
      
      public function hasLinkedZoneFight() : Boolean
      {
         return this.mov && !this.nonWalkableDuringFight && !this.farmCell && !this.havenbagCell;
      }
      
      public function get linkedZoneFight() : int
      {
         return this._linkedZone & 15;
      }
      
      public function fromRaw(raw:IDataInput) : void
      {
         var tmpbytesv9:int = 0;
         var topArrow:Boolean = false;
         var bottomArrow:Boolean = false;
         var rightArrow:Boolean = false;
         var leftArrow:Boolean = false;
         var tmpBits:int = 0;
         try
         {
            this._floor = raw.readByte() * 10;
            if(this._floor == -1280)
            {
               return;
            }
            if(this._map.mapVersion >= 9)
            {
               tmpbytesv9 = raw.readShort();
               this._mov = (tmpbytesv9 & 1) == 0;
               this._nonWalkableDuringFight = (tmpbytesv9 & 2) != 0;
               this._nonWalkableDuringRP = (tmpbytesv9 & 4) != 0;
               this._los = (tmpbytesv9 & 8) == 0;
               this._blue = (tmpbytesv9 & 16) != 0;
               this._red = (tmpbytesv9 & 32) != 0;
               this._visible = (tmpbytesv9 & 64) != 0;
               this._farmCell = (tmpbytesv9 & 128) != 0;
               if(this.map.mapVersion >= 10)
               {
                  this._havenbagCell = (tmpbytesv9 & 256) != 0;
                  topArrow = (tmpbytesv9 & 512) != 0;
                  bottomArrow = (tmpbytesv9 & 1024) != 0;
                  rightArrow = (tmpbytesv9 & 2048) != 0;
                  leftArrow = (tmpbytesv9 & 4096) != 0;
               }
               else
               {
                  topArrow = (tmpbytesv9 & 256) != 0;
                  bottomArrow = (tmpbytesv9 & 512) != 0;
                  rightArrow = (tmpbytesv9 & 1024) != 0;
                  leftArrow = (tmpbytesv9 & 2048) != 0;
               }
               if(topArrow)
               {
                  this._map.topArrowCell.push(this.id);
               }
               if(bottomArrow)
               {
                  this._map.bottomArrowCell.push(this.id);
               }
               if(rightArrow)
               {
                  this._map.rightArrowCell.push(this.id);
               }
               if(leftArrow)
               {
                  this._map.leftArrowCell.push(this.id);
               }
            }
            else
            {
               this._losmov = raw.readUnsignedByte();
               this._los = (this._losmov & 2) >> 1 == 1;
               this._mov = (this._losmov & 1) == 1;
               this._visible = (this._losmov & 64) >> 6 == 1;
               this._farmCell = (this._losmov & 32) >> 5 == 1;
               this._blue = (this._losmov & 16) >> 4 == 1;
               this._red = (this._losmov & 8) >> 3 == 1;
               this._nonWalkableDuringRP = (this._losmov & 128) >> 7 == 1;
               this._nonWalkableDuringFight = (this._losmov & 4) >> 2 == 1;
            }
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("  (CellData) LOS : " + this._los);
            }
            this.speed = raw.readByte();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("  (CellData) Speed : " + this.speed);
            }
            this.mapChangeData = raw.readByte();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("  (CellData) MapChangeData : " + this.mapChangeData);
            }
            if(this._map.mapVersion > 5)
            {
               this.moveZone = raw.readUnsignedByte();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("  (CellData) moveZone : " + this.moveZone);
               }
            }
            if(this._map.mapVersion > 10 && (this.hasLinkedZoneRP() || this.hasLinkedZoneFight()))
            {
               this._linkedZone = raw.readUnsignedByte();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("  (CellData) linkedZoneRP : " + this.linkedZoneRP);
                  _log.debug("  (CellData) linkedZoneFight : " + this.linkedZoneFight);
               }
            }
            if(this._map.mapVersion > 7 && this.map.mapVersion < 9)
            {
               tmpBits = raw.readByte();
               this._arrow = 15 & tmpBits;
               if(this.useTopArrow)
               {
                  this._map.topArrowCell.push(this.id);
               }
               if(this.useBottomArrow)
               {
                  this._map.bottomArrowCell.push(this.id);
               }
               if(this.useLeftArrow)
               {
                  this._map.leftArrowCell.push(this.id);
               }
               if(this.useRightArrow)
               {
                  this._map.rightArrowCell.push(this.id);
               }
            }
         }
         catch(e:*)
         {
            throw e;
         }
      }
      
      public function toString() : String
      {
         return "map : " + this._map.id + " CellId : " + this.id + " mov : " + this._mov + " los : " + this._los + " nonWalkableDuringFight : " + this._nonWalkableDuringFight + " nonWalkableDuringRp : " + this._nonWalkableDuringRP + " farmCell : " + this._farmCell + " havenbagCell: " + this._havenbagCell + " visbile : " + this._visible + " speed: " + this.speed + " moveZone: " + this.moveZone + " linkedZoneId: " + this._linkedZone;
      }
   }
}
