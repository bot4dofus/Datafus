package com.ankamagames.dofus.types.data
{
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class WeaponTooltipInfo extends SpellTooltipInfo
   {
       
      
      public var makerParams:Object;
      
      public var weapon:WeaponWrapper;
      
      public function WeaponTooltipInfo(spellWrapper:SpellWrapper, shortcutKey:String = null, makerParams:Object = null, weapon:WeaponWrapper = null)
      {
         this.weapon = !!weapon ? weapon : PlayedCharacterManager.getInstance().currentWeapon;
         this.makerParams = makerParams;
         super(spellWrapper,shortcutKey);
      }
   }
}
