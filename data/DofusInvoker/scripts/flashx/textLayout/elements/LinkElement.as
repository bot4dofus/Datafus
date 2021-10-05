package flashx.textLayout.elements
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flashx.textLayout.events.FlowElementMouseEventManager;
   import flashx.textLayout.events.ModelChange;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [Event(name="click",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="rollOut",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="rollOver",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="mouseMove",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="mouseUp",type="flashx.textLayout.events.FlowElementMouseEvent")]
   [Event(name="mouseDown",type="flashx.textLayout.events.FlowElementMouseEvent")]
   public final class LinkElement extends SubParagraphGroupElementBase implements IEventDispatcher
   {
      
      tlf_internal static const LINK_NORMAL_FORMAT_NAME:String = "linkNormalFormat";
      
      tlf_internal static const LINK_ACTIVE_FORMAT_NAME:String = "linkActiveFormat";
      
      tlf_internal static const LINK_HOVER_FORMAT_NAME:String = "linkHoverFormat";
       
      
      private var _uriString:String;
      
      private var _targetString:String;
      
      private var _linkState:String;
      
      public function LinkElement()
      {
         super();
         this._linkState = LinkState.LINK;
      }
      
      override tlf_internal function get precedence() : uint
      {
         return 800;
      }
      
      public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         getEventMirror().addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public function dispatchEvent(evt:Event) : Boolean
      {
         if(!hasActiveEventMirror())
         {
            return false;
         }
         return tlf_internal::_eventMirror.dispatchEvent(evt);
      }
      
      public function hasEventListener(type:String) : Boolean
      {
         if(!hasActiveEventMirror())
         {
            return false;
         }
         return tlf_internal::_eventMirror.hasEventListener(type);
      }
      
      public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         if(hasActiveEventMirror())
         {
            tlf_internal::_eventMirror.removeEventListener(type,listener,useCapture);
         }
      }
      
      public function willTrigger(type:String) : Boolean
      {
         if(!hasActiveEventMirror())
         {
            return false;
         }
         return tlf_internal::_eventMirror.willTrigger(type);
      }
      
      override protected function get abstract() : Boolean
      {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String
      {
         return "a";
      }
      
      public function get href() : String
      {
         return this._uriString;
      }
      
      public function set href(newUriString:String) : void
      {
         this._uriString = newUriString;
         modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength);
      }
      
      public function get target() : String
      {
         return this._targetString;
      }
      
      public function set target(newTargetString:String) : void
      {
         this._targetString = newTargetString;
         modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength);
      }
      
      public function get linkState() : String
      {
         return this._linkState;
      }
      
      override public function shallowCopy(startPos:int = 0, endPos:int = -1) : FlowElement
      {
         if(endPos == -1)
         {
            endPos = textLength;
         }
         var retFlow:LinkElement = super.shallowCopy(startPos,endPos) as LinkElement;
         retFlow.href = this.href;
         retFlow.target = this.target;
         return retFlow;
      }
      
      override tlf_internal function mergeToPreviousIfPossible() : Boolean
      {
         var myidx:int = 0;
         var sib:LinkElement = null;
         if(parent && !tlf_internal::bindableElement)
         {
            myidx = parent.getChildIndex(this);
            if(textLength == 0)
            {
               parent.replaceChildren(myidx,myidx + 1,null);
               return true;
            }
            if(myidx != 0 && !hasActiveEventMirror())
            {
               sib = parent.getChildAt(myidx - 1) as LinkElement;
               if(sib != null && !sib.hasActiveEventMirror())
               {
                  if(this.href == sib.href && this.target == sib.target && equalStylesForMerge(sib))
                  {
                     parent.removeChildAt(myidx);
                     if(numChildren > 0)
                     {
                        sib.replaceChildren(sib.numChildren,sib.numChildren,this.mxmlChildren);
                     }
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      private function computeLinkFormat(formatName:String) : ITextLayoutFormat
      {
         var tf:TextFlow = null;
         var linkStyle:ITextLayoutFormat = getUserStyleWorker(formatName) as ITextLayoutFormat;
         if(linkStyle == null)
         {
            tf = getTextFlow();
            if(tf)
            {
               linkStyle = tf.configuration["defaultL" + formatName.substr(1)];
            }
         }
         return linkStyle;
      }
      
      tlf_internal function get effectiveLinkElementTextLayoutFormat() : ITextLayoutFormat
      {
         var cf:ITextLayoutFormat = null;
         if(this._linkState == LinkState.SUPPRESSED)
         {
            return null;
         }
         if(this._linkState == LinkState.ACTIVE)
         {
            cf = this.computeLinkFormat(tlf_internal::LINK_ACTIVE_FORMAT_NAME);
            if(cf)
            {
               return cf;
            }
         }
         else if(this._linkState == LinkState.HOVER)
         {
            cf = this.computeLinkFormat(tlf_internal::LINK_HOVER_FORMAT_NAME);
            if(cf)
            {
               return cf;
            }
         }
         return this.computeLinkFormat(tlf_internal::LINK_NORMAL_FORMAT_NAME);
      }
      
      override tlf_internal function get formatForCascade() : ITextLayoutFormat
      {
         var resultingTextLayoutFormat:TextLayoutFormat = null;
         var superFormat:TextLayoutFormat = TextLayoutFormat(format);
         var effectiveFormat:ITextLayoutFormat = this.effectiveLinkElementTextLayoutFormat;
         if(effectiveFormat || superFormat)
         {
            if(effectiveFormat && superFormat)
            {
               resultingTextLayoutFormat = new TextLayoutFormat(effectiveFormat);
               if(superFormat)
               {
                  resultingTextLayoutFormat.concatInheritOnly(superFormat);
               }
               return resultingTextLayoutFormat;
            }
            return !!superFormat ? superFormat : effectiveFormat;
         }
         return null;
      }
      
      private function setToState(linkState:String) : void
      {
         var oldCharAttrs:ITextLayoutFormat = null;
         var newCharAttrs:ITextLayoutFormat = null;
         var tf:TextFlow = null;
         if(this._linkState != linkState)
         {
            oldCharAttrs = this.effectiveLinkElementTextLayoutFormat;
            this._linkState = linkState;
            newCharAttrs = this.effectiveLinkElementTextLayoutFormat;
            if(!TextLayoutFormat.isEqual(oldCharAttrs,newCharAttrs))
            {
               formatChanged(true);
               tf = getTextFlow();
               if(tf && tf.flowComposer)
               {
                  tf.flowComposer.updateAllControllers();
               }
            }
         }
      }
      
      tlf_internal function chgLinkState(linkState:String) : void
      {
         if(this._linkState != linkState)
         {
            this._linkState = linkState;
            formatChanged(false);
         }
      }
      
      tlf_internal function mouseDownHandler(mgr:FlowElementMouseEventManager, evt:MouseEvent) : void
      {
         mgr.setHandCursor(true);
         this.setToState(LinkState.ACTIVE);
         evt.stopImmediatePropagation();
      }
      
      tlf_internal function mouseMoveHandler(mgr:FlowElementMouseEventManager, evt:MouseEvent) : void
      {
         mgr.setHandCursor(true);
         this.setToState(!!evt.buttonDown ? LinkState.ACTIVE : LinkState.HOVER);
      }
      
      tlf_internal function mouseOutHandler(mgr:FlowElementMouseEventManager, evt:MouseEvent) : void
      {
         mgr.setHandCursor(false);
         this.setToState(LinkState.LINK);
      }
      
      tlf_internal function mouseOverHandler(mgr:FlowElementMouseEventManager, evt:MouseEvent) : void
      {
         mgr.setHandCursor(true);
         this.setToState(!!evt.buttonDown ? LinkState.ACTIVE : LinkState.HOVER);
      }
      
      tlf_internal function mouseUpHandler(mgr:FlowElementMouseEventManager, evt:MouseEvent) : void
      {
         mgr.setHandCursor(true);
         this.setToState(LinkState.HOVER);
         evt.stopImmediatePropagation();
      }
      
      tlf_internal function mouseClickHandler(mgr:FlowElementMouseEventManager, evt:MouseEvent) : void
      {
         var u:URLRequest = null;
         if(this._uriString != null)
         {
            if(this._uriString.length > 6 && this._uriString.substr(0,6) == "event:")
            {
               mgr.dispatchFlowElementMouseEvent(this._uriString.substring(6,this._uriString.length),evt);
            }
            else
            {
               u = new URLRequest(encodeURI(this._uriString));
               navigateToURL(u,this.target);
            }
         }
         evt.stopImmediatePropagation();
      }
      
      override tlf_internal function acceptTextBefore() : Boolean
      {
         return false;
      }
      
      override tlf_internal function acceptTextAfter() : Boolean
      {
         return false;
      }
      
      override tlf_internal function appendElementsForDelayedUpdate(tf:TextFlow, changeType:String) : void
      {
         if(changeType == ModelChange.ELEMENT_ADDED)
         {
            tf.incInteractiveObjectCount();
            getParagraph().incInteractiveChildrenCount();
         }
         else if(changeType == ModelChange.ELEMENT_REMOVAL)
         {
            tf.decInteractiveObjectCount();
            getParagraph().decInteractiveChildrenCount();
         }
         super.appendElementsForDelayedUpdate(tf,changeType);
      }
      
      override tlf_internal function updateForMustUseComposer(textFlow:TextFlow) : Boolean
      {
         return true;
      }
   }
}
