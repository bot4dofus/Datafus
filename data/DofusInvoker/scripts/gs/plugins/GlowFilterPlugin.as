package gs.plugins
{
   import flash.filters.GlowFilter;
   import gs.TweenLite;
   
   public class GlowFilterPlugin extends FilterPlugin
   {
      
      public static const API:Number = 1;
      
      private static var _propNames:Array = ["color","alpha","blurX","blurY","strength","quality","inner","knockout"];
       
      
      public function GlowFilterPlugin()
      {
         super();
         this.propName = "glowFilter";
         this.overwriteProps = ["glowFilter"];
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         _target = target;
         _type = GlowFilter;
         initFilter(value,new GlowFilter(16777215,0,0,0,Number(value.strength) || Number(1),int(value.quality) || 2,value.inner,value.knockout),_propNames);
         return true;
      }
   }
}
