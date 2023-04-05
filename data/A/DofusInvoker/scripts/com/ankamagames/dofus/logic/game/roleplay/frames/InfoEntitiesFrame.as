package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.messages.CellOutMessage;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.atouin.messages.EntityMovementCompleteMessage;
   import com.ankamagames.atouin.messages.EntityMovementStoppedMessage;
   import com.ankamagames.atouin.messages.MapZoomMessage;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.interactives.StealthBones;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.SwitchCreatureModeAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOutAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOverAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleDematerializationAction;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.messages.GameActionFightLeaveMessage;
   import com.ankamagames.dofus.logic.game.roleplay.managers.RoleplayManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDeathMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightTeleportOnSameMapMessage;
   import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceEndMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRemoveElementMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRemoveMultipleElementsMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameMapMovementMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightStartingMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSynchronizeMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.GameRolePlayShowActorMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.GameRolePlayShowMultipleActorsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.TeleportOnSameMapMessage;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionAlliance;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.Rectangle2;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class InfoEntitiesFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InfoEntitiesFrame));
       
      
      private var _namesVisible:Boolean = false;
      
      private var _labelContainer:Sprite;
      
      private var _playersNames:Vector.<DisplayedEntity>;
      
      private var _movableEntities:Vector.<Number>;
      
      private var _waitList:Vector.<Number>;
      
      private var _roleplayEntitiesFrame:RoleplayEntitiesFrame;
      
      private var _fightEntitiesFrame:FightEntitiesFrame;
      
      private var _fightContextFrame:FightContextFrame;
      
      public function InfoEntitiesFrame()
      {
         super();
         this._labelContainer = new Sprite();
         this._movableEntities = new Vector.<Number>();
         this._waitList = new Vector.<Number>();
      }
      
      public function pushed() : Boolean
      {
         var entityId:Number = NaN;
         if(!this._namesVisible)
         {
            this._playersNames = new Vector.<DisplayedEntity>();
            if(PlayedCharacterApi.getInstance().isInFight())
            {
               if(this._fightEntitiesFrame == null)
               {
                  this._fightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
               }
               if(this._fightContextFrame == null)
               {
                  this._fightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               }
               for each(entityId in this._fightEntitiesFrame.getEntitiesIdsList())
               {
                  if(entityId > 0)
                  {
                     this.addEntity(entityId,this._fightContextFrame.getFighterName(entityId));
                  }
               }
            }
            else
            {
               this.updateEntities();
            }
            this.addListener();
            this._namesVisible = true;
            DisplayObjectContainer(Berilia.getInstance().docMain.getChildAt(StrataEnum.STRATA_WORLD + 1)).addChild(this._labelContainer);
         }
         return true;
      }
      
      public function pulled() : Boolean
      {
         var child:DisplayObject = null;
         if(this._namesVisible)
         {
            this.removeAllTooltips();
            this._namesVisible = false;
            EnterFrameDispatcher.removeEventListener(this.updateTextsPosition);
            child = Berilia.getInstance().docMain.getChildAt(StrataEnum.STRATA_WORLD + 1);
            if(child && DisplayObjectContainer(child).contains(this._labelContainer))
            {
               DisplayObjectContainer(child).removeChild(this._labelContainer);
            }
            KernelEventsManager.getInstance().processCallback(HookList.ShowPlayersNames,false);
         }
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var gmmmsg:GameMapMovementMessage = null;
         var tosmmsg:TeleportOnSameMapMessage = null;
         var gcremsg:GameContextRemoveElementMessage = null;
         var ent:AnimatedCharacter = null;
         var gcrmemsg:GameContextRemoveMultipleElementsMessage = null;
         var ac:AnimatedCharacter = null;
         var emovmsg:EntityMouseOverMessage = null;
         var conmsg:CellOverMessage = null;
         var cellEntity:AnimatedCharacter = null;
         var coutMsg:CellOutMessage = null;
         var cellEntity2:AnimatedCharacter = null;
         var emomsg:EntityMouseOutMessage = null;
         var gaftosmmsg:GameActionFightTeleportOnSameMapMessage = null;
         var gaflmsg:GameActionFightLeaveMessage = null;
         var gafdmsg:GameActionFightDeathMessage = null;
         var id:Number = NaN;
         var entity:IEntity = null;
         var entity2:IEntity = null;
         this.addListener();
         switch(true)
         {
            case msg is CurrentMapMessage:
               this.removeAllTooltips();
               return false;
            case msg is GameMapMovementMessage:
               gmmmsg = msg as GameMapMovementMessage;
               this.movementHandler(gmmmsg.actorId);
               break;
            case msg is EntityMovementCompleteMessage:
               this.entityMovementCompleteHandler((msg as EntityMovementCompleteMessage).entity);
               break;
            case msg is EntityMovementStoppedMessage:
               this.entityMovementCompleteHandler((msg as EntityMovementStoppedMessage).entity);
               break;
            case msg is TeleportOnSameMapMessage:
               tosmmsg = msg as TeleportOnSameMapMessage;
               this.movementHandler(tosmmsg.targetId);
               break;
            case msg is GameRolePlayShowActorMessage:
               this.gameRolePlayShowActorHandler(msg);
               break;
            case msg is GameRolePlayShowMultipleActorsMessage:
               this.gameRolePlayShowMultipleActorsHandler(msg);
               break;
            case msg is GameContextRemoveElementMessage:
               gcremsg = msg as GameContextRemoveElementMessage;
               ent = DofusEntities.getEntity(gcremsg.id) as AnimatedCharacter;
               if(ent)
               {
                  ent.removeEventListener(TiphonEvent.RENDER_FAILED,this.onUpdateEntityFail);
                  ent.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onUpdateEntitySuccess);
               }
               this.removeElementHandler(gcremsg.id);
               break;
            case msg is GameContextRemoveMultipleElementsMessage:
               gcrmemsg = msg as GameContextRemoveMultipleElementsMessage;
               for each(id in gcrmemsg.elementsIds)
               {
                  ac = DofusEntities.getEntity(id) as AnimatedCharacter;
                  if(ac)
                  {
                     ac.removeEventListener(TiphonEvent.RENDER_FAILED,this.onUpdateEntityFail);
                     ac.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onUpdateEntitySuccess);
                  }
                  this.removeElementHandler(id);
               }
               break;
            case msg is GameFightStartingMessage:
               Kernel.getWorker().removeFrame(this);
               break;
            case msg is GameFightEndMessage:
               Kernel.getWorker().removeFrame(this);
               break;
            case msg is EntityMouseOverMessage:
               emovmsg = msg as EntityMouseOverMessage;
               this.mouseOverHandler(emovmsg.entity.id);
               break;
            case msg is CellOverMessage:
               conmsg = msg as CellOverMessage;
               for each(entity in EntitiesManager.getInstance().getEntitiesOnCell(conmsg.cellId))
               {
                  if(entity is AnimatedCharacter && !(entity as AnimatedCharacter).isMoving)
                  {
                     cellEntity = entity as AnimatedCharacter;
                     break;
                  }
               }
               if(cellEntity)
               {
                  this.mouseOverHandler(cellEntity.id);
               }
               break;
            case msg is CellOutMessage:
               coutMsg = msg as CellOutMessage;
               for each(entity2 in EntitiesManager.getInstance().getEntitiesOnCell(coutMsg.cellId))
               {
                  if(entity2 is AnimatedCharacter)
                  {
                     cellEntity2 = entity2 as AnimatedCharacter;
                     break;
                  }
               }
               if(cellEntity2)
               {
                  this.mouseOutHandler(cellEntity2.id);
               }
               break;
            case msg is TimelineEntityOverAction:
               this.mouseOverHandler((msg as TimelineEntityOverAction).targetId);
               break;
            case msg is TimelineEntityOutAction:
               this.mouseOutHandler((msg as TimelineEntityOutAction).targetId);
               break;
            case msg is EntityMouseOutMessage:
               emomsg = msg as EntityMouseOutMessage;
               this.mouseOutHandler(emomsg.entity.id);
               break;
            case msg is GameActionFightTeleportOnSameMapMessage:
               gaftosmmsg = msg as GameActionFightTeleportOnSameMapMessage;
               this.getEntity(gaftosmmsg.targetId).visible = false;
               (DofusEntities.getEntity(gaftosmmsg.targetId) as AnimatedCharacter).addEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
               break;
            case msg is GameActionFightLeaveMessage:
               gaflmsg = msg as GameActionFightLeaveMessage;
               this.removeElementHandler(gaflmsg.targetId);
               break;
            case msg is GameActionFightDeathMessage:
               gafdmsg = msg as GameActionFightDeathMessage;
               this.removeElementHandler(gafdmsg.targetId);
               break;
            case msg is ToggleDematerializationAction:
               this.updateAllTooltipsAfterRender();
               break;
            case msg is SwitchCreatureModeAction:
               this.updateAllTooltipsAfterRender();
               break;
            case msg is GameFightSynchronizeMessage:
               this.updateAllTooltips();
               break;
            case msg is SequenceEndMessage:
               this.updateAllTooltips();
               break;
            case msg is MapZoomMessage:
               this.updateAllTooltips();
         }
         return false;
      }
      
      public function get priority() : int
      {
         return Priority.HIGHEST;
      }
      
      public function update() : void
      {
         this.removeAllTooltips();
         this.updateEntities();
         this.updateAllTooltipsAfterRender();
      }
      
      private function movementHandler(actorId:Number) : void
      {
         var de:DisplayedEntity = null;
         var movedEntity:IEntity = DofusEntities.getEntity(actorId);
         if(!movedEntity)
         {
            _log.warn("The entity " + actorId + " not found.");
         }
         else
         {
            de = this.getEntity(movedEntity.id);
            if(de)
            {
               this._movableEntities.push(this._playersNames.indexOf(de));
            }
         }
         this.addListener();
      }
      
      private function entityMovementCompleteHandler(entity:IEntity) : void
      {
         var startIndex:int = 0;
         var de:DisplayedEntity = this.getEntity(entity.id);
         var index:int = this._playersNames.indexOf(de);
         if(index != -1)
         {
            startIndex = this._movableEntities.indexOf(index);
            this._movableEntities.splice(startIndex,1);
            de.target = this.getBounds(entity.id);
            this.updateDisplayedEntityPosition(de);
         }
      }
      
      private function gameRolePlayShowActorHandler(grpsamsg:Object) : void
      {
         var option:* = undefined;
         var infos:GameRolePlayCharacterInformations = grpsamsg.informations as GameRolePlayCharacterInformations;
         if(infos == null)
         {
            return;
         }
         var entityId:Number = infos.contextualId;
         var de:DisplayedEntity = this.getEntity(entityId);
         var allianceTag:* = "";
         for each(option in infos.humanoidInfo.options)
         {
            if(option is HumanOptionAlliance)
            {
               allianceTag = "[" + option.allianceInformation.allianceTag + "]";
            }
         }
         if(de)
         {
            if(allianceTag != de.allianceName)
            {
               this.removeElementHandler(entityId);
               de = null;
            }
            else
            {
               de.visible = false;
               (DofusEntities.getEntity(entityId) as AnimatedCharacter).addEventListener(TiphonEvent.RENDER_SUCCEED,this.onAnimationEnd);
            }
         }
         if(!de)
         {
            this.addEntity(entityId,infos.name,allianceTag);
         }
      }
      
      private function gameRolePlayShowMultipleActorsHandler(grpsmamsg:Object) : void
      {
         var actorInformation:GameRolePlayActorInformations = null;
         for each(actorInformation in grpsmamsg.informationsList)
         {
            this.gameRolePlayShowActorHandler({"informations":actorInformation});
         }
      }
      
      private function removeElementHandler(entityId:Number) : void
      {
         var nameIndex:int = 0;
         var mvtIndex:int = 0;
         var entity:DisplayedEntity = this.getEntity(entityId);
         if(entity != null)
         {
            nameIndex = this._playersNames.indexOf(entity);
            if(nameIndex != -1)
            {
               mvtIndex = this._movableEntities.indexOf(nameIndex);
               if(mvtIndex != -1)
               {
                  this._movableEntities.splice(mvtIndex,1);
               }
               this._playersNames.splice(nameIndex,1);
               if(this._labelContainer.contains(entity.text))
               {
                  this._labelContainer.removeChild(entity.text);
               }
               entity.text.removeEventListener(MouseEvent.CLICK,this.onTooltipClicked);
               entity.clear();
               entity = null;
            }
         }
      }
      
      private function mouseOverHandler(identityId:Number) : void
      {
         var identity:DisplayedEntity = this.getEntity(identityId);
         if(identity != null)
         {
            identity.visible = false;
         }
      }
      
      private function mouseOutHandler(identityId:Number) : void
      {
         var identity:DisplayedEntity = this.getEntity(identityId);
         if(identity != null)
         {
            identity.visible = true;
         }
      }
      
      private function onAnimationEnd(pEvt:TiphonEvent) : void
      {
         var de:DisplayedEntity = null;
         var e:AnimatedCharacter = pEvt.currentTarget as AnimatedCharacter;
         if(e.hasEventListener(TiphonEvent.ANIMATION_END))
         {
            e.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
         }
         if(e.hasEventListener(TiphonEvent.RENDER_SUCCEED))
         {
            e.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onAnimationEnd);
         }
         if(StealthBones.getStealthBonesById((pEvt.currentTarget as TiphonSprite).look.getBone()))
         {
            this.removeElementHandler(e.id);
         }
         else
         {
            de = this.getEntity(e.id);
            if(de)
            {
               de.visible = true;
               de.target = this.getBounds(e.id);
               this.updateDisplayedEntityPosition(de);
            }
         }
      }
      
      private function updateEntities() : void
      {
         var entityId:Number = NaN;
         var entityInfo:GameRolePlayCharacterInformations = null;
         var allianceTag:* = null;
         var option:* = undefined;
         if(this._roleplayEntitiesFrame == null)
         {
            this._roleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         }
         var ids:Array = this._roleplayEntitiesFrame.playersId;
         for each(entityId in ids)
         {
            entityInfo = this._roleplayEntitiesFrame.getEntityInfos(entityId) as GameRolePlayCharacterInformations;
            if(entityInfo != null)
            {
               allianceTag = "";
               for each(option in entityInfo.humanoidInfo.options)
               {
                  if(option is HumanOptionAlliance)
                  {
                     allianceTag = "[" + option.allianceInformation.allianceTag + "]";
                  }
               }
               this.addEntity(entityId,entityInfo.name,allianceTag);
            }
            else
            {
               _log.warn("Entity info for " + entityId + " not found");
            }
         }
      }
      
      private function removeAllTooltips() : void
      {
         var de:DisplayedEntity = null;
         var i:int = 0;
         var ac:AnimatedCharacter = null;
         while(this._playersNames.length)
         {
            de = this._playersNames.pop();
            if(de != null)
            {
               if(this._labelContainer.contains(de.text))
               {
                  this._labelContainer.removeChild(de.text);
               }
               ac = DofusEntities.getEntity(de.entityId) as AnimatedCharacter;
               if(ac)
               {
                  ac.removeEventListener(TiphonEvent.RENDER_FAILED,this.onUpdateEntityFail);
                  ac.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onUpdateEntitySuccess);
               }
               de.clear();
               de = null;
            }
         }
      }
      
      private function getEntity(id:Number) : DisplayedEntity
      {
         var i:int = 0;
         var len:int = this._playersNames.length;
         for(i = 0; i < len; i++)
         {
            if(this._playersNames[i].entityId == id)
            {
               return this._playersNames[i];
            }
         }
         _log.warn("DisplayedEntity " + id + " not found");
         return null;
      }
      
      private function getEntityFromLabel(lbl:Label) : DisplayedEntity
      {
         var i:int = 0;
         var len:int = this._playersNames.length;
         for(i = 0; i < len; i++)
         {
            if(this._playersNames[i].text == lbl)
            {
               return this._playersNames[i];
            }
         }
         _log.warn("DisplayedEntity not found");
         return null;
      }
      
      private function updateDisplayedEntityPosition(de:DisplayedEntity) : void
      {
         if(de == null)
         {
            return;
         }
         if(de.target == null || de.target.width == 0 || de.target.height == 0)
         {
            this._waitList.push(de.entityId);
            if(!EnterFrameDispatcher.hasEventListener(this.waitForEntity))
            {
               EnterFrameDispatcher.addEventListener(this.waitForEntity,EnterFrameConst.WAIT_FOR_ENTITY,5);
            }
         }
         else
         {
            de.text.x = de.target.x + (de.target.width > de.text.textWidth ? (de.target.width - de.text.textWidth) / 2 : (de.text.textWidth - de.target.width) / 2 * -1);
            de.text.y = de.target.y - 30;
            if(de.text.y < 0)
            {
               de.text.y = 2;
            }
         }
      }
      
      private function addEntity(entityId:Number, pName:String, aTag:String = "") : void
      {
         var lbl:Label = null;
         var ts:TiphonSprite = null;
         var de:DisplayedEntity = null;
         var e:IEntity = null;
         var startIndex:int = 0;
         if(this.getEntity(entityId) == null)
         {
            lbl = new Label();
            lbl.css = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "css/normal2.css");
            if(aTag != "")
            {
               lbl.text = pName + " " + aTag;
            }
            else
            {
               lbl.text = pName;
            }
            lbl.mouseEnabled = true;
            lbl.bgMargin = 2;
            lbl.bgColor = XmlConfig.getInstance().getEntry("colors.tooltip.bg");
            lbl.bgAlpha = XmlConfig.getInstance().getEntry("colors.tooltip.bg.alpha");
            lbl.width = lbl.textWidth + 7;
            lbl.height += 4;
            lbl.buttonMode = true;
            lbl.addEventListener(MouseEvent.CLICK,this.onTooltipClicked);
            if(entityId == PlayedCharacterApi.getInstance().id())
            {
               lbl.colorText = XmlConfig.getInstance().getEntry("colors.tooltip.text.orange");
            }
            ts = DofusEntities.getEntity(entityId) as TiphonSprite;
            if(ts == null)
            {
               de = new DisplayedEntity(entityId,lbl);
            }
            else
            {
               de = new DisplayedEntity(entityId,lbl,this.getBounds(entityId),aTag);
               if(StealthBones.getStealthBonesById(ts.look.getBone()))
               {
                  return;
               }
               this._labelContainer.addChild(lbl);
            }
            this.updateDisplayedEntityPosition(de);
            this._playersNames.push(de);
            e = DofusEntities.getEntity(entityId);
            if(e is IMovable)
            {
               if(IMovable(e).isMoving)
               {
                  this._movableEntities.push(this._playersNames.indexOf(de));
               }
               else
               {
                  startIndex = this._movableEntities.indexOf(this._playersNames.indexOf(de));
                  if(startIndex != -1)
                  {
                     this._movableEntities.splice(startIndex,1);
                  }
               }
            }
         }
      }
      
      public function updateAllTooltips() : void
      {
         var ent:DisplayedEntity = null;
         for each(ent in this._playersNames)
         {
            ent.target = this.getBounds(ent.entityId);
            this.updateDisplayedEntityPosition(ent);
         }
      }
      
      private function updateAllTooltipsAfterRender() : void
      {
         var ent:DisplayedEntity = null;
         var ac:AnimatedCharacter = null;
         for each(ent in this._playersNames)
         {
            ac = DofusEntities.getEntity(ent.entityId) as AnimatedCharacter;
            ac.addEventListener(TiphonEvent.RENDER_FAILED,this.onUpdateEntityFail,false,0,true);
            ac.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onUpdateEntitySuccess,false,0,true);
         }
      }
      
      private function onUpdateEntitySuccess(pEvt:TiphonEvent) : void
      {
         pEvt.sprite.removeEventListener(TiphonEvent.RENDER_FAILED,this.onUpdateEntityFail);
         pEvt.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onUpdateEntitySuccess);
         var ent:DisplayedEntity = this.getEntity(pEvt.target.id);
         ent.target = this.getBounds(ent.entityId);
         this.updateDisplayedEntityPosition(ent);
      }
      
      private function onUpdateEntityFail(pEvt:TiphonEvent) : void
      {
         pEvt.sprite.removeEventListener(TiphonEvent.RENDER_FAILED,this.onUpdateEntityFail);
         pEvt.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onUpdateEntitySuccess);
      }
      
      private function onTooltipClicked(pEvt:MouseEvent) : void
      {
         var entity:DisplayedEntity = null;
         var entityInfo:GameContextActorInformations = null;
         if(!PlayedCharacterManager.getInstance().isFighting)
         {
            entity = this.getEntityFromLabel(pEvt.currentTarget as Label);
            entityInfo = this._roleplayEntitiesFrame.getEntityInfos(entity.entityId);
            if(entityInfo)
            {
               RoleplayManager.getInstance().displayCharacterContextualMenu(entityInfo);
            }
         }
      }
      
      private function updateTextsPosition(pEvt:Event) : void
      {
         var i:int = 0;
         var len:int = 0;
         var de:DisplayedEntity = null;
         var entityId:Number = NaN;
         if(!this.removeListener())
         {
            len = this._movableEntities.length;
            for(i = 0; i < len; i += 1)
            {
               if(!(i >= this._movableEntities.length || this._movableEntities[i] >= this._playersNames.length || this._playersNames[this._movableEntities[i]] == null))
               {
                  entityId = this._playersNames[this._movableEntities[i]].entityId;
                  de = this.getEntity(entityId);
                  if(de)
                  {
                     de.target = this.getBounds(entityId);
                     this.updateDisplayedEntityPosition(de);
                  }
               }
            }
         }
      }
      
      private function addListener() : Boolean
      {
         if(this._movableEntities.length > 0 && !EnterFrameDispatcher.hasEventListener(this.updateTextsPosition))
         {
            EnterFrameDispatcher.addEventListener(this.updateTextsPosition,EnterFrameConst.INFOS_ENTITIES,25);
            return true;
         }
         return false;
      }
      
      private function removeListener() : Boolean
      {
         if(this._movableEntities.length <= 0 && EnterFrameDispatcher.hasEventListener(this.updateTextsPosition))
         {
            EnterFrameDispatcher.removeEventListener(this.updateTextsPosition);
            return true;
         }
         return false;
      }
      
      private function waitForEntity(pEvt:Event) : void
      {
         var entityId:Number = NaN;
         var entity:DisplayedEntity = null;
         var ts:TiphonSprite = null;
         var t:DisplayObject = null;
         for each(entityId in this._waitList)
         {
            entity = this.getEntity(entityId);
            if(entity != null && DofusEntities.getEntity(entityId) != null)
            {
               ts = DofusEntities.getEntity(entityId) as TiphonSprite;
               t = ts.getSlot("Tete");
               entity.target = this.getBounds(entityId);
               if(ts && entity.target.width != 0 && entity.target.height != 0)
               {
                  this._waitList.splice(this._waitList.indexOf(entityId),1);
                  if(StealthBones.getStealthBonesById(ts.look.getBone()))
                  {
                     return;
                  }
                  if(!this._labelContainer.contains(entity.text))
                  {
                     this._labelContainer.addChild(entity.text);
                  }
                  this.updateDisplayedEntityPosition(entity);
               }
            }
         }
         if(this._waitList.length <= 0)
         {
            EnterFrameDispatcher.removeEventListener(this.waitForEntity);
         }
      }
      
      private function getBounds(entityId:Number) : IRectangle
      {
         var targetBounds:IRectangle = null;
         var r1:Rectangle = null;
         var r2:Rectangle2 = null;
         var foot:DisplayObject = null;
         var rider:TiphonSprite = null;
         var ts:TiphonSprite = DofusEntities.getEntity(entityId) as TiphonSprite;
         if(ts == null)
         {
            return null;
         }
         var head:DisplayObject = ts.getSlot("Tete");
         if(head)
         {
            r1 = head.getBounds(StageShareManager.stage);
            r2 = new Rectangle2(r1.x,r1.y,r1.width,r1.height);
            targetBounds = r2;
            if(targetBounds.y <= targetBounds.height)
            {
               foot = ts.getSlot("Pied");
               if(!foot)
               {
                  rider = ts.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
                  if(rider)
                  {
                     foot = rider.getSlot("Pied");
                  }
               }
               if(foot)
               {
                  r1 = foot.getBounds(StageShareManager.stage);
                  r2 = new Rectangle2(r1.x,r1.y + targetBounds.height + 30,r1.width,r1.height);
                  targetBounds = r2;
               }
            }
         }
         if(!targetBounds)
         {
            targetBounds = (ts as IDisplayable).absoluteBounds;
            if(targetBounds.y <= targetBounds.height)
            {
               targetBounds.y += targetBounds.height + 30;
            }
         }
         return targetBounds;
      }
   }
}

import com.ankamagames.berilia.components.Label;
import com.ankamagames.jerakine.interfaces.IRectangle;

class DisplayedEntity
{
    
   
   public var entityId:Number;
   
   public var text:Label;
   
   public var target:IRectangle;
   
   public var allianceName:String;
   
   function DisplayedEntity(pId:Number = 0, pText:Label = null, pTarget:IRectangle = null, pAllianceName:String = "")
   {
      super();
      this.entityId = pId;
      this.text = pText;
      this.target = pTarget;
      this.allianceName = pAllianceName;
   }
   
   public function clear() : void
   {
      this.text.remove();
      this.text = null;
      this.target = null;
   }
   
   public function set visible(val:Boolean) : void
   {
      this.text.visible = val;
   }
}
