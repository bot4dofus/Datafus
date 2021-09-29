package gs.plugins
{
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.geom.Transform;
   import gs.TweenLite;
   import gs.core.PropTween;
   
   public class TintPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
      
      protected static var _props:Array = ["redMultiplier","greenMultiplier","blueMultiplier","alphaMultiplier","redOffset","greenOffset","blueOffset","alphaOffset"];
       
      
      protected var _transform:Transform;
      
      protected var _ct:ColorTransform;
      
      protected var _ignoreAlpha:Boolean;
      
      public function TintPlugin()
      {
         super();
         this.propName = "tint";
         this.overwriteProps = ["tint"];
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         if(!(target is DisplayObject))
         {
            return false;
         }
         var end:ColorTransform = new ColorTransform();
         if(value != null && tween.vars.removeTint != true)
         {
            end.color = uint(value);
         }
         this._ignoreAlpha = true;
         this.init(target as DisplayObject,end);
         return true;
      }
      
      public function init(target:DisplayObject, end:ColorTransform) : void
      {
         var p:String = null;
         this._transform = target.transform;
         this._ct = this._transform.colorTransform;
         var i:int = _props.length;
         while(i--)
         {
            p = _props[i];
            if(this._ct[p] != end[p])
            {
               _tweens[_tweens.length] = new PropTween(this._ct,p,this._ct[p],end[p] - this._ct[p],"tint",false);
            }
         }
      }
      
      override public function set changeFactor(n:Number) : void
      {
         var ct:ColorTransform = null;
         updateTweens(n);
         if(this._ignoreAlpha)
         {
            ct = this._transform.colorTransform;
            this._ct.alphaMultiplier = ct.alphaMultiplier;
            this._ct.alphaOffset = ct.alphaOffset;
         }
         this._transform.colorTransform = this._ct;
      }
   }
}
