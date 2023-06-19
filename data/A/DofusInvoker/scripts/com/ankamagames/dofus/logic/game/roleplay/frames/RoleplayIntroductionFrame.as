package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.messages.MapsLoadingStartedMessage;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.types.event.UiUnloadEvent;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.RegisteringFrame;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   
   public class RoleplayIntroductionFrame extends RegisteringFrame
   {
      
      private static const START_MAP_ID:uint = 152305664;
      
      private static const START_CELL_ID:uint = 342;
      
      private static const CINEMATIC_UI_NAME:String = "cinematic";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayIntroductionFrame));
       
      
      private var _spawnEntity:AnimatedCharacter;
      
      public function RoleplayIntroductionFrame()
      {
         super();
      }
      
      override protected function registerMessages() : void
      {
         _priority = Priority.LOW;
         register(MapsLoadingStartedMessage,this.onMapRenderStart);
         register(MapComplementaryInformationsDataMessage,this.onMapData);
      }
      
      private function onMapRenderStart(msg:MapsLoadingStartedMessage) : Boolean
      {
         if(msg.id == START_MAP_ID)
         {
            this.changeWorldVisibility(false);
            MapDisplayManager.getInstance().renderer.displayWorld = false;
         }
         else
         {
            Kernel.getWorker().removeFrame(this);
         }
         return false;
      }
      
      private function onMapData(msg:MapComplementaryInformationsDataMessage) : Boolean
      {
         var playerEntity:DisplayObject = EntitiesManager.getInstance().getEntity(PlayedCharacterManager.getInstance().id) as DisplayObject;
         if(playerEntity && IEntity(playerEntity).position && IEntity(playerEntity).position.cellId == START_CELL_ID)
         {
            KernelEventsManager.getInstance().processCallback(HookList.IntroductionCinematicStart);
            this.setPlayerVisibility(false);
            Atouin.getInstance().rootContainer.mouseChildren = false;
            Atouin.getInstance().rootContainer.mouseEnabled = false;
            this.hideHudOnStart();
            this.initSprite();
         }
         else
         {
            this.changeWorldVisibility(true);
         }
         return false;
      }
      
      private function hideHudOnStart() : void
      {
         var ui:UiRootContainer = null;
         for each(ui in Berilia.getInstance().getHud())
         {
            if(ui)
            {
               ui.visible = false;
            }
         }
      }
      
      private function initSprite() : void
      {
         if(!this._spawnEntity)
         {
            this._spawnEntity = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(),TiphonEntityLook.fromString("{3440}"));
         }
         this._spawnEntity.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onSpawnEntityRendered);
         this._spawnEntity.addEventListener(TiphonEvent.RENDER_FAILED,this.onSpawnEntityFailed);
         this._spawnEntity.setAnimationAndDirection("AnimStatique",0);
      }
      
      private function setPlayerVisibility(b:Boolean) : void
      {
         var playerEntity:DisplayObject = EntitiesManager.getInstance().getEntity(PlayedCharacterManager.getInstance().id) as DisplayObject;
         if(playerEntity != null)
         {
            playerEntity.visible = b;
         }
      }
      
      private function changeWorldVisibility(visible:Boolean) : void
      {
         Atouin.getInstance().worldContainer.visible = visible;
      }
      
      protected function onSpawnAnimShot(event:Event) : void
      {
         _log.debug("onSpawnAnimShot");
         this.setPlayerVisibility(true);
      }
      
      protected function onSpawnAnimEnd(event:Event) : void
      {
         this.setPlayerVisibility(true);
         if(this._spawnEntity)
         {
            EntitiesDisplayManager.getInstance().removeEntity(this._spawnEntity);
            this._spawnEntity.stopAnimation(1);
            this._spawnEntity.removeEventListener(TiphonEvent.ANIMATION_END,this.onSpawnAnimEnd);
            this._spawnEntity.removeEventListener(TiphonEvent.ANIMATION_SHOT,this.onSpawnAnimShot);
            this._spawnEntity.destroy();
            this._spawnEntity.visible = false;
            this._spawnEntity = null;
         }
         Atouin.getInstance().rootContainer.mouseChildren = true;
         Atouin.getInstance().rootContainer.mouseEnabled = true;
         KernelEventsManager.getInstance().processCallback(HookList.IntroductionCinematicEnd);
         Kernel.getWorker().removeFrame(this);
      }
      
      protected function onSpawnEntityRendered(event:Event) : void
      {
         this._spawnEntity.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onSpawnEntityRendered);
         this._spawnEntity.removeEventListener(TiphonEvent.RENDER_FAILED,this.onSpawnEntityFailed);
         this._spawnEntity.addEventListener(TiphonEvent.ANIMATION_END,this.onSpawnAnimEnd);
         this._spawnEntity.addEventListener(TiphonEvent.ANIMATION_SHOT,this.onSpawnAnimShot);
         EntitiesDisplayManager.getInstance().displayEntity(this._spawnEntity,MapPoint.fromCellId(START_CELL_ID),PlacementStrataEnums.STRATA_FOREGROUND);
         this._spawnEntity.setAnimationAndDirection("FX",0);
         this._spawnEntity.stopAnimationAtLastFrame();
         if(Berilia.getInstance().isUiDisplayed(CINEMATIC_UI_NAME))
         {
            this._spawnEntity.stopAnimation(1);
            Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE,this.onUiUnloaded);
         }
         this.changeWorldVisibility(true);
      }
      
      protected function onSpawnEntityFailed(event:Event) : void
      {
         this.changeWorldVisibility(true);
         this.setPlayerVisibility(true);
      }
      
      protected function onUiUnloaded(e:UiUnloadEvent) : void
      {
         Berilia.getInstance().removeEventListener(UiUnloadEvent.UNLOAD_UI_COMPLETE,this.onUiUnloaded);
         if(e.name != CINEMATIC_UI_NAME)
         {
            return;
         }
         if(this._spawnEntity)
         {
            this._spawnEntity.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onSpawnEntityRendered);
            this._spawnEntity.restartAnimation();
         }
      }
   }
}
