package com.ankamagames.dofus.logic.game.roleplay.managers
{
   import avmplus.getQualifiedClassName;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.berilia.factories.MenusFactory;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatSmileyRequestAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.misc.SpellCastSequence;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastSequenceContext;
   import com.ankamagames.dofus.logic.game.roleplay.actions.EmotePlayRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.types.GameContextPaddockItemInformations;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMountInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPortalInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
   import com.ankamagames.dofus.scripts.SpellScriptContext;
   import com.ankamagames.dofus.scripts.SpellScriptManager;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   
   public class RoleplayManager implements IDestroyable
   {
      
      private static var _self:RoleplayManager;
      
      private static const REWARD_SCALE_CAP:Number = 1.5;
      
      private static const REWARD_REDUCED_SCALE:Number = 0.7;
       
      
      protected var _log:Logger;
      
      private var _timer:BenchmarkTimer;
      
      public var dofusTimeYearLag:int;
      
      public function RoleplayManager()
      {
         this._log = Log.getLogger(getQualifiedClassName(RoleplayManager));
         super();
         if(_self != null)
         {
            throw new SingletonError("RoleplayManager is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : RoleplayManager
      {
         if(_self == null)
         {
            _self = new RoleplayManager();
         }
         return _self;
      }
      
      public function destroy() : void
      {
         if(this._timer)
         {
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this._timer = null;
         }
         _self = null;
      }
      
      public function displayCharacterContextualMenu(pGameContextActorInformations:GameContextActorInformations) : Boolean
      {
         var modContextMenu:Object = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
         var menu:ContextMenuData = MenusFactory.create(pGameContextActorInformations,null,[{"id":pGameContextActorInformations.contextualId}]);
         if(menu)
         {
            modContextMenu.createContextMenu(menu);
            return true;
         }
         return false;
      }
      
      public function displayContextualMenu(pGameContextActorInformations:GameContextActorInformations, pEntity:IInteractive) : Boolean
      {
         var menu:ContextMenuData = null;
         var modContextMenu:Object = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
         switch(true)
         {
            case pGameContextActorInformations is GameRolePlayMutantInformations:
               if((pGameContextActorInformations as GameRolePlayMutantInformations).humanoidInfo.restrictions.cantAttack)
               {
                  menu = MenusFactory.create(pGameContextActorInformations,null,[pEntity]);
               }
               break;
            case pGameContextActorInformations is GameRolePlayCharacterInformations:
               menu = MenusFactory.create(pGameContextActorInformations,null,[pEntity]);
               break;
            case pGameContextActorInformations is GameRolePlayNpcInformations:
               menu = MenusFactory.create(pGameContextActorInformations,null,{
                  "entity":pEntity,
                  "rightClick":false
               });
               break;
            case pGameContextActorInformations is GameRolePlayTaxCollectorInformations:
               menu = MenusFactory.create(pGameContextActorInformations,null,{
                  "entity":pEntity,
                  "rightClick":false
               });
               break;
            case pGameContextActorInformations is GameRolePlayPrismInformations:
               menu = MenusFactory.create(pGameContextActorInformations,null,{
                  "entity":pEntity,
                  "rightClick":false
               });
               break;
            case pGameContextActorInformations is GameRolePlayPortalInformations:
               menu = MenusFactory.create(pGameContextActorInformations,null,{
                  "entity":pEntity,
                  "rightClick":false
               });
               break;
            case pGameContextActorInformations is GameContextPaddockItemInformations:
               menu = MenusFactory.create(pGameContextActorInformations,null,[pEntity]);
               break;
            case pGameContextActorInformations is GameRolePlayMountInformations:
               menu = MenusFactory.create(pGameContextActorInformations,null,[pEntity]);
         }
         if(menu)
         {
            modContextMenu.createContextMenu(menu);
            return true;
         }
         return false;
      }
      
      public function putEntityOnTop(entity:AnimatedCharacter) : void
      {
         var cellSprite:Sprite = InteractiveCellManager.getInstance().getCell(entity.position.cellId);
         EntitiesDisplayManager.getInstance().orderEntity(entity,cellSprite);
      }
      
      public function celebrate() : void
      {
         if(!this._timer)
         {
            this._timer = new BenchmarkTimer(500,3,"RoleplayManager._timer");
            this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         }
         this._timer.reset();
         this.dispatchCallback();
      }
      
      public function getKamasReward(kamasScaleWithPlayerLevel:Boolean = true, optimalLevel:int = -1, kamasRatio:Number = 1, duration:Number = 1, pPlayerLevel:int = -1) : Number
      {
         if(pPlayerLevel == -1 && kamasScaleWithPlayerLevel)
         {
            pPlayerLevel = PlayedCharacterManager.getInstance().limitedLevel;
         }
         var lvl:int = !!kamasScaleWithPlayerLevel ? int(pPlayerLevel) : int(optimalLevel);
         return Math.floor((Math.pow(lvl,2) + 20 * lvl - 20) * kamasRatio * duration);
      }
      
      public function getExperienceReward(pPlayerLevel:int, pXpBonus:int, optimalLevel:int = -1, xpRatio:Number = 1.0, duration:Number = 1.0) : int
      {
         var rewardLevel:int = 0;
         var fixeOptimalLevelExperienceReward:Number = NaN;
         var fixeLevelExperienceReward:Number = NaN;
         var reducedOptimalExperienceReward:Number = NaN;
         var reducedExperienceReward:Number = NaN;
         var sumExperienceRewards:int = 0;
         var result:int = 0;
         var xpBonus:Number = 1 + pXpBonus / 100;
         if(pPlayerLevel > ProtocolConstantsEnum.MAX_LEVEL)
         {
            pPlayerLevel = ProtocolConstantsEnum.MAX_LEVEL;
         }
         if(pPlayerLevel > optimalLevel)
         {
            rewardLevel = Math.min(pPlayerLevel,optimalLevel * REWARD_SCALE_CAP);
            fixeOptimalLevelExperienceReward = this.getFixeExperienceReward(optimalLevel,duration,xpRatio);
            fixeLevelExperienceReward = this.getFixeExperienceReward(rewardLevel,duration,xpRatio);
            reducedOptimalExperienceReward = (1 - REWARD_REDUCED_SCALE) * fixeOptimalLevelExperienceReward;
            reducedExperienceReward = REWARD_REDUCED_SCALE * fixeLevelExperienceReward;
            sumExperienceRewards = Math.floor(reducedOptimalExperienceReward + reducedExperienceReward);
            return int(Math.floor(sumExperienceRewards * xpBonus));
         }
         return Math.floor(this.getFixeExperienceReward(pPlayerLevel,duration,xpRatio) * xpBonus);
      }
      
      private function getFixeExperienceReward(level:int, duration:Number, xpRatio:Number) : Number
      {
         var levelPow:int = Math.pow(100 + 2 * level,2);
         return Number(level * levelPow / 20 * duration * xpRatio);
      }
      
      private function dispatchCallback() : void
      {
         this.onTimer(null);
         this._timer.start();
         KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.common.congratulation") + " !",ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
      }
      
      private function onTimer(e:Event) : void
      {
         var csra:ChatSmileyRequestAction = null;
         var emotes:Array = null;
         var rndEmoteId:int = 0;
         var emoteWrapper:EmoteWrapper = null;
         var i:int = 0;
         var epra:EmotePlayRequestAction = null;
         var spellEffects:Array = [1846,1841,1848];
         var cellId:int = Math.floor(Math.random() * 195) + 363;
         var spellIndex:int = Math.floor(Math.random() * spellEffects.length);
         this.playSpellAnimation(spellEffects[spellIndex],5,cellId);
         if(this._timer.currentCount == this._timer.repeatCount || this._timer.running == false)
         {
            csra = ChatSmileyRequestAction.create(5);
            Kernel.getWorker().process(csra);
            emotes = [27,88,32,43,42,50];
            for(i = 5; i > 0; )
            {
               rndEmoteId = Math.floor(Math.random() * emotes.length);
               emoteWrapper = EmoteWrapper.getEmoteWrapperById(emotes[rndEmoteId]);
               if(emoteWrapper && emoteWrapper.isUsable)
               {
                  break;
               }
               i--;
            }
            epra = EmotePlayRequestAction.create(emotes[rndEmoteId]);
            Kernel.getWorker().process(epra);
         }
      }
      
      private function playSpellAnimation(spellId:int, spellLevel:int, targetCellId:int) : void
      {
         var context:SpellCastSequenceContext = new SpellCastSequenceContext();
         context.casterId = PlayedCharacterManager.getInstance().id;
         context.spellData = Spell.getSpellById(spellId);
         context.spellLevelData = context.spellData.getSpellLevel(spellLevel);
         context.targetedCellId = targetCellId;
         var castSequence:SpellCastSequence = new SpellCastSequence(context);
         var contexts:Vector.<SpellScriptContext> = SpellScriptManager.getInstance().resolveScriptUsageFromCastContext(context,targetCellId);
         SpellScriptManager.getInstance().runBulk(contexts,castSequence,new Callback(this.executeSpellBuffer,null,true,true,castSequence),new Callback(this.executeSpellBuffer,null,true,false,castSequence));
      }
      
      private function executeSpellBuffer(callback:Function, hadScript:Boolean, scriptSuccess:Boolean = false, castSequence:SpellCastSequence = null) : void
      {
         var step:ISequencable = null;
         var serialSequencer:SerialSequencer = new SerialSequencer();
         for each(step in castSequence.steps)
         {
            serialSequencer.addStep(step);
         }
         serialSequencer.start();
      }
   }
}
