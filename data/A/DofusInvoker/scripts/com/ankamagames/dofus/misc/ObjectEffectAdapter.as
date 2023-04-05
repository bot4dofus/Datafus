package com.ankamagames.dofus.misc
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceCreature;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDate;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDuration;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceLadder;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMinMax;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMount;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceString;
   import com.ankamagames.dofus.datacenter.items.IncarnationLevel;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectCreature;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectDate;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectDice;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectDuration;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectInteger;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectLadder;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectMinMax;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectMount;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectString;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class ObjectEffectAdapter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ObjectEffectAdapter));
       
      
      public function ObjectEffectAdapter()
      {
         super();
      }
      
      public static function fromNetwork(oe:ObjectEffect) : EffectInstance
      {
         var effect:EffectInstance = null;
         var level:int = 0;
         var floor:int = 0;
         var nextFloor:int = 0;
         var incLevel:IncarnationLevel = null;
         var incLevelPlusOne:IncarnationLevel = null;
         var serverEffect:ObjectEffectInteger = null;
         var clientEffects:Vector.<EffectInstanceInteger> = null;
         var intEffect:EffectInstanceInteger = null;
         if(oe is ObjectEffectDice && oe.actionId == ActionIds.ACTION_INCARNATION)
         {
            effect = new EffectInstanceDate();
            EffectInstanceDate(effect).year = ObjectEffectDice(oe).diceNum;
            EffectInstanceDate(effect).month = ObjectEffectDice(oe).diceSide * 32768 + ObjectEffectDice(oe).diceConst;
            level = 1;
            do
            {
               incLevel = IncarnationLevel.getIncarnationLevelByIdAndLevel(ObjectEffectDice(oe).diceNum,level);
               if(incLevel)
               {
                  floor = incLevel.requiredXp;
               }
               level++;
               incLevelPlusOne = IncarnationLevel.getIncarnationLevelByIdAndLevel(ObjectEffectDice(oe).diceNum,level);
               if(incLevelPlusOne)
               {
                  nextFloor = incLevelPlusOne.requiredXp;
               }
            }
            while(nextFloor < EffectInstanceDate(effect).month && level < 51);
            
            level--;
            EffectInstanceDate(effect).day = level;
            EffectInstanceDate(effect).hour = 0;
            EffectInstanceDate(effect).minute = 0;
         }
         else
         {
            switch(true)
            {
               case oe is ObjectEffectString:
                  effect = new EffectInstanceString();
                  EffectInstanceString(effect).text = ObjectEffectString(oe).value;
                  break;
               case oe is ObjectEffectInteger:
                  effect = new EffectInstanceInteger();
                  EffectInstanceInteger(effect).value = ObjectEffectInteger(oe).value;
                  break;
               case oe is ObjectEffectMinMax:
                  effect = new EffectInstanceMinMax();
                  EffectInstanceMinMax(effect).min = ObjectEffectMinMax(oe).min;
                  EffectInstanceMinMax(effect).max = ObjectEffectMinMax(oe).max;
                  break;
               case oe is ObjectEffectDice:
                  effect = new EffectInstanceDice();
                  EffectInstanceDice(effect).diceNum = ObjectEffectDice(oe).diceNum;
                  EffectInstanceDice(effect).diceSide = ObjectEffectDice(oe).diceSide;
                  EffectInstanceDice(effect).value = ObjectEffectDice(oe).diceConst;
                  break;
               case oe is ObjectEffectDate:
                  effect = new EffectInstanceDate();
                  EffectInstanceDate(effect).year = ObjectEffectDate(oe).year;
                  EffectInstanceDate(effect).month = ObjectEffectDate(oe).month + 1;
                  EffectInstanceDate(effect).day = ObjectEffectDate(oe).day;
                  EffectInstanceDate(effect).hour = ObjectEffectDate(oe).hour;
                  EffectInstanceDate(effect).minute = ObjectEffectDate(oe).minute;
                  break;
               case oe is ObjectEffectDuration:
                  effect = new EffectInstanceDuration();
                  EffectInstanceDuration(effect).days = ObjectEffectDuration(oe).days;
                  EffectInstanceDuration(effect).hours = ObjectEffectDuration(oe).hours;
                  EffectInstanceDuration(effect).minutes = ObjectEffectDuration(oe).minutes;
                  break;
               case oe is ObjectEffectLadder:
                  effect = new EffectInstanceLadder();
                  EffectInstanceLadder(effect).monsterFamilyId = ObjectEffectLadder(oe).monsterFamilyId;
                  EffectInstanceLadder(effect).monsterCount = ObjectEffectLadder(oe).monsterCount;
                  break;
               case oe is ObjectEffectCreature:
                  effect = new EffectInstanceCreature();
                  EffectInstanceCreature(effect).monsterFamilyId = ObjectEffectCreature(oe).monsterFamilyId;
                  break;
               case oe is ObjectEffectMount:
                  effect = new EffectInstanceMount();
                  EffectInstanceMount(effect).id = (oe as ObjectEffectMount).id;
                  EffectInstanceMount(effect).expirationDate = (oe as ObjectEffectMount).expirationDate;
                  EffectInstanceMount(effect).model = (oe as ObjectEffectMount).model;
                  EffectInstanceMount(effect).owner = (oe as ObjectEffectMount).owner;
                  EffectInstanceMount(effect).name = (oe as ObjectEffectMount).name;
                  EffectInstanceMount(effect).level = (oe as ObjectEffectMount).level;
                  EffectInstanceMount(effect).sex = (oe as ObjectEffectMount).sex;
                  EffectInstanceMount(effect).isRideable = (oe as ObjectEffectMount).isRideable;
                  EffectInstanceMount(effect).isFecondationReady = (oe as ObjectEffectMount).isFecondationReady;
                  EffectInstanceMount(effect).isFeconded = (oe as ObjectEffectMount).isFeconded;
                  EffectInstanceMount(effect).reproductionCount = (oe as ObjectEffectMount).reproductionCount;
                  EffectInstanceMount(effect).reproductionCountMax = (oe as ObjectEffectMount).reproductionCountMax;
                  clientEffects = new Vector.<EffectInstanceInteger>();
                  for each(serverEffect in (oe as ObjectEffectMount).effects)
                  {
                     intEffect = new EffectInstanceInteger();
                     intEffect.value = serverEffect.value;
                     intEffect.effectId = serverEffect.actionId;
                     intEffect.duration = 0;
                     clientEffects.push(intEffect);
                  }
                  EffectInstanceMount(effect).effects = clientEffects;
                  EffectInstanceMount(effect).capacities = (oe as ObjectEffectMount).capacities;
                  break;
               default:
                  effect = new EffectInstance();
            }
         }
         effect.effectId = oe.actionId;
         effect.duration = 0;
         return effect;
      }
   }
}
