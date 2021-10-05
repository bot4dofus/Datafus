package damageCalculation.damageManagement
{
   import damageCalculation.DamageCalculator;
   import damageCalculation.FightContext;
   import damageCalculation.fighterManagement.HaxeBuff;
   import damageCalculation.fighterManagement.HaxeFighter;
   import damageCalculation.fighterManagement.PlayerTypeEnum;
   import damageCalculation.spellManagement.HaxeSpell;
   import damageCalculation.spellManagement.HaxeSpellEffect;
   import damageCalculation.spellManagement.RunningEffect;
   import damageCalculation.spellManagement.SpellManager;
   import damageCalculation.tools.LinkedListNode;
   import mapTools.MapTools;
   import mapTools.SpellZone;
   import tools.ActionIdHelper;
   import tools.FpUtils;
   
   public class TargetManagement
   {
      
      public static var DEFAULT_SORT_DIRECTION:int = 7;
       
      
      public function TargetManagement()
      {
      }
      
      public static function getTargets(param1:FightContext, param2:HaxeFighter, param3:HaxeSpell, param4:HaxeSpellEffect, param5:HaxeFighter) : Object
      {
         var _loc7_:* = null as String;
         var _loc8_:* = null as Array;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:* = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:* = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:* = 0;
         var _loc24_:* = 0;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:* = null as SpellZone;
         var fightContext:FightContext = param1;
         var caster:HaxeFighter = param2;
         var effect:HaxeSpellEffect = param4;
         var triggeringFighter:HaxeFighter = param5;
         var _loc6_:Boolean = fightContext.usingPortal();
         var i:int = -1;
         while((i = i + 1) < int(effect.masks.length))
         {
            _loc7_ = effect.masks[i];
            if(_loc7_.charCodeAt(0) != "*".charCodeAt(0))
            {
               break;
            }
            _loc8_ = FpUtils.arrayCopy_String(effect.masks);
            if(!SpellManager.targetPassMaskExclusion(caster,caster,triggeringFighter,fightContext,_loc7_,_loc8_,_loc6_,true))
            {
               return {
                  "targetedFighters":null,
                  "additionalTargets":null,
                  "isUsed":false
               };
            }
         }
         _loc8_ = [];
         if(effect.actionId == 783)
         {
            _loc9_ = caster.getCurrentPositionCell();
            _loc10_ = fightContext.targetedCell;
            _loc11_ = Math.floor(_loc9_ / MapTools.MAP_GRID_WIDTH);
            _loc12_ = Math.floor((_loc11_ + 1) / 2);
            _loc13_ = _loc9_ - _loc11_ * MapTools.MAP_GRID_WIDTH;
            _loc14_ = Math.floor(_loc9_ / MapTools.MAP_GRID_WIDTH);
            _loc15_ = Math.floor((_loc14_ + 1) / 2);
            _loc16_ = _loc14_ - _loc15_;
            _loc17_ = _loc9_ - _loc14_ * MapTools.MAP_GRID_WIDTH;
            _loc18_ = Math.floor(_loc10_ / MapTools.MAP_GRID_WIDTH);
            _loc19_ = Math.floor((_loc18_ + 1) / 2);
            _loc20_ = _loc10_ - _loc18_ * MapTools.MAP_GRID_WIDTH;
            _loc21_ = Math.floor(_loc10_ / MapTools.MAP_GRID_WIDTH);
            _loc22_ = Math.floor((_loc21_ + 1) / 2);
            _loc23_ = _loc21_ - _loc22_;
            _loc24_ = _loc10_ - _loc21_ * MapTools.MAP_GRID_WIDTH;
            _loc25_ = MapTools.getLookDirection8ExactByCoord(_loc12_ + _loc13_,_loc17_ - _loc16_,_loc19_ + _loc20_,_loc24_ - _loc23_);
            _loc26_ = caster.getCurrentPositionCell();
            _loc8_ = fightContext.getFightersUpTo(_loc26_,_loc25_,1,1,1);
         }
         else if(effect.actionId == 1043)
         {
            _loc9_ = caster.getCurrentPositionCell();
            _loc10_ = fightContext.targetedCell;
            _loc11_ = Math.floor(_loc9_ / MapTools.MAP_GRID_WIDTH);
            _loc12_ = Math.floor((_loc11_ + 1) / 2);
            _loc13_ = _loc9_ - _loc11_ * MapTools.MAP_GRID_WIDTH;
            _loc14_ = Math.floor(_loc9_ / MapTools.MAP_GRID_WIDTH);
            _loc15_ = Math.floor((_loc14_ + 1) / 2);
            _loc16_ = _loc14_ - _loc15_;
            _loc17_ = _loc9_ - _loc14_ * MapTools.MAP_GRID_WIDTH;
            _loc18_ = Math.floor(_loc10_ / MapTools.MAP_GRID_WIDTH);
            _loc19_ = Math.floor((_loc18_ + 1) / 2);
            _loc20_ = _loc10_ - _loc18_ * MapTools.MAP_GRID_WIDTH;
            _loc21_ = Math.floor(_loc10_ / MapTools.MAP_GRID_WIDTH);
            _loc22_ = Math.floor((_loc21_ + 1) / 2);
            _loc23_ = _loc21_ - _loc22_;
            _loc24_ = _loc10_ - _loc21_ * MapTools.MAP_GRID_WIDTH;
            _loc25_ = MapTools.getLookDirection8ExactByCoord(_loc12_ + _loc13_,_loc17_ - _loc16_,_loc19_ + _loc20_,_loc24_ - _loc23_);
            _loc26_ = caster.getCurrentPositionCell();
            _loc8_ = fightContext.getFightersUpTo(_loc26_,_loc25_,param3.minimaleRange,param3.maximaleRange,1);
         }
         else if(!!ActionIdHelper.isSummonWithoutTarget(effect.actionId) && effect.zone.shape == "C")
         {
            _loc8_ = [];
         }
         else
         {
            _loc27_ = effect.zone;
            _loc9_ = fightContext.targetedCell;
            _loc10_ = !!_loc6_ ? int(fightContext.map.getOutputPortalCell(fightContext.inputPortalCellId)) : int(caster.getCurrentPositionCell());
            _loc8_ = fightContext.getFightersFromZone(_loc27_,_loc9_,_loc10_);
         }
         var _loc28_:Array = TargetManagement.getOutOfAreaTarget(fightContext,caster,effect,triggeringFighter,_loc8_);
         if(int(_loc28_.length) > 0)
         {
            _loc8_ = _loc8_.concat(_loc28_);
         }
         _loc8_ = FpUtils.arrayFilter_damageCalculation_fighterManagement_HaxeFighter(_loc8_,function(param1:HaxeFighter):Boolean
         {
            var _loc2_:* = null as Array;
            if(!(caster == param1 && effect.actionId == 90))
            {
               _loc2_ = effect.masks.slice(i);
               return Boolean(SpellManager.isSelectedByMask(caster,_loc2_,param1,triggeringFighter,fightContext));
            }
            return true;
         });
         return {
            "targetedFighters":_loc8_,
            "additionalTargets":_loc28_,
            "isUsed":true
         };
      }
      
      public static function forceSelection(param1:HaxeFighter, param2:HaxeSpellEffect, param3:HaxeFighter) : Boolean
      {
         if(param1 == param3)
         {
            return param2.actionId == 90;
         }
         return false;
      }
      
      public static function applyComboBonusToCaster(param1:HaxeFighter, param2:FightContext) : void
      {
         var _loc4_:* = null as LinkedListNode;
         var _loc5_:* = null as LinkedListNode;
         var _loc3_:LinkedListNode = param1._buffs.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_;
            _loc3_ = _loc3_.next;
            _loc5_ = _loc4_;
            if(_loc5_.item.effect.actionId == 1027)
            {
               param1.getSummoner(param2).storePendingBuff(_loc5_.item);
            }
         }
         param1.removeBuffByActionId(1027);
      }
      
      public static function getOutOfAreaTarget(param1:FightContext, param2:HaxeFighter, param3:HaxeSpellEffect, param4:HaxeFighter, param5:Array) : Array
      {
         var _loc6_:Array = param3.masks;
         var _loc7_:Array = [];
         if(int(param5.indexOf(param2)) == -1 && (int(_loc6_.indexOf("C")) != -1 || param3.actionId == 90 || param3.actionId == 4) && param3.actionId != 780)
         {
            _loc7_.push(param2);
         }
         if(int(_loc6_.indexOf("O")) != -1 && param4 != null && int(param5.indexOf(param4)) == -1)
         {
            _loc7_.push(param4);
         }
         var _loc8_:HaxeFighter = param2.getCarried(param1);
         if(_loc8_ != null)
         {
            if((int(_loc6_.indexOf("K")) != -1 || param3.actionId == 51) && int(param5.indexOf(_loc8_)) == -1 && int(_loc7_.indexOf(_loc8_)) == -1)
            {
               _loc7_.push(_loc8_);
            }
         }
         return _loc7_;
      }
      
      public static function comparePositions(param1:int, param2:Boolean, param3:int, param4:int) : int
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:* = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:* = 0;
         var _loc20_:* = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:* = 0;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:* = 0;
         var _loc27_:* = 0;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:* = 0;
         var _loc31_:int = 0;
         var _loc32_:int = 0;
         var _loc33_:* = 0;
         var _loc34_:* = 0;
         var _loc35_:int = 0;
         var _loc5_:int = MapTools.getDistance(param3,param1);
         var _loc6_:int = MapTools.getDistance(param4,param1);
         if(_loc5_ == _loc6_)
         {
            _loc7_ = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
            _loc8_ = Math.floor((_loc7_ + 1) / 2);
            _loc9_ = param1 - _loc7_ * MapTools.MAP_GRID_WIDTH;
            _loc10_ = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
            _loc11_ = Math.floor((_loc10_ + 1) / 2);
            _loc12_ = _loc10_ - _loc11_;
            _loc13_ = param1 - _loc10_ * MapTools.MAP_GRID_WIDTH;
            _loc14_ = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
            _loc15_ = Math.floor((_loc14_ + 1) / 2);
            _loc16_ = param3 - _loc14_ * MapTools.MAP_GRID_WIDTH;
            _loc17_ = Math.floor(param3 / MapTools.MAP_GRID_WIDTH);
            _loc18_ = Math.floor((_loc17_ + 1) / 2);
            _loc19_ = _loc17_ - _loc18_;
            _loc20_ = param3 - _loc17_ * MapTools.MAP_GRID_WIDTH;
            _loc5_ = MapTools.getLookDirection8ByCoord(_loc8_ + _loc9_,_loc13_ - _loc12_,_loc15_ + _loc16_,_loc20_ - _loc19_);
            _loc21_ = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
            _loc22_ = Math.floor((_loc21_ + 1) / 2);
            _loc23_ = param1 - _loc21_ * MapTools.MAP_GRID_WIDTH;
            _loc24_ = Math.floor(param1 / MapTools.MAP_GRID_WIDTH);
            _loc25_ = Math.floor((_loc24_ + 1) / 2);
            _loc26_ = _loc24_ - _loc25_;
            _loc27_ = param1 - _loc24_ * MapTools.MAP_GRID_WIDTH;
            _loc28_ = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
            _loc29_ = Math.floor((_loc28_ + 1) / 2);
            _loc30_ = param4 - _loc28_ * MapTools.MAP_GRID_WIDTH;
            _loc31_ = Math.floor(param4 / MapTools.MAP_GRID_WIDTH);
            _loc32_ = Math.floor((_loc31_ + 1) / 2);
            _loc33_ = _loc31_ - _loc32_;
            _loc34_ = param4 - _loc31_ * MapTools.MAP_GRID_WIDTH;
            _loc6_ = MapTools.getLookDirection8ByCoord(_loc22_ + _loc23_,_loc27_ - _loc26_,_loc29_ + _loc30_,_loc34_ - _loc33_);
            if(_loc5_ == _loc6_)
            {
               _loc6_ = 0;
               if(_loc5_ == 0 || _loc5_ == 7 || _loc5_ == 6 || _loc5_ == 5)
               {
                  _loc5_ = param3 < param4 ? -1 : 1;
               }
               else
               {
                  _loc5_ = param3 < param4 ? 1 : -1;
               }
            }
            else
            {
               _loc35_ = 1;
               _loc5_ = (_loc5_ + _loc35_) % 8;
               _loc6_ = (_loc6_ + _loc35_) % 8;
            }
         }
         return (_loc6_ - _loc5_) * (!!param2 ? 1 : -1);
      }
      
      public static function getBombsAboutToExplode(param1:HaxeFighter, param2:FightContext, param3:RunningEffect, param4:Array = undefined) : Array
      {
         var _loc7_:* = null as RunningEffect;
         var _loc10_:* = null as LinkedListNode;
         var _loc11_:* = null as LinkedListNode;
         var _loc14_:* = null as HaxeSpellEffect;
         var _loc15_:* = null;
         var _loc16_:int = 0;
         var _loc17_:* = null as Array;
         var _loc18_:* = null as HaxeFighter;
         if(!(param1.playerType == PlayerTypeEnum.MONSTER && param1.data.isSummon() && int(HaxeFighter.BOMB_BREED_ID.indexOf(param1.breed)) != -1))
         {
            return [];
         }
         var _loc5_:Array = param4 == null ? [] : param4;
         if(int(_loc5_.indexOf(param1)) != -1)
         {
            return _loc5_;
         }
         var _loc6_:HaxeSpell = DamageCalculator.dataInterface.getLinkedExplosionSpellFromFighter(param1);
         if(_loc6_ == null)
         {
            return _loc5_;
         }
         var _loc8_:int = param2.targetedCell;
         var _loc9_:LinkedListNode = param1._buffs.head;
         while(_loc9_ != null)
         {
            _loc10_ = _loc9_;
            _loc9_ = _loc9_.next;
            _loc11_ = _loc10_;
            if(_loc11_.item.effect.actionId == 1027)
            {
               param1.getSummoner(param2).storePendingBuff(_loc11_.item);
            }
         }
         param1.removeBuffByActionId(1027);
         _loc5_.push(param1);
         var _loc12_:int = 0;
         var _loc13_:Array = _loc6_.getEffects();
         while(_loc12_ < int(_loc13_.length))
         {
            _loc14_ = _loc13_[_loc12_];
            _loc12_++;
            if(_loc14_.actionId == 1009)
            {
               _loc7_ = new RunningEffect(param1,_loc6_,_loc14_);
               _loc7_.setParentEffect(param3);
               _loc7_.forceCritical = param3.forceCritical;
               _loc15_ = TargetManagement.getTargets(param2,param1,_loc6_,_loc14_,null);
               _loc16_ = 0;
               _loc17_ = _loc15_.targetedFighters;
               while(_loc16_ < int(_loc17_.length))
               {
                  _loc18_ = _loc17_[_loc16_];
                  _loc16_++;
                  if(!(_loc18_ == param1 || param3.isTargetingAnAncestor(_loc18_) || !_loc18_.isLinkedBomb(param1)))
                  {
                     param2.targetedCell = int(_loc18_.getCurrentPositionCell());
                     _loc5_ = TargetManagement.getBombsAboutToExplode(_loc18_,param2,_loc7_,_loc5_);
                  }
               }
               param2.targetedCell = _loc8_;
            }
         }
         return _loc5_;
      }
   }
}
