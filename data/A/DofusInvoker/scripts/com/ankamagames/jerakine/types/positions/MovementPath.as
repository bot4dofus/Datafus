package com.ankamagames.jerakine.types.positions
{
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.utils.errors.JerakineError;
   
   public class MovementPath
   {
      
      public static var MAX_PATH_LENGTH:int = 100;
       
      
      protected var _oStart:MapPoint;
      
      protected var _oEnd:MapPoint;
      
      protected var _aPath:Vector.<PathElement>;
      
      public function MovementPath()
      {
         super();
         this._oEnd = new MapPoint();
         this._oStart = new MapPoint();
         this._aPath = new Vector.<PathElement>();
      }
      
      public function get start() : MapPoint
      {
         return this._oStart;
      }
      
      public function set start(nValue:MapPoint) : void
      {
         this._oStart = nValue;
      }
      
      public function get end() : MapPoint
      {
         return this._oEnd;
      }
      
      public function set end(nValue:MapPoint) : void
      {
         this._oEnd = nValue;
      }
      
      public function get path() : Vector.<PathElement>
      {
         return this._aPath;
      }
      
      public function set path(value:Vector.<PathElement>) : void
      {
         this._aPath = value;
      }
      
      public function get length() : uint
      {
         return this._aPath.length;
      }
      
      public function fillFromCellIds(cells:Vector.<uint>) : void
      {
         for(var i:uint = 0; i < cells.length; i++)
         {
            this._aPath.push(new PathElement(MapPoint.fromCellId(cells[i])));
         }
         for(i = 0; i < cells.length - 1; i++)
         {
            PathElement(this._aPath[i]).orientation = PathElement(this._aPath[i]).step.orientationTo(PathElement(this._aPath[i + 1]).step);
         }
         if(this._aPath[0])
         {
            this._oStart = this._aPath[0].step;
            this._oEnd = this._aPath[this._aPath.length - 1].step;
         }
      }
      
      public function addPoint(pathElem:PathElement) : void
      {
         this._aPath.push(pathElem);
      }
      
      public function getPointAtIndex(index:uint) : PathElement
      {
         return this._aPath[index];
      }
      
      public function deletePoint(index:uint, deleteCount:uint = 1) : void
      {
         if(deleteCount == 0)
         {
            this._aPath.splice(index,this._aPath.length - index);
         }
         else
         {
            this._aPath.splice(index,deleteCount);
         }
      }
      
      public function toString() : String
      {
         var str:* = "\ndepart : [" + this._oStart.x + ", " + this._oStart.y + "]";
         str += "\narrivée : [" + this._oEnd.x + ", " + this._oEnd.y + "]\nchemin :";
         for(var i:uint = 0; i < this._aPath.length; i++)
         {
            str += "[" + PathElement(this._aPath[i]).step.x + ", " + PathElement(this._aPath[i]).step.y + ", " + PathElement(this._aPath[i]).orientation + "]  ";
         }
         return str;
      }
      
      public function compress() : void
      {
         var elem:uint = 0;
         if(this._aPath.length > 0)
         {
            elem = this._aPath.length - 1;
            while(elem > 0)
            {
               if(this._aPath[elem].orientation == this._aPath[elem - 1].orientation)
               {
                  this.deletePoint(elem);
                  elem--;
               }
               else
               {
                  elem--;
               }
            }
         }
      }
      
      public function fill() : void
      {
         var elem:int = 0;
         var pFinal:PathElement = null;
         var pe:PathElement = null;
         if(this._aPath.length > 0)
         {
            elem = 0;
            pFinal = new PathElement();
            pFinal.orientation = 0;
            pFinal.step = this._oEnd;
            this._aPath.push(pFinal);
            while(elem < this._aPath.length - 1)
            {
               if(Math.abs(this._aPath[elem].step.x - this._aPath[elem + 1].step.x) > 1 || Math.abs(this._aPath[elem].step.y - this._aPath[elem + 1].step.y) > 1)
               {
                  pe = new PathElement();
                  pe.orientation = this._aPath[elem].orientation;
                  switch(pe.orientation)
                  {
                     case DirectionsEnum.RIGHT:
                        pe.step = MapPoint.fromCoords(this._aPath[elem].step.x + 1,this._aPath[elem].step.y + 1);
                        break;
                     case DirectionsEnum.DOWN_RIGHT:
                        pe.step = MapPoint.fromCoords(this._aPath[elem].step.x + 1,this._aPath[elem].step.y);
                        break;
                     case DirectionsEnum.DOWN:
                        pe.step = MapPoint.fromCoords(this._aPath[elem].step.x + 1,this._aPath[elem].step.y - 1);
                        break;
                     case DirectionsEnum.DOWN_LEFT:
                        pe.step = MapPoint.fromCoords(this._aPath[elem].step.x,this._aPath[elem].step.y - 1);
                        break;
                     case DirectionsEnum.LEFT:
                        pe.step = MapPoint.fromCoords(this._aPath[elem].step.x - 1,this._aPath[elem].step.y - 1);
                        break;
                     case DirectionsEnum.UP_LEFT:
                        pe.step = MapPoint.fromCoords(this._aPath[elem].step.x - 1,this._aPath[elem].step.y);
                        break;
                     case DirectionsEnum.UP:
                        pe.step = MapPoint.fromCoords(this._aPath[elem].step.x - 1,this._aPath[elem].step.y + 1);
                        break;
                     case DirectionsEnum.UP_RIGHT:
                        pe.step = MapPoint.fromCoords(this._aPath[elem].step.x,this._aPath[elem].step.y + 1);
                  }
                  this._aPath.splice(elem + 1,0,pe);
                  elem++;
               }
               else
               {
                  elem++;
               }
               if(elem > MAX_PATH_LENGTH)
               {
                  throw new JerakineError("Path too long. Maybe an orientation problem?");
               }
            }
         }
         this._aPath.pop();
      }
      
      public function getCells() : Vector.<uint>
      {
         var mp:MapPoint = null;
         var cells:Vector.<uint> = new Vector.<uint>();
         for(var i:uint = 0; i < this._aPath.length; i++)
         {
            mp = this._aPath[i].step;
            cells.push(mp.cellId);
         }
         cells.push(this._oEnd.cellId);
         return cells;
      }
      
      public function replaceEnd(newEnd:MapPoint) : void
      {
         this._oEnd = newEnd;
      }
      
      public function clone() : MovementPath
      {
         var clonePath:MovementPath = new MovementPath();
         clonePath.start = this._oStart;
         clonePath.end = this._oEnd;
         clonePath.path = this._aPath.concat();
         return clonePath;
      }
   }
}
