package com.ankamagames.dofus.internalDatacenter.spells
{
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.logic.game.fight.types.StateBuff;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectsListWrapper implements IDataCenter
   {
      
      public static const CATEGORY_ACTIVE_BONUS:int = 0;
      
      public static const CATEGORY_ACTIVE_MALUS:int = 1;
      
      public static const CATEGORY_PASSIVE_BONUS:int = 2;
      
      public static const CATEGORY_PASSIVE_MALUS:int = 3;
      
      public static const CATEGORY_TRIGGERED:int = 4;
      
      public static const CATEGORY_STATE:int = 5;
      
      public static const CATEGORY_OTHER:int = 6;
       
      
      private var _categories:Array;
      
      public var effects:Vector.<EffectInstance>;
      
      public function EffectsListWrapper(buffs:Array)
      {
         var buff:BasicBuff = null;
         var effect:EffectInstance = null;
         var effectData:Effect = null;
         var category:int = 0;
         super();
         this._categories = new Array();
         for each(buff in buffs)
         {
            effect = buff.effect;
            effectData = Effect.getEffectById(effect.effectId);
            category = !!effect.trigger ? int(CATEGORY_TRIGGERED) : int(this.getCategory(effectData));
            this.addBuff(category,buff);
         }
      }
      
      public function get categories() : Array
      {
         var c:* = null;
         var cat:Array = new Array();
         for(c in this._categories)
         {
            if(this._categories[c].length > 0 && cat[c] == null)
            {
               cat.push(c);
            }
         }
         cat.sort();
         return cat;
      }
      
      public function getBuffs(category:int) : Array
      {
         return this._categories[category];
      }
      
      public function get buffArray() : Array
      {
         return this._categories;
      }
      
      private function addBuff(category:int, buff:BasicBuff) : void
      {
         var b:BasicBuff = null;
         var e:Effect = null;
         if(!this._categories[category])
         {
            this._categories[category] = new Array();
         }
         for each(b in this._categories[category])
         {
            e = Effect.getEffectById(buff.actionId);
            if(e.useDice && b.actionId == buff.actionId && buff.trigger == false && !(buff is StateBuff))
            {
               if(!(buff.effect is EffectInstanceInteger))
               {
                  throw new Error("Tentative de cumulation d\'effets ambigue");
               }
               b.param1 += buff.param1;
               b.param2 += buff.param2;
               b.param3 += buff.param3;
               return;
            }
         }
         b = buff.clone();
         this._categories[category].push(b);
      }
      
      private function getCategory(effect:Effect) : int
      {
         if(effect.characteristic == 71)
         {
            return CATEGORY_STATE;
         }
         if(effect.operator == "-")
         {
            if(effect.active)
            {
               return CATEGORY_ACTIVE_MALUS;
            }
            return CATEGORY_PASSIVE_MALUS;
         }
         if(effect.operator == "+")
         {
            if(effect.active)
            {
               return CATEGORY_ACTIVE_BONUS;
            }
            return CATEGORY_PASSIVE_BONUS;
         }
         return CATEGORY_OTHER;
      }
   }
}
