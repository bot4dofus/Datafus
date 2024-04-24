package com.ankamagames.dofus.scripts
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.spells.BoundScriptUsageData;
   import com.ankamagames.dofus.datacenter.spells.EffectZone;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellScript;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.misc.ISpellCastSequence;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastSequenceContext;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.scripts.spells.*;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.script.ScriptErrorEnum;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.jerakine.types.zones.DisplayZone;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class SpellScriptManager
   {
      
      private static var SPELL_SCRIPT_1:SpellScript1;
      
      private static var SPELL_SCRIPT_2:SpellScript2;
      
      private static var SPELL_SCRIPT_3:SpellScript3;
      
      private static var SPELL_SCRIPT_5:SpellScript5;
      
      private static var SPELL_SCRIPT_6:SpellScript6;
      
      private static var SPELL_SCRIPT_7:SpellScript7;
      
      private static var SPELL_SCRIPT_8:SpellScript8;
      
      private static var FALL_BACK_SPELL_SCRIPT:FallbackSpellScript;
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(SpellScriptManager));
      
      private static var _self:SpellScriptManager;
       
      
      public function SpellScriptManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("SpellScriptManager is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : SpellScriptManager
      {
         if(_self == null)
         {
            _self = new SpellScriptManager();
         }
         return _self;
      }
      
      public function run(context:SpellScriptContext, sequence:ISpellCastSequence, successCallback:Callback = null, errorCallback:Callback = null) : void
      {
         var scriptData:SpellScript = null;
         var caster:IEntity = DofusEntities.getEntity(context.casterId);
         var scriptClass:Class = null;
         try
         {
            scriptData = SpellScript.getSpellScriptById(context.scriptId);
            scriptClass = scriptData !== null ? getDefinitionByName("com.ankamagames.dofus.scripts.spells.SpellScript" + scriptData.typeId) as Class : null;
         }
         catch(error:Error)
         {
            _log.error("Can\'t find class SpellScript" + context);
         }
         if(!scriptClass)
         {
            scriptClass = FallbackSpellScript;
         }
         var scriptRunner:SpellScriptRunner = new SpellScriptRunner(caster,context.scriptId,context.targetedCellId,sequence);
         var returnCode:uint = scriptRunner.run(scriptClass);
         if(returnCode == ScriptErrorEnum.SCRIPT_ERROR)
         {
            errorCallback.exec();
         }
         else
         {
            successCallback.exec();
         }
      }
      
      public function runBulk(contexts:Vector.<SpellScriptContext>, sequence:ISpellCastSequence, successCallback:Callback = null, errorCallback:Callback = null) : void
      {
         var context:SpellScriptContext = null;
         for each(context in contexts)
         {
            this.run(context,sequence,successCallback,errorCallback);
         }
      }
      
      public function resolveScriptUsage(spell:SpellWrapper, isCritical:Boolean, casterId:Number, targetedCellId:int) : Vector.<SpellScriptContext>
      {
         var entitiesFrame:AbstractEntitiesFrame = null;
         var usageData:BoundScriptUsageData = null;
         var weaponContext:SpellScriptContext = null;
         var spellZoneManager:SpellZoneManager = null;
         var isWeapon:* = false;
         var activationZone:DisplayZone = null;
         var targetZone:DisplayZone = null;
         var scriptZone:Custom = null;
         var context:SpellScriptContext = null;
         var targetEffectZone:EffectZone = null;
         var targetEffect:EffectInstance = null;
         var fightEntitiesFrame:FightEntitiesFrame = null;
         var entityId:Number = NaN;
         var cellId:int = 0;
         var entityInfo:GameFightFighterInformations = null;
         if(targetedCellId === -1)
         {
            return new Vector.<SpellScriptContext>();
         }
         var spellData:Spell = spell.spell;
         if(spell.id === 0)
         {
            weaponContext = new SpellScriptContext();
            weaponContext.scriptId = SpellScript.WEAPON_SCRIPT_ID;
            weaponContext.spellId = spell.id;
            weaponContext.casterId = casterId;
            weaponContext.targetedCellId = targetedCellId;
            return new <SpellScriptContext>[weaponContext];
         }
         var allUsageData:Vector.<BoundScriptUsageData> = !!isCritical ? spellData.criticalHitBoundScriptUsageData : spellData.boundScriptUsageData;
         var randomizedUsageData:Vector.<BoundScriptUsageData> = SpellScriptUsageUtils.getRandomizedUsageData(allUsageData);
         if(randomizedUsageData.length == 0)
         {
            return new Vector.<SpellScriptContext>();
         }
         if(PlayedCharacterManager.getInstance().isFighting)
         {
            entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         }
         else
         {
            entitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         }
         var scriptIds:Vector.<SpellScriptContext> = new Vector.<SpellScriptContext>();
         if(!entitiesFrame)
         {
            return scriptIds;
         }
         var entitiesIds:Vector.<Number> = entitiesFrame.getEntitiesIdsList();
         for each(usageData in randomizedUsageData)
         {
            if(SpellScriptUsageUtils.isSpellLevelMatch(spell,usageData.spellLevels))
            {
               if(SpellScriptUsageUtils.isCriterionMatch(usageData.criterion))
               {
                  if(SpellScriptUsageUtils.isCasterMatch(casterId,usageData.casterMask))
                  {
                     spellZoneManager = SpellZoneManager.getInstance();
                     isWeapon = spell.id === 0;
                     activationZone = spellZoneManager.parseZone(usageData.activationZone,casterId,targetedCellId,isWeapon);
                     targetZone = spellZoneManager.parseZone(usageData.targetZone,casterId,targetedCellId,isWeapon);
                     scriptZone = SpellScriptUsageUtils.generateScriptZone(targetZone,activationZone,casterId,targetedCellId,usageData.activationMask,entitiesIds);
                     if(scriptZone.surface !== 0)
                     {
                        if(!usageData.targetMask)
                        {
                           for each(cellId in scriptZone.getCells())
                           {
                              context = new SpellScriptContext();
                              context.scriptId = usageData.scriptId;
                              context.spellId = spell.id;
                              context.casterId = casterId;
                              context.targetedCellId = cellId;
                              scriptIds.push(context);
                           }
                        }
                        else
                        {
                           targetEffectZone = spellZoneManager.getEffectZone(usageData.targetZone);
                           targetEffect = new EffectInstance();
                           targetEffect.targetMask = usageData.targetMask;
                           targetEffect.zoneShape = targetEffectZone.activationZoneShape;
                           targetEffect.zoneSize = targetEffectZone.activationZoneSize;
                           targetEffect.zoneMinSize = targetEffectZone.activationZoneMinSize;
                           targetEffect.zoneStopAtTarget = targetEffectZone.activationZoneStopAtTarget;
                           fightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                           for each(entityId in entitiesIds)
                           {
                              entityInfo = fightEntitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations;
                              if(entityInfo !== null)
                              {
                                 if(SpellScriptUsageUtils.isTargetMatch(scriptZone,casterId,entityInfo,targetEffect))
                                 {
                                    context = new SpellScriptContext();
                                    context.scriptId = usageData.scriptId;
                                    context.spellId = spell.id;
                                    context.casterId = casterId;
                                    context.targetedCellId = entityInfo.disposition.cellId;
                                    scriptIds.push(context);
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return scriptIds;
      }
      
      public function resolveScriptUsageFromCastContext(castSequenceContext:SpellCastSequenceContext, specificTargetedCellId:int = -1) : Vector.<SpellScriptContext>
      {
         var spell:SpellWrapper = SpellWrapper.create(castSequenceContext.spellData.id,castSequenceContext.spellLevelData.grade,false,castSequenceContext.casterId);
         return this.resolveScriptUsage(spell,castSequenceContext.isCriticalHit,castSequenceContext.casterId,specificTargetedCellId != -1 ? int(specificTargetedCellId) : int(castSequenceContext.targetedCellId));
      }
   }
}
