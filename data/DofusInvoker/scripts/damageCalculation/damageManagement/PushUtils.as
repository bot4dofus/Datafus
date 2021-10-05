package damageCalculation.damageManagement
{
   import damageCalculation.DamageCalculator;
   import damageCalculation.FightContext;
   import damageCalculation.fighterManagement.HaxeFighter;
   import damageCalculation.fighterManagement.PlayerTypeEnum;
   import damageCalculation.spellManagement.HaxeSpellEffect;
   import damageCalculation.spellManagement.Mark;
   import damageCalculation.spellManagement.RunningEffect;
   import mapTools.MapDirection;
   import mapTools.MapTools;
   
   public class PushUtils
   {
      
      public static var ALLOW_MARK_PREVIEW:Boolean = true;
       
      
      public function PushUtils()
      {
      }
      
      public static function getPullDirection(param1:int, param2:int, param3:int, param4:Boolean = true) : int
      {
         var _loc5_:int = PushUtils.getPushDirection(param1,param2,param3,param4);
         if(_loc5_ == -1)
         {
            return _loc5_;
         }
         return int(MapDirection.getOppositeDirection(_loc5_));
      }
      
      public static function getPushDirection(param1:int, param2:int, param3:int, param4:Boolean = true) : int
      {
         var _loc6_:int = 0;
         if(param3 == param2 && (param3 == param1 || !param4))
         {
            return -1;
         }
         var _loc5_:int = param2 == param3 ? param1 : param2;
         if(MapTools.isInDiag(_loc5_,param3))
         {
            _loc6_ = MapTools.getLookDirection4DiagExact(_loc5_,param3);
         }
         else
         {
            _loc6_ = MapTools.getLookDirection4(_loc5_,param3);
         }
         return _loc6_;
      }
      
      public static function getCollisionDamage(param1:FightContext, param2:HaxeFighter, param3:HaxeFighter, param4:int, param5:int) : DamageRange
      {
         var _loc6_:int = 0;
         if(!!param2.data.isSummon() && Number(param2.data.getSummonerId()) != 0)
         {
            _loc6_ = param2.getSummoner(param1).level;
         }
         else
         {
            _loc6_ = param2.level;
         }
         var _loc7_:* = int(param2.data.getCharacteristicValue(84));
         var _loc8_:int = param3.data.getCharacteristicValue(85);
         _loc7_ -= _loc8_;
         var _loc9_:int = param4 * (int(Math.floor(_loc6_ / 2)) + 32 + _loc7_) / (4 * Math.pow(2,param5));
         var _loc10_:DamageRange = new DamageRange(_loc9_,_loc9_);
         _loc10_.minimizeBy(0);
         _loc10_.isCollision = true;
         if(param2.hasStateEffect(6))
         {
            _loc10_.setToZero();
         }
         return _loc10_;
      }
      
      public static function pull(param1:FightContext, param2:RunningEffect, param3:HaxeFighter, param4:int, param5:Boolean, param6:Boolean) : Array
      {
         var _loc10_:* = null as HaxeFighter;
         var _loc11_:int = 0;
         var _loc7_:HaxeFighter = param2.getCaster();
         var _loc8_:Boolean = param1.usingPortal();
         var _loc9_:* = param2.getSpellEffect().actionId == 1042;
         if(_loc9_)
         {
            _loc10_ = _loc7_;
            _loc7_ = param3;
            param3 = _loc10_;
         }
         if(_loc8_)
         {
            _loc11_ = !!_loc9_ ? param1.inputPortalCellId : int(param1.map.getOutputPortalCell(param1.inputPortalCellId));
         }
         else
         {
            _loc11_ = _loc7_.getCurrentPositionCell();
         }
         var _loc12_:int = !!param1.inMovement ? int(param3.getCurrentPositionCell()) : int(param3.getBeforeLastSpellPosition());
         var _loc13_:int = !!_loc8_ ? _loc12_ : param1.targetedCell;
         var _loc14_:int = PushUtils.getPullDirection(_loc11_,_loc13_,_loc12_,!param1.inMovement);
         return PushUtils.drag(param1,param2,param3,param4,_loc14_,param5,false,param6,true);
      }
      
      public static function push(param1:FightContext, param2:RunningEffect, param3:HaxeFighter, param4:int, param5:Boolean, param6:Boolean, param7:Boolean) : Array
      {
         var _loc11_:* = null as HaxeFighter;
         var _loc12_:int = 0;
         var _loc8_:HaxeFighter = param2.getCaster();
         var _loc9_:Boolean = param1.usingPortal();
         var _loc10_:* = param2.getSpellEffect().actionId == 1041;
         if(_loc10_)
         {
            _loc11_ = _loc8_;
            _loc8_ = param3;
            param3 = _loc11_;
         }
         if(_loc9_)
         {
            _loc12_ = !!_loc10_ ? param1.inputPortalCellId : int(param1.map.getOutputPortalCell(param1.inputPortalCellId));
         }
         else
         {
            _loc12_ = _loc8_.getBeforeLastSpellPosition();
         }
         var _loc13_:int = !!param1.inMovement ? int(param3.getCurrentPositionCell()) : int(param3.getBeforeLastSpellPosition());
         var _loc14_:int = PushUtils.getPushDirection(_loc12_,param1.targetedCell,_loc13_,!param1.inMovement);
         return PushUtils.drag(param1,param2,param3,param4,_loc14_,param5,param6,param7,false);
      }
      
      public static function pullTo(param1:FightContext, param2:RunningEffect, param3:HaxeFighter, param4:Boolean, param5:Boolean) : Array
      {
         var _loc6_:int = MapTools.getDistance(param1.targetedCell,int(param3.getBeforeLastSpellPosition()));
         var _loc7_:FightContext = param1.copy();
         _loc7_.targetedCell = int(param2.getCaster().getBeforeLastSpellPosition());
         return PushUtils.pull(_loc7_,param2,param3,_loc6_,param4,param5);
      }
      
      public static function pushTo(param1:FightContext, param2:RunningEffect, param3:HaxeFighter, param4:Boolean, param5:Boolean, param6:Boolean) : Array
      {
         var _loc7_:int = MapTools.getDistance(param1.targetedCell,int(param3.getBeforeLastSpellPosition()));
         var _loc8_:FightContext = param1.copy();
         _loc8_.targetedCell = int(param2.getCaster().getBeforeLastSpellPosition());
         return PushUtils.push(_loc8_,param2,param3,_loc7_,param4,param5,param6);
      }
      
      public static function drag(param1:FightContext, param2:RunningEffect, param3:HaxeFighter, param4:int, param5:int, param6:Boolean, param7:Boolean, param8:Boolean, param9:Boolean) : Array
      {
         var _loc10_:* = null;
         var _loc11_:Boolean = false;
         var _loc15_:* = null as HaxeFighter;
         var _loc16_:* = null as FightContext;
         var _loc17_:* = null as EffectOutput;
         if(!param6 && !(!param3.hasStateEffect(3) && param3.data.canBreedBePushed() && !param3.hasStateEffect(0)) || param5 == -1)
         {
            return [];
         }
         if(MapDirection.isCardinal(param5))
         {
            param4 = Math.ceil(param4 / 2);
         }
         var _loc12_:Boolean = false;
         var _loc13_:* = false;
         var _loc14_:Array = [];
         do
         {
            _loc10_ = PushUtils.getDragCellDest(param1,param3,param5,param4);
            if(int(_loc10_.cell) != int(param3.getCurrentPositionCell()))
            {
               _loc12_ = true;
               _loc13_ = _loc10_.stopReason == DragResultEnum.PORTAL;
               _loc15_ = param3.getCarried(param1);
               if(_loc15_ != null)
               {
                  _loc16_ = param1.copy();
                  _loc16_.targetedCell = int(param3.getCurrentPositionCell());
                  _loc14_ = _loc14_.concat(Teleport.throwFighter(param1,param3,param2,param8));
               }
            }
            _loc11_ = PushUtils.applyDrag(param1,param2,param3,int(_loc10_.cell),param8);
            param4 = _loc10_.remainingForce;
         }
         while(!!_loc11_ && _loc10_.stopReason == DragResultEnum.PORTAL && param4 > 0);
         
         if(_loc12_)
         {
            _loc17_ = new EffectOutput(param3.id);
            _loc17_.movement = new MovementInfos(int(_loc10_.cell),-1);
            _loc17_.throughPortal = _loc13_;
            if(param9)
            {
               _loc17_.isPulled = true;
            }
            else
            {
               _loc17_.isPushed = true;
            }
            _loc14_.push(_loc17_);
         }
         if(param7)
         {
            PushUtils.applyCollisionDamage(param1,param2,param3,_loc10_,param5,param8);
         }
         if(_loc12_)
         {
            DamageCalculator.executeMarks(param1,param2,param3,int(_loc10_.cell),param8);
         }
         return _loc14_;
      }
      
      public static function getDragCellDest(param1:FightContext, param2:HaxeFighter, param3:int, param4:int) : Object
      {
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = null as Array;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:int = 0;
         var _loc14_:* = null as Mark;
         var _loc15_:* = null as DragResultEnum;
         var _loc5_:int = param2.getCurrentPositionCell();
         var _loc7_:int = 0;
         var _loc8_:int = param4;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = _loc7_++;
            _loc6_ = _loc5_;
            _loc5_ = MapTools.getNextCellByDirection(_loc5_,param3);
            if(PushUtils.isPathBlocked(param1,_loc6_,_loc5_,param3))
            {
               return {
                  "remainingForce":param4 - _loc9_,
                  "cell":_loc6_,
                  "stopReason":DragResultEnum.COLLISION
               };
            }
            _loc10_ = param1.map.getMarkInteractingWithCell(_loc5_);
            _loc11_ = false;
            _loc12_ = false;
            if(_loc10_ != null)
            {
               _loc13_ = 0;
               while(_loc13_ < int(_loc10_.length))
               {
                  _loc14_ = _loc10_[_loc13_];
                  _loc13_++;
                  if(_loc14_.markType != 0)
                  {
                     if(!_loc11_ && (_loc14_.stopDrag() || _loc14_.markType == 4))
                     {
                        _loc11_ = true;
                     }
                     if(!_loc12_ && _loc14_.markType != 4 && _loc14_.stopDrag())
                     {
                        _loc12_ = true;
                     }
                     if(!!_loc11_ && _loc12_)
                     {
                        break;
                     }
                  }
               }
            }
            if(_loc11_)
            {
               _loc15_ = !!_loc12_ ? DragResultEnum.ACTIVE_OBJECT : DragResultEnum.PORTAL;
               return {
                  "remainingForce":param4 - _loc9_ - 1,
                  "cell":_loc5_,
                  "stopReason":_loc15_
               };
            }
         }
         return {
            "remainingForce":0,
            "cell":_loc5_,
            "stopReason":DragResultEnum.COMPLETE
         };
      }
      
      public static function applyDrag(param1:FightContext, param2:RunningEffect, param3:HaxeFighter, param4:int, param5:Boolean) : Boolean
      {
         var _loc6_:* = null as Array;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(param4 == int(param3.getCurrentPositionCell()))
         {
            return false;
         }
         if(!param5)
         {
            _loc6_ = MapTools.getCellsIdOnLargeWay(int(param3.getCurrentPositionCell()),param4);
            if(_loc6_ != null)
            {
               _loc7_ = 0;
               while(_loc7_ < int(_loc6_.length))
               {
                  _loc8_ = _loc6_[_loc7_];
                  _loc7_++;
                  param1.map.dispellIllusionOnCell(_loc8_);
               }
            }
         }
         param3.setCurrentPositionCell(param4);
         if(!!param3.data.canBreedUsePortals() && !param3.hasStateEffect(17))
         {
            _loc6_ = param1.map.getMarkInteractingWithCell(param4,4);
            if(int(_loc6_.length) > 0 && (_loc6_[0].teamId == param3.teamId || param1.gameTurn != 1))
            {
               _loc7_ = param1.map.getOutputPortalCell(param4);
               if(MapTools.isValidCellId(_loc7_))
               {
                  param3.setCurrentPositionCell(_loc7_);
               }
            }
         }
         return true;
      }
      
      public static function applyCollisionDamage(param1:FightContext, param2:RunningEffect, param3:HaxeFighter, param4:Object, param5:int, param6:Boolean) : void
      {
         var _loc11_:* = null as HaxeFighter;
         if(!param3.isAlive() || int(param4.remainingForce) <= 0 || param2.getCaster() == null || param4.stopReason == DragResultEnum.ACTIVE_OBJECT)
         {
            return;
         }
         if(MapDirection.isCardinal(param5))
         {
            param4.remainingForce = int(param4.remainingForce) * 2;
         }
         var _loc7_:HaxeFighter = param2.getCaster();
         if(_loc7_.playerType == PlayerTypeEnum.MONSTER && _loc7_.data.isSummon() && int(HaxeFighter.BOMB_BREED_ID.indexOf(_loc7_.breed)) != -1 || _loc7_.playerType == PlayerTypeEnum.MONSTER && _loc7_.data.isSummon() && int(HaxeFighter.STEAMER_TURRET_BREED_ID.indexOf(_loc7_.breed)) != -1)
         {
            _loc7_ = _loc7_.getSummoner(param1);
         }
         PushUtils.applyCollisionDamageOnTarget(param1,param2,param3,int(param4.remainingForce),0,param6);
         var _loc8_:Array = PushUtils.getCollateralTargets(param1,int(param4.cell),param5,int(param4.remainingForce));
         var _loc9_:int = 1;
         var _loc10_:int = 0;
         while(_loc10_ < int(_loc8_.length))
         {
            _loc11_ = _loc8_[_loc10_];
            _loc10_++;
            PushUtils.applyCollisionDamageOnTarget(param1,param2,_loc11_,int(param4.remainingForce),_loc9_,param6);
            _loc9_++;
         }
      }
      
      public static function applyCollisionDamageOnTarget(param1:FightContext, param2:RunningEffect, param3:HaxeFighter, param4:int, param5:int, param6:Boolean) : void
      {
         var _loc7_:HaxeSpellEffect = new HaxeSpellEffect(param2.getSpellEffect().id,1,0,80,param4,param5,0,0,param2.getSpellEffect().isCritical,"I","P","a,A",0,0,true,0,2);
         var _loc8_:RunningEffect = param2.copy();
         _loc8_.overrideSpellEffect(_loc7_);
         DamageCalculator.computeEffect(param1,_loc8_,param6,[param3],null);
      }
      
      public static function getCollateralTargets(param1:FightContext, param2:int, param3:int, param4:int) : Array
      {
         var _loc5_:Array = [];
         param2 = MapTools.getNextCellByDirection(param2,param3);
         var _loc6_:HaxeFighter = param1.getFighterFromCell(param2,true);
         while(param4 > 0 && _loc6_ != null && _loc6_.isAlive())
         {
            _loc5_.push(_loc6_);
            param2 = MapTools.getNextCellByDirection(param2,param3);
            _loc6_ = param1.getFighterFromCell(param2);
            param4--;
         }
         return _loc5_;
      }
      
      public static function isPathBlocked(param1:FightContext, param2:int, param3:int, param4:int) : Boolean
      {
         if(!!param1.isCellEmptyForMovement(param3) && MapTools.adjacentCellsAllowAccess(param1,param2,param4))
         {
            return false;
         }
         return true;
      }
   }
}
