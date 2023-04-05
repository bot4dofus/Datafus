package com.ankamagames.dofus.internalDatacenter.spells
{
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectsWrapper implements IDataCenter
   {
       
      
      public var effects:Array;
      
      public var spellName:String = "";
      
      public var casterName:String = "";
      
      public var fromBuff:Boolean = false;
      
      public function EffectsWrapper(aeffects:Array, spell:Spell, name:String, buff:Boolean)
      {
         super();
         this.effects = aeffects;
         this.spellName = spell.name;
         this.casterName = name;
         this.fromBuff = buff;
      }
   }
}
