package com.ankamagames.jerakine.handlers
{
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseMiddleClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.MessageDispatcher;
   import com.ankamagames.jerakine.messages.Worker;
   import com.ankamagames.jerakine.pools.GenericPool;
   import com.ankamagames.jerakine.utils.display.KeyPoll;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import com.ankamagames.jerakine.utils.prng.ParkMillerCarta;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class HumanInputHandler extends MessageDispatcher
   {
      
      private static var _self:HumanInputHandler;
      
      private static const DOUBLE_CLICK_DELAY:uint = 500;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HumanInputHandler));
       
      
      private var _handler:Worker;
      
      private var _keyPoll:KeyPoll;
      
      private var _lastTarget:WeakReference;
      
      private var _lastDoucleClick:int;
      
      private var _lastSingleClick:int;
      
      private var _appleDown:Boolean;
      
      private var _appleKeyboardEvent:KeyboardEvent;
      
      private var _debugOver:Boolean = false;
      
      private var _debugOverSprite:Dictionary;
      
      private var _isMouseDown:Boolean = false;
      
      private const random:ParkMillerCarta = new ParkMillerCarta();
      
      public function HumanInputHandler()
      {
         this._debugOverSprite = new Dictionary(true);
         super();
         if(_self != null)
         {
            throw new SingletonError("HumanInputHandler constructor should not be called directly.");
         }
         this.initialize();
      }
      
      public static function getInstance() : HumanInputHandler
      {
         if(_self == null)
         {
            _self = new HumanInputHandler();
         }
         return _self;
      }
      
      public function get isMouseDown() : Boolean
      {
         return this._isMouseDown;
      }
      
      public function get debugOver() : Boolean
      {
         return this._debugOver;
      }
      
      public function set debugOver(value:Boolean) : void
      {
         var sprite:* = undefined;
         if(this._debugOver && !value)
         {
            for(sprite in this._debugOverSprite)
            {
               if(sprite.parent)
               {
                  sprite.parent.removeChild(sprite);
               }
            }
            this._debugOverSprite = new Dictionary();
         }
         this._debugOver = value;
      }
      
      public function get handler() : Worker
      {
         return this._handler;
      }
      
      public function set handler(value:Worker) : void
      {
         this._handler = value;
      }
      
      public function getKeyboardPoll() : KeyPoll
      {
         return this._keyPoll;
      }
      
      public function resetClick() : void
      {
         this._lastTarget = null;
      }
      
      private function initialize() : void
      {
         this._keyPoll = new KeyPoll();
         this.registerListeners();
      }
      
      public function unregisterListeners(target:Stage = null) : void
      {
         if(target == null)
         {
            var target:Stage = StageShareManager.stage;
         }
         target.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClick,true);
         target.removeEventListener(MouseEvent.CLICK,this.onClick,true);
         target.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,true);
         target.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,true);
         target.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut,true);
         target.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown,true);
         target.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp,true);
         try
         {
            target.removeEventListener(MouseEvent.MIDDLE_CLICK,this.onMiddleClick,true);
            target.removeEventListener(MouseEvent.RIGHT_CLICK,this.onRightClick,true);
            target.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN,this.onRightMouseDown,true);
            target.removeEventListener(MouseEvent.RIGHT_MOUSE_UP,this.onRightMouseUp,true);
         }
         catch(e:TypeError)
         {
            _log.error("RIGHT_CLICK / MIDDLE_CLICK non supporté");
         }
         target.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false);
         target.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false);
      }
      
      public function registerListeners(target:Stage = null) : void
      {
         if(target == null)
         {
            var target:Stage = StageShareManager.stage;
         }
         target.addEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClick,true,1,true);
         target.addEventListener(MouseEvent.CLICK,this.onClick,true,1,true);
         target.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,false,1,true);
         target.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,true,1,true);
         target.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut,true,1,true);
         target.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown,true,1,true);
         target.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp,true,1,true);
         try
         {
            target.addEventListener(MouseEvent.MIDDLE_CLICK,this.onMiddleClick,true,1,true);
            target.addEventListener(MouseEvent.RIGHT_CLICK,this.onRightClick,true,1,true);
            target.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN,this.onRightMouseDown,true,1,true);
            target.addEventListener(MouseEvent.RIGHT_MOUSE_UP,this.onRightMouseUp,true,1,true);
         }
         catch(e:TypeError)
         {
            _log.error("RIGHT_CLICK / MIDDLE_CLICK non supporté");
         }
         target.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,1,true);
         target.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false,1,true);
      }
      
      private function onDoubleClick(me:MouseEvent) : void
      {
         this._handler.processImmediately(GenericPool.get(MouseDoubleClickMessage,me.target,me));
         this._lastDoucleClick = getTimer();
      }
      
      private function onClick(me:MouseEvent) : void
      {
         var time:int = getTimer();
         if(time - this._lastDoucleClick < DOUBLE_CLICK_DELAY)
         {
            this._lastSingleClick = time;
            this._lastDoucleClick = 0;
         }
         else if(time - this._lastSingleClick < DOUBLE_CLICK_DELAY)
         {
            this._handler.processImmediately(GenericPool.get(MouseDoubleClickMessage,me.target,me));
            this._lastDoucleClick = time;
         }
         else
         {
            this._handler.processImmediately(GenericPool.get(MouseClickMessage,me.target,me));
         }
      }
      
      private function onMouseWheel(me:MouseEvent) : void
      {
         this._handler.processImmediately(GenericPool.get(MouseWheelMessage,me.target,me));
      }
      
      private function onMouseOver(me:MouseEvent) : void
      {
         var dObj:DisplayObject = null;
         var shapeName:* = null;
         var s:Sprite = null;
         var present:Boolean = false;
         var i:uint = 0;
         var seed:uint = 0;
         var j:uint = 0;
         var b:Rectangle = null;
         if(this.debugOver && me.target.parent)
         {
            dObj = me.target as DisplayObject;
            shapeName = "#{{{debug_shape_" + dObj.name + "}}}#";
            present = false;
            i = 0;
            while(i < dObj.parent.numChildren && !present)
            {
               if(dObj.parent.getChildAt(i).name == shapeName)
               {
                  s = dObj.parent.getChildAt(i) as Sprite;
                  break;
               }
               i++;
            }
            seed = 1;
            for(j = 0; j < shapeName.length; j++)
            {
               seed += shapeName.charCodeAt(j) * 100 * j;
            }
            this.random.seed(seed);
            if(!s)
            {
               s = new Sprite();
               s.mouseEnabled = false;
               s.mouseChildren = false;
            }
            this._debugOverSprite[s] = true;
            s.name = shapeName;
            s.graphics.clear();
            b = dObj.getBounds(dObj.parent);
            s.graphics.beginFill(this.random.nextInt(),0.4);
            s.graphics.lineStyle(1,0,0.5);
            s.graphics.drawRect(b.left,b.top,b.width,b.height);
            s.graphics.endFill();
            dObj.parent.addChildAt(s,dObj.parent.getChildIndex(dObj) + 1);
         }
         this._handler.processImmediately(GenericPool.get(MouseOverMessage,me.target,me));
      }
      
      private function onMouseOut(me:MouseEvent) : void
      {
         this._handler.processImmediately(GenericPool.get(MouseOutMessage,me.target,me));
      }
      
      private function onMiddleClick(me:MouseEvent) : void
      {
         this._handler.processImmediately(GenericPool.get(MouseMiddleClickMessage,me.target,me));
      }
      
      private function onRightClick(me:MouseEvent) : void
      {
         if(this._lastTarget != null && this._lastTarget.object != me.target)
         {
            this._handler.processImmediately(GenericPool.get(MouseRightClickOutsideMessage,this._lastTarget.object,me));
         }
         this._lastTarget = new WeakReference(me.target);
         this._handler.processImmediately(GenericPool.get(MouseRightClickMessage,me.target,me));
      }
      
      private function onRightMouseDown(me:MouseEvent) : void
      {
         this._handler.processImmediately(GenericPool.get(MouseRightDownMessage,me.target,me));
      }
      
      private function onRightMouseUp(me:MouseEvent) : void
      {
         this._handler.processImmediately(GenericPool.get(MouseRightUpMessage,me.target,me));
      }
      
      private function onMouseDown(me:MouseEvent) : void
      {
         this._isMouseDown = true;
         this._lastTarget = new WeakReference(me.target);
         this._handler.processImmediately(GenericPool.get(MouseDownMessage,me.target,me));
         FocusHandler.getInstance().setFocus(InteractiveObject(me.target));
      }
      
      private function onMouseUp(me:MouseEvent) : void
      {
         this._isMouseDown = false;
         if(this._lastTarget != null && this._lastTarget.object != me.target)
         {
            this._handler.processImmediately(GenericPool.get(MouseReleaseOutsideMessage,this._lastTarget.object,me));
         }
         this._handler.processImmediately(GenericPool.get(MouseUpMessage,me.target,me));
      }
      
      private function onKeyDown(ke:KeyboardEvent) : void
      {
         if(this._keyPoll.isDown(Keyboard.CONTROL))
         {
            ke.ctrlKey = true;
         }
         if(ke.keyCode == Keyboard.ESCAPE)
         {
            ke.preventDefault();
         }
         else if(ke.keyCode == Keyboard.COMMAND)
         {
            this._appleDown = true;
         }
         else if(ke.keyCode == Keyboard.S && ke.ctrlKey)
         {
            ke.preventDefault();
         }
         this._handler.processImmediately(GenericPool.get(KeyboardKeyDownMessage,FocusHandler.getInstance().getFocus(),ke));
      }
      
      private function onKeyUp(ke:KeyboardEvent) : void
      {
         if(this._keyPoll.isDown(Keyboard.CONTROL))
         {
            ke.ctrlKey = true;
         }
         if(!this._appleDown)
         {
            this._handler.processImmediately(GenericPool.get(KeyboardKeyUpMessage,FocusHandler.getInstance().getFocus(),ke));
         }
         else
         {
            this._appleDown = false;
         }
      }
   }
}
