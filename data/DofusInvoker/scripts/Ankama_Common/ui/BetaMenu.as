package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.logic.game.roleplay.actions.EmotePlayRequestAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.Event;
   import flash.events.TimerEvent;
   
   public class BetaMenu
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="RoleplayApi")]
      public var rpApi:RoleplayApi;
      
      private var _timer:BenchmarkTimer;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:Object;
      
      public var btn_beta:ButtonContainer;
      
      public var btn_p:ButtonContainer;
      
      public var ctr_bg:GraphicContainer;
      
      public function BetaMenu()
      {
         super();
      }
      
      public function main(... args) : void
      {
         if(args && args.length == 1)
         {
            if(args[0].hasOwnProperty("visibleBugReportBtn"))
            {
               this.btn_beta.visible = args[0].visibleBugReportBtn;
               this.ctr_bg.visible = args[0].visibleBugReportBtn;
               if(args[0].visibleBugReportBtn)
               {
                  this.uiApi.addComponentHook(this.btn_beta,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(this.btn_beta,ComponentHookList.ON_ROLL_OUT);
               }
            }
            if(args[0].hasOwnProperty("visiblePartyTimeBtn"))
            {
               this.btn_p.visible = args[0].visiblePartyTimeBtn;
               if(args[0].visiblePartyTimeBtn)
               {
                  this._timer = new BenchmarkTimer(800,4,"BetaMenu._timer");
                  this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
               }
            }
         }
      }
      
      public function unload() : void
      {
         if(this._timer)
         {
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this._timer = null;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target == this.btn_beta)
         {
            this.sysApi.goToUrl(this.uiApi.getText("ui.link.betaForumReport"));
         }
         else if(target == this.btn_p)
         {
            this._timer.reset();
            this.dispatchCallback();
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var txt:String = null;
         if(target == this.btn_beta)
         {
            txt = this.uiApi.getText("ui.common.bugReport");
         }
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt),target,false,"standard",7,1,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function dispatchCallback() : void
      {
         this.onTimer(null);
         this._timer.start();
         var texts:Array = ["YEAH ! PARTY HARD !","C\'est carrément la fête aujourd\'hui !","Je passe un super bon moment !","Je suis super heureux !","\\o/",":D","Ouhouou ! Shut up and dance with me !","Cette journée est tellement magique !","C\'est la fête ! C\'est la fête ! Service garanti impec\' !","Tout le monde chante, tout le monde danse, oui mam\'zelle ça c\'est la France !"];
         var index:int = Math.floor(Math.random() * texts.length);
         this.sysApi.dispatchHook(ChatHookList.TextInformation,texts[index],ChatActivableChannelsEnum.CHANNEL_ADMIN,this.timeApi.getTimestamp());
      }
      
      private function onTimer(e:Event) : void
      {
         var spellEffects:Array = [1846,1841,1848];
         var cellId:int = Math.floor(Math.random() * 195) + 363;
         var spellIndex:int = Math.floor(Math.random() * spellEffects.length);
         this.rpApi.playSpellAnimation(spellEffects[spellIndex],5,cellId);
         if(this._timer.currentCount == this._timer.repeatCount || this._timer.running == false)
         {
            this.sysApi.sendAction(new EmotePlayRequestAction([27]));
         }
      }
   }
}
