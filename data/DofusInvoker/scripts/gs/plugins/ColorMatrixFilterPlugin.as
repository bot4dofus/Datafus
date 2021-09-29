package gs.plugins
{
   import flash.filters.ColorMatrixFilter;
   import gs.TweenLite;
   
   public class ColorMatrixFilterPlugin extends FilterPlugin
   {
      
      public static const API:Number = 1;
      
      private static var _propNames:Array = [];
      
      protected static var _idMatrix:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
      
      protected static var _lumR:Number = 0.212671;
      
      protected static var _lumG:Number = 0.71516;
      
      protected static var _lumB:Number = 0.072169;
       
      
      protected var _matrix:Array;
      
      protected var _matrixTween:EndArrayPlugin;
      
      public function ColorMatrixFilterPlugin()
      {
         super();
         this.propName = "colorMatrixFilter";
         this.overwriteProps = ["colorMatrixFilter"];
      }
      
      public static function colorize(m:Array, color:Number, amount:Number = 1) : Array
      {
         if(isNaN(color))
         {
            return m;
         }
         if(isNaN(amount))
         {
            amount = 1;
         }
         var r:Number = (color >> 16 & 255) / 255;
         var g:Number = (color >> 8 & 255) / 255;
         var b:Number = (color & 255) / 255;
         var inv:Number = 1 - amount;
         var temp:Array = [inv + amount * r * _lumR,amount * r * _lumG,amount * r * _lumB,0,0,amount * g * _lumR,inv + amount * g * _lumG,amount * g * _lumB,0,0,amount * b * _lumR,amount * b * _lumG,inv + amount * b * _lumB,0,0,0,0,0,1,0];
         return applyMatrix(temp,m);
      }
      
      public static function setThreshold(m:Array, n:Number) : Array
      {
         if(isNaN(n))
         {
            return m;
         }
         var temp:Array = [_lumR * 256,_lumG * 256,_lumB * 256,0,-256 * n,_lumR * 256,_lumG * 256,_lumB * 256,0,-256 * n,_lumR * 256,_lumG * 256,_lumB * 256,0,-256 * n,0,0,0,1,0];
         return applyMatrix(temp,m);
      }
      
      public static function setHue(m:Array, n:Number) : Array
      {
         if(isNaN(n))
         {
            return m;
         }
         n *= Math.PI / 180;
         var c:Number = Math.cos(n);
         var s:Number = Math.sin(n);
         var temp:Array = [_lumR + c * (1 - _lumR) + s * -_lumR,_lumG + c * -_lumG + s * -_lumG,_lumB + c * -_lumB + s * (1 - _lumB),0,0,_lumR + c * -_lumR + s * 0.143,_lumG + c * (1 - _lumG) + s * 0.14,_lumB + c * -_lumB + s * -0.283,0,0,_lumR + c * -_lumR + s * -(1 - _lumR),_lumG + c * -_lumG + s * _lumG,_lumB + c * (1 - _lumB) + s * _lumB,0,0,0,0,0,1,0,0,0,0,0,1];
         return applyMatrix(temp,m);
      }
      
      public static function setBrightness(m:Array, n:Number) : Array
      {
         if(isNaN(n))
         {
            return m;
         }
         n = n * 100 - 100;
         return applyMatrix([1,0,0,0,n,0,1,0,0,n,0,0,1,0,n,0,0,0,1,0,0,0,0,0,1],m);
      }
      
      public static function setSaturation(m:Array, n:Number) : Array
      {
         if(isNaN(n))
         {
            return m;
         }
         var inv:Number = 1 - n;
         var r:Number = inv * _lumR;
         var g:Number = inv * _lumG;
         var b:Number = inv * _lumB;
         var temp:Array = [r + n,g,b,0,0,r,g + n,b,0,0,r,g,b + n,0,0,0,0,0,1,0];
         return applyMatrix(temp,m);
      }
      
      public static function setContrast(m:Array, n:Number) : Array
      {
         if(isNaN(n))
         {
            return m;
         }
         n += 0.01;
         var temp:Array = [n,0,0,0,128 * (1 - n),0,n,0,0,128 * (1 - n),0,0,n,0,128 * (1 - n),0,0,0,1,0];
         return applyMatrix(temp,m);
      }
      
      public static function applyMatrix(m:Array, m2:Array) : Array
      {
         var y:int = 0;
         var x:int = 0;
         if(!(m is Array) || !(m2 is Array))
         {
            return m2;
         }
         var temp:Array = [];
         var i:int = 0;
         var z:int = 0;
         for(y = 0; y < 4; y += 1)
         {
            for(x = 0; x < 5; x += 1)
            {
               if(x == 4)
               {
                  z = m[i + 4];
               }
               else
               {
                  z = 0;
               }
               temp[i + x] = m[i] * m2[x] + m[i + 1] * m2[x + 5] + m[i + 2] * m2[x + 10] + m[i + 3] * m2[x + 15] + z;
            }
            i += 5;
         }
         return temp;
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         _target = target;
         _type = ColorMatrixFilter;
         var cmf:Object = value;
         initFilter({
            "remove":value.remove,
            "index":value.index,
            "addFilter":value.addFilter
         },new ColorMatrixFilter(_idMatrix.slice()),_propNames);
         this._matrix = ColorMatrixFilter(_filter).matrix;
         var endMatrix:Array = [];
         if(cmf.matrix != null && cmf.matrix is Array)
         {
            endMatrix = cmf.matrix;
         }
         else
         {
            if(cmf.relative == true)
            {
               endMatrix = this._matrix.slice();
            }
            else
            {
               endMatrix = _idMatrix.slice();
            }
            endMatrix = setBrightness(endMatrix,cmf.brightness);
            endMatrix = setContrast(endMatrix,cmf.contrast);
            endMatrix = setHue(endMatrix,cmf.hue);
            endMatrix = setSaturation(endMatrix,cmf.saturation);
            endMatrix = setThreshold(endMatrix,cmf.threshold);
            if(!isNaN(cmf.colorize))
            {
               endMatrix = colorize(endMatrix,cmf.colorize,cmf.amount);
            }
         }
         this._matrixTween = new EndArrayPlugin();
         this._matrixTween.init(this._matrix,endMatrix);
         return true;
      }
      
      override public function set changeFactor(n:Number) : void
      {
         this._matrixTween.changeFactor = n;
         ColorMatrixFilter(_filter).matrix = this._matrix;
         super.changeFactor = n;
      }
   }
}
