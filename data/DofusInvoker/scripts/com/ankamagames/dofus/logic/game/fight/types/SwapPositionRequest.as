package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.managers.EntitiesLooksManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.frames.FightPreparationFrame;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.utils.display.Rectangle2;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.DisplayObject;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class SwapPositionRequest
   {
       
      
      private var _instanceName:String;
      
      private var _icon:UiRootContainer;
      
      private var _timelineInstanceName:String;
      
      private var _timelineIcon:UiRootContainer;
      
      private var _isRequesterIcon:Boolean;
      
      public var requestId:uint;
      
      public var requesterId:Number;
      
      public var requestedId:Number;
      
      public function SwapPositionRequest(pRequestId:uint, pRequesterId:Number, pRequestedId:Number)
      {
         super();
         this.requestId = pRequestId;
         this.requesterId = pRequesterId;
         this.requestedId = pRequestedId;
         this._instanceName = "swapPositionRequest#" + pRequestId;
         this._timelineInstanceName = "timeline_" + this._instanceName;
      }
      
      public function set visible(pVisible:Boolean) : void
      {
         this._timelineIcon.visible = pVisible;
      }
      
      public function destroy() : void
      {
         Berilia.getInstance().unloadUi(this._instanceName);
         Berilia.getInstance().unloadUi(this._timelineInstanceName);
         var frame:FightPreparationFrame = Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame;
         if(frame)
         {
            frame.removeSwapPositionRequest(this.requestId);
         }
      }
      
      public function showRequesterIcon() : void
      {
         this._isRequesterIcon = true;
         this.showIcon();
      }
      
      public function showRequestedIcon() : void
      {
         this._isRequesterIcon = false;
         this.showIcon();
      }
      
      public function updateIcon() : void
      {
         var entity:AnimatedCharacter = DofusEntities.getEntity(!!this._isRequesterIcon ? Number(this.requesterId) : Number(this.requestedId)) as AnimatedCharacter;
         if(this._icon.scale != Atouin.getInstance().currentZoom)
         {
            this._icon.scale = Atouin.getInstance().currentZoom;
         }
         this.placeIcon(entity);
         this.placeTimelineIcon(entity);
      }
      
      private function showIcon() : void
      {
         var entityId:Number = !!this._isRequesterIcon ? Number(this.requesterId) : Number(this.requestedId);
         var mod:UiModule = UiModuleManager.getInstance().getModule("Ankama_Fight");
         var entity:AnimatedCharacter = DofusEntities.getEntity(entityId) as AnimatedCharacter;
         this._icon = Berilia.getInstance().loadUi(mod,mod.uis["swapPositionIcon"],this._instanceName,{
            "requestId":this.requestId,
            "isRequester":this._isRequesterIcon,
            "entityId":entityId,
            "rollEvents":false
         },false);
         this._icon.filters = [new GlowFilter(0,1,2,2,2,1)];
         this.placeIcon(entity);
         this._timelineIcon = Berilia.getInstance().loadUi(mod,mod.uis["swapPositionIcon"],this._timelineInstanceName,{
            "requestId":this.requestId,
            "isRequester":this._isRequesterIcon,
            "entityId":entityId,
            "rollEvents":true
         },false);
         this.placeTimelineIcon(entity);
      }
      
      private function placeIcon(pEntity:AnimatedCharacter) : void
      {
         var targetBounds:IRectangle = null;
         var r1:Rectangle = null;
         var r2:Rectangle2 = null;
         var offsetY:Number = NaN;
         var globalPos:Point = null;
         var entitySpr:TiphonSprite = pEntity as TiphonSprite;
         if(entitySpr.getSubEntitySlot(2,0) && !EntitiesLooksManager.getInstance().isCreatureMode())
         {
            entitySpr = entitySpr.getSubEntitySlot(2,0) as TiphonSprite;
         }
         var head:DisplayObject = entitySpr.getSlot("Tete");
         var readySwords:DisplayObject = entitySpr.getBackground("readySwords");
         if(head && !readySwords)
         {
            r1 = head.getBounds(StageShareManager.stage);
            r2 = new Rectangle2(r1.x,r1.y,r1.width,r1.height);
            targetBounds = r2;
         }
         else if(!readySwords)
         {
            targetBounds = (entitySpr as IDisplayable).absoluteBounds;
         }
         else
         {
            r1 = readySwords.getBounds(StageShareManager.stage);
            r2 = new Rectangle2(r1.x,r1.y,r1.width,r1.height);
            targetBounds = r2;
         }
         if(targetBounds)
         {
            offsetY = !!TooltipManager.isVisible("tooltipOverEntity_" + pEntity.id) ? Number(70) : Number(10);
            globalPos = new Point(targetBounds.x + targetBounds.width / 2,targetBounds.y - offsetY);
            this._icon.x = globalPos.x;
            this._icon.y = globalPos.y;
         }
      }
      
      private function placeTimelineIcon(pEntity:AnimatedCharacter) : void
      {
         var timeline:UiRootContainer = Berilia.getInstance().getUi("timeline");
         var fighterFrame:Object = timeline.uiClass.getFighterById(pEntity.id).frame;
         fighterFrame.getParent().addChild(this._timelineIcon);
         this._timelineIcon.x = fighterFrame.x + fighterFrame.width / 2;
         if(fighterFrame.y != 0)
         {
            this._timelineIcon.y = fighterFrame.y / 2;
         }
         else
         {
            this._timelineIcon.y = this._timelineIcon.getConstant("icon_offset_vertical");
         }
      }
   }
}
