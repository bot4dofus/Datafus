package damageCalculation.damageManagement
{
   import damageCalculation.DamageCalculator;
   import damageCalculation.FightContext;
   import damageCalculation.fighterManagement.HaxeBuff;
   import damageCalculation.fighterManagement.HaxeFighter;
   import damageCalculation.spellManagement.HaxeSpell;
   import damageCalculation.spellManagement.HaxeSpellEffect;
   import damageCalculation.spellManagement.RunningEffect;
   import damageCalculation.tools.PortalUtils;
   import mapTools.MapTools;
   import mapTools.Point;
   import mapTools.SpellZone;
   import tools.ActionIdHelper;
   
   public class Teleport
   {
      
      public static var SAME_DIRECTION:int = -1;
      
      public static var OPPOSITE_DIRECTION:int = -2;
       
      
      public function Teleport()
      {
      }
      
      public static function teleportFighter(param1:FightContext, param2:RunningEffect, param3:HaxeFighter, param4:Boolean) : Array
      {
         var _loc6_:* = null as HaxeFighter;
         var _loc7_:int = 0;
         var _loc10_:Boolean = false;
         var _loc12_:* = null as HaxeFighter;
         var _loc5_:Array = [];
         var _loc8_:int = param2.getSpellEffect().actionId;
         var _loc9_:Boolean = false;
         var _loc11_:int = _loc8_;
         if(_loc11_ != 4)
         {
            if(_loc11_ == 1104)
            {
               addr30:
               _loc6_ = param2.getCaster();
               _loc9_ = true;
            }
            else
            {
               _loc10_ = ActionIdHelper.isExchange(_loc8_);
               if(_loc10_ == true)
               {
                  _loc6_ = param2.getCaster();
                  _loc9_ = true;
               }
               else
               {
                  _loc6_ = param3;
               }
            }
            _loc11_ = _loc8_;
            if(_loc11_ != 1099)
            {
               if(_loc11_ == 1100)
               {
                  addr64:
                  _loc7_ = -1;
               }
               else
               {
                  if(_loc11_ != 4)
                  {
                     if(_loc11_ != 1104)
                     {
                        _loc10_ = ActionIdHelper.isExchange(_loc8_);
                        _loc7_ = _loc10_ == true ? -1 : -2;
                     }
                     §§goto(addr98);
                  }
                  _loc7_ = MapTools.getLookDirection4(int(param2.getCaster().getCurrentPositionCell()),param1.targetedCell);
               }
               addr98:
               _loc11_ = Teleport.getTeleportedPosition(param1,param2,_loc6_,param1.targetedCell);
               if(_loc11_ == int(_loc6_.getCurrentPositionCell()) && ActionIdHelper.isExchange(_loc8_))
               {
                  _loc11_ = param3.getCurrentPositionCell();
               }
               if(_loc11_ != int(_loc6_.getCurrentPositionCell()))
               {
                  _loc12_ = null;
                  if(param1.map.isCellWalkable(_loc11_))
                  {
                     _loc12_ = param1.getFighterFromCell(_loc11_,true);
                     if(_loc12_ != null && _loc12_.isAlive())
                     {
                        if(!(_loc8_ == 1023 || !!_loc12_.canSwitchPosition(_loc6_,_loc8_,false) && _loc6_.canSwitchPosition(_loc12_,_loc8_,_loc9_)))
                        {
                           return [];
                        }
                        _loc5_.push(EffectOutput.fromMovement(_loc12_.id,int(_loc6_.getCurrentPositionCell()),-1,_loc6_));
                        _loc12_.setCurrentPositionCell(int(_loc6_.getCurrentPositionCell()));
                     }
                     else
                     {
                        _loc12_ = null;
                     }
                     if(_loc6_.hasState(8))
                     {
                        Teleport.releaseFighter(param1,_loc6_.getCarrier(param1));
                     }
                     _loc6_.setCurrentPositionCell(_loc11_);
                  }
                  else
                  {
                     _loc11_ = -1;
                  }
                  if(int(_loc6_.getCurrentPositionCell()) == _loc11_)
                  {
                     DamageCalculator.executeMarks(param1,param2,_loc6_,int(_loc6_.getCurrentPositionCell()),param4);
                  }
                  if(_loc12_ != null)
                  {
                     DamageCalculator.executeMarks(param1,param2,_loc12_,int(_loc12_.getCurrentPositionCell()),param4);
                  }
                  _loc5_.push(EffectOutput.fromMovement(_loc6_.id,_loc11_,_loc7_,_loc12_));
               }
               return _loc5_;
            }
            §§goto(addr64);
         }
         §§goto(addr30);
      }
      
      public static function getTeleportedPosition(param1:FightContext, param2:RunningEffect, param3:HaxeFighter, param4:int) : int
      {
         var _loc7_:* = null as Point;
         var _loc8_:int = 0;
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         var _loc11_:* = null as SpellZone;
         var _loc12_:* = null as Array;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:* = null as Point;
         var _loc16_:* = null as Point;
         var _loc17_:* = null as HaxeFighter;
         var _loc5_:int = param3.getCurrentPositionCell();
         var _loc6_:int = _loc5_;
         if(!!param3.isAlive() && param3.canTeleport(param2.getSpellEffect().actionId,false,_loc6_))
         {
            _loc7_ = null;
            _loc8_ = param2.getSpellEffect().actionId;
            _loc10_ = _loc8_;
            if(_loc10_ == 4)
            {
               _loc9_ = ActionIdHelper.isExchange(_loc8_);
               if(_loc9_ == true)
               {
                  _loc6_ = param4;
               }
               else if(param1.isCellEmptyForMovement(param4))
               {
                  _loc6_ = param4;
               }
               else if(param2.getSpellEffect().rawZone.charAt(0) != "P")
               {
                  _loc11_ = SpellZone.fromRawZone(param2.getSpellEffect().rawZone);
                  _loc12_ = _loc11_.getCells(param4,int(param3.getCurrentPositionCell()));
                  _loc12_ = PortalUtils.getPortalChainFromPortalCells(param1.targetedCell,_loc12_,Boolean(ActionIdHelper.isPush(param2.getSpellEffect().actionId)));
                  _loc13_ = 0;
                  while(_loc13_ < int(_loc12_.length))
                  {
                     _loc14_ = _loc12_[_loc13_];
                     _loc13_++;
                     if(param1.isCellEmptyForMovement(_loc14_))
                     {
                        _loc6_ = _loc14_;
                        break;
                     }
                  }
               }
            }
            else if(_loc10_ == 1099)
            {
               _loc6_ = param3.data.getTurnBeginPosition();
            }
            else if(_loc10_ == 1100)
            {
               _loc6_ = param3.getPendingPreviousPosition();
            }
            else if(_loc10_ == 1101)
            {
               _loc6_ = param2.getCaster().getCurrentPositionCell();
            }
            else
            {
               if(_loc10_ != 1104)
               {
                  if(_loc10_ != 1106)
                  {
                     if(_loc10_ == 1105)
                     {
                        _loc7_ = MapTools.getCellCoordById(int(param2.getCaster().getCurrentPositionCell()));
                     }
                     else
                     {
                        _loc9_ = ActionIdHelper.isExchange(_loc8_);
                        if(_loc9_ == true)
                        {
                           _loc6_ = param4;
                        }
                        else
                        {
                           _loc7_ = null;
                        }
                     }
                  }
                  §§goto(addr215);
               }
               _loc7_ = MapTools.getCellCoordById(param4);
            }
            addr215:
            if(_loc7_ != null)
            {
               _loc15_ = new Point(0,0);
               _loc16_ = new Point(0,0);
               _loc15_.x = _loc7_.x - MapTools.getCellCoordById(int(param3.getCurrentPositionCell())).x;
               _loc15_.y = _loc7_.y - MapTools.getCellCoordById(int(param3.getCurrentPositionCell())).y;
               _loc16_.x = _loc7_.x + _loc15_.x;
               _loc16_.y = _loc7_.y + _loc15_.y;
               _loc6_ = MapTools.getCellIdByCoord(_loc16_.x,_loc16_.y);
            }
            §§goto(addr277);
         }
         addr277:
         if(_loc6_ != _loc5_)
         {
            _loc17_ = param1.getFighterFromCell(_loc6_);
            if(_loc17_ != null && (param3.hasState(3) || _loc17_.hasState(3)))
            {
               _loc6_ = _loc5_;
            }
         }
         return _loc6_;
      }
      
      public static function throwFighter(param1:FightContext, param2:HaxeFighter, param3:RunningEffect, param4:Boolean) : Array
      {
         var _loc5_:HaxeFighter = param2.getCarried(param1);
         if(_loc5_ == null)
         {
            return [];
         }
         param2.removeState(3);
         param2.carryFighter(null);
         _loc5_.removeState(8);
         _loc5_.setCurrentPositionCell(param1.targetedCell);
         var _loc6_:int = MapTools.getLookDirection4(int(param2.getCurrentPositionCell()),param1.targetedCell);
         var _loc7_:EffectOutput = EffectOutput.fromMovement(_loc5_.id,param1.targetedCell,_loc6_);
         _loc7_.throwedBy = param2.id;
         DamageCalculator.executeMarks(param1,param3,_loc5_,param1.targetedCell,param4);
         return [EffectOutput.fromStateChange(param2.id,3,false),EffectOutput.fromStateChange(_loc5_.id,8,false),_loc7_];
      }
      
      public static function releaseFighter(param1:FightContext, param2:HaxeFighter) : Array
      {
         if(param2 == null)
         {
            return [];
         }
         var _loc3_:HaxeFighter = param2.getCarried(param1);
         if(_loc3_ == null)
         {
            return [];
         }
         param2.removeState(3);
         param2.carryFighter(null);
         _loc3_.removeState(8);
         return [EffectOutput.fromStateChange(param2.id,3,false),EffectOutput.fromStateChange(_loc3_.id,8,false)];
      }
      
      public static function breakCarrierLink(param1:HaxeFighter, param2:HaxeFighter) : void
      {
         param1.removeState(3);
         param1.carryFighter(null);
         param2.removeState(8);
      }
      
      public static function carryFighter(param1:FightContext, param2:RunningEffect, param3:HaxeFighter) : Array
      {
         if(!(!param3.hasStateEffect(3) && param3.data.canBreedBeCarried() && !param3.hasStateEffect(4)))
         {
            return [];
         }
         var _loc4_:HaxeSpellEffect = param2.getSpellEffect().clone();
         _loc4_.actionId = 950;
         _loc4_.param3 = 3;
         _loc4_.param1 = 0;
         param2.getCaster().storePendingBuff(new HaxeBuff(param2.getCaster().id,param2.getSpell(),_loc4_));
         param2.getCaster().carryFighter(param3);
         var _loc5_:HaxeSpellEffect = param2.getSpellEffect().clone();
         _loc5_.actionId = 950;
         _loc5_.param3 = 8;
         _loc5_.param1 = 0;
         param3.storePendingBuff(new HaxeBuff(param2.getCaster().id,param2.getSpell(),_loc5_));
         param3.setCurrentPositionCell(int(param2.getCaster().getCurrentPositionCell()));
         var _loc6_:int = MapTools.getLookDirection4(int(param2.getCaster().getCurrentPositionCell()),param1.targetedCell);
         var _loc7_:EffectOutput = EffectOutput.fromMovement(param3.id,int(param2.getCaster().getCurrentPositionCell()),_loc6_);
         _loc7_.carriedBy = param2.getCaster().id;
         var _loc8_:Array = [EffectOutput.fromStateChange(param2.getCaster().id,3,true),EffectOutput.fromStateChange(param3.id,8,true),_loc7_];
         if(param2.getCaster().hasState(250))
         {
            _loc8_.push(EffectOutput.fromStateChange(param2.getCaster().id,250,false));
         }
         if(param3.hasState(250))
         {
            _loc8_.push(EffectOutput.fromStateChange(param3.id,250,false));
         }
         return _loc8_;
      }
   }
}
