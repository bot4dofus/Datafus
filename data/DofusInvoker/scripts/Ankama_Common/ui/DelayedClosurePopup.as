package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.TimerEvent;
   
   public class DelayedClosurePopup
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      public var popCtr:GraphicContainer;
      
      public var lbl_content:Label;
      
      private var _timer:BenchmarkTimer;
      
      public function DelayedClosurePopup()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         if(!param)
         {
            throw new Error("Can\'t load popup without properties.");
         }
         this.lbl_content.text = param.content;
         if(param.marginTop)
         {
            this.popCtr.y = param.marginTop;
         }
         this._timer = new BenchmarkTimer(param.delay,0,"DelayedClosurePopup._timer");
         this._timer.addEventListener(TimerEvent.TIMER,this.closeMe);
         this._timer.start();
         this.uiApi.me().render();
      }
      
      private function closeMe(pEvt:TimerEvent) : void
      {
         this.unload();
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function unload() : void
      {
         if(this._timer != null)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.closeMe);
            this._timer = null;
         }
      }
   }
}
