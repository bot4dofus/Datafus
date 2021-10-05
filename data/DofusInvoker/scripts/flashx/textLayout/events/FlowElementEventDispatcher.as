package flashx.textLayout.events
{
   import flash.events.EventDispatcher;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [ExcludeClass]
   public class FlowElementEventDispatcher extends EventDispatcher
   {
       
      
      tlf_internal var _listenerCount:int = 0;
      
      tlf_internal var _element:FlowElement;
      
      public function FlowElementEventDispatcher(element:FlowElement)
      {
         this._element = element;
         super(null);
      }
      
      override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         var tf:TextFlow = null;
         var pg:ParagraphElement = null;
         super.addEventListener(type,listener,useCapture,priority,useWeakReference);
         ++this._listenerCount;
         if(this._listenerCount == 1)
         {
            tf = this._element.getTextFlow();
            if(tf)
            {
               tf.incInteractiveObjectCount();
            }
            pg = this._element.getParagraph();
            if(pg)
            {
               pg.incInteractiveChildrenCount();
            }
         }
         this._element.modelChanged(ModelChange.ELEMENT_MODIFIED,this._element,0,this._element.textLength);
      }
      
      override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         var tf:TextFlow = null;
         var pg:ParagraphElement = null;
         super.removeEventListener(type,listener,useCapture);
         --this._listenerCount;
         if(this._listenerCount == 0)
         {
            tf = this._element.getTextFlow();
            if(tf)
            {
               tf.decInteractiveObjectCount();
            }
            pg = this._element.getParagraph();
            if(pg)
            {
               pg.decInteractiveChildrenCount();
            }
         }
         this._element.modelChanged(ModelChange.ELEMENT_MODIFIED,this._element,0,this._element.textLength);
      }
   }
}
