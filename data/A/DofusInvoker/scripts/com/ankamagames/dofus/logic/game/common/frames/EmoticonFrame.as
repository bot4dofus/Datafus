package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.DetailedStat;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStat;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.AccountManager;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.roleplay.actions.EmotePlayRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayMovementFrame;
   import com.ankamagames.dofus.logic.game.roleplay.messages.GameRolePlaySetAnimationMessage;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.messages.game.character.stats.LifePointsRegenBeginMessage;
   import com.ankamagames.dofus.network.messages.game.character.stats.LifePointsRegenEndMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmoteAddMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmoteListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayErrorMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayMassiveMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmoteRemoveMessage;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import damageCalculation.tools.StatIds;
   import flash.utils.clearInterval;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setInterval;
   
   public class EmoticonFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EmoticonFrame));
       
      
      private var _emotes:Array;
      
      private var _emotesList:Array;
      
      private var _interval:Number;
      
      private var _hpRegenStartTime:Number = 0;
      
      private var _hpRegenRate:uint = 0;
      
      private var _hpRegenStartValue:Number = 0;
      
      private var _isHpRegen:Boolean = false;
      
      private var _bEmoteOn:Boolean = false;
      
      public function EmoticonFrame()
      {
         super();
      }
      
      public function get isHpRegen() : Boolean
      {
         return this._isHpRegen;
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get emotes() : Array
      {
         this._emotes.sort(Array.NUMERIC);
         return this._emotes;
      }
      
      public function get emotesList() : Array
      {
         this._emotesList.sortOn("order",Array.NUMERIC);
         return this._emotesList;
      }
      
      private function get socialFrame() : SocialFrame
      {
         return Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
      }
      
      private function get roleplayEntitiesFrame() : RoleplayEntitiesFrame
      {
         return Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
      }
      
      private function get roleplayMovementFrame() : RoleplayMovementFrame
      {
         return Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
      }
      
      public function pushed() : Boolean
      {
         this._emotes = [];
         this._emotesList = [];
         return true;
      }
      
      public function isKnownEmote(id:int) : Boolean
      {
         return this._emotes.indexOf(id) != -1;
      }
      
      public function process(msg:Message) : Boolean
      {
         var shortcut:ShortcutWrapper = null;
         var stats:EntityStats = null;
         var elmsg:EmoteListMessage = null;
         var pos:uint = 0;
         var eamsg:EmoteAddMessage = null;
         var ew:EmoteWrapper = null;
         var em:Emoticon = null;
         var emoteWAdd:EmoteWrapper = null;
         var addText:String = null;
         var ermsg:EmoteRemoveMessage = null;
         var removeText:String = null;
         var epra:EmotePlayRequestAction = null;
         var emoteObj:Emoticon = null;
         var emote:EmoteWrapper = null;
         var eprmsg:EmotePlayRequestMessage = null;
         var playerEntity:IEntity = null;
         var epmsg:EmotePlayMessage = null;
         var entityInfo:GameContextActorInformations = null;
         var epmmsg:EmotePlayMassiveMessage = null;
         var errorText:String = null;
         var lprbmsg:LifePointsRegenBeginMessage = null;
         var lpremsg:LifePointsRegenEndMessage = null;
         var id:* = undefined;
         var emoteW:EmoteWrapper = null;
         var i:* = undefined;
         var eamsgNid:uint = 0;
         var ire:int = 0;
         var ire2:int = 0;
         var e:Emoticon = null;
         var anim:String = null;
         var persistancy:Boolean = false;
         var directions8:Boolean = false;
         var spellLevelId:uint = 0;
         var actor:* = undefined;
         var mEntityInfo:GameContextActorInformations = null;
         var emo:Emoticon = null;
         var mAnim:String = null;
         var mPersistancy:Boolean = false;
         var mDirections8:Boolean = false;
         var regenText:String = null;
         switch(true)
         {
            case msg is EmoteListMessage:
               elmsg = msg as EmoteListMessage;
               this._emotes = [];
               this._emotesList.splice(0,this._emotesList.length);
               pos = 0;
               for each(id in elmsg.emoteIds)
               {
                  this._emotes.push(id);
                  emoteW = EmoteWrapper.create(id,pos);
                  this._emotesList.push(emoteW);
                  pos++;
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
               for each(shortcut in InventoryManager.getInstance().shortcutBarItems)
               {
                  if(shortcut && shortcut.type == 4)
                  {
                     shortcut.active = this._emotes.indexOf(shortcut.id) != -1;
                  }
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
               return true;
            case msg is EmoteAddMessage:
               eamsg = msg as EmoteAddMessage;
               for(i in this._emotes)
               {
                  if(this._emotes[i] == eamsg.emoteId)
                  {
                     return true;
                  }
               }
               for each(ew in this._emotesList)
               {
                  if(ew.id == eamsg.emoteId)
                  {
                     return true;
                  }
               }
               em = Emoticon.getEmoticonById(eamsg.emoteId);
               if(!em)
               {
                  return true;
               }
               this._emotes.push(eamsg.emoteId);
               emoteWAdd = EmoteWrapper.create(eamsg.emoteId,this._emotes.length);
               this._emotesList.push(emoteWAdd);
               if(!StoreDataManager.getInstance().getData(Constants.DATASTORE_COMPUTER_OPTIONS,"learnEmote" + eamsg.emoteId))
               {
                  StoreDataManager.getInstance().setData(Constants.DATASTORE_COMPUTER_OPTIONS,"learnEmote" + eamsg.emoteId,true);
                  eamsgNid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.emotes"),I18n.getUiText("ui.common.emoteAdded",[em.name]),NotificationTypeEnum.TUTORIAL,"new_emote_" + eamsg.emoteId);
                  NotificationManager.getInstance().addButtonToNotification(eamsgNid,I18n.getUiText("ui.common.details"),"OpenSmileysAction",[1,true],true,130);
                  NotificationManager.getInstance().sendNotification(eamsgNid);
               }
               addText = I18n.getUiText("ui.common.emoteAdded",[Emoticon.getEmoticonById(eamsg.emoteId).name]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,addText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
               for each(shortcut in InventoryManager.getInstance().shortcutBarItems)
               {
                  if(shortcut && shortcut.type == 4 && shortcut.id == eamsg.emoteId)
                  {
                     shortcut.active = true;
                     KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
                  }
               }
               return true;
               break;
            case msg is EmoteRemoveMessage:
               ermsg = msg as EmoteRemoveMessage;
               for(ire = 0; ire < this._emotes.length; ire++)
               {
                  if(this._emotes[ire] == ermsg.emoteId)
                  {
                     this._emotes[ire] = null;
                     this._emotes.splice(ire,1);
                     break;
                  }
               }
               for(ire2 = 0; ire2 < this._emotesList.length; ire2++)
               {
                  if(this._emotesList[ire2].id == ermsg.emoteId)
                  {
                     this._emotesList[ire2] = null;
                     this._emotesList.splice(ire2,1);
                     break;
                  }
               }
               removeText = I18n.getUiText("ui.common.emoteRemoved",[Emoticon.getEmoticonById(ermsg.emoteId).name]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,removeText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.EmoteListUpdated);
               for each(shortcut in InventoryManager.getInstance().shortcutBarItems)
               {
                  if(shortcut && shortcut.type == 4 && shortcut.id == ermsg.emoteId)
                  {
                     shortcut.active = false;
                     KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
                  }
               }
               return true;
            case msg is EmotePlayRequestAction:
               epra = msg as EmotePlayRequestAction;
               emoteObj = Emoticon.getEmoticonById(epra.emoteId);
               if(!emoteObj || !this.roleplayEntitiesFrame)
               {
                  return true;
               }
               emote = EmoteWrapper.getEmoteWrapperById(emoteObj.id);
               if(!emote || emote && emote.timer > 0)
               {
                  return true;
               }
               if(this.roleplayEntitiesFrame.currentEmoticon != epra.emoteId)
               {
                  EmoteWrapper.getEmoteWrapperById(emoteObj.id).timerToStart = emoteObj.cooldown;
               }
               eprmsg = new EmotePlayRequestMessage();
               eprmsg.initEmotePlayRequestMessage(epra.emoteId);
               playerEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               if(!playerEntity)
               {
                  return true;
               }
               if((playerEntity as IMovable).isMoving)
               {
                  this.roleplayMovementFrame.setFollowingMessage(eprmsg);
                  (playerEntity as IMovable).stop();
               }
               else
               {
                  ConnectionsHandler.getConnection().send(eprmsg);
               }
               return true;
               break;
            case msg is EmotePlayMessage:
               if(Kernel.getWorker().avoidFlood(getQualifiedClassName(msg)))
               {
                  return true;
               }
               epmsg = msg as EmotePlayMessage;
               this._bEmoteOn = true;
               if(this.roleplayEntitiesFrame == null)
               {
                  return true;
               }
               delete this.roleplayEntitiesFrame.lastStaticAnimations[epmsg.actorId];
               entityInfo = this.roleplayEntitiesFrame.getEntityInfos(epmsg.actorId);
               AccountManager.getInstance().setAccountFromId(epmsg.actorId,epmsg.accountId);
               if(entityInfo is GameRolePlayCharacterInformations && this.socialFrame.isIgnored(GameRolePlayCharacterInformations(entityInfo).name,epmsg.accountId))
               {
                  return true;
               }
               if(epmsg.emoteId == 0)
               {
                  this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(entityInfo,AnimationEnum.ANIM_STATIQUE));
               }
               else
               {
                  if(!entityInfo)
                  {
                     return true;
                  }
                  e = Emoticon.getEmoticonById(epmsg.emoteId);
                  if(!e)
                  {
                     _log.error("ERREUR : Le client n\'a pas de données pour l\'emote [" + epmsg.emoteId + "].");
                     return true;
                  }
                  anim = e.getAnimName();
                  persistancy = e.persistancy;
                  directions8 = e.eight_directions;
                  spellLevelId = e.spellLevelId;
                  this.roleplayEntitiesFrame.currentEmoticon = epmsg.emoteId;
                  this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(entityInfo,anim,spellLevelId,epmsg.emoteStartTime,!persistancy,directions8));
               }
               return true;
               break;
            case msg is EmotePlayMassiveMessage:
               epmmsg = msg as EmotePlayMassiveMessage;
               this._bEmoteOn = true;
               if(this.roleplayEntitiesFrame == null)
               {
                  return true;
               }
               for each(actor in epmmsg.actorIds)
               {
                  mEntityInfo = this.roleplayEntitiesFrame.getEntityInfos(actor);
                  if(epmmsg.emoteId == 0)
                  {
                     this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(mEntityInfo,AnimationEnum.ANIM_STATIQUE));
                  }
                  else
                  {
                     emo = Emoticon.getEmoticonById(epmmsg.emoteId);
                     mAnim = emo.getAnimName();
                     mPersistancy = Emoticon.getEmoticonById(epmmsg.emoteId).persistancy;
                     mDirections8 = Emoticon.getEmoticonById(epmmsg.emoteId).eight_directions;
                     this.roleplayEntitiesFrame.currentEmoticon = epmmsg.emoteId;
                     this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(mEntityInfo,mAnim,emo.spellLevelId,epmmsg.emoteStartTime,!mPersistancy,mDirections8));
                  }
               }
               return true;
               break;
            case msg is EmotePlayErrorMessage:
               errorText = I18n.getUiText("ui.common.cantUseEmote");
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,errorText,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is LifePointsRegenBeginMessage:
               lprbmsg = msg as LifePointsRegenBeginMessage;
               this._hpRegenRate = lprbmsg.regenRate * 100;
               this._isHpRegen = true;
               this._hpRegenStartTime = TimeManager.getInstance().getTimestamp();
               this.updateHpStartRegenValue();
               this._interval = setInterval(this.interval,this._hpRegenRate / 2);
               KernelEventsManager.getInstance().processCallback(HookList.LifePointsRegenBegin,null);
               return true;
            case msg is LifePointsRegenEndMessage:
               lpremsg = msg as LifePointsRegenEndMessage;
               this._hpRegenRate = 0;
               this._hpRegenStartTime = 0;
               this._hpRegenStartValue = 0;
               this._isHpRegen = false;
               if(this._bEmoteOn)
               {
                  if(lpremsg.lifePointsGained != 0)
                  {
                     regenText = I18n.getUiText("ui.common.emoteRestoreLife",[lpremsg.lifePointsGained]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,regenText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
                  this._bEmoteOn = false;
               }
               clearInterval(this._interval);
               this._interval = 0;
               stats = StatsManager.getInstance().getStats(PlayedCharacterManager.getInstance().id);
               if(stats !== null)
               {
                  stats.setStat(new EntityStat(StatIds.CUR_LIFE,lpremsg.lifePoints - lpremsg.maxLifePoints - stats.getStatTotalValue(StatIds.CUR_PERMANENT_DAMAGE)));
                  stats.setStat(new EntityStat(StatIds.MAX_LIFE,lpremsg.maxLifePoints));
                  KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function updateHpStartRegenValue(curLife:Number = NaN) : void
      {
         var currentLostHp:EntityStat = null;
         var currentLostHpDetailed:DetailedStat = null;
         if(!isNaN(curLife))
         {
            this._hpRegenStartValue = curLife;
            return;
         }
         var stats:EntityStats = StatsManager.getInstance().getStats(PlayedCharacterManager.getInstance().id);
         if(stats !== null)
         {
            currentLostHp = stats.getStat(StatIds.CUR_LIFE) as EntityStat;
            if(currentLostHp is DetailedStat)
            {
               currentLostHpDetailed = currentLostHp as DetailedStat;
               this._hpRegenStartValue = currentLostHpDetailed.baseValue;
            }
            else if(currentLostHp is EntityStat)
            {
               this._hpRegenStartValue = currentLostHp.totalValue;
            }
         }
         else
         {
            this._hpRegenStartValue = 0;
         }
      }
      
      public function pulled() : Boolean
      {
         if(this._interval)
         {
            clearInterval(this._interval);
         }
         return true;
      }
      
      public function interval() : void
      {
         var playedCharacterManager:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if(playedCharacterManager === null)
         {
            return;
         }
         var stats:EntityStats = StatsManager.getInstance().getStats(playedCharacterManager.id);
         if(stats === null)
         {
            return;
         }
         var currentLostHp:EntityStat = stats.getStat(StatIds.CUR_LIFE) as EntityStat;
         var currentLostHpDetailed:DetailedStat = null;
         if(currentLostHp === null)
         {
            currentLostHp = new EntityStat(StatIds.CUR_LIFE,0);
         }
         if(currentLostHp.totalValue === 0)
         {
            return;
         }
         var regenDelta:Number = this.getRegenDelta();
         if(regenDelta === 0)
         {
            return;
         }
         if(currentLostHp is DetailedStat)
         {
            currentLostHpDetailed = currentLostHp as DetailedStat;
            stats.setStat(new DetailedStat(currentLostHpDetailed.id,this._hpRegenStartValue + regenDelta,currentLostHpDetailed.additionalValue,currentLostHpDetailed.objectsAndMountBonusValue,currentLostHpDetailed.alignGiftBonusValue,currentLostHpDetailed.contextModifValue));
         }
         else if(currentLostHp is EntityStat)
         {
            stats.setStat(new EntityStat(currentLostHp.id,this._hpRegenStartValue + regenDelta));
         }
         KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList,true);
      }
      
      public function getRegenDelta() : Number
      {
         if(this._hpRegenRate === 0 || this._hpRegenStartTime === 0 || this._hpRegenStartValue === 0)
         {
            return 0;
         }
         var stats:EntityStats = StatsManager.getInstance().getStats(PlayedCharacterManager.getInstance().id);
         if(stats === null)
         {
            return 0;
         }
         var regenFactor:Number = (TimeManager.getInstance().getTimestamp() - this._hpRegenStartTime) / this._hpRegenRate;
         var regenDelta:Number = regenFactor;
         if(this._hpRegenStartValue + regenDelta > 0)
         {
            regenDelta = -this._hpRegenStartValue;
         }
         return Math.floor(regenDelta);
      }
   }
}
