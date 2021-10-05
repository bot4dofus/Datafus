package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.chat.PopupWarningCloseRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class LockedPopup
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      protected var onCancelFunction:Function = null;
      
      private var _autoCloseTimer:BenchmarkTimer;
      
      private var _closeAllowed:Boolean = true;
      
      private var _autoClose:Boolean = false;
      
      private var _timer:Timer;
      
      private var _remainedTime:uint;
      
      private var _duration:uint;
      
      public var popCtr:GraphicContainer;
      
      public var btn_ok:ButtonContainer;
      
      public var btn_lbl_btn_ok:Label;
      
      public var lbl_title_popup:Label;
      
      public var lbl_content:Label;
      
      public function LockedPopup()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         var hook:String = null;
         var duration:uint = 0;
         this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
         this.btn_ok.soundId = SoundEnum.WINDOW_CLOSE;
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.sysApi.addHook(HookList.PopupWarningClosed,this.closePopup);
         if(param)
         {
            if(param.hideModalContainer)
            {
               this.popCtr.getUi().showModalContainer = false;
            }
            else
            {
               this.popCtr.getUi().showModalContainer = true;
            }
            if(!this.sysApi.isFightContext())
            {
               this.btn_ok.disabled = true;
               this._closeAllowed = false;
               this._autoClose = param.autoClose;
               if(param.closeAtHook)
               {
                  for each(hook in param.closeParam)
                  {
                     this.sysApi.addHook(hook,this.onCloseHook);
                  }
               }
               else
               {
                  duration = uint(param.closeParam[0]);
                  if(duration > 10)
                  {
                     duration = 10;
                  }
                  this._timer = new Timer(1000,duration);
                  this._remainedTime = this._timer.repeatCount;
                  this.btn_lbl_btn_ok.text = this.uiApi.getText("ui.common.ok") + " (" + this._remainedTime + ")";
                  this._duration = duration;
                  this._timer.addEventListener(TimerEvent.TIMER,this.updateTime);
                  this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.timerEnded);
                  this._timer.start();
               }
            }
            this.lbl_title_popup.text = param.title;
            if(param.useHyperLink)
            {
               this.lbl_content.hyperlinkEnabled = true;
               this.lbl_content.useStyleSheet = true;
            }
            this.lbl_content.text = param.content;
            this.popCtr.height = Math.floor(this.lbl_content.textfield.textHeight) + this.lbl_content.y + 92;
            return;
         }
         throw new Error("Can\'t load popup without properties.");
      }
      
      public function unload() : void
      {
         if(this._autoCloseTimer)
         {
            this._autoCloseTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
            this._autoCloseTimer.stop();
            this._autoCloseTimer = null;
         }
         this.sysApi.dispatchHook(HookList.ClosePopup);
         if(this._timer)
         {
            this._timer.removeEventListener(TimerEvent.TIMER,this.updateTime);
            this._timer = null;
         }
      }
      
      private function allowClose() : void
      {
         this._closeAllowed = true;
         this.btn_ok.disabled = false;
         if(this._autoClose)
         {
            this._autoCloseTimer = new BenchmarkTimer(1000,1,"LockedPopup._autoCloseTimer");
            this._autoCloseTimer.start();
            this._autoCloseTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
         }
      }
      
      private function closePopupRequest() : void
      {
         if(this._closeAllowed)
         {
            this.sysApi.sendAction(new PopupWarningCloseRequestAction());
         }
      }
      
      private function closePopup() : void
      {
         if(this._closeAllowed)
         {
            if(this._autoCloseTimer)
            {
               this._autoCloseTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
               this._autoCloseTimer.stop();
               this._autoCloseTimer = null;
            }
            if(this.onCancelFunction != null)
            {
               this.onCancelFunction();
            }
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target == this.btn_ok)
         {
            this.closePopupRequest();
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
            case "closeUi":
               this.closePopupRequest();
               return true;
            default:
               return false;
         }
      }
      
      public function onCloseHook(param:Object) : void
      {
         this.allowClose();
      }
      
      public function updateTime(e:Event) : void
      {
         var remainedTime:int = 0;
         if(this._timer.currentCount < this._timer.repeatCount)
         {
            remainedTime = this._timer.repeatCount - this._timer.currentCount;
            this.btn_lbl_btn_ok.text = this.uiApi.getText("ui.common.ok") + " (" + remainedTime + ")";
            this._remainedTime = remainedTime;
         }
      }
      
      public function timerEnded(e:Event) : void
      {
         this._timer.removeEventListener(TimerEvent.TIMER,this.updateTime);
         this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.timerEnded);
         this.btn_lbl_btn_ok.text = this.uiApi.getText("ui.common.ok");
         this.allowClose();
      }
      
      public function onTimeOut(e:TimerEvent) : void
      {
         this.closePopupRequest();
      }
   }
}
