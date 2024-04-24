package com.ankamagames.tiphon.engine
{
   import com.ankamagames.jerakine.interfaces.IFLAEventHandler;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.types.EventListener;
   import com.ankamagames.tiphon.types.TiphonEventInfo;
   import flash.display.FrameLabel;
   import flash.display.Scene;
   import flash.utils.getQualifiedClassName;
   
   public class TiphonEventsManager
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(TiphonEventsManager));
      
      private static var _listeners:Vector.<EventListener> = new Vector.<EventListener>();
      
      private static var _eventsDic:Array;
      
      private static const EVENT_SHOT:String = "SHOT";
      
      private static const EVENT_END:String = "END";
      
      private static const PLAYER_STOP:String = "STOP";
      
      public static var BALISE_SOUND:String = "Sound";
      
      public static var BALISE_DATASOUND:String = "DataSound";
      
      public static var BALISE_PLAYANIM:String = "PlayAnim";
      
      public static var BALISE_EVT:String = "Evt";
      
      public static var BALISE_PARAM_BEGIN:String = "(";
      
      public static var BALISE_PARAM_END:String = ")";
       
      
      private var _weakTiphonSprite:WeakReference;
      
      private var _events:Array;
      
      public function TiphonEventsManager(pTiphonSprite:TiphonSprite)
      {
         super();
         this._weakTiphonSprite = new WeakReference(pTiphonSprite);
         this._events = [];
         if(_eventsDic == null)
         {
            _eventsDic = [];
         }
      }
      
      public static function get listeners() : Vector.<EventListener>
      {
         return _listeners;
      }
      
      public static function addListener(pListener:IFLAEventHandler, pTypes:String) : void
      {
         var el:EventListener = null;
         var i:int = -1;
         var num:int = _listeners.length;
         while(++i < num)
         {
            el = _listeners[i];
            if(el.listener == pListener && el.typesEvents == pTypes)
            {
               return;
            }
         }
         TiphonEventsManager._listeners.push(new EventListener(pListener,pTypes));
      }
      
      public function parseLabels(pScene:Scene, pAnimationName:String) : void
      {
         var curLabel:FrameLabel = null;
         var curLabelName:String = null;
         var curLabelFrame:int = 0;
         var numLabels:int = pScene.labels.length;
         var curLabelIndex:int = -1;
         while(++curLabelIndex < numLabels)
         {
            curLabel = pScene.labels[curLabelIndex] as FrameLabel;
            curLabelName = curLabel.name;
            curLabelFrame = curLabel.frame;
            this.addEvent(curLabelName,curLabelFrame,pAnimationName);
         }
      }
      
      public function dispatchEvents(pFrame:*) : void
      {
         var num:int = 0;
         var i:int = 0;
         var event:TiphonEventInfo = null;
         var numListener:int = 0;
         var k:int = 0;
         var eListener:EventListener = null;
         if(!this._weakTiphonSprite)
         {
            return;
         }
         if(pFrame == 0)
         {
            pFrame = 1;
         }
         var ts:TiphonSprite = this._weakTiphonSprite.object as TiphonSprite;
         var spriteDirection:uint = ts.getDirection();
         if(spriteDirection == 3)
         {
            spriteDirection = 1;
         }
         if(spriteDirection == 7)
         {
            spriteDirection = 5;
         }
         if(spriteDirection == 4)
         {
            spriteDirection = 0;
         }
         var spriteAnimation:String = ts.getAnimation();
         var frameEventsList:Vector.<TiphonEventInfo> = this._events[pFrame];
         if(frameEventsList)
         {
            num = frameEventsList.length;
            i = -1;
            while(++i < num)
            {
               event = frameEventsList[i];
               numListener = _listeners.length;
               k = -1;
               while(++k < numListener)
               {
                  eListener = _listeners[k];
                  if(eListener.typesEvents == event.type && event.animationType == spriteAnimation && event.direction == spriteDirection)
                  {
                     eListener.listener.handleFLAEvent(event.animationName,event.type,event.params,ts);
                  }
               }
            }
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         var num:int = 0;
         var list:Vector.<TiphonEventInfo> = null;
         var k:int = 0;
         var num2:int = 0;
         var tiphonEventInfo:TiphonEventInfo = null;
         if(this._events)
         {
            i = -1;
            num = this._events.length;
            while(++i < num)
            {
               list = this._events[i];
               if(list)
               {
                  k = -1;
                  num2 = list.length;
                  while(++k < num2)
                  {
                     tiphonEventInfo = list[k];
                     tiphonEventInfo.destroy();
                  }
               }
            }
            this._events = null;
         }
         if(this._weakTiphonSprite)
         {
            this._weakTiphonSprite.destroy();
            this._weakTiphonSprite = null;
         }
      }
      
      public function addEvent(pLabelName:String, pFrame:int, pAnimationName:String) : void
      {
         var event:TiphonEventInfo = null;
         var newEvent:TiphonEventInfo = null;
         var labelEvent:TiphonEventInfo = null;
         var ts:TiphonSprite = null;
         if(this._events[pFrame] == null)
         {
            this._events[pFrame] = new Vector.<TiphonEventInfo>();
         }
         pAnimationName = TiphonEventInfo.parseAnimationName(pAnimationName);
         for each(event in this._events[pFrame])
         {
            if(event.animationName == pAnimationName && event.label == pLabelName)
            {
               return;
            }
         }
         if(_eventsDic[pLabelName])
         {
            newEvent = (_eventsDic[pLabelName] as TiphonEventInfo).duplicate();
            newEvent.label = pLabelName;
            this._events[pFrame].push(newEvent);
            newEvent.animationName = pAnimationName;
         }
         else
         {
            labelEvent = this.parseLabel(pLabelName);
            if(labelEvent)
            {
               _eventsDic[pLabelName] = labelEvent;
               labelEvent.animationName = pAnimationName;
               labelEvent.label = pLabelName;
               this._events[pFrame].push(labelEvent);
            }
            else if(pLabelName != "END")
            {
               ts = this._weakTiphonSprite.object as TiphonSprite;
               _log.error("Found label \'" + pLabelName + "\' on sprite " + ts.look.getBone() + " (anim " + ts.getAnimation() + ")");
            }
         }
      }
      
      public function removeEvents(pTypeName:String, pAnimation:String) : void
      {
         var frame:* = null;
         var events:Vector.<TiphonEventInfo> = null;
         var newEvents:Vector.<TiphonEventInfo> = null;
         var tei:TiphonEventInfo = null;
         pAnimation = TiphonEventInfo.parseAnimationName(pAnimation);
         for(frame in this._events)
         {
            events = this._events[frame];
            newEvents = new Vector.<TiphonEventInfo>();
            for each(tei in events)
            {
               if(tei.animationName != pAnimation || tei.type != pTypeName)
               {
                  newEvents.push(tei);
               }
            }
            if(newEvents.length != events.length)
            {
               this._events[frame] = newEvents;
            }
         }
      }
      
      private function parseLabel(pLabelName:String) : TiphonEventInfo
      {
         var returnEvent:TiphonEventInfo = null;
         var param:String = null;
         var eventName:String = pLabelName.split(BALISE_PARAM_BEGIN)[0];
         var r:RegExp = /^\s*(.*?)\s*$/g;
         eventName = eventName.replace(r,"$1");
         switch(eventName.toUpperCase())
         {
            case BALISE_SOUND.toUpperCase():
               param = pLabelName.split(BALISE_PARAM_BEGIN)[1];
               param = param.split(BALISE_PARAM_END)[0];
               returnEvent = new TiphonEventInfo(TiphonEvent.SOUND_EVENT,param);
               break;
            case BALISE_DATASOUND.toUpperCase():
               param = pLabelName.split(BALISE_PARAM_BEGIN)[1];
               param = param.split(BALISE_PARAM_END)[0];
               returnEvent = new TiphonEventInfo(TiphonEvent.DATASOUND_EVENT,param);
               break;
            case BALISE_PLAYANIM.toUpperCase():
               param = pLabelName.split(BALISE_PARAM_BEGIN)[1];
               param = param.split(BALISE_PARAM_END)[0];
               returnEvent = new TiphonEventInfo(TiphonEvent.PLAYANIM_EVENT,param);
               break;
            case BALISE_EVT.toUpperCase():
               param = pLabelName.split(BALISE_PARAM_BEGIN)[1];
               param = param.split(BALISE_PARAM_END)[0];
               returnEvent = new TiphonEventInfo(TiphonEvent.EVT_EVENT,param);
               break;
            default:
               returnEvent = this.convertOldLabel(pLabelName);
         }
         return returnEvent;
      }
      
      private function convertOldLabel(pLabelName:String) : TiphonEventInfo
      {
         var returnEvent:TiphonEventInfo = null;
         switch(pLabelName)
         {
            case EVENT_END:
               returnEvent = new TiphonEventInfo(TiphonEvent.EVT_EVENT,EVENT_END);
               break;
            case PLAYER_STOP:
               returnEvent = new TiphonEventInfo(TiphonEvent.EVT_EVENT,PLAYER_STOP);
               break;
            case EVENT_SHOT:
               returnEvent = new TiphonEventInfo(TiphonEvent.EVT_EVENT,EVENT_SHOT);
         }
         return returnEvent;
      }
   }
}
