package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SpellState implements IDataCenter
   {
      
      public static const MODULE:String = "SpellStates";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getSpellStateById,getSpellStates);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var preventsSpellCast:Boolean;
      
      public var preventsFight:Boolean;
      
      public var isSilent:Boolean;
      
      public var cantDealDamage:Boolean;
      
      public var invulnerable:Boolean;
      
      public var incurable:Boolean;
      
      public var cantBeMoved:Boolean;
      
      public var cantBePushed:Boolean;
      
      public var cantSwitchPosition:Boolean;
      
      public var effectsIds:Vector.<int>;
      
      public var icon:String = "";
      
      public var iconVisibilityMask:int;
      
      public var invulnerableMelee:Boolean;
      
      public var invulnerableRange:Boolean;
      
      public var cantTackle:Boolean;
      
      public var cantBeTackled:Boolean;
      
      public var displayTurnRemaining:Boolean;
      
      private var _name:String;
      
      public function SpellState()
      {
         super();
      }
      
      public static function getSpellStateById(id:int) : SpellState
      {
         return GameData.getObject(MODULE,id) as SpellState;
      }
      
      public static function getSpellStates() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
