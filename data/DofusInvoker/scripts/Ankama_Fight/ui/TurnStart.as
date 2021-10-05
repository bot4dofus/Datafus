package Ankama_Fight.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.fight.FighterInformations;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class TurnStart
   {
      
      public static const POPUP_TIME:uint = 2000;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="FightApi")]
      public var fightApi:FightApi;
      
      private var _clockStart:uint;
      
      public var mainCtr:GraphicContainer;
      
      public var tx_picture:Object;
      
      public var tx_background:Texture;
      
      public var entityDisplayer:EntityDisplayer;
      
      public var lb_name:Label;
      
      public var lb_level:Label;
      
      public var windowCtr:GraphicContainer;
      
      public function TurnStart()
      {
         super();
      }
      
      public function main(params:Object) : void
      {
         this.sysApi.addEventListener(this.onEnterFrame,"time");
         this.restart(params.fighterId,params.waitingTime);
      }
      
      public function unload() : void
      {
         this.sysApi.removeEventListener(this.onEnterFrame);
      }
      
      public function restart(fighterId:Number, waitingTime:uint) : void
      {
         var bgTextureWidth:Number = NaN;
         var fighter:FighterInformations = this.fightApi.getFighterInformations(fighterId);
         this._clockStart = getTimer();
         this.lb_name.text = this.fightApi.getFighterName(fighterId);
         var level:int = this.fightApi.getFighterLevel(fighterId);
         if(fighterId > 0 && level > ProtocolConstantsEnum.MAX_LEVEL)
         {
            this.lb_level.text = this.uiApi.getText("ui.common.prestige") + " " + (level - ProtocolConstantsEnum.MAX_LEVEL);
         }
         else
         {
            this.lb_level.text = this.uiApi.getText("ui.common.level") + " " + level;
         }
         if(this.lb_name.textWidth > this.lb_level.textWidth)
         {
            bgTextureWidth = this.lb_name.textWidth + this.lb_name.x * 1.9;
         }
         else
         {
            bgTextureWidth = this.lb_level.textWidth + this.lb_level.x * 1.9;
         }
         this.windowCtr.width = bgTextureWidth + parseInt(this.uiApi.me().getConstant("windowMargin"));
         this.entityDisplayer.useFade = false;
         this.entityDisplayer.setAnimationAndDirection("AnimArtwork",1);
         this.entityDisplayer.view = "turnstart";
         this.entityDisplayer.look = this.fightApi.getFighterInformations(fighterId).look;
         this.mainCtr.visible = true;
         this.uiApi.me().render();
      }
      
      public function onEnterFrame(e:Event) : void
      {
         var clock:uint = 0;
         var duration:int = 0;
         if(this.mainCtr.visible)
         {
            clock = getTimer();
            duration = clock - this._clockStart;
            if(duration > POPUP_TIME)
            {
               this.mainCtr.visible = false;
            }
         }
      }
   }
}
