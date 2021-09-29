package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.components.messages.BrowserDomChange;
   import com.ankamagames.berilia.components.messages.BrowserDomReady;
   import com.ankamagames.berilia.components.messages.BrowserSessionTimeout;
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.TimeoutHTMLLoader;
   import com.ankamagames.berilia.types.shortcut.Bind;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.misc.CopyObject;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.NativeWindow;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setTimeout;
   
   public class WebBrowser extends GraphicContainer implements FinalizableUIComponent
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(WebBrowser));
       
      
      private var _htmlLoader:TimeoutHTMLLoader;
      
      private var _vScrollBar:ScrollBar;
      
      private var _resizeTimer:BenchmarkTimer;
      
      private var _scrollTopOffset:int = 0;
      
      private var _cacheId:String;
      
      private var _cacheLife:Number = 15;
      
      private var _lifeTimer:BenchmarkTimer;
      
      private var _linkList:Array;
      
      private var _inputFocus:Boolean;
      
      private var _manualExternalLink:Dictionary;
      
      private var _transparentBackground:Boolean;
      
      private var _htmlRendered:Boolean = false;
      
      private var _timeoutId:uint;
      
      private var _domInit:Boolean;
      
      public function WebBrowser()
      {
         this._linkList = [];
         this._manualExternalLink = new Dictionary();
         super();
         this._vScrollBar = new ScrollBar();
         this._resizeTimer = new BenchmarkTimer(200,0,"WebBrowser._resizeTimer");
         this._resizeTimer.addEventListener(TimerEvent.TIMER,this.onResizeEnd);
         var mainWindow:NativeWindow = StageShareManager.stage.nativeWindow;
         mainWindow.addEventListener(Event.RESIZE,this.onResize);
         this._vScrollBar.min = 1;
         this._vScrollBar.max = 1;
         this._vScrollBar.width = 16;
         this._vScrollBar.addEventListener(Event.CHANGE,this.onScroll);
      }
      
      public function get cacheLife() : Number
      {
         return this._cacheLife;
      }
      
      public function set cacheLife(value:Number) : void
      {
         this._cacheLife = Math.max(1,value);
         if(this._htmlLoader)
         {
            this._htmlLoader.life = value;
         }
      }
      
      public function get cacheId() : String
      {
         return this._cacheId;
      }
      
      public function set cacheId(value:String) : void
      {
         this._cacheId = value;
      }
      
      [Uri]
      public function set scrollCss(sUrl:Uri) : void
      {
         this._vScrollBar.css = sUrl;
      }
      
      [Uri]
      public function get scrollCss() : Uri
      {
         return this._vScrollBar.css;
      }
      
      public function set displayScrollBar(b:Boolean) : void
      {
         this._vScrollBar.width = !!b ? Number(16) : Number(0);
         this.onResizeEnd(null);
      }
      
      public function get displayScrollBar() : Boolean
      {
         return this._vScrollBar.width != 0;
      }
      
      public function set scrollTopOffset(v:int) : void
      {
         this._scrollTopOffset = v;
         this._vScrollBar.y = v;
         if(height)
         {
            this._vScrollBar.height = height - this._scrollTopOffset;
         }
      }
      
      override public function set width(nW:Number) : void
      {
         super.width = nW;
         if(this._htmlLoader)
         {
            this._htmlLoader.width = nW - 2;
            this._vScrollBar.x = this._htmlLoader.x + this._htmlLoader.width - this._vScrollBar.width;
         }
      }
      
      override public function set height(nH:Number) : void
      {
         super.height = nH;
         if(this._htmlLoader)
         {
            this._htmlLoader.height = nH;
         }
         this.scrollTopOffset = this._scrollTopOffset;
      }
      
      public function get fromCache() : Boolean
      {
         return this._htmlLoader.fromCache;
      }
      
      public function get location() : String
      {
         return this._htmlLoader.location;
      }
      
      public function clearLocation() : void
      {
         var bgColor:String = XmlConfig.getInstance().getEntry("colors.grid.bg").replace("0x","#");
         this._htmlLoader.loadString("<html><body bgcolor=\"" + bgColor + "\"></body></html>");
      }
      
      public function set transparentBackground(pValue:Boolean) : void
      {
         this._transparentBackground = pValue;
         if(this._htmlLoader)
         {
            this._htmlLoader.paintsDefaultBackground = !this._transparentBackground;
         }
      }
      
      override public function finalize() : void
      {
         addChild(this._vScrollBar);
         this._vScrollBar.finalize();
         if(!this._htmlLoader)
         {
            this._htmlLoader = TimeoutHTMLLoader.getLoader(this.cacheId);
            if(this._htmlLoader.fromCache)
            {
               this.onDomReady(null);
            }
            else
            {
               this.clearLocation();
            }
            this._htmlLoader.life = this.cacheLife;
            this._htmlLoader.addEventListener(Event["HTML_RENDER"],this.onDomReady);
            this._htmlLoader.addEventListener(Event["HTML_BOUNDS_CHANGE"],this.onBoundsChange);
            this._htmlLoader.addEventListener(TimeoutHTMLLoader.TIMEOUT,this.onSessionTimeout);
            this._htmlLoader.addEventListener(Event["LOCATION_CHANGE"],this.onLocationChange);
            this._htmlLoader.paintsDefaultBackground = !this._transparentBackground;
         }
         this.width = width;
         this.height = height;
         this.updateScrollbar();
         if(this._htmlLoader.fromCache)
         {
            this._vScrollBar.value = this._htmlLoader.scrollV;
         }
         addChild(this._htmlLoader);
         this.onResizeEnd(null);
         _finalized = true;
         super.finalize();
         if(getUi())
         {
            getUi().iAmFinalized(this);
         }
      }
      
      public function setBlankLink(linkPattern:String, blank:Boolean) : void
      {
         if(blank)
         {
            this._manualExternalLink[linkPattern] = new RegExp(linkPattern);
         }
         else
         {
            delete this._manualExternalLink[linkPattern];
         }
         this.modifyDOM(this._htmlLoader.window.document);
      }
      
      override public function process(msg:Message) : Boolean
      {
         var currentDo:DisplayObject = null;
         var updateScroll:* = false;
         var kbmsg:KeyboardMessage = null;
         var allowedShorcut:Boolean = false;
         var sShortcut:String = null;
         var bind:Bind = null;
         if(msg is BrowserDomChange)
         {
            updateScroll = this._vScrollBar.value != this._htmlLoader.scrollV;
         }
         else if(msg is MouseWheelMessage)
         {
            currentDo = MouseWheelMessage(msg).target;
            while(currentDo != this._htmlLoader && currentDo && currentDo.parent)
            {
               currentDo = currentDo.parent;
            }
            updateScroll = currentDo == this._htmlLoader;
         }
         if(updateScroll)
         {
            this._vScrollBar.value = this._htmlLoader.scrollV;
         }
         if(msg is KeyboardKeyDownMessage || msg is KeyboardKeyUpMessage)
         {
            kbmsg = msg as KeyboardMessage;
            sShortcut = BindsManager.getInstance().getShortcutString(kbmsg.keyboardEvent.keyCode,this.getCharCode(kbmsg));
            bind = BindsManager.getInstance().getBind(new Bind(sShortcut,"",kbmsg.keyboardEvent.altKey,kbmsg.keyboardEvent.ctrlKey,kbmsg.keyboardEvent.shiftKey));
            if(bind && (bind.targetedShortcut == "closeUi" || bind.targetedShortcut == "toggleFullscreen"))
            {
               allowedShorcut = true;
            }
            if(!allowedShorcut)
            {
               currentDo = FocusHandler.getInstance().getFocus();
               while(currentDo != this._htmlLoader && currentDo && currentDo.parent)
               {
                  currentDo = currentDo.parent;
               }
               return currentDo == this._htmlLoader;
            }
         }
         return false;
      }
      
      override public function remove() : void
      {
         if(this._resizeTimer)
         {
            this._resizeTimer.removeEventListener(TimerEvent.TIMER,this.onResizeEnd);
         }
         this.removeHtmlEvent();
         StageShareManager.stage.removeEventListener(Event.RESIZE,this.onResize);
         if(this._htmlLoader)
         {
            this._htmlLoader.removeEventListener(Event["HTML_RENDER"],this.onDomReady);
            this._htmlLoader.removeEventListener(Event["HTML_BOUNDS_CHANGE"],this.onBoundsChange);
            this._htmlLoader.removeEventListener(TimeoutHTMLLoader.TIMEOUT,this.onSessionTimeout);
            this._htmlLoader.removeEventListener(Event["LOCATION_CHANGE"],this.onLocationChange);
            if(contains(this._htmlLoader))
            {
               removeChild(this._htmlLoader);
            }
         }
         var mainWindow:NativeWindow = StageShareManager.stage.nativeWindow;
         mainWindow.removeEventListener(Event.RESIZE,this.onResize);
         this._vScrollBar.removeEventListener(Event.CHANGE,this.onScroll);
         if(this._timeoutId)
         {
            clearTimeout(this._timeoutId);
         }
         super.remove();
      }
      
      public function hasContent() : Boolean
      {
         var a:Object = this._htmlLoader.window.document.getElementsByTagName("body");
         if(!a[0] || a[0].firstChild == null)
         {
            return false;
         }
         if(a[0].getElementsByTagName("h1") && a[0].getElementsByTagName("h1").length > 0)
         {
            return true;
         }
         return false;
      }
      
      public function get content() : Object
      {
         if(!this._domInit)
         {
            return null;
         }
         if(this._htmlLoader && this._htmlLoader.window && this._htmlLoader.window.document)
         {
            return this._htmlLoader.window.document;
         }
         return null;
      }
      
      public function load(urlRequest:URLRequest) : void
      {
         var clone:URLRequest = new URLRequest();
         CopyObject.copyObject(urlRequest,null,clone);
         this._htmlLoader.load(clone);
      }
      
      public function javascriptSetVar(varName:String, value:*) : void
      {
         var path:Array = null;
         var len:int = 0;
         var htmlVar:Object = null;
         var i:int = 0;
         try
         {
            path = varName.split(".");
            len = path.length;
            htmlVar = this._htmlLoader.window;
            for(i = 0; i < len; i++)
            {
               if(i < len - 1)
               {
                  htmlVar = htmlVar[path[i]];
               }
               else
               {
                  htmlVar[path[i]] = value;
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function javascriptCall(fctName:String, ... params) : void
      {
         var path:Array = null;
         var len:int = 0;
         var htmlFunction:Object = null;
         var i:int = 0;
         try
         {
            path = fctName.split(".");
            len = path.length;
            htmlFunction = this._htmlLoader.window;
            for(i = 0; i < len; i++)
            {
               htmlFunction = htmlFunction[path[i]];
            }
            (htmlFunction as Function).apply(null,params);
         }
         catch(e:Error)
         {
         }
      }
      
      private function removeHtmlEvent() : void
      {
         var link:Object = null;
         while(this._linkList.length)
         {
            link = this._linkList.pop();
            try
            {
               if(link)
               {
                  link.removeEventListener("click",this.onLinkClick);
               }
            }
            catch(e:Error)
            {
               continue;
            }
         }
      }
      
      private function getCharCode(pKeyboardMessage:KeyboardMessage) : int
      {
         var charCode:int = 0;
         if(pKeyboardMessage.keyboardEvent.shiftKey && pKeyboardMessage.keyboardEvent.keyCode == 52)
         {
            charCode = 39;
         }
         else if(pKeyboardMessage.keyboardEvent.shiftKey && pKeyboardMessage.keyboardEvent.keyCode == 54)
         {
            charCode = 45;
         }
         else
         {
            charCode = pKeyboardMessage.keyboardEvent.charCode;
         }
         return charCode;
      }
      
      private function onResize(e:Event) : void
      {
         if(this._resizeTimer)
         {
            this._resizeTimer.reset();
            this._resizeTimer.start();
         }
      }
      
      private function onResizeEnd(e:Event) : void
      {
         if(this._resizeTimer)
         {
            this._resizeTimer.stop();
         }
         var scale:Number = StageShareManager.windowScale * StageShareManager.stage.contentsScaleFactor;
         if(this._htmlLoader)
         {
            this._htmlLoader.width = width * scale - this._vScrollBar.width;
            this._htmlLoader.height = height * scale;
            this._htmlLoader.scaleX = 1 / scale;
            this._htmlLoader.scaleY = 1 / scale;
         }
      }
      
      private function onDomReady(e:Event = null) : void
      {
         if(!this._htmlLoader.window.document.body)
         {
            this._domInit = false;
            if(!this._timeoutId)
            {
               this._timeoutId = setTimeout(this.onDomReady,100,null);
            }
            return;
         }
         if(this._timeoutId)
         {
            clearTimeout(this._timeoutId);
            this._timeoutId = 0;
         }
         this.modifyDOM(this._htmlLoader.window.document);
         if(this._domInit)
         {
            return;
         }
         this._domInit = true;
         this.updateScrollbar();
         this.onResizeEnd(null);
         Berilia.getInstance().handler.process(new BrowserDomReady(InteractiveObject(this)));
      }
      
      private function isManualExternalLink(link:String) : Boolean
      {
         var pattern:RegExp = null;
         for each(pattern in this._manualExternalLink)
         {
            if(link.match(pattern).length)
            {
               return true;
            }
         }
         return false;
      }
      
      private function modifyDOM(target:Object) : void
      {
         var i:uint = 0;
         var a:Object = null;
         try
         {
            a = target.getElementsByTagName("a");
            for(i = 0; i < a.length; i++)
            {
               if(a[i].target == "_blank" || this.isManualExternalLink(a[i].href))
               {
                  a[i].addEventListener("click",this.onLinkClick,false);
                  if(this._linkList.indexOf(a[i]) == -1)
                  {
                     this._linkList.push(a[i]);
                  }
               }
            }
            Berilia.getInstance().handler.process(new BrowserDomChange(InteractiveObject(this)));
         }
         catch(e:Error)
         {
            _log.error("Erreur lors de l\'ajout des lien blank");
         }
      }
      
      private function onLinkClick(e:*) : void
      {
         var target:Object = e.target;
         if(target.tagName == "IMG")
         {
            target = target.parentElement;
         }
         if(target.target == "_blank" || this.isManualExternalLink(target.href))
         {
            e.preventDefault();
            navigateToURL(new URLRequest(target.href));
         }
      }
      
      private function onInputFocus(e:*) : void
      {
         this._inputFocus = true;
      }
      
      private function onInputBlur(e:*) : void
      {
         this._inputFocus = false;
      }
      
      private function onScroll(e:Event) : void
      {
         this._htmlLoader.scrollV = this._vScrollBar.value;
      }
      
      private function onBoundsChange(e:Event) : void
      {
         this.updateScrollbar();
      }
      
      private function updateScrollbar() : void
      {
         var heightDiff:int = this._htmlLoader.contentHeight - this._htmlLoader.height;
         if(this._vScrollBar.max != heightDiff && heightDiff > 0)
         {
            this._vScrollBar.min = 0;
            this._vScrollBar.max = heightDiff;
         }
      }
      
      private function onSessionTimeout(e:Event) : void
      {
         Berilia.getInstance().handler.process(new BrowserSessionTimeout(InteractiveObject(this)));
      }
      
      private function onLocationChange(e:Event) : void
      {
         _log.trace("Load " + this._htmlLoader.location);
         this.removeHtmlEvent();
         this._inputFocus = false;
         this._domInit = false;
         this._htmlRendered = false;
      }
   }
}
