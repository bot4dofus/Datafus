package Ankama_GameUiCore.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.VideoPlayer;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.Event;
   import flash.events.TimerEvent;
   
   public class CinematicPlayer
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _hasFlushed:Boolean = false;
      
      public var btn_skip:ButtonContainer;
      
      public var mainCtr:GraphicContainer;
      
      public var vplayer:VideoPlayer;
      
      public var tx_loading:Texture;
      
      public var tx_loading_bg:Texture;
      
      public var lb_loading:Label;
      
      private var _timeout:Boolean;
      
      private var _timer:BenchmarkTimer;
      
      public function CinematicPlayer()
      {
         super();
      }
      
      public function main(args:Object) : void
      {
         var gfxPath:String = this.sysApi.getConfigEntry("config.gfx.path.cinematic");
         var file:* = gfxPath + args.cinematicId + ".flv";
         this.sysApi.log(8,"Ouverture de la vidéo " + file);
         this.uiApi.addComponentHook(this.vplayer,"onVideoConnectFailed");
         this.uiApi.addComponentHook(this.vplayer,"onVideoConnectSuccess");
         this.uiApi.addComponentHook(this.vplayer,"onVideoBufferChange");
         this.sysApi.addHook(CustomUiHookList.StopCinematic,this.onStopCinematic);
         this.sysApi.addHook(HookList.MapComplementaryInformationsData,this.onMapComplementaryInformationsData);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.vplayer.mute = !this.soundApi.soundsAreActivated();
         this.vplayer.flv = file;
         this.vplayer.connect();
         this.sysApi.showWorld(false);
         this.soundApi.activateSounds(false);
         if(this.uiApi.getUi("mapInfo"))
         {
            this.uiApi.getUi("mapInfo").uiClass.visible = false;
         }
         this.vplayer.width = this.mainCtr.width;
         this.vplayer.height = this.mainCtr.height;
         this._timeout = false;
         this._timer = new BenchmarkTimer(2000,1,"CinematicPlayer._timer");
         this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
         this._timer.start();
      }
      
      public function unload() : void
      {
         this.sysApi.log(8,"Fermeture de l\'interface vidéo");
         this.sysApi.showWorld(true);
         this.soundApi.activateSounds(true);
         if(this.uiApi.getUi("mapInfo"))
         {
            this.uiApi.getUi("mapInfo").uiClass.visible = true;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_skip:
               this.sysApi.dispatchHook(CustomUiHookList.StopCinematic);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var data:Object = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case this.btn_skip:
               tooltipText = this.uiApi.getText("ui.cancel.cinematic");
         }
         data = this.uiApi.textTooltipInfo(tooltipText);
         this.uiApi.showTooltip(data,target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               this.vplayer.stop();
               this.sysApi.dispatchHook(CustomUiHookList.StopCinematic);
         }
         return false;
      }
      
      public function onVideoConnectFailed(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.vplayer:
               this.sysApi.log(16,"Echec de la lecture de la vidéo " + this.vplayer.flv);
               this.sysApi.dispatchHook(CustomUiHookList.StopCinematic);
         }
      }
      
      public function dispatchQuitCinematic() : void
      {
         this.sysApi.dispatchHook(CustomUiHookList.StopCinematic);
      }
      
      public function onVideoConnectSuccess(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.vplayer:
               this.vplayer.play();
         }
      }
      
      public function onVideoBufferChange(target:GraphicContainer, state:uint) : void
      {
         if(target == this.vplayer)
         {
            this.sysApi.log(8,"Changement d\'état du buffer vidéo : " + state + "     (timeout " + this._timeout + ")");
            switch(state)
            {
               case 0:
                  this.tx_loading.visible = false;
                  this.lb_loading.visible = false;
                  this.tx_loading_bg.visible = false;
                  break;
               case 1:
                  if(this._timeout && this._hasFlushed)
                  {
                     this.vplayer.stop();
                     this.sysApi.dispatchHook(CustomUiHookList.StopCinematic);
                  }
                  break;
               case 2:
                  this._hasFlushed = true;
            }
         }
      }
      
      public function onMapComplementaryInformationsData(map:Object, subAreaId:uint, show:Boolean) : void
      {
         this.sysApi.showWorld(false);
      }
      
      private function onStopCinematic() : void
      {
         this.vplayer.stop();
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function onTimeOut(event:Event) : void
      {
         this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
         this._timeout = true;
      }
   }
}
