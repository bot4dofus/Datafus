package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.enums.LocationTypeEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.uiDefinition.LocationELement;
   import com.ankamagames.berilia.utils.errors.BeriliaXmlParsingError;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class GraphicLocation
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GraphicLocation));
      
      public static const REF_PARENT:String = "$PARENT";
      
      public static const REF_TOP:String = "$TOP";
      
      public static const REF_SCREEN:String = "$SCREEN";
      
      public static const REF_LAST:String = "$LAST";
       
      
      private var _nPoint:uint;
      
      private var _nRelativePoint:uint;
      
      private var _sRelativeTo:String;
      
      protected var _nOffsetX:Number;
      
      protected var _nOffsetY:Number;
      
      public var offsetXType:uint;
      
      public var offsetYType:uint;
      
      public function GraphicLocation(nPoint:Number = NaN, nRelativePoint:Number = NaN, sRelativeTo:String = null)
      {
         super();
         this._nOffsetX = 0;
         this._nOffsetY = 0;
         this._nPoint = LocationEnum.POINT_TOPLEFT;
         this._nRelativePoint = LocationEnum.POINT_TOPLEFT;
         this._sRelativeTo = REF_PARENT;
         if(!isNaN(nPoint))
         {
            this._nPoint = nPoint;
         }
         if(!isNaN(nRelativePoint))
         {
            this._nRelativePoint = nRelativePoint;
         }
         if(sRelativeTo != null)
         {
            this._sRelativeTo = sRelativeTo;
         }
      }
      
      public static function convertPointStringToInt(sPoint:String) : uint
      {
         switch(sPoint)
         {
            case "TOPLEFT":
               return LocationEnum.POINT_TOPLEFT;
            case "TOP":
               return LocationEnum.POINT_TOP;
            case "TOPRIGHT":
               return LocationEnum.POINT_TOPRIGHT;
            case "LEFT":
               return LocationEnum.POINT_LEFT;
            case "CENTER":
               return LocationEnum.POINT_CENTER;
            case "RIGHT":
               return LocationEnum.POINT_RIGHT;
            case "BOTTOMLEFT":
               return LocationEnum.POINT_BOTTOMLEFT;
            case "BOTTOM":
               return LocationEnum.POINT_BOTTOM;
            case "BOTTOMRIGHT":
               return LocationEnum.POINT_BOTTOMRIGHT;
            default:
               throw new BeriliaXmlParsingError(sPoint + " is not a valid value for a point location");
         }
      }
      
      public static function convertPointIntToString(nPoint:uint) : String
      {
         switch(nPoint)
         {
            case LocationEnum.POINT_TOPLEFT:
               return "TOPLEFT";
            case LocationEnum.POINT_TOP:
               return "TOP";
            case LocationEnum.POINT_TOPRIGHT:
               return "TOPRIGHT";
            case LocationEnum.POINT_LEFT:
               return "LEFT";
            case LocationEnum.POINT_CENTER:
               return "CENTER";
            case LocationEnum.POINT_RIGHT:
               return "RIGHT";
            case LocationEnum.POINT_BOTTOMLEFT:
               return "BOTTOMLEFT";
            case LocationEnum.POINT_BOTTOM:
               return "BOTTOM";
            case LocationEnum.POINT_BOTTOMRIGHT:
               return "BOTTOMRIGHT";
            default:
               throw new BeriliaXmlParsingError(nPoint + " is not a valid value for a point location");
         }
      }
      
      public function reset() : void
      {
         this._nOffsetX = 0;
         this._nOffsetY = 0;
         this._nPoint = LocationEnum.POINT_TOPLEFT;
         this._nRelativePoint = LocationEnum.POINT_TOPLEFT;
         this._sRelativeTo = REF_PARENT;
      }
      
      public function setPoint(sPoint:String) : void
      {
         this._nPoint = convertPointStringToInt(sPoint);
      }
      
      public function getPoint() : uint
      {
         return this._nPoint;
      }
      
      public function setRelativePoint(sPoint:String) : void
      {
         this._nRelativePoint = convertPointStringToInt(sPoint);
      }
      
      public function getRelativePoint() : uint
      {
         return this._nRelativePoint;
      }
      
      public function setRelativeTo(sPoint:String) : void
      {
         this._sRelativeTo = sPoint;
      }
      
      public function getRelativeTo() : String
      {
         return this._sRelativeTo;
      }
      
      public function setOffsetX(nOffset:Number) : void
      {
         if(this.offsetXType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE)
         {
            this._nOffsetX = Math.floor(nOffset);
         }
         else
         {
            this._nOffsetX = nOffset;
         }
      }
      
      public function getOffsetX() : Number
      {
         return this._nOffsetX;
      }
      
      public function setOffsetY(nOffset:Number) : void
      {
         if(this.offsetYType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE)
         {
            this._nOffsetY = Math.floor(nOffset);
         }
         else
         {
            this._nOffsetY = nOffset;
         }
      }
      
      public function getOffsetY() : Number
      {
         return this._nOffsetY;
      }
      
      public function toString() : String
      {
         return "GraphicLocation [point : " + convertPointIntToString(this.getPoint()) + ", relativePoint : " + convertPointIntToString(this.getRelativePoint()) + ", relativeTo : " + this.getRelativeTo() + ", offset : " + this.getOffsetX() + "/" + this.getOffsetY();
      }
      
      public function clone() : GraphicLocation
      {
         var tmp:GraphicLocation = new GraphicLocation(this._nPoint,this._nRelativePoint,this._sRelativeTo);
         tmp.offsetXType = this.offsetXType;
         tmp.offsetYType = this.offsetYType;
         tmp.setOffsetX(this.getOffsetX());
         tmp.setOffsetY(this.getOffsetY());
         return tmp;
      }
      
      public function toLocationElement() : LocationELement
      {
         var le:LocationELement = new LocationELement();
         le.offsetXType = this.offsetXType;
         le.offsetYType = this.offsetYType;
         le.offsetX = this.getOffsetX();
         le.offsetY = this.getOffsetY();
         le.point = this.getPoint();
         le.relativePoint = this.getRelativePoint();
         le.relativeTo = this.getRelativeTo();
         return le;
      }
   }
}
