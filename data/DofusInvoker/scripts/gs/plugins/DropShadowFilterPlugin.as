package gs.plugins
{
   import flash.filters.DropShadowFilter;
   import gs.TweenLite;
   
   public class DropShadowFilterPlugin extends FilterPlugin
   {
      
      public static const API:Number = 1;
      
      private static var _propNames:Array = ["distance","angle","color","alpha","blurX","blurY","strength","quality","inner","knockout","hideObject"];
       
      
      public function DropShadowFilterPlugin()
      {
         super();
         this.propName = "dropShadowFilter";
         this.overwriteProps = ["dropShadowFilter"];
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         _target = target;
         _type = DropShadowFilter;
         initFilter(value,new DropShadowFilter(0,45,0,0,0,0,1,int(value.quality) || 2,value.inner,value.knockout,value.hideObject),_propNames);
         return true;
      }
   }
}
