package gs.plugins
{
   import flash.filters.BlurFilter;
   import gs.TweenLite;
   
   public class BlurFilterPlugin extends FilterPlugin
   {
      
      public static const API:Number = 1;
      
      private static var _propNames:Array = ["blurX","blurY","quality"];
       
      
      public function BlurFilterPlugin()
      {
         super();
         this.propName = "blurFilter";
         this.overwriteProps = ["blurFilter"];
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         _target = target;
         _type = BlurFilter;
         initFilter(value,new BlurFilter(0,0,int(value.quality) || 2),_propNames);
         return true;
      }
   }
}
