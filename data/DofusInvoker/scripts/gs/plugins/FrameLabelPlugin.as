package gs.plugins
{
   import flash.display.MovieClip;
   import gs.TweenLite;
   
   public class FrameLabelPlugin extends FramePlugin
   {
      
      public static const API:Number = 1;
       
      
      public function FrameLabelPlugin()
      {
         super();
         this.propName = "frameLabel";
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         if(!tween.target is MovieClip)
         {
            return false;
         }
         _target = target as MovieClip;
         this.frame = _target.currentFrame;
         var labels:Array = _target.currentLabels;
         var label:String = value;
         var endFrame:int = _target.currentFrame;
         var i:int = labels.length;
         while(i--)
         {
            if(labels[i].name == label)
            {
               endFrame = labels[i].frame;
               break;
            }
         }
         if(this.frame != endFrame)
         {
            addTween(this,"frame",this.frame,endFrame,"frame");
         }
         return true;
      }
   }
}
