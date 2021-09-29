package gs.plugins
{
   import gs.TweenLite;
   
   public class AutoAlphaPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
       
      
      protected var _target:Object;
      
      protected var _ignoreVisible:Boolean;
      
      public function AutoAlphaPlugin()
      {
         super();
         this.propName = "autoAlpha";
         this.overwriteProps = ["alpha","visible"];
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         this._target = target;
         addTween(target,"alpha",target.alpha,value,"alpha");
         return true;
      }
      
      override public function killProps(lookup:Object) : void
      {
         super.killProps(lookup);
         this._ignoreVisible = Boolean("visible" in lookup);
      }
      
      override public function set changeFactor(n:Number) : void
      {
         updateTweens(n);
         if(!this._ignoreVisible)
         {
            this._target.visible = Boolean(this._target.alpha != 0);
         }
      }
   }
}
