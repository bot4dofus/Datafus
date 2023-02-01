package com.ankamagames.berilia.factories
{
   import com.ankamagames.berilia.events.LinkInteractionEvent;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.berilia.managers.HtmlManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.display.FrameIdManager;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.EventDispatcher;
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class HyperlinkFactory
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HyperlinkFactory));
      
      private static const LEFT:String = "{";
      
      private static const RIGHT:String = "}";
      
      private static const SEPARATOR:String = "::";
      
      private static var PROTOCOL:Dictionary = new Dictionary();
      
      private static var PROTOCOL_TEXT:Dictionary = new Dictionary();
      
      private static var PROTOCOL_SHIFT:Dictionary = new Dictionary();
      
      private static var PROTOCOL_BOLD:Dictionary = new Dictionary();
      
      private static var PROTOCOL_ROLL_OVER:Dictionary = new Dictionary();
      
      private static var staticStyleSheet:StyleSheet;
      
      public static var lastClickEventFrame:uint;
      
      private static var _clickTimerDuration:Number = -101;
      
      private static var _shiftClickTimerDuration:Number = -101;
      
      private static var _rollOverTimer:BenchmarkTimer;
      
      private static var _rollOverData:String;
       
      
      public function HyperlinkFactory()
      {
         super();
      }
      
      public static function protocolIsRegister(protocolName:String) : Boolean
      {
         return PROTOCOL[protocolName] != null;
      }
      
      public static function textProtocolIsRegister(protocolName:String) : Boolean
      {
         return PROTOCOL_TEXT[protocolName] != null;
      }
      
      public static function shiftProtocolIsRegister(protocolName:String) : Boolean
      {
         return PROTOCOL_SHIFT[protocolName] != null;
      }
      
      public static function boldProtocolIsRegister(protocolName:String) : Boolean
      {
         return PROTOCOL_BOLD[protocolName] == true;
      }
      
      public static function createTextClickHandler(component:EventDispatcher, styleSheet:Boolean = false) : void
      {
         var t:TextField = null;
         if(component is TextField)
         {
            t = component as TextField;
            t.htmlText = decode(t.htmlText,true,!!styleSheet ? t : null);
            t.mouseEnabled = true;
         }
         component.addEventListener(TextEvent.LINK,processClick,false,0,true);
      }
      
      public static function removeTextClickHandler(component:EventDispatcher) : void
      {
         component.removeEventListener(TextEvent.LINK,processClick);
      }
      
      public static function createRollOverHandler(component:EventDispatcher) : void
      {
         component.addEventListener(LinkInteractionEvent.ROLL_OVER,processRollOver,false,0,true);
         component.addEventListener(LinkInteractionEvent.ROLL_OUT,processRollOut,false,0,true);
      }
      
      public static function removeRollOverHandler(component:EventDispatcher) : void
      {
         component.removeEventListener(LinkInteractionEvent.ROLL_OVER,processRollOver);
         component.removeEventListener(LinkInteractionEvent.ROLL_OUT,processRollOut);
      }
      
      public static function activeSmallHyperlink(textField:TextField) : void
      {
         textField.addEventListener(TextEvent.LINK,processClick,false,0,true);
      }
      
      public static function deactiveSmallHyperlink(textField:TextField) : void
      {
         textField.removeEventListener(TextEvent.LINK,processClick);
      }
      
      public static function decode(string:String, htmlMode:Boolean = true, textField:TextField = null) : String
      {
         var leftIndex:int = 0;
         var rightIndex:int = 0;
         var leftBlock:String = null;
         var rightBlock:String = null;
         var middleBlock:String = null;
         var text:String = null;
         var linkInfo:Array = null;
         var param:String = null;
         var paramList:Array = null;
         var protocolName:String = null;
         var linkColor:String = null;
         var hoverColor:String = null;
         var i:int = 0;
         var nbParams:int = 0;
         var p:String = null;
         var mainFunction:Function = null;
         var getTextFunction:Function = null;
         var customStyleSheet:Boolean = false;
         var styleSheet:StyleSheet = null;
         if(!string)
         {
            return "";
         }
         var currentText:String = string;
         while(true)
         {
            leftIndex = currentText.indexOf(LEFT);
            if(leftIndex == -1)
            {
               break;
            }
            rightIndex = currentText.indexOf(RIGHT);
            if(rightIndex == -1)
            {
               break;
            }
            if(leftIndex > rightIndex)
            {
               break;
            }
            leftBlock = currentText.substring(0,leftIndex);
            rightBlock = currentText.substring(rightIndex + 1);
            middleBlock = currentText.substring(leftIndex,rightIndex);
            linkInfo = middleBlock.split(SEPARATOR);
            param = linkInfo[0].substr(1);
            paramList = param.split(",");
            protocolName = paramList.shift();
            nbParams = paramList.length;
            for(i = 0; i < nbParams; i++)
            {
               p = paramList[i];
               if(p.indexOf("linkColor") != -1)
               {
                  linkColor = p.split(":")[1];
                  paramList.splice(i,1);
                  i--;
                  nbParams--;
               }
               if(p.indexOf("hoverColor") != -1)
               {
                  hoverColor = p.split(":")[1];
                  paramList.splice(i,1);
                  i--;
                  nbParams--;
               }
            }
            if((linkColor || hoverColor) && paramList.length)
            {
               param = protocolName + "," + paramList.join(",");
            }
            mainFunction = PROTOCOL[protocolName];
            if(mainFunction != null && mainFunction.length != paramList.length)
            {
            }
            if(linkInfo.length == 1)
            {
               getTextFunction = PROTOCOL_TEXT[protocolName];
               if(getTextFunction != null)
               {
                  try
                  {
                     linkInfo.push(getTextFunction.apply(getTextFunction,paramList));
                  }
                  catch(e:Error)
                  {
                     _log.error("Invalid link : " + string);
                     return string;
                  }
               }
            }
            if(htmlMode)
            {
               text = linkInfo[1];
               if(PROTOCOL_BOLD[protocolName])
               {
                  text = HtmlManager.addTag(text,HtmlManager.BOLD);
               }
               currentText = leftBlock;
               currentText += HtmlManager.addLink(text,"event:" + param,null,true);
               currentText += rightBlock;
               if(textField)
               {
                  customStyleSheet = linkColor || hoverColor;
                  if(!linkColor)
                  {
                     linkColor = XmlConfig.getInstance().getEntry("colors.hyperlink.link");
                     linkColor = linkColor.replace("0x","#");
                  }
                  if(!hoverColor)
                  {
                     hoverColor = XmlConfig.getInstance().getEntry("colors.hyperlink.hover");
                     hoverColor = hoverColor.replace("0x","#");
                  }
                  if(!customStyleSheet)
                  {
                     if(!staticStyleSheet)
                     {
                        staticStyleSheet = new StyleSheet();
                     }
                     styleSheet = staticStyleSheet;
                  }
                  else
                  {
                     styleSheet = new StyleSheet();
                  }
                  if(styleSheet.styleNames.length == 0)
                  {
                     styleSheet.setStyle("a:link",{"color":linkColor});
                     styleSheet.setStyle("a:hover",{"color":hoverColor});
                  }
                  textField.styleSheet = styleSheet;
               }
            }
            else
            {
               text = linkInfo.length == 2 ? linkInfo[1] : "";
               currentText = leftBlock + text + rightBlock;
            }
         }
         return currentText;
      }
      
      public static function registerProtocol(name:String, callBack:Function, textCallBack:Function = null, shiftCallBack:Function = null, useBoldText:Boolean = true, rollOverCallback:Function = null) : void
      {
         PROTOCOL[name] = callBack;
         if(textCallBack != null)
         {
            PROTOCOL_TEXT[name] = textCallBack;
         }
         if(shiftCallBack != null)
         {
            PROTOCOL_SHIFT[name] = shiftCallBack;
         }
         if(useBoldText)
         {
            PROTOCOL_BOLD[name] = true;
         }
         if(rollOverCallback != null)
         {
            PROTOCOL_ROLL_OVER[name] = rollOverCallback;
         }
      }
      
      public static function processClick(event:TextEvent, forceClick:Boolean = false) : void
      {
         var ret:Boolean = false;
         var shiftCallBack:Function = null;
         var callBack:Function = null;
         var currentTime:int = getTimer();
         lastClickEventFrame = FrameIdManager.frameId;
         StageShareManager.stage.focus = StageShareManager.stage;
         var param:Array = event.text.split(",");
         if(ShortcutsFrame.shiftKey)
         {
            ret = currentTime - _shiftClickTimerDuration > 100;
            _shiftClickTimerDuration = currentTime;
            if(!ret && !forceClick)
            {
               return;
            }
            if(event.target.parent && event.target.parent.hasOwnProperty("shiftClickActivated") && !event.target.parent.shiftClickActivated)
            {
               return;
            }
            shiftCallBack = PROTOCOL_SHIFT[param[0]];
            if(shiftCallBack == null)
            {
               KernelEventsManager.getInstance().processCallback(BeriliaHookList.ChatHyperlink,"{" + param.join(",") + "}");
            }
            else
            {
               param.shift();
               try
               {
                  shiftCallBack.apply(null,param);
               }
               catch(e:Error)
               {
                  _log.error("Invalid link: " + event.text);
               }
            }
         }
         else
         {
            ret = currentTime - _clickTimerDuration > 100;
            _clickTimerDuration = currentTime;
            if(!ret && !forceClick)
            {
               return;
            }
            callBack = PROTOCOL[param.shift()];
            if(callBack != null)
            {
               try
               {
                  callBack.apply(null,param);
               }
               catch(e:Error)
               {
                  _log.error("Invalid link: " + event.text);
               }
            }
         }
      }
      
      public static function processRollOver(pEvt:LinkInteractionEvent) : void
      {
         if(_rollOverTimer == null)
         {
            _rollOverTimer = new BenchmarkTimer(400,1,"HyperlinkFactory._rollOverTimer");
         }
         else
         {
            _rollOverTimer.reset();
         }
         _rollOverTimer.addEventListener(TimerEvent.TIMER_COMPLETE,onRollOverTimerComplete);
         _rollOverData = pEvt.text;
         _rollOverTimer.start();
      }
      
      public static function processRollOut(pEvt:LinkInteractionEvent) : void
      {
         if(_rollOverTimer != null)
         {
            _rollOverTimer.reset();
         }
         _rollOverData = null;
      }
      
      private static function onRollOverTimerComplete(pEvt:TimerEvent) : void
      {
         if(_rollOverData == null)
         {
            return;
         }
         _rollOverTimer.stop();
         _rollOverTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,onRollOverTimerComplete);
         var param:Array = _rollOverData.split(",");
         param[1] = StageShareManager.stage.mouseX;
         var callback:Function = PROTOCOL_ROLL_OVER[param.shift()];
         if(callback != null)
         {
            try
            {
               callback.apply(null,param);
            }
            catch(e:Error)
            {
               _log.error("Invalid link");
            }
         }
      }
   }
}
