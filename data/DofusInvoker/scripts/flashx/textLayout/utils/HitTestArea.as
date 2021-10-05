package flashx.textLayout.utils
{
   import flash.geom.Rectangle;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [ExcludeClass]
   public class HitTestArea
   {
       
      
      private var tl:HitTestArea = null;
      
      private var tr:HitTestArea = null;
      
      private var bl:HitTestArea = null;
      
      private var br:HitTestArea = null;
      
      private var _rect:Rectangle;
      
      private var _xm:Number;
      
      private var _ym:Number;
      
      private var _owner:FlowElement = null;
      
      public function HitTestArea(objects:Object)
      {
         super();
         this.initialize(objects);
      }
      
      tlf_internal function initialize(objects:Object) : void
      {
         var obj:* = null;
         var r:Rectangle = null;
         var quadrant:Rectangle = null;
         var dxLower:Number = NaN;
         var dxUpper:Number = NaN;
         var dyLower:Number = NaN;
         var dyUpper:Number = NaN;
         var count:int = 0;
         if(objects)
         {
            for(obj in objects)
            {
               if(++count > 1)
               {
                  break;
               }
            }
         }
         if(count == 0)
         {
            this._rect = new Rectangle();
            this._xm = this._ym = 0;
            return;
         }
         if(count == 1)
         {
            var _loc10_:int = 0;
            var _loc11_:* = objects;
            for each(obj in _loc11_)
            {
               this._rect = obj.rect;
               this._xm = this._rect.left;
               this._ym = this._rect.top;
               this._owner = obj.owner;
               return;
            }
         }
         for each(obj in objects)
         {
            r = obj.rect;
            if(!this._rect)
            {
               this._rect = r;
            }
            else
            {
               this._rect = this._rect.union(r);
            }
         }
         this._xm = Math.ceil(this._rect.left + this._rect.width / 2);
         this._ym = Math.ceil(this._rect.top + this._rect.height / 2);
         if(this._rect.width <= 3 || this._rect.height <= 3)
         {
            _loc10_ = 0;
            _loc11_ = objects;
            for each(obj in _loc11_)
            {
               this._owner = obj.owner;
               return;
            }
         }
         for each(obj in objects)
         {
            r = obj.rect;
            if(!r.equals(this._rect))
            {
               if(r.contains(this._xm,this._ym))
               {
                  dxLower = this._xm - r.left;
                  dxUpper = r.right - this._xm;
                  dyLower = this._ym - r.top;
                  dyUpper = r.bottom - this._ym;
                  this._xm = dxLower > dxUpper ? Number(this._xm + dxUpper) : Number(this._xm - dxLower);
                  this._ym = dyLower > dyUpper ? Number(this._ym + dyUpper) : Number(this._ym - dyLower);
                  break;
               }
            }
         }
         quadrant = new Rectangle(this._rect.left,this._rect.top,this._xm - this._rect.left,this._ym - this._rect.top);
         this.addQuadrant(objects,"tl",quadrant);
         quadrant.left = this._xm;
         quadrant.right = this._rect.right;
         this.addQuadrant(objects,"tr",quadrant);
         quadrant.left = this._rect.left;
         quadrant.top = this._ym;
         quadrant.right = this._xm;
         quadrant.bottom = this._rect.bottom;
         this.addQuadrant(objects,"bl",quadrant);
         quadrant.left = this._xm;
         quadrant.right = this._rect.right;
         this.addQuadrant(objects,"br",quadrant);
      }
      
      public function hitTest(x:Number, y:Number) : FlowElement
      {
         if(!this._rect.contains(x,y))
         {
            return null;
         }
         if(this._owner)
         {
            return this._owner;
         }
         var quadrantName:String = y < this._ym ? "t" : "b";
         quadrantName += x < this._xm ? "l" : "r";
         var quadrant:HitTestArea = this[quadrantName];
         if(quadrant == null)
         {
            return null;
         }
         return quadrant.hitTest(x,y);
      }
      
      private function addQuadrant(objects:Object, propName:String, quadrant:Rectangle) : void
      {
         var obj:Object = null;
         var intersect:Rectangle = null;
         if(quadrant.isEmpty())
         {
            return;
         }
         var qrects:Object = {};
         var i:int = 0;
         for each(obj in objects)
         {
            intersect = obj.rect.intersection(quadrant);
            if(!intersect.isEmpty())
            {
               var _loc10_:* = i++;
               qrects[_loc10_] = {
                  "owner":obj.owner,
                  "rect":intersect
               };
            }
         }
         if(i > 0)
         {
            this[propName] = new HitTestArea(qrects);
         }
      }
   }
}
