package com.ankamagames.berilia.types.event
{
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.uiRender.UiRenderer;
   import flash.events.Event;
   
   public class UiRenderEvent extends Event
   {
      
      public static var UIRenderComplete:String = "UIRenderComplete";
      
      public static var UIRenderScriptLaunching:String = "UIRenderScriptLaunching";
      
      public static var UIRenderFailed:String = "UIRenderFailed";
       
      
      private var _secUiTarget:UiRootContainer;
      
      private var _uiRenderer:UiRenderer;
      
      public function UiRenderEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, uiTarget:UiRootContainer = null, uiRenderer:UiRenderer = null)
      {
         super(type,bubbles,cancelable);
         this._secUiTarget = uiTarget;
         this._uiRenderer = uiRenderer;
      }
      
      public function get uiTarget() : UiRootContainer
      {
         return this._secUiTarget;
      }
      
      public function get uiRenderer() : UiRenderer
      {
         return this._uiRenderer;
      }
      
      override public function clone() : Event
      {
         return new UiRenderEvent(type,bubbles,cancelable,this.uiTarget,this.uiRenderer);
      }
   }
}
