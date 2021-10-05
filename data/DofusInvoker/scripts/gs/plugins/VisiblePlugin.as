package gs.plugins
{
   import gs.TweenLite;
   
   public class VisiblePlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
       
      
      protected var _target:Object;
      
      protected var _tween:TweenLite;
      
      protected var _visible:Boolean;
      
      protected var _initVal:Boolean;
      
      public function VisiblePlugin()
      {
         super();
         this.propName = "visible";
         this.overwriteProps = ["visible"];
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         this._target = target;
         this._tween = tween;
         this._initVal = this._target.visible;
         this._visible = Boolean(value);
         return true;
      }
      
      override public function set changeFactor(n:Number) : void
      {
         if(n == 1 && (this._tween.cachedDuration == this._tween.cachedTime || this._tween.cachedTime == 0))
         {
            this._target.visible = this._visible;
         }
         else
         {
            this._target.visible = this._initVal;
         }
      }
   }
}
