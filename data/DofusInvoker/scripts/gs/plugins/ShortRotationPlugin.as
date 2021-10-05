package gs.plugins
{
   import gs.TweenLite;
   
   public class ShortRotationPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
       
      
      public function ShortRotationPlugin()
      {
         super();
         this.propName = "shortRotation";
         this.overwriteProps = [];
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         var p:* = null;
         if(typeof value == "number")
         {
            return false;
         }
         for(p in value)
         {
            this.initRotation(target,p,target[p],typeof value[p] == "number" ? Number(Number(value[p])) : Number(target[p] + Number(value[p])));
         }
         return true;
      }
      
      public function initRotation(target:Object, propName:String, start:Number, end:Number) : void
      {
         var dif:Number = (end - start) % 360;
         if(dif != dif % 180)
         {
            dif = dif < 0 ? Number(dif + 360) : Number(dif - 360);
         }
         addTween(target,propName,start,start + dif,propName);
         this.overwriteProps[this.overwriteProps.length] = propName;
      }
   }
}
