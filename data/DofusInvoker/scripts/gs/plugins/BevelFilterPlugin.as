package gs.plugins
{
   import flash.filters.BevelFilter;
   import gs.TweenLite;
   
   public class BevelFilterPlugin extends FilterPlugin
   {
      
      public static const API:Number = 1;
      
      private static var _propNames:Array = ["distance","angle","highlightColor","highlightAlpha","shadowColor","shadowAlpha","blurX","blurY","strength","quality"];
       
      
      public function BevelFilterPlugin()
      {
         super();
         this.propName = "bevelFilter";
         this.overwriteProps = ["bevelFilter"];
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         _target = target;
         _type = BevelFilter;
         initFilter(value,new BevelFilter(0,0,16777215,0.5,0,0.5,2,2,0,int(value.quality) || 2),_propNames);
         return true;
      }
   }
}
