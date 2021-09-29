package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.berilia.types.graphic.ExternalUi;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import flash.display.Bitmap;
   import flash.display.Screen;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   
   public class LoadingScreenLight extends ExternalUi
   {
       
      
      private var _logoFr:Class;
      
      private var _progression:Number;
      
      private var _progressBar:Shape;
      
      public var closeRequestHandler:Function;
      
      public function LoadingScreenLight()
      {
         var logo:Bitmap = null;
         this._logoFr = LoadingScreenLight__logoFr;
         super();
         var urc:UiRootContainer = new UiRootContainer(null,null);
         uiRootContainer = urc;
         var mainCtr:GraphicContainer = new GraphicContainer();
         logo = new this._logoFr();
         logo.smoothing = true;
         var progressBarBg:Shape = new Shape();
         progressBarBg.graphics.beginFill(9211020);
         progressBarBg.graphics.drawRect(0,0,logo.width,4);
         progressBarBg.graphics.endFill();
         progressBarBg.graphics.beginFill(9211020);
         progressBarBg.graphics.drawRect(1,1,logo.width - 2,2);
         progressBarBg.graphics.endFill();
         progressBarBg.y = logo.y + logo.height - 61;
         this._progressBar = new Shape();
         this._progressBar.graphics.beginFill(12254976);
         this._progressBar.graphics.drawRect(0,0,logo.width - 2,2);
         this._progressBar.graphics.endFill();
         this._progressBar.scaleX = 0;
         this._progressBar.y = logo.y + logo.height - 60;
         this._progressBar.x = 1;
         urc.addContent(mainCtr);
         mainCtr.addChild(logo);
         mainCtr.addChild(progressBarBg);
         mainCtr.addChild(this._progressBar);
         urc.finalize();
         onUiRendered(null);
         stage.nativeWindow.x = (Screen.mainScreen.bounds.width - stage.width) / 2;
         stage.nativeWindow.y = (Screen.mainScreen.bounds.height - stage.height) / 2;
         stage.doubleClickEnabled = true;
         stage.addChild(mainCtr);
         stage.addEventListener(MouseEvent.DOUBLE_CLICK,this.onDblClick);
         alwaysInFront = true;
      }
      
      protected function onDblClick(event:MouseEvent) : void
      {
         stage.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onDblClick);
         if(this.closeRequestHandler != null)
         {
            this.closeRequestHandler();
         }
      }
      
      public function get progression() : Number
      {
         return this._progression;
      }
      
      public function set progression(value:Number) : void
      {
         this._progression = Math.min(1,Math.max(0,value));
         this._progressBar.scaleX = this._progression;
      }
   }
}
