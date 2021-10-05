package flashx.textLayout.events
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import flash.utils.Dictionary;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.container.ScrollPolicy;
   import flashx.textLayout.elements.Configuration;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.LinkElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.elements.TextRange;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.utils.GeometryUtil;
   import flashx.textLayout.utils.HitTestArea;
   
   use namespace tlf_internal;
   
   [ExcludeClass]
   public class FlowElementMouseEventManager
   {
       
      
      private var _container:DisplayObjectContainer;
      
      private var _hitTests:HitTestArea = null;
      
      private var _currentElement:FlowElement = null;
      
      private var _mouseDownElement:FlowElement = null;
      
      private var _needsCtrlKey:Boolean = false;
      
      private var _ctrlKeyState:Boolean = false;
      
      private var _lastMouseEvent:MouseEvent = null;
      
      private var _blockInteraction:Boolean = false;
      
      private const OWNER_HANDLES_EVENT:int = 0;
      
      private const THIS_HANDLES_EVENT:int = 1;
      
      private const THIS_LISTENS_FOR_EVENTS:int = 2;
      
      private var _eventListeners:Object;
      
      private var _hitRects:Object = null;
      
      public function FlowElementMouseEventManager(container:DisplayObjectContainer, eventNames:Array)
      {
         var name:String = null;
         super();
         this._container = container;
         this._eventListeners = {};
         this._eventListeners[MouseEvent.MOUSE_OVER] = this._eventListeners[MouseEvent.MOUSE_OUT] = this._eventListeners[MouseEvent.MOUSE_DOWN] = this._eventListeners[MouseEvent.MOUSE_UP] = this._eventListeners[MouseEvent.MOUSE_MOVE] = this._eventListeners[KeyboardEvent.KEY_DOWN] = this._eventListeners[KeyboardEvent.KEY_UP] = this.THIS_HANDLES_EVENT;
         for each(name in eventNames)
         {
            this._eventListeners[name] = this.OWNER_HANDLES_EVENT;
         }
      }
      
      public function mouseToContainer(evt:MouseEvent) : Point
      {
         var m:Matrix = null;
         var obj:DisplayObject = evt.target as DisplayObject;
         var containerPoint:Point = new Point(evt.localX,evt.localY);
         while(obj != this._container)
         {
            m = obj.transform.matrix;
            containerPoint.offset(m.tx,m.ty);
            obj = obj.parent;
            if(!obj)
            {
               break;
            }
         }
         return containerPoint;
      }
      
      public function get needsCtrlKey() : Boolean
      {
         return this._needsCtrlKey;
      }
      
      public function set needsCtrlKey(k:Boolean) : void
      {
         this._needsCtrlKey = k;
      }
      
      public function updateHitTests(xoffset:Number, clipRect:Rectangle, textFlow:TextFlow, startPos:int, endPos:int, container:ContainerController, needsCtrlKey:Boolean = false) : void
      {
         var rect:Rectangle = null;
         var obj:Object = null;
         var newHitRects:Object = null;
         var uniqueDictionary:Dictionary = null;
         var o:Object = null;
         var f:FlowElement = null;
         var interactiveObjects_LastTime:Array = null;
         var element:FlowElement = null;
         var elemStart:int = 0;
         var elemEnd:int = 0;
         var tf:TextFlow = null;
         var elemRects:Array = null;
         var leftEdge:Number = NaN;
         var topEdge:Number = NaN;
         var wmode:String = null;
         var adjustLines:Boolean = false;
         var width:Number = NaN;
         var name:String = null;
         var oldObj:Object = null;
         this._needsCtrlKey = needsCtrlKey;
         var elements:Array = [];
         if(textFlow.interactiveObjectCount != 0 && startPos != endPos)
         {
            uniqueDictionary = container.interactiveObjects;
            for each(o in uniqueDictionary)
            {
               f = o as FlowElement;
               if(f && f.getAbsoluteStart() < endPos && f.getAbsoluteStart() + f.textLength >= startPos)
               {
                  elements.push(o);
               }
            }
            interactiveObjects_LastTime = container.oldInteractiveObjects;
            for each(o in interactiveObjects_LastTime)
            {
               f = o as FlowElement;
               if(f && f.getAbsoluteStart() < endPos && f.getAbsoluteStart() + f.textLength >= startPos)
               {
                  elements.push(o);
                  uniqueDictionary[o] = o;
               }
            }
         }
         var rectCount:int = 0;
         if(elements.length != 0)
         {
            newHitRects = {};
            for each(element in elements)
            {
               elemStart = element.getAbsoluteStart();
               elemEnd = Math.min(elemStart + element.textLength,endPos);
               tf = element.getTextFlow();
               if(tf)
               {
                  elemRects = GeometryUtil.getHighlightBounds(new TextRange(tf,elemStart,elemEnd));
                  for each(obj in elemRects)
                  {
                     rect = obj.rect;
                     leftEdge = clipRect.x;
                     topEdge = clipRect.y;
                     wmode = element.computedFormat.blockProgression;
                     adjustLines = false;
                     adjustLines = wmode == BlockProgression.RL && (container.horizontalScrollPolicy == ScrollPolicy.OFF && container.verticalScrollPolicy == ScrollPolicy.OFF);
                     if(adjustLines)
                     {
                        width = !!container.measureWidth ? Number(clipRect.width) : Number(container.compositionWidth);
                        leftEdge = clipRect.x - width + container.horizontalScrollPosition + clipRect.width;
                     }
                     if(wmode == BlockProgression.TB)
                     {
                        leftEdge = 0;
                        topEdge = 0;
                     }
                     else
                     {
                        topEdge = 0;
                     }
                     rect.x = leftEdge + obj.textLine.x + rect.x + xoffset;
                     rect.y = topEdge + obj.textLine.y + rect.y;
                     rect = rect.intersection(clipRect);
                     if(!rect.isEmpty())
                     {
                        rect.x = int(rect.x);
                        rect.y = int(rect.y);
                        rect.width = int(rect.width);
                        rect.height = int(rect.height);
                        name = rect.toString();
                        oldObj = newHitRects[name];
                        if(!oldObj || oldObj.owner != element)
                        {
                           newHitRects[name] = {
                              "rect":rect,
                              "owner":element
                           };
                           rectCount++;
                        }
                     }
                  }
               }
            }
         }
         if(rectCount > 0)
         {
            if(!this._hitTests)
            {
               this.startHitTests();
            }
            this._hitRects = newHitRects;
            this._hitTests = new HitTestArea(newHitRects);
         }
         else
         {
            this.stopHitTests();
         }
      }
      
      tlf_internal function startHitTests() : void
      {
         this._currentElement = null;
         this._mouseDownElement = null;
         this._ctrlKeyState = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,false);
         this.addEventListener(MouseEvent.MOUSE_OUT,false);
         this.addEventListener(MouseEvent.MOUSE_DOWN,false);
         this.addEventListener(MouseEvent.MOUSE_UP,false);
         this.addEventListener(MouseEvent.MOUSE_MOVE,false);
      }
      
      public function stopHitTests() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,false);
         this.removeEventListener(MouseEvent.MOUSE_OUT,false);
         this.removeEventListener(MouseEvent.MOUSE_DOWN,false);
         this.removeEventListener(MouseEvent.MOUSE_UP,false);
         this.removeEventListener(MouseEvent.MOUSE_MOVE,false);
         this.removeEventListener(KeyboardEvent.KEY_DOWN,true);
         this.removeEventListener(KeyboardEvent.KEY_UP,true);
         this._hitRects = null;
         this._hitTests = null;
         this._currentElement = null;
         this._mouseDownElement = null;
         this._ctrlKeyState = false;
      }
      
      private function addEventListener(name:String, kbdEvent:Boolean = false) : void
      {
         var target:DisplayObjectContainer = null;
         var listener:Function = null;
         if(this._eventListeners[name] === this.THIS_HANDLES_EVENT)
         {
            if(kbdEvent)
            {
               target = this._container.stage;
               if(!target)
               {
                  target = this._container;
               }
               listener = this.hitTestKeyEventHandler;
            }
            else
            {
               target = this._container;
               listener = this.hitTestMouseEventHandler;
            }
            target.addEventListener(name,listener,false,1);
            this._eventListeners[name] = this.THIS_LISTENS_FOR_EVENTS;
         }
      }
      
      private function removeEventListener(name:String, kbdEvent:Boolean) : void
      {
         var target:DisplayObjectContainer = null;
         var listener:Function = null;
         if(this._eventListeners[name] === this.THIS_LISTENS_FOR_EVENTS)
         {
            if(kbdEvent)
            {
               target = this._container.stage;
               if(!target)
               {
                  target = this._container;
               }
               listener = this.hitTestKeyEventHandler;
            }
            else
            {
               target = this._container;
               listener = this.hitTestMouseEventHandler;
            }
            target.removeEventListener(name,listener);
            this._eventListeners[name] = this.THIS_HANDLES_EVENT;
         }
      }
      
      tlf_internal function collectElements(parent:FlowGroupElement, startPosition:int, endPosition:int, results:Array) : void
      {
         var child:FlowElement = null;
         var group:FlowGroupElement = null;
         for(var i:int = parent.findChildIndexAtPosition(startPosition); i < parent.numChildren; )
         {
            child = parent.getChildAt(i);
            if(child.parentRelativeStart >= endPosition)
            {
               break;
            }
            if(child.hasActiveEventMirror() || child is LinkElement)
            {
               results.push(child);
            }
            group = child as FlowGroupElement;
            if(group)
            {
               this.collectElements(group,Math.max(startPosition - group.parentRelativeStart,0),endPosition - group.parentRelativeStart,results);
            }
            i++;
         }
      }
      
      public function dispatchEvent(evt:Event) : void
      {
         var keyEvt:KeyboardEvent = null;
         var mouseEvt:MouseEvent = evt as MouseEvent;
         if(mouseEvt)
         {
            this.hitTestMouseEventHandler(mouseEvt);
         }
         else
         {
            keyEvt = evt as KeyboardEvent;
            if(keyEvt)
            {
               this.hitTestKeyEventHandler(keyEvt);
            }
         }
      }
      
      private function hitTestKeyEventHandler(evt:KeyboardEvent) : void
      {
         if(!this._blockInteraction)
         {
            this.checkCtrlKeyState(evt.ctrlKey);
         }
      }
      
      private function checkCtrlKeyState(curState:Boolean) : void
      {
         var link:LinkElement = this._currentElement as LinkElement;
         if(!link || !this._needsCtrlKey || !this._lastMouseEvent || curState == this._ctrlKeyState)
         {
            return;
         }
         this._ctrlKeyState = curState;
         if(this._ctrlKeyState)
         {
            link.mouseOverHandler(this,this._lastMouseEvent);
         }
         else
         {
            link.mouseOutHandler(this,this._lastMouseEvent);
         }
      }
      
      private function hitTestMouseEventHandler(evt:MouseEvent) : void
      {
         if(!this._hitTests)
         {
            return;
         }
         this._lastMouseEvent = evt;
         var containerPoint:Point = this.mouseToContainer(evt);
         var hitElement:FlowElement = this._hitTests.hitTest(containerPoint.x,containerPoint.y);
         if(hitElement != this._currentElement)
         {
            this._mouseDownElement = null;
            if(this._currentElement)
            {
               this.localDispatchEvent(FlowElementMouseEvent.ROLL_OUT,evt);
            }
            else if(evt.buttonDown)
            {
               this._blockInteraction = true;
            }
            this._currentElement = hitElement;
            if(this._currentElement)
            {
               this.localDispatchEvent(FlowElementMouseEvent.ROLL_OVER,evt);
            }
            else
            {
               this._blockInteraction = false;
            }
         }
         var isClick:* = false;
         var eventType:String = null;
         switch(evt.type)
         {
            case MouseEvent.MOUSE_MOVE:
               eventType = FlowElementMouseEvent.MOUSE_MOVE;
               if(!this._blockInteraction)
               {
                  this.checkCtrlKeyState(evt.ctrlKey);
               }
               break;
            case MouseEvent.MOUSE_DOWN:
               this._mouseDownElement = this._currentElement;
               eventType = FlowElementMouseEvent.MOUSE_DOWN;
               break;
            case MouseEvent.MOUSE_UP:
               eventType = FlowElementMouseEvent.MOUSE_UP;
               isClick = this._currentElement == this._mouseDownElement;
               this._mouseDownElement = null;
         }
         if(this._currentElement && eventType)
         {
            this.localDispatchEvent(eventType,evt);
            if(isClick)
            {
               this.localDispatchEvent(FlowElementMouseEvent.CLICK,evt);
            }
         }
      }
      
      tlf_internal function dispatchFlowElementMouseEvent(type:String, originalEvent:MouseEvent) : Boolean
      {
         if(this._needsCtrlKey && !originalEvent.ctrlKey && type != FlowElementMouseEvent.ROLL_OUT)
         {
            return false;
         }
         var locallyListening:Boolean = this._currentElement.hasActiveEventMirror();
         var textFlow:TextFlow = this._currentElement.getTextFlow();
         var textFlowListening:Boolean = false;
         if(textFlow)
         {
            textFlowListening = textFlow.hasEventListener(type);
         }
         if(!locallyListening && !textFlowListening)
         {
            return false;
         }
         var event:FlowElementMouseEvent = new FlowElementMouseEvent(type,false,true,this._currentElement,originalEvent);
         if(locallyListening)
         {
            this._currentElement.getEventMirror().dispatchEvent(event);
            if(event.isDefaultPrevented())
            {
               return true;
            }
         }
         if(textFlowListening)
         {
            textFlow.dispatchEvent(event);
            if(event.isDefaultPrevented())
            {
               return true;
            }
         }
         return false;
      }
      
      private function localDispatchEvent(type:String, evt:MouseEvent) : void
      {
         if(this._blockInteraction || !this._currentElement)
         {
            return;
         }
         if(this._needsCtrlKey)
         {
            switch(type)
            {
               case FlowElementMouseEvent.ROLL_OVER:
                  this.addEventListener(KeyboardEvent.KEY_DOWN,true);
                  this.addEventListener(KeyboardEvent.KEY_UP,true);
                  break;
               case FlowElementMouseEvent.ROLL_OUT:
                  this.removeEventListener(KeyboardEvent.KEY_DOWN,true);
                  this.removeEventListener(KeyboardEvent.KEY_UP,true);
            }
         }
         if(this.dispatchFlowElementMouseEvent(type,evt))
         {
            return;
         }
         var link:LinkElement = !this._needsCtrlKey || evt.ctrlKey ? this._currentElement as LinkElement : null;
         if(!link)
         {
            return;
         }
         switch(type)
         {
            case FlowElementMouseEvent.MOUSE_DOWN:
               link.mouseDownHandler(this,evt);
               break;
            case FlowElementMouseEvent.MOUSE_MOVE:
               link.mouseMoveHandler(this,evt);
               break;
            case FlowElementMouseEvent.ROLL_OUT:
               link.mouseOutHandler(this,evt);
               break;
            case FlowElementMouseEvent.ROLL_OVER:
               link.mouseOverHandler(this,evt);
               break;
            case FlowElementMouseEvent.MOUSE_UP:
               link.mouseUpHandler(this,evt);
               break;
            case FlowElementMouseEvent.CLICK:
               link.mouseClickHandler(this,evt);
         }
      }
      
      tlf_internal function setHandCursor(state:Boolean = true) : void
      {
         var sprite:Sprite = null;
         var wmode:String = null;
         if(this._currentElement == null)
         {
            return;
         }
         var tf:TextFlow = this._currentElement.getTextFlow();
         if(tf != null && tf.flowComposer && tf.flowComposer.numControllers)
         {
            sprite = this._container as Sprite;
            if(sprite)
            {
               sprite.buttonMode = state;
               sprite.useHandCursor = state;
            }
            if(state)
            {
               Mouse.cursor = MouseCursor.BUTTON;
            }
            else
            {
               wmode = tf.computedFormat.blockProgression;
               if(tf.interactionManager && wmode != BlockProgression.RL)
               {
                  Mouse.cursor = MouseCursor.IBEAM;
               }
               else
               {
                  Mouse.cursor = Configuration.getCursorString(tf.configuration,MouseCursor.AUTO);
               }
            }
            Mouse.hide();
            Mouse.show();
         }
      }
   }
}
