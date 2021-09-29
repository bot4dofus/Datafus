package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.interfaces.IRadioItem;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.RadioGroup;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import com.ankamagames.jerakine.interfaces.IDragAndDropHandler;
   import com.ankamagames.jerakine.interfaces.IInterfaceListener;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.utils.display.FrameIdManager;
   import flash.utils.getQualifiedClassName;
   
   public class ButtonContainer extends StateContainer implements IRadioItem, FinalizableUIComponent, IDragAndDropHandler
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ButtonContainer));
       
      
      private var _selected:Boolean = false;
      
      protected var _mousePressed:Boolean = false;
      
      protected var _disabled:Boolean = false;
      
      private var _radioGroup:String;
      
      private var _value;
      
      private var _lastClickFameId:uint = 4.294967295E9;
      
      private var _checkbox:Boolean = false;
      
      private var _radioMode:Boolean = false;
      
      protected var _sLinkedTo:String;
      
      protected var _soundId:String = "0";
      
      protected var _playRollOverSound:Boolean = true;
      
      protected var _isMute:Boolean = false;
      
      private var _tooltipContent:String;
      
      public function ButtonContainer()
      {
         super();
         buttonMode = true;
         useHandCursor = true;
         mouseEnabled = true;
         mouseChildren = false;
      }
      
      public function get tooltipContent() : String
      {
         return this._tooltipContent;
      }
      
      public function set tooltipContent(content:String) : void
      {
         this._tooltipContent = content;
      }
      
      public function set checkBox(b:Boolean) : void
      {
         this._checkbox = b;
         this._radioMode = !b && this._radioMode;
      }
      
      public function get checkBox() : Boolean
      {
         return this._checkbox;
      }
      
      public function set radioMode(b:Boolean) : void
      {
         this._radioMode = b;
         this._checkbox = !b && this._checkbox;
      }
      
      public function get radioMode() : Boolean
      {
         return this._radioMode;
      }
      
      override public function set linkedTo(sUiComponent:String) : void
      {
         this._sLinkedTo = sUiComponent;
      }
      
      override public function get linkedTo() : String
      {
         return this._sLinkedTo;
      }
      
      public function set radioGroup(radioGroupName:String) : void
      {
         if(radioGroupName == "")
         {
            this._radioGroup = null;
         }
         else
         {
            this._radioGroup = radioGroupName;
         }
      }
      
      public function get radioGroup() : String
      {
         return this._radioGroup;
      }
      
      public function get mousePressed() : Boolean
      {
         return this._mousePressed;
      }
      
      public function set selected(b:Boolean) : void
      {
         var rg:RadioGroup = null;
         this._selected = b;
         if(changingStateData)
         {
            if(!changingStateData[!!b ? StatesEnum.STATE_SELECTED : StatesEnum.STATE_NORMAL])
            {
               this.state = !!this._selected ? StatesEnum.STATE_SELECTED : StatesEnum.STATE_NORMAL;
            }
            else
            {
               this.state = !!b ? StatesEnum.STATE_SELECTED : StatesEnum.STATE_NORMAL;
            }
         }
         if(this._selected && this._radioGroup && getUi())
         {
            rg = getUi().getRadioGroup(this._radioGroup);
            if(rg)
            {
               rg.selectedItem = this;
            }
         }
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      override public function set state(newState:*) : void
      {
         if(_state == newState)
         {
            return;
         }
         switch(newState)
         {
            case StatesEnum.STATE_NORMAL:
               changeState(newState);
               break;
            case StatesEnum.STATE_DISABLED:
               this._disabled = true;
            case StatesEnum.STATE_SELECTED:
            case StatesEnum.STATE_CLICKED:
            case StatesEnum.STATE_OVER:
            case StatesEnum.STATE_SELECTED_CLICKED:
            case StatesEnum.STATE_SELECTED_OVER:
               if(!softDisabled)
               {
                  changeState(newState);
               }
         }
      }
      
      public function get id() : String
      {
         return name;
      }
      
      public function get value() : *
      {
         return this._value;
      }
      
      public function set value(v:*) : void
      {
         this._value = v;
      }
      
      override public function finalize() : void
      {
         var rg:RadioGroup = null;
         var ui:UiRootContainer = getUi();
         if(this._radioGroup)
         {
            rg = ui.addRadioGroup(this._radioGroup);
            rg.addItem(this);
         }
         if(this._selected)
         {
            this.selected = this._selected;
         }
         super.finalize();
         if(ui)
         {
            ui.iAmFinalized(this);
         }
         _finalized = true;
      }
      
      public function get soundId() : String
      {
         return this._soundId;
      }
      
      public function set soundId(pSoundId:String) : void
      {
         this._soundId = pSoundId;
      }
      
      public function get isMute() : Boolean
      {
         return this._isMute;
      }
      
      public function set isMute(pMute:Boolean) : void
      {
         this._isMute = pMute;
      }
      
      public function reset() : void
      {
         _snapshot = new Array();
         this.selected = false;
         _state = StatesEnum.STATE_NORMAL;
      }
      
      override public function free() : void
      {
         super.free();
         this._selected = false;
         this._mousePressed = false;
         this._disabled = false;
         this._radioGroup = null;
         this._value = null;
         this._checkbox = false;
         this._radioMode = false;
         this._sLinkedTo = null;
      }
      
      override public function remove() : void
      {
         super.remove();
         this.free();
      }
      
      protected function selectSound() : String
      {
         if(this._soundId != "0")
         {
            return this._soundId;
         }
         switch(true)
         {
            case this.checkBox:
               if(this.selected)
               {
                  return "16006";
               }
               return "16007";
               break;
            default:
               return "16004";
         }
      }
      
      override public function process(msg:Message) : Boolean
      {
         var listener:IInterfaceListener = null;
         var soundToPLay:String = null;
         var listenerInterface:IInterfaceListener = null;
         var rg:RadioGroup = null;
         var elem:GraphicContainer = null;
         var tmpState:uint = 9999;
         if(!canProcessMessage(msg))
         {
            return true;
         }
         if(!this._disabled)
         {
            switch(true)
            {
               case msg is MouseDownMessage:
                  this._mousePressed = true;
                  tmpState = !!this._selected ? uint(StatesEnum.STATE_SELECTED_CLICKED) : uint(StatesEnum.STATE_CLICKED);
                  break;
               case msg is MouseDoubleClickMessage:
               case msg is MouseClickMessage:
                  this._mousePressed = false;
                  if(this._lastClickFameId == FrameIdManager.frameId)
                  {
                     break;
                  }
                  this._lastClickFameId = FrameIdManager.frameId;
                  if(this._checkbox)
                  {
                     this._selected = !this._selected;
                  }
                  else if(this._radioMode)
                  {
                     this._selected = true;
                  }
                  tmpState = !!this._selected ? uint(StatesEnum.STATE_SELECTED_OVER) : uint(StatesEnum.STATE_OVER);
                  if(!changingStateData[tmpState])
                  {
                     tmpState = !!this._selected ? uint(StatesEnum.STATE_SELECTED) : uint(StatesEnum.STATE_NORMAL);
                  }
                  if(!this.isMute)
                  {
                     for each(listener in Berilia.getInstance().UISoundListeners)
                     {
                        soundToPLay = this.selectSound();
                        if(int(soundToPLay) != -1)
                        {
                           listener.playUISound(soundToPLay);
                        }
                     }
                  }
                  break;
               case msg is MouseOverMessage:
                  if(this._mousePressed)
                  {
                     tmpState = !!this._selected ? uint(StatesEnum.STATE_SELECTED_CLICKED) : uint(StatesEnum.STATE_CLICKED);
                  }
                  else
                  {
                     if(this._playRollOverSound && !this.isMute)
                     {
                        for each(listenerInterface in Berilia.getInstance().UISoundListeners)
                        {
                           listenerInterface.playUISound("16010");
                        }
                     }
                     tmpState = !!this._selected ? uint(StatesEnum.STATE_SELECTED_OVER) : uint(StatesEnum.STATE_OVER);
                     if(changingStateData && !changingStateData[tmpState])
                     {
                        tmpState = !!this._selected ? uint(StatesEnum.STATE_SELECTED) : uint(StatesEnum.STATE_NORMAL);
                     }
                  }
                  if(this._tooltipContent)
                  {
                     TooltipManager.show(new TextTooltipInfo(this._tooltipContent),TooltipManager.getTargetRect(this),UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP);
                  }
                  break;
               case msg is MouseReleaseOutsideMessage:
                  this._mousePressed = false;
               case msg is MouseOutMessage:
                  tmpState = !!this._selected ? uint(StatesEnum.STATE_SELECTED) : uint(StatesEnum.STATE_NORMAL);
                  if(this._tooltipContent)
                  {
                     TooltipManager.hide();
                  }
            }
         }
         if(tmpState != 9999)
         {
            this.state = tmpState;
            if(this._radioGroup && this._selected)
            {
               rg = getUi().getRadioGroup(this._radioGroup);
               if(rg)
               {
                  rg.selectedItem = this;
               }
            }
         }
         if(this._sLinkedTo)
         {
            elem = getUi().getElement(this._sLinkedTo);
            if(elem)
            {
               elem.process(msg);
            }
         }
         return false;
      }
   }
}
