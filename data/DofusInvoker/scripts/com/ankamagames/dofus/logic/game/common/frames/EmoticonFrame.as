package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.DetailedStat;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.internalDatacenter.stats.Stat;
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
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
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
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
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
      
      private var _hpDelta:Number = 0;
      
      private var _bEmoteOn:Boolean = false;
      
      public function EmoticonFrame()
      {
         super();
      }
      
      public function get isHpRegen() : Boolean
      {
         return this._interval !== 0;
      }
      
      public function get hpDelta() : Number
      {
         return this._hpDelta;
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
         this._emotes = new Array();
         this._emotesList = new Array();
         return true;
      }
      
      public function isKnownEmote(id:int) : Boolean
      {
         return this._emotes.indexOf(id) != -1;
      }
      
      public function process(msg:Message) : Boolean
      {
         var shortcut:ShortcutWrapper = null;
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
         var epemsg:EmotePlayErrorMessage = null;
         var errorText:String = null;
         var lprbmsg:LifePointsRegenBeginMessage = null;
         var lpremsg:LifePointsRegenEndMessage = null;
         var stats:EntityStats = null;
         var id:* = undefined;
         var emoteW:EmoteWrapper = null;
         var i:* = undefined;
         var eamsgNid:uint = 0;
         var ire:int = 0;
         var ire2:int = 0;
         var e:Emoticon = null;
         var tiphonLook:TiphonEntityLook = null;
         var riderLook:TiphonEntityLook = null;
         var anim:String = null;
         var persistancy:Boolean = false;
         var directions8:Boolean = false;
         var spellLevelId:uint = 0;
         var actor:* = undefined;
         var mEntityInfo:GameContextActorInformations = null;
         var tiphonMassiveLook:TiphonEntityLook = null;
         var emo:Emoticon = null;
         var mAnim:String = null;
         var mPersistancy:Boolean = false;
         var mDirections8:Boolean = false;
         var regenText:String = null;
         switch(true)
         {
            case msg is EmoteListMessage:
               elmsg = msg as EmoteListMessage;
               this._emotes = new Array();
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
                     if(this._emotes.indexOf(shortcut.id) != -1)
                     {
                        shortcut.active = true;
                     }
                     else
                     {
                        shortcut.active = false;
                     }
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
                  tiphonLook = EntityLookAdapter.fromNetwork(entityInfo.look);
                  riderLook = tiphonLook.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
                  anim = e.getAnimName(!!riderLook ? riderLook : tiphonLook);
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
                     tiphonMassiveLook = EntityLookAdapter.fromNetwork(mEntityInfo.look);
                     emo = Emoticon.getEmoticonById(epmmsg.emoteId);
                     mAnim = emo.getAnimName(TiphonUtility.getLookWithoutMount(tiphonMassiveLook));
                     mPersistancy = Emoticon.getEmoticonById(epmmsg.emoteId).persistancy;
                     mDirections8 = Emoticon.getEmoticonById(epmmsg.emoteId).eight_directions;
                     this.roleplayEntitiesFrame.currentEmoticon = epmmsg.emoteId;
                     this.roleplayEntitiesFrame.process(new GameRolePlaySetAnimationMessage(mEntityInfo,mAnim,emo.spellLevelId,epmmsg.emoteStartTime,!mPersistancy,mDirections8));
                  }
               }
               return true;
               break;
            case msg is EmotePlayErrorMessage:
               epemsg = msg as EmotePlayErrorMessage;
               errorText = I18n.getUiText("ui.common.cantUseEmote");
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,errorText,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is LifePointsRegenBeginMessage:
               lprbmsg = msg as LifePointsRegenBeginMessage;
               this._interval = setInterval(this.interval,lprbmsg.regenRate * 100);
               this._hpDelta = 0;
               KernelEventsManager.getInstance().processCallback(HookList.LifePointsRegenBegin,null);
               return true;
            case msg is LifePointsRegenEndMessage:
               lpremsg = msg as LifePointsRegenEndMessage;
               this._hpDelta = 0;
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
                  stats.setStat(new Stat(StatIds.CUR_LIFE,lpremsg.lifePoints - lpremsg.maxLifePoints - stats.getStatTotalValue(StatIds.CUR_PERMANENT_DAMAGE)));
                  stats.setStat(new Stat(StatIds.MAX_LIFE,lpremsg.maxLifePoints));
                  KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
               }
               return true;
            default:
               return false;
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
         var stats:EntityStats = null;
         var currentLostHP:Stat = null;
         var currentLostHPDetailed:DetailedStat = null;
         var playedCharacterManager:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if(stats !== null)
         {
            stats = StatsManager.getInstance().getStats(playedCharacterManager.id);
            if(stats !== null)
            {
               currentLostHP = stats.getStat(StatIds.CUR_LIFE);
               currentLostHPDetailed = null;
               if(currentLostHP === null)
               {
                  currentLostHP = new Stat(StatIds.CUR_LIFE,0);
               }
               ++this._hpDelta;
               if(currentLostHP.totalValue + 1 > 0)
               {
                  clearInterval(this._interval);
                  this._hpDelta = 0;
                  if(currentLostHP is Stat)
                  {
                     stats.setStat(new Stat(currentLostHP.id,0));
                  }
                  else if(currentLostHP is DetailedStat)
                  {
                     currentLostHPDetailed = currentLostHP as DetailedStat;
                     stats.setStat(new DetailedStat(currentLostHPDetailed.id,0,currentLostHPDetailed.additionalValue,currentLostHPDetailed.objectsAndMountBonusValue,currentLostHPDetailed.alignGiftBonusValue,currentLostHPDetailed.contextModifValue));
                  }
               }
               else if(currentLostHP is Stat)
               {
                  stats.setStat(new Stat(currentLostHP.id,currentLostHP.totalValue + 1));
               }
               else if(currentLostHP is DetailedStat)
               {
                  currentLostHPDetailed = currentLostHP as DetailedStat;
                  stats.setStat(new DetailedStat(currentLostHPDetailed.id,currentLostHPDetailed.baseValue + 1,currentLostHPDetailed.additionalValue,currentLostHPDetailed.objectsAndMountBonusValue,currentLostHPDetailed.alignGiftBonusValue,currentLostHPDetailed.contextModifValue));
               }
               KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList,true);
            }
         }
      }
   }
}
