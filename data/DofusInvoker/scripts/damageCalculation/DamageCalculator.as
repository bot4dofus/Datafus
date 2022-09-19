package damageCalculation
{
   import damageCalculation.damageManagement.DamageRange;
   import damageCalculation.damageManagement.DamageReceiver;
   import damageCalculation.damageManagement.DamageSender;
   import damageCalculation.damageManagement.EffectOutput;
   import damageCalculation.damageManagement.PushUtils;
   import damageCalculation.damageManagement.SummonInfos;
   import damageCalculation.damageManagement.TargetManagement;
   import damageCalculation.damageManagement.Teleport;
   import damageCalculation.debug.Debug;
   import damageCalculation.fighterManagement.HaxeBuff;
   import damageCalculation.fighterManagement.HaxeFighter;
   import damageCalculation.fighterManagement.PlayerTypeEnum;
   import damageCalculation.spellManagement.HaxeSpell;
   import damageCalculation.spellManagement.HaxeSpellEffect;
   import damageCalculation.spellManagement.Mark;
   import damageCalculation.spellManagement.RandomGroup;
   import damageCalculation.spellManagement.RunningEffect;
   import damageCalculation.spellManagement.SpellManager;
   import damageCalculation.tools.Interval;
   import damageCalculation.tools.LinkedList;
   import damageCalculation.tools.LinkedListNode;
   import damageCalculation.tools.MathUtils;
   import haxe.IMap;
   import haxe.ds.ArraySort;
   import haxe.ds.IntMap;
   import haxe.ds.List;
   import haxe.ds.ObjectMap;
   import haxe.ds._IntMap.IntMapValuesIterator;
   import mapTools.MapTools;
   import mapTools.Point;
   import mapTools.SpellZone;
   import tools.ActionIdHelper;
   import tools.FpUtils;
   import tools.HaxeLogger;
   import tools.LoggerInterface;
   
   public class DamageCalculator
   {
      
      public static var ALLOW_SPLASH_DEGRESSION:Boolean = true;
      
      public static var dataInterface:DamageCalculationInterface;
      
      public static var logger:LoggerInterface;
      
      public static var loopCountIterations:int = 0;
      
      public static var MAX_LOOP_ITERATIONS:int = 500;
      
      public static var START_TIME:Number = -1;
      
      public static var MAX_WALL_LENGTH:int = 7;
      
      public static var WALL_ZONE:SpellZone = SpellZone.fromRawZone("X" + 7);
      
      public static var isCritical:Boolean = false;
      
      public static var isDebug:Boolean = false;
       
      
      public function DamageCalculator()
      {
      }
      
      public static function damageComputation(param1:HaxeFighter, param2:HaxeSpell, param3:int, param4:IMapInfo, param5:int, param6:int, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false) : Array
      {
         var _loc12_:int = 0;
         var _loc13_:* = null as Array;
         var _loc14_:* = null as HaxeFighter;
         DamageCalculator.loopCountIterations = 0;
         var _loc10_:FightContext = new FightContext(param3,param4,param5,param1,null,null,param6,param9);
         var _loc11_:HaxeFighter = _loc10_.getFighterFromCell(_loc10_.targetedCell);
         if(!!param2.needsFreeCell && _loc11_ != null && _loc11_.isAlive() || !!param2.needsTakenCell && (_loc11_ == null || !_loc11_.isAlive()))
         {
            return [];
         }
         DamageCalculator.START_TIME = Number(Date.now().getTime());
         if(!param8 || param1.isUnlucky() || int(param2.getCriticalEffects().length) == 0)
         {
            DamageCalculator.isCritical = false;
            DamageCalculator.executeSpell(_loc10_,param1,param2,false,null,param7);
            _loc12_ = 0;
            _loc13_ = _loc10_.fighters;
            while(_loc12_ < int(_loc13_.length))
            {
               _loc14_ = _loc13_[_loc12_];
               _loc12_++;
               _loc14_.savePendingEffects();
               _loc14_.data.resetStats();
            }
         }
         if(!param1.isUnlucky() && ((!!param7 && param2.criticalHitProbability > 0 || param8) && int(param2.getCriticalEffects().length) != 0))
         {
            DamageCalculator.isCritical = true;
            if(param7)
            {
               _loc12_ = 0;
               _loc13_ = _loc10_.fighters;
               while(_loc12_ < int(_loc13_.length))
               {
                  _loc14_ = _loc13_[_loc12_];
                  _loc12_++;
                  if(int(_loc10_.tempFighters.indexOf(_loc14_)) != -1)
                  {
                     FpUtils.arrayRemove_damageCalculation_fighterManagement_HaxeFighter(_loc10_.fighters,_loc14_);
                  }
                  else
                  {
                     _loc14_.resetToInitialState();
                  }
               }
               _loc10_.tempFighters = [];
               _loc10_.inMovement = false;
               _loc10_.triggeredMarks = [];
            }
            DamageCalculator.loopCountIterations = 0;
            DamageCalculator.executeSpell(_loc10_,param1,param2,true,null,param7);
            _loc12_ = 0;
            _loc13_ = _loc10_.fighters;
            while(_loc12_ < int(_loc13_.length))
            {
               _loc14_ = _loc13_[_loc12_];
               _loc12_++;
               _loc14_.savePendingEffects();
               _loc14_.data.resetStats();
            }
         }
         return _loc10_.getAffectedFighters();
      }
      
      public static function executeSpell(param1:FightContext, param2:HaxeFighter, param3:HaxeSpell, param4:Boolean, param5:RunningEffect, param6:Boolean = false, param7:Boolean = false) : void
      {
         var _loc8_:* = null as EffectOutput;
         var _loc9_:* = null as RunningEffect;
         var _loc10_:* = null as Array;
         var _loc14_:* = null as HaxeSpellEffect;
         var _loc15_:* = null as HaxeFighter;
         var _loc16_:* = null;
         var _loc17_:int = 0;
         var _loc18_:* = null as IMap;
         var _loc19_:Number = NaN;
         var _loc20_:* = null as Array;
         var _loc21_:* = null as RandomGroup;
         var _loc22_:* = null as List;
         if(param1.debugMode)
         {
            Debug.storeSpell(param3);
         }
         if(!(param5 != null && int(param5.getSpellEffect().triggers.indexOf("X")) != -1) && !param2.isAlive())
         {
            return;
         }
         if(param2.playerType != PlayerTypeEnum.MONSTER && param2.hasState(250) && param3.isImmediateDamageInflicted(param4))
         {
            _loc8_ = EffectOutput.fromStateChange(param2.id,250,false);
            param2.pendingEffects.add(_loc8_);
            DamageCalculator.triggerHandler([_loc8_],new RunningEffect(param2,param3,HaxeSpellEffect.EMPTY),param1,param2,true,param6);
         }
         if(param5 == null && (param3.criticalHitProbability == 0 || int(param3.getCriticalEffects().length) == 0))
         {
            param4 = false;
         }
         if(!param4 || param5 != null || int(param3.getCriticalEffects().length) == 0)
         {
            _loc10_ = param3.getEffects();
         }
         else
         {
            _loc10_ = param3.getCriticalEffects();
         }
         _loc10_ = FpUtils.arrayCopy_damageCalculation_spellManagement_HaxeSpellEffect(_loc10_);
         var _loc11_:IMap = new IntMap();
         var _loc12_:IMap = new IntMap();
         var _loc13_:int = 0;
         while(_loc13_ < int(_loc10_.length))
         {
            _loc14_ = _loc10_[_loc13_];
            _loc15_ = param5 != null ? param5.triggeringFighter : null;
            _loc16_ = TargetManagement.getTargets(param1,param2,param3,_loc14_,_loc15_);
            if(_loc16_.isUsed)
            {
               _loc11_.h[int(_loc14_.id)] = _loc16_.targetedFighters;
               _loc12_.h[int(_loc14_.id)] = _loc16_.additionalTargets;
               _loc13_++;
            }
            else
            {
               _loc10_.splice(_loc13_,1);
            }
         }
         _loc17_ = 0;
         while(_loc17_ < int(_loc10_.length))
         {
            _loc14_ = _loc10_[_loc17_];
            _loc17_++;
            if(_loc14_.randomWeight <= 0)
            {
               _loc9_ = new RunningEffect(param2,param3,_loc14_);
               _loc9_.setParentEffect(param5);
               _loc9_.forceCritical = param4 || _loc14_.isCritical;
               DamageCalculator.computeEffect(param1,_loc9_,param6,_loc11_.h[int(_loc14_.id)],_loc12_.h[int(_loc14_.id)],param7);
            }
         }
         if(!!param3.hasAtLeastOneRandomEffect() && _loc10_ != null)
         {
            _loc18_ = RandomGroup.createGroups(_loc10_);
            _loc19_ = Number(RandomGroup.totalWeight(_loc18_));
            _loc17_ = 0;
            _loc20_ = param1.fighters;
            while(_loc17_ < int(_loc20_.length))
            {
               _loc15_ = _loc20_[_loc17_];
               _loc17_++;
               _loc15_.save();
            }
            _loc16_ = new IntMapValuesIterator(_loc18_.h);
            while(_loc16_.hasNext())
            {
               _loc21_ = _loc16_.next();
               _loc17_ = 0;
               _loc20_ = _loc21_.effects;
               while(_loc17_ < int(_loc20_.length))
               {
                  _loc14_ = _loc20_[_loc17_];
                  _loc17_++;
                  if(SpellManager.isInstantaneousSpellEffect(_loc14_))
                  {
                     _loc9_ = new RunningEffect(param2,param3,_loc14_);
                     _loc9_.setParentEffect(param5);
                     _loc9_.forceCritical = param4 || _loc14_.isCritical;
                     _loc9_.probability = Number(MathUtils.roundWithPrecision(_loc21_.weight / _loc19_ * 100,3));
                     DamageCalculator.computeEffect(param1,_loc9_,param6,_loc11_.h[int(_loc14_.id)],_loc12_.h[int(_loc14_.id)]);
                  }
               }
               _loc17_ = 0;
               _loc20_ = param1.fighters;
               while(_loc17_ < int(_loc20_.length))
               {
                  _loc15_ = _loc20_[_loc17_];
                  _loc17_++;
                  _loc22_ = _loc15_.getEffectsDeltaFromSave();
                  if(_loc22_ != null)
                  {
                     if(_loc15_.totalEffects != null)
                     {
                        _loc15_.totalEffects = FpUtils.listConcat_damageCalculation_damageManagement_EffectOutput(_loc15_.totalEffects,_loc22_);
                     }
                     else
                     {
                        _loc15_.totalEffects = _loc22_;
                     }
                  }
                  if(!_loc15_.load())
                  {
                     _loc15_.savePendingEffects();
                     _loc15_.resetToInitialState();
                  }
               }
            }
         }
      }
      
      public static function computeEffect(param1:FightContext, param2:RunningEffect, param3:Boolean, param4:Array, param5:Array, param6:Boolean = false) : void
      {
         var _loc11_:* = null as DamageRange;
         var _loc12_:* = null as String;
         var _loc13_:Boolean = false;
         var _loc14_:* = null as Array;
         var _loc15_:int = 0;
         var _loc16_:* = null as Mark;
         var _loc17_:* = null as HaxeFighter;
         var _loc18_:* = null as Point;
         var _loc19_:int = 0;
         var _loc20_:* = null as Array;
         var _loc21_:int = 0;
         var _loc22_:* = null as Point;
         var _loc23_:int = 0;
         var _loc24_:* = null as HaxeFighter;
         var _loc25_:Boolean = false;
         var _loc26_:Boolean = false;
         var _loc27_:* = null as HaxeBuff;
         var _loc28_:* = null as IMap;
         var _loc29_:* = null;
         var _loc30_:* = null;
         var _loc31_:* = null as HaxeSpell;
         var _loc32_:* = null as FightContext;
         var _loc33_:Number = NaN;
         var _loc34_:* = null as DamageRange;
         var _loc35_:Boolean = false;
         var _loc36_:Boolean = false;
         var _loc37_:Boolean = false;
         var _loc38_:Boolean = false;
         var _loc39_:int = 0;
         var _loc40_:Boolean = false;
         var _loc41_:* = false;
         var _loc42_:* = null as EffectOutput;
         var _loc43_:* = null as Interval;
         var _loc44_:* = null as Array;
         var _loc45_:* = null as SpellZone;
         var _loc46_:Boolean = false;
         var _loc47_:Boolean = false;
         var _loc48_:* = null as DamageRange;
         var _loc49_:* = null as RunningEffect;
         var _loc50_:int = 0;
         var _loc51_:Boolean = false;
         var fightContext:FightContext = param1;
         var _loc7_:HaxeSpell = param2.getSpell();
         var effect:HaxeSpellEffect = param2.getSpellEffect();
         var _loc8_:HaxeFighter = param2.getCaster();
         var _loc9_:int = 0;
         var _loc10_:HaxeFighter = null;
         param2.forceCritical = param2.forceCritical || effect.isCritical;
         if(_loc8_.id != fightContext.originalCaster.id)
         {
            fightContext.inputPortalCellId = -1;
         }
         DamageCalculator.loopCountIterations = DamageCalculator.loopCountIterations + 1;
         if(DamageCalculator.loopCountIterations > DamageCalculator.MAX_LOOP_ITERATIONS)
         {
            _loc12_ = "[Damage Preview] Infinite loop detected after " + DamageCalculator.MAX_LOOP_ITERATIONS + " iterations";
            HaxeLogger.logInfiniteLoop(_loc12_,param2);
            throw _loc12_;
         }
         if(DamageCalculator.START_TIME != -1 && Date.now().getTime() - DamageCalculator.START_TIME > 1000)
         {
            _loc12_ = "[Damage Preview] Preview takes too long to run";
            if(!DamageCalculator.isDebug)
            {
               HaxeLogger.logInfiniteLoop(_loc12_,param2);
               throw _loc12_;
            }
            _loc12_ += ". If you didn\'t use any breakpoint, please fix the code";
            HaxeLogger.logInfiniteLoop(_loc12_,param2);
         }
         if(SpellManager.isInstantaneousSpellEffect(effect) || param2.isTriggered)
         {
            if(effect.actionId == 2023)
            {
               if(effect.zone.shape == "P")
               {
                  _loc14_ = fightContext.map.getMarkInteractingWithCell(fightContext.targetedCell,5);
                  _loc15_ = 0;
                  while(_loc15_ < int(_loc14_.length))
                  {
                     _loc16_ = _loc14_[_loc15_];
                     _loc15_++;
                     if(_loc16_.casterId == _loc8_.id)
                     {
                        DamageCalculator.executeMarkSpell(null,_loc16_,param2,fightContext,param3);
                     }
                  }
               }
               else
               {
                  _loc14_ = fightContext.map.getMarks(5,_loc8_.teamId);
                  _loc15_ = 0;
                  while(_loc15_ < int(_loc14_.length))
                  {
                     _loc16_ = _loc14_[_loc15_];
                     _loc15_++;
                     if(_loc16_.casterId == _loc8_.id && effect.zone.isCellInZone(_loc16_.mainCell,fightContext.targetedCell,int(_loc8_.getCurrentPositionCell())))
                     {
                        DamageCalculator.executeMarkSpell(null,_loc16_,param2,fightContext,param3);
                     }
                  }
               }
               return;
            }
            _loc13_ = ActionIdHelper.isSummonWithoutTarget(effect.actionId);
            if(_loc13_ == true)
            {
               _loc17_ = fightContext.getFighterFromCell(fightContext.targetedCell);
               _loc15_ = Math.floor(Number(Math.max(0,int(_loc8_.data.getCharacteristicValue(26)) - int(fightContext.getFighterCurrentSummonCount(_loc8_)))));
               _loc14_ = [];
               if(!!fightContext.map.isCellWalkable(fightContext.targetedCell) && (_loc17_ == null || !_loc17_.isAlive()))
               {
                  if(effect.actionId == 1097)
                  {
                     _loc18_ = MapTools.getCellCoordById(int(_loc8_.getCurrentPositionCell()));
                     _loc19_ = MapTools.getDistance(int(_loc8_.getCurrentPositionCell()),fightContext.targetedCell);
                     _loc20_ = [new Point(_loc18_.x + _loc19_,_loc18_.y),new Point(_loc18_.x - _loc19_,_loc18_.y),new Point(_loc18_.x,_loc18_.y + _loc19_),new Point(_loc18_.x,_loc18_.y - _loc19_)];
                     _loc21_ = 0;
                     while(_loc21_ < int(_loc20_.length))
                     {
                        _loc22_ = _loc20_[_loc21_];
                        _loc21_++;
                        _loc23_ = MapTools.getCellIdByCoord(_loc22_.x,_loc22_.y);
                        if(!!fightContext.map.isCellWalkable(_loc23_) && fightContext.getFighterFromCell(_loc23_) == null)
                        {
                           _loc10_ = DamageCalculator.summon(effect,fightContext,_loc8_,_loc23_);
                           if(_loc10_ != null)
                           {
                              if(_loc10_.data.useSummonSlot())
                              {
                                 if(_loc15_ <= 0)
                                 {
                                    continue;
                                 }
                                 _loc15_--;
                              }
                              _loc14_.push(_loc10_);
                           }
                        }
                     }
                  }
                  else
                  {
                     _loc10_ = DamageCalculator.summon(effect,fightContext,_loc8_);
                     if(_loc10_ != null)
                     {
                        if(!_loc10_.data.useSummonSlot() || _loc15_ > 0)
                        {
                           _loc14_.push(_loc10_);
                        }
                     }
                  }
               }
               _loc19_ = 0;
               while(_loc19_ < int(_loc14_.length))
               {
                  _loc24_ = _loc14_[_loc19_];
                  _loc19_++;
                  param4.push(_loc24_);
               }
            }
            else
            {
               _loc17_ = param2.getCaster();
               if(!(_loc17_.playerType == PlayerTypeEnum.MONSTER && _loc17_.data.isSummon() && int(HaxeFighter.BOMB_BREED_ID.indexOf(_loc17_.breed)) != -1))
               {
                  _loc24_ = param2.getCaster();
                  _loc25_ = _loc24_.playerType == PlayerTypeEnum.MONSTER && _loc24_.data.isSummon() && int(HaxeFighter.STEAMER_TURRET_BREED_ID.indexOf(_loc24_.breed)) != -1;
               }
               else
               {
                  _loc25_ = true;
               }
               if(_loc25_)
               {
                  param2.overrideCaster(param2.getCaster().getSummoner(fightContext));
               }
               if((ActionIdHelper.isDamage(effect.category,effect.actionId) || ActionIdHelper.isHeal(effect.actionId)) == true)
               {
                  _loc11_ = DamageSender.getTotalDamage(fightContext,param2,param3);
               }
               else
               {
                  _loc26_ = ActionIdHelper.isShield(effect.actionId);
                  _loc11_ = _loc26_ == true ? DamageSender.getTotalShield(param2,param3) : DamageRange.ZERO;
               }
               _loc11_.probability = param2.probability;
               if(_loc8_ != param2.getCaster())
               {
                  param2.overrideCaster(_loc8_);
               }
            }
         }
         ArraySort.sort(param4,function(param1:HaxeFighter, param2:HaxeFighter):int
         {
            return int(TargetManagement.comparePositions(fightContext.targetedCell,Boolean(ActionIdHelper.isPush(effect.actionId)),int(param1.getCurrentPositionCell()),int(param2.getCurrentPositionCell())));
         });
         _loc15_ = 0;
         while(_loc15_ < int(param4.length))
         {
            _loc17_ = param4[_loc15_];
            _loc15_++;
            if(_loc17_.data.isInvisible())
            {
               continue;
            }
            if(int(param2.getSpellEffect().triggers.indexOf("X")) == -1 && !_loc17_.isAlive() && !_loc17_.isSummonCastPreviewed && param2.getSpellEffect().rawZone.charAt(0) != "A" && !ActionIdHelper.isRevive(effect.actionId))
            {
               continue;
            }
            if(!SpellManager.isInstantaneousSpellEffect(effect) && !param2.isTriggered)
            {
               _loc17_.storePendingBuff(HaxeBuff.fromRunningEffect(param2));
               continue;
            }
            _loc19_ = effect.actionId;
            if((_loc19_ != 117 && _loc19_ != 116 && ActionIdHelper.isStatModifier(_loc19_)) == true)
            {
               _loc27_ = HaxeBuff.fromRunningEffect(param2);
               if(param2.isTriggered)
               {
                  _loc27_.effect = _loc27_.effect.clone();
                  _loc27_.effect.triggers = ["I"];
               }
               _loc17_.storePendingBuff(_loc27_);
               if(_loc27_.effect.actionId == 169 || _loc27_.effect.actionId == 168)
               {
                  if(_loc27_.effect.actionId == 169)
                  {
                     effect.actionId = 1080;
                  }
                  else if(_loc27_.effect.actionId == 168)
                  {
                     effect.actionId = 1079;
                  }
                  DamageCalculator.computeEffect(fightContext,param2,param3,[_loc17_],null,param6);
               }
               continue;
            }
            _loc13_ = ActionIdHelper.isStatBoost(_loc19_);
            if(_loc13_ == true)
            {
               _loc8_.storeSpellEffectStatBoost(_loc7_,effect);
               continue;
            }
            _loc25_ = _loc19_ == 1008 && _loc10_ == null || ActionIdHelper.isSpellExecution(_loc19_);
            if(_loc25_ == true)
            {
               if(ActionIdHelper.spellExecutionHasGlobalLimitation(effect.actionId))
               {
                  _loc9_++;
                  if(_loc9_ > effect.param3)
                  {
                     return;
                  }
               }
               _loc28_ = new ObjectMap();
               _loc21_ = 0;
               _loc14_ = fightContext.fighters;
               while(_loc21_ < int(_loc14_.length))
               {
                  _loc24_ = _loc14_[_loc21_];
                  _loc21_++;
                  _loc28_[_loc24_] = int(_loc24_.getBeforeLastSpellPosition());
                  _loc24_.savePositionBeforeSpellExecution();
               }
               _loc29_ = DamageCalculator.solveSpellExecution(fightContext,param2,_loc17_,param3);
               if(_loc29_ != null)
               {
                  DamageCalculator.executeSpell(_loc29_.context,_loc29_.caster,_loc29_.spell,Boolean(_loc29_.isCritical),param2,param3,!_loc8_.data.isAlly());
               }
               _loc30_ = _loc28_.keys();
               while(_loc30_.hasNext())
               {
                  _loc24_ = _loc30_.next();
                  _loc24_.setBeforeLastSpellPosition(_loc28_[_loc24_]);
               }
               continue;
            }
            _loc21_ = _loc19_;
            if(_loc21_ == 406)
            {
               _loc8_.removeBuffBySpellId(effect.param3);
               continue;
            }
            if(_loc21_ == 952)
            {
               _loc17_.removeState(effect.param3);
               continue;
            }
            if(_loc21_ == 1009)
            {
               _loc14_ = TargetManagement.getBombsAboutToExplode(_loc17_,fightContext,param2);
               _loc23_ = 0;
               while(_loc23_ < int(_loc14_.length))
               {
                  _loc24_ = _loc14_[_loc23_];
                  _loc23_++;
                  _loc31_ = DamageCalculator.dataInterface.getBombExplosionSpellFromFighter(_loc24_);
                  if(_loc31_ != null)
                  {
                     _loc32_ = fightContext.copy();
                     _loc32_.targetedCell = int(_loc24_.getCurrentPositionCell());
                     DamageCalculator.executeSpell(_loc32_,_loc24_,_loc31_,param2.forceCritical,param2,param3);
                  }
               }
               continue;
            }
            if(_loc21_ == 1159)
            {
               _loc33_ = effect.param1 * 0.01;
               _loc34_ = param2.triggeringOutput.damageRange;
               if(_loc34_ != null && !_loc34_.isInvulnerable && !_loc34_.isCollision && _loc34_.isHeal)
               {
                  _loc34_.multiply(_loc33_);
               }
               continue;
            }
            _loc26_ = ActionIdHelper.isTargetMarkDispell(_loc19_);
            if(_loc26_ == true)
            {
               _loc23_ = effect.actionId;
               if(_loc23_ == 2018)
               {
                  _loc21_ = 1;
               }
               else if(_loc23_ == 2019)
               {
                  _loc21_ = 2;
               }
               else if(_loc23_ == 2024)
               {
                  _loc21_ = 5;
               }
               else
               {
                  _loc21_ = 0;
               }
               _loc23_ = 0;
               _loc14_ = fightContext.map.getMarks(_loc21_,_loc17_.teamId);
               while(_loc23_ < int(_loc14_.length))
               {
                  _loc16_ = _loc14_[_loc23_];
                  _loc23_++;
                  if(_loc16_.casterId == _loc17_.id && (effect.param1 == 0 || effect.param1 == _loc16_.associatedSpell.id))
                  {
                     _loc16_.active = false;
                  }
               }
               continue;
            }
            _loc35_ = MapTools.areCellsAdjacent(int(param2.getCaster().getCurrentPositionCell()),int(_loc17_.getCurrentPositionCell()));
            _loc21_ = effect.actionId;
            if(Boolean(ActionIdHelper.isTeleport(_loc21_)) == true)
            {
               _loc14_ = Teleport.teleportFighter(fightContext,param2,_loc17_,param3);
            }
            else
            {
               _loc23_ = _loc21_;
               if(_loc23_ == 50)
               {
                  _loc14_ = Teleport.carryFighter(fightContext,param2,_loc17_);
               }
               else if(_loc23_ == 51)
               {
                  _loc24_ = param2.getCaster();
                  _loc14_ = Teleport.throwFighter(fightContext,_loc24_,param2,param3);
               }
               else
               {
                  if(_loc23_ != 116)
                  {
                     if(_loc23_ != 117)
                     {
                        if(_loc23_ != 320)
                        {
                           if(_loc23_ == 141)
                           {
                              _loc36_ = ActionIdHelper.isPush(_loc21_);
                              if(_loc36_ == true)
                              {
                                 _loc39_ = effect.param1;
                                 _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                 _loc41_ = Boolean(ActionIdHelper.allowCollisionDamage(effect.actionId));
                                 _loc14_ = PushUtils.push(fightContext,param2,_loc17_,_loc39_,_loc40_,_loc41_,param3);
                              }
                              else
                              {
                                 _loc37_ = ActionIdHelper.isPull(_loc21_);
                                 if(_loc37_ == true)
                                 {
                                    _loc39_ = effect.param1;
                                    _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                    _loc14_ = PushUtils.pull(fightContext,param2,_loc17_,_loc39_,_loc40_,param3);
                                 }
                                 else
                                 {
                                    _loc14_ = [EffectOutput.deathOf(_loc17_.id)];
                                 }
                              }
                              addr2788:
                              _loc40_ = false;
                              if(ActionIdHelper.isTargetMaxLifeAffected(effect.actionId))
                              {
                                 _loc14_.push(EffectOutput.fromAffectedMaxLifePoints(_loc17_.id));
                              }
                              _loc23_ = 0;
                              while(_loc23_ < int(_loc14_.length))
                              {
                                 _loc42_ = _loc14_[_loc23_];
                                 _loc23_++;
                                 if(_loc42_.damageRange != null && param6 == true)
                                 {
                                    _loc42_.unknown = true;
                                 }
                                 _loc24_ = fightContext.getFighterById(_loc42_.fighterId);
                                 if(_loc42_.damageRange != null)
                                 {
                                    _loc34_ = _loc42_.damageRange;
                                    _loc41_ = !(_loc34_.min == 0 && _loc34_.max == 0);
                                 }
                                 else
                                 {
                                    _loc41_ = false;
                                 }
                                 if(_loc41_)
                                 {
                                    _loc42_.areLifePointsAffected = true;
                                    _loc34_ = DamageReceiver.getPermanentDamage(_loc42_.damageRange,_loc24_);
                                    _loc42_.areErodedLifePointsAffected = _loc34_ != null && !(_loc34_.min == 0 && _loc34_.max == 0);
                                 }
                                 if(_loc42_.areErodedLifePointsAffected)
                                 {
                                    _loc42_.areMaxLifePointsAffected = true;
                                 }
                                 if(_loc42_.death)
                                 {
                                    fightContext.addLastKilledAlly(_loc24_);
                                 }
                                 if(_loc42_.summon != null)
                                 {
                                    _loc40_ = true;
                                 }
                                 _loc24_.pendingEffects.add(_loc42_);
                              }
                              DamageCalculator.triggerHandler(_loc14_,param2,fightContext,_loc17_,_loc35_,param3);
                              if(_loc40_ == true && _loc10_ != null)
                              {
                                 _loc31_ = DamageCalculator.dataInterface.getStartingSpell(_loc10_,effect.param2);
                                 if(_loc31_ != null)
                                 {
                                    DamageCalculator.executeSpell(fightContext,_loc10_,_loc31_,param2.forceCritical,null,param3,param6);
                                 }
                              }
                              continue;
                           }
                           if(_loc23_ == 783)
                           {
                              _loc14_ = PushUtils.pushTo(fightContext,param2,_loc17_,false,false,param3);
                           }
                           else if(_loc23_ == 786)
                           {
                              _loc36_ = ActionIdHelper.isPush(_loc21_);
                              if(_loc36_ == true)
                              {
                                 _loc39_ = effect.param1;
                                 _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                 _loc41_ = Boolean(ActionIdHelper.allowCollisionDamage(effect.actionId));
                                 _loc14_ = PushUtils.push(fightContext,param2,_loc17_,_loc39_,_loc40_,_loc41_,param3);
                              }
                              else
                              {
                                 _loc37_ = ActionIdHelper.isPull(_loc21_);
                                 if(_loc37_ == true)
                                 {
                                    _loc39_ = effect.param1;
                                    _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                    _loc14_ = PushUtils.pull(fightContext,param2,_loc17_,_loc39_,_loc40_,param3);
                                 }
                                 else
                                 {
                                    _loc43_ = effect.getDamageInterval();
                                    _loc34_ = param2.triggeringOutput.computeLifeDamage();
                                    _loc24_ = param2.getParentEffect() != null ? param2.getParentEffect().getCaster() : null;
                                    if(_loc34_ != null && _loc24_ != null && !_loc34_.isHeal && !_loc34_.isInvulnerable && !(_loc34_.min == 0 && _loc34_.max == 0))
                                    {
                                       _loc34_.multiply(_loc43_.min);
                                       _loc34_.multiply(0.01);
                                       _loc34_.isHeal = true;
                                       _loc34_.isShieldDamage = false;
                                       _loc14_ = [EffectOutput.fromDamageRange(_loc24_.id,_loc34_)];
                                    }
                                    else
                                    {
                                       _loc14_ = [];
                                    }
                                 }
                              }
                           }
                           else if(_loc23_ == 950)
                           {
                              _loc36_ = ActionIdHelper.isPush(_loc21_);
                              if(_loc36_ == true)
                              {
                                 _loc39_ = effect.param1;
                                 _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                 _loc41_ = Boolean(ActionIdHelper.allowCollisionDamage(effect.actionId));
                                 _loc14_ = PushUtils.push(fightContext,param2,_loc17_,_loc39_,_loc40_,_loc41_,param3);
                              }
                              else
                              {
                                 _loc37_ = ActionIdHelper.isPull(_loc21_);
                                 if(_loc37_ == true)
                                 {
                                    _loc39_ = effect.param1;
                                    _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                    _loc14_ = PushUtils.pull(fightContext,param2,_loc17_,_loc39_,_loc40_,param3);
                                 }
                                 else
                                 {
                                    _loc27_ = HaxeBuff.fromRunningEffect(param2);
                                    if(param2.isTriggered)
                                    {
                                       _loc27_.effect.triggers = ["I"];
                                    }
                                    _loc17_.storePendingBuff(_loc27_);
                                    _loc14_ = [EffectOutput.fromStateChange(_loc17_.id,effect.param3,true)];
                                 }
                              }
                           }
                           else if(_loc23_ == 951)
                           {
                              _loc36_ = ActionIdHelper.isPush(_loc21_);
                              if(_loc36_ == true)
                              {
                                 _loc39_ = effect.param1;
                                 _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                 _loc41_ = Boolean(ActionIdHelper.allowCollisionDamage(effect.actionId));
                                 _loc14_ = PushUtils.push(fightContext,param2,_loc17_,_loc39_,_loc40_,_loc41_,param3);
                              }
                              else
                              {
                                 _loc37_ = ActionIdHelper.isPull(_loc21_);
                                 if(_loc37_ == true)
                                 {
                                    _loc39_ = effect.param1;
                                    _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                    _loc14_ = PushUtils.pull(fightContext,param2,_loc17_,_loc39_,_loc40_,param3);
                                 }
                                 else
                                 {
                                    _loc14_ = !!_loc17_.removeState(int(effect.getMinRoll())) ? [EffectOutput.fromStateChange(_loc17_.id,effect.param3,false)] : [];
                                 }
                              }
                           }
                           else if(_loc23_ == 1043)
                           {
                              _loc14_ = PushUtils.pullTo(fightContext,param2,_loc17_,false,param3);
                           }
                           else if(_loc23_ == 1075)
                           {
                              _loc36_ = ActionIdHelper.isPush(_loc21_);
                              if(_loc36_ == true)
                              {
                                 _loc39_ = effect.param1;
                                 _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                 _loc41_ = Boolean(ActionIdHelper.allowCollisionDamage(effect.actionId));
                                 _loc14_ = PushUtils.push(fightContext,param2,_loc17_,_loc39_,_loc40_,_loc41_,param3);
                              }
                              else
                              {
                                 _loc37_ = ActionIdHelper.isPull(_loc21_);
                                 if(_loc37_ == true)
                                 {
                                    _loc39_ = effect.param1;
                                    _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                    _loc14_ = PushUtils.pull(fightContext,param2,_loc17_,_loc39_,_loc40_,param3);
                                 }
                                 else
                                 {
                                    _loc20_ = _loc17_.reduceBuffDurations(int(effect.getMinRoll()));
                                    if(_loc20_ != null && int(_loc20_.length) > 0)
                                    {
                                       _loc44_ = [EffectOutput.fromDispell(_loc17_.id)];
                                       _loc39_ = 0;
                                       while(_loc39_ < int(_loc20_.length))
                                       {
                                          _loc27_ = _loc20_[_loc39_];
                                          _loc39_++;
                                          if(_loc27_.effect.actionId == 950)
                                          {
                                             _loc44_.push(EffectOutput.fromStateChange(_loc17_.id,_loc27_.effect.param3,false));
                                          }
                                       }
                                       _loc14_ = _loc44_;
                                    }
                                    else
                                    {
                                       _loc14_ = [];
                                    }
                                 }
                              }
                           }
                           else
                           {
                              if(_loc23_ != 84)
                              {
                                 if(_loc23_ != 1079)
                                 {
                                    if(_loc23_ != 77)
                                    {
                                       if(_loc23_ != 1080)
                                       {
                                          _loc36_ = ActionIdHelper.isPush(_loc21_);
                                          if(_loc36_ == true)
                                          {
                                             _loc23_ = effect.param1;
                                             _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                             _loc41_ = Boolean(ActionIdHelper.allowCollisionDamage(effect.actionId));
                                             _loc14_ = PushUtils.push(fightContext,param2,_loc17_,_loc23_,_loc40_,_loc41_,param3);
                                          }
                                          else
                                          {
                                             _loc37_ = ActionIdHelper.isPull(_loc21_);
                                             if(_loc37_ == true)
                                             {
                                                _loc23_ = effect.param1;
                                                _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                                _loc14_ = PushUtils.pull(fightContext,param2,_loc17_,_loc23_,_loc40_,param3);
                                                §§goto(addr2788);
                                             }
                                             else
                                             {
                                                _loc38_ = ActionIdHelper.isSummon(_loc21_);
                                                if(_loc38_ == true)
                                                {
                                                   if(!!ActionIdHelper.isSummonWithoutTarget(effect.actionId) && _loc10_ != null)
                                                   {
                                                      _loc23_ = effect.actionId;
                                                      if(_loc23_ != 180)
                                                      {
                                                         if(_loc23_ != 1097)
                                                         {
                                                            if(_loc23_ == 1189)
                                                            {
                                                               addr2306:
                                                               _loc33_ = _loc8_.id;
                                                            }
                                                            else
                                                            {
                                                               _loc33_ = 0;
                                                            }
                                                            _loc23_ = MapTools.getLookDirection4(int(_loc8_.getCurrentPositionCell()),int(_loc17_.getCurrentPositionCell()));
                                                            _loc14_ = [EffectOutput.fromSummon(_loc17_.id,int(_loc17_.getCurrentPositionCell()),_loc23_,_loc33_),EffectOutput.fromSummoning(_loc8_.id)];
                                                            addr2432:
                                                            §§goto(addr2788);
                                                         }
                                                      }
                                                      §§goto(addr2306);
                                                   }
                                                   else if(!!ActionIdHelper.isKillAndSummon(effect.actionId) && (!DamageCalculator.summonTakesSlot(effect,fightContext,_loc8_) || int(fightContext.getFighterCurrentSummonCount(_loc8_)) > int(_loc8_.data.getCharacteristicValue(26))))
                                                   {
                                                      _loc20_ = [EffectOutput.deathOf(_loc17_.id)];
                                                      _loc24_ = DamageCalculator.summon(effect,fightContext,_loc8_);
                                                      _loc23_ = MapTools.getLookDirection4(int(_loc8_.getCurrentPositionCell()),int(_loc24_.getCurrentPositionCell()));
                                                      if(_loc24_ != null)
                                                      {
                                                         _loc20_.push(EffectOutput.fromSummon(_loc24_.id,int(_loc24_.getCurrentPositionCell()),_loc23_));
                                                         _loc20_.push(EffectOutput.fromSummoning(_loc8_.id));
                                                      }
                                                      _loc14_ = _loc20_;
                                                   }
                                                   else
                                                   {
                                                      _loc14_ = [];
                                                   }
                                                   §§goto(addr2432);
                                                }
                                                else
                                                {
                                                   _loc23_ = effect.actionId;
                                                   if(_loc23_ == 80)
                                                   {
                                                      _loc34_ = PushUtils.getCollisionDamage(fightContext,_loc8_,_loc17_,effect.param1,effect.param2);
                                                   }
                                                   else
                                                   {
                                                      _loc40_ = ActionIdHelper.isBasedOnTargetLife(_loc23_);
                                                      _loc34_ = _loc40_ == true ? DamageReceiver.getDamageBasedOnTargetLife(param2.getSpellEffect(),_loc17_,_loc11_.copy()) : _loc11_.copy();
                                                   }
                                                   if(param2.getCaster() == _loc17_)
                                                   {
                                                      _loc35_ = false;
                                                      if(effect.actionId == 90)
                                                      {
                                                         _loc34_.isHeal = false;
                                                      }
                                                   }
                                                   if(!ActionIdHelper.isFakeDamage(effect.actionId) && effect.actionId != 80 && !(_loc34_.min == 0 && _loc34_.max == 0))
                                                   {
                                                      _loc33_ = 1;
                                                      if((param5 == null || int(param5.indexOf(_loc17_)) == -1) && ActionIdHelper.allowAOEMalus(effect.actionId))
                                                      {
                                                         _loc39_ = 0;
                                                         if(effect.zone.radius >= 1)
                                                         {
                                                            _loc45_ = effect.zone;
                                                            _loc39_ = _loc45_.getAOEMalus(fightContext.targetedCell,int(_loc8_.getCurrentPositionCell()),int(_loc17_.getBeforeLastSpellPosition()));
                                                         }
                                                         _loc33_ *= (100 - _loc39_) / 100;
                                                      }
                                                      if(fightContext.usingPortal())
                                                      {
                                                         _loc33_ *= Number(1 + int(fightContext.getPortalBonus()) * 0.01);
                                                      }
                                                      _loc34_.multiply(_loc33_);
                                                   }
                                                   _loc39_ = effect.actionId;
                                                   if(_loc39_ == 106)
                                                   {
                                                      _loc42_ = param2.triggeringOutput;
                                                      _loc48_ = param2.triggeringOutput.damageRange;
                                                      _loc49_ = param2.getParentEffect();
                                                      _loc24_ = _loc49_ != null ? _loc49_.getCaster() : null;
                                                      _loc50_ = _loc49_ != null ? _loc49_.getSpell().level : 1;
                                                      _loc51_ = _loc49_ != null && _loc49_.getSpell().isWeapon;
                                                      if(_loc24_ != null && _loc49_ != null && _loc48_ != null && !_loc42_.damageRange.isCollision && _loc50_ <= effect.param2 && !_loc51_)
                                                      {
                                                         _loc17_.pendingEffects.remove(_loc42_);
                                                         _loc14_ = DamageReceiver.receiveDamageOrHeal(fightContext,_loc49_,_loc42_.damageRange,_loc24_,_loc35_,param3);
                                                      }
                                                      else
                                                      {
                                                         _loc14_ = [];
                                                      }
                                                   }
                                                   else
                                                   {
                                                      _loc41_ = Boolean(ActionIdHelper.isShield(_loc39_));
                                                      if(_loc41_ == true)
                                                      {
                                                         _loc14_ = [EffectOutput.fromDamageRange(_loc17_.id,_loc34_)];
                                                      }
                                                      else
                                                      {
                                                         _loc46_ = ActionIdHelper.isHeal(_loc39_);
                                                         if(_loc46_ == true)
                                                         {
                                                            _loc14_ = DamageReceiver.receiveDamageOrHeal(fightContext,param2,_loc34_,_loc17_,_loc35_,param3);
                                                         }
                                                         else
                                                         {
                                                            _loc47_ = ActionIdHelper.isDamage(effect.category,effect.actionId);
                                                            _loc14_ = _loc47_ == true ? DamageReceiver.receiveDamageOrHeal(fightContext,param2,_loc34_,_loc17_,_loc35_,param3) : [];
                                                         }
                                                      }
                                                   }
                                                   §§goto(addr2788);
                                                }
                                             }
                                          }
                                       }
                                       §§goto(addr2788);
                                    }
                                    _loc36_ = ActionIdHelper.isPush(_loc21_);
                                    if(_loc36_ == true)
                                    {
                                       _loc39_ = effect.param1;
                                       _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                       _loc41_ = Boolean(ActionIdHelper.allowCollisionDamage(effect.actionId));
                                       _loc14_ = PushUtils.push(fightContext,param2,_loc17_,_loc39_,_loc40_,_loc41_,param3);
                                    }
                                    else
                                    {
                                       _loc37_ = ActionIdHelper.isPull(_loc21_);
                                       if(_loc37_ == true)
                                       {
                                          _loc39_ = effect.param1;
                                          _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                          _loc14_ = PushUtils.pull(fightContext,param2,_loc17_,_loc39_,_loc40_,param3);
                                       }
                                       else
                                       {
                                          _loc14_ = [EffectOutput.fromAmTheft(_loc17_.id,effect.getDamageInterval().min)];
                                       }
                                    }
                                 }
                                 §§goto(addr2788);
                              }
                              _loc36_ = ActionIdHelper.isPush(_loc21_);
                              if(_loc36_ == true)
                              {
                                 _loc39_ = effect.param1;
                                 _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                 _loc41_ = Boolean(ActionIdHelper.allowCollisionDamage(effect.actionId));
                                 _loc14_ = PushUtils.push(fightContext,param2,_loc17_,_loc39_,_loc40_,_loc41_,param3);
                              }
                              else
                              {
                                 _loc37_ = ActionIdHelper.isPull(_loc21_);
                                 if(_loc37_ == true)
                                 {
                                    _loc39_ = effect.param1;
                                    _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                                    _loc14_ = PushUtils.pull(fightContext,param2,_loc17_,_loc39_,_loc40_,param3);
                                 }
                                 else
                                 {
                                    _loc14_ = [EffectOutput.fromApTheft(_loc17_.id,effect.getDamageInterval().min)];
                                 }
                              }
                           }
                           §§goto(addr2788);
                        }
                        §§goto(addr2788);
                     }
                  }
                  _loc36_ = ActionIdHelper.isPush(_loc21_);
                  if(_loc36_ == true)
                  {
                     _loc39_ = effect.param1;
                     _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                     _loc41_ = Boolean(ActionIdHelper.allowCollisionDamage(effect.actionId));
                     _loc14_ = PushUtils.push(fightContext,param2,_loc17_,_loc39_,_loc40_,_loc41_,param3);
                  }
                  else
                  {
                     _loc37_ = ActionIdHelper.isPull(_loc21_);
                     if(_loc37_ == true)
                     {
                        _loc39_ = effect.param1;
                        _loc40_ = ActionIdHelper.isForcedDrag(effect.actionId);
                        _loc14_ = PushUtils.pull(fightContext,param2,_loc17_,_loc39_,_loc40_,param3);
                     }
                     else
                     {
                        _loc42_ = new EffectOutput(_loc17_.id);
                        _loc39_ = effect.getDamageInterval().min;
                        if(effect.actionId == 320 || effect.actionId == 116)
                        {
                           _loc42_.rangeLoss = _loc39_;
                        }
                        else
                        {
                           _loc42_.rangeGain = _loc39_;
                        }
                        _loc14_ = [_loc42_];
                     }
                  }
               }
            }
            §§goto(addr2788);
         }
      }
      
      public static function summonTakesSlot(param1:HaxeSpellEffect, param2:FightContext, param3:HaxeFighter) : Boolean
      {
         if(!ActionIdHelper.isSummonWithSlot(param1.actionId))
         {
            if(param1.actionId == 181)
            {
               return Boolean(DamageCalculator.dataInterface.summonMonster(param3,param1.param1,param1.param2).data.useSummonSlot());
            }
            return false;
         }
         return true;
      }
      
      public static function summon(param1:HaxeSpellEffect, param2:FightContext, param3:HaxeFighter, param4:int = -1) : HaxeFighter
      {
         var _loc6_:* = null as HaxeFighter;
         var _loc8_:Boolean = false;
         if(!MapTools.isValidCellId(param4))
         {
            param4 = param2.targetedCell;
         }
         var _loc5_:HaxeFighter = param2.getFighterFromCell(param4);
         if(!param2.map.isCellWalkable(param4) || _loc5_ != null && _loc5_.isAlive())
         {
            return null;
         }
         var _loc7_:int = param1.actionId;
         var _loc9_:int = _loc7_;
         if(_loc9_ != 180)
         {
            if(_loc9_ != 1097)
            {
               if(_loc9_ == 1189)
               {
                  addr57:
                  _loc6_ = param3.copy(param2);
               }
               else
               {
                  _loc8_ = ActionIdHelper.isRevive(_loc7_);
                  _loc6_ = _loc8_ == true ? param2.getLastKilledAlly(param3.teamId) : DamageCalculator.dataInterface.summonMonster(param3,param1.param1,param1.param2);
               }
               if(_loc6_ == null)
               {
                  return null;
               }
               var _loc10_:HaxeFighter = param2.getFighterById(_loc6_.id);
               if(!!ActionIdHelper.isRevive(param1.actionId) && _loc10_ != null && _loc10_.isAlive())
               {
                  return null;
               }
               _loc6_.setCurrentPositionCell(param4);
               _loc6_.beforeLastSpellPosition = param4;
               if(param2.getFighterById(_loc6_.id) == null)
               {
                  param2.tempFighters.push(_loc6_);
                  param2.fighters.push(_loc6_);
               }
               return _loc6_;
            }
         }
         §§goto(addr57);
      }
      
      public static function triggerHandler(param1:Array, param2:RunningEffect, param3:FightContext, param4:HaxeFighter, param5:Boolean, param6:Boolean) : void
      {
         var _loc8_:* = null as EffectOutput;
         var _loc9_:* = null as HaxeFighter;
         var _loc10_:Boolean = false;
         var _loc7_:int = 0;
         while(_loc7_ < int(param1.length))
         {
            _loc8_ = param1[_loc7_];
            _loc7_++;
            if(_loc8_.damageRange != null && param2.forceCritical)
            {
               _loc8_.damageRange.isCritical = true;
            }
            _loc9_ = param3.getFighterById(_loc8_.fighterId);
            _loc10_ = MapTools.areCellsAdjacent(int(param2.getCaster().getCurrentPositionCell()),int(_loc9_.getCurrentPositionCell()));
            DamageCalculator.triggerEffects(param3,param2,_loc9_,_loc10_,_loc8_,param6);
         }
      }
      
      public static function getAOEMalus(param1:HaxeSpellEffect, param2:int, param3:HaxeFighter, param4:HaxeFighter) : Number
      {
         var _loc6_:* = null as SpellZone;
         var _loc5_:int = 0;
         if(param1.zone.radius >= 1)
         {
            _loc6_ = param1.zone;
            _loc5_ = _loc6_.getAOEMalus(param2,int(param3.getCurrentPositionCell()),int(param4.getBeforeLastSpellPosition()));
         }
         return (100 - _loc5_) / 100;
      }
      
      public static function triggerEffects(param1:FightContext, param2:RunningEffect, param3:HaxeFighter, param4:Boolean, param5:EffectOutput, param6:Boolean) : Boolean
      {
         var fightContext:FightContext = param1;
         var triggeringRunningEffect:RunningEffect = param2;
         var target:HaxeFighter = param3;
         var melee:Boolean = param4;
         var triggeringOutput:EffectOutput = param5;
         var isPreview:Boolean = param6;
         var hasTriggerEffect:Boolean = false;
         var _loc7_:Function = function(param1:LinkedList, param2:Boolean, param3:Function, param4:HaxeFighter):void
         {
            var _loc6_:* = null as LinkedListNode;
            var _loc7_:* = null as LinkedListNode;
            var _loc8_:* = null as HaxeBuff;
            var _loc9_:* = null as HaxeFighter;
            var _loc10_:* = null as HaxeSpellEffect;
            var _loc11_:* = null as RunningEffect;
            var _loc12_:* = null as FightContext;
            var _loc5_:LinkedListNode = param1.head;
            while(_loc5_ != null)
            {
               _loc6_ = _loc5_;
               _loc5_ = _loc5_.next;
               _loc7_ = _loc6_;
               _loc8_ = _loc7_.item;
               if(_loc8_.effect.actionId == 792 || _loc8_.effect.actionId == 793 || int(_loc8_.effect.triggers.indexOf("K")) != -1 || int(_loc8_.effect.triggers.indexOf("KWW")) != -1 || int(_loc8_.effect.triggers.indexOf("KWS")) != -1 || int(_loc8_.effect.triggers.indexOf("PO")) != -1)
               {
                  _loc9_ = param4;
               }
               else
               {
                  _loc9_ = target;
               }
               if(!(_loc8_.effect.triggers == null || int(_loc8_.effect.triggers.length) == 0 || int(_loc8_.effect.triggers.length) == 1 && _loc8_.effect.triggers[0] == "I" || !_loc8_.canBeTriggeredBy(triggeringRunningEffect) || !!ActionIdHelper.isSpellExecution(_loc8_.effect.actionId) && _loc8_.effect.param3 > 0 && int(_loc8_.get_triggerCount()) >= _loc8_.effect.param3 || !!param2 && int(_loc8_.hasBeenTriggeredOn.indexOf(_loc9_.id)) != -1))
               {
                  if(param3(_loc8_))
                  {
                     if(_loc8_.effect.isCritical)
                     {
                        _loc10_ = _loc8_.effect.clone();
                        _loc10_.isCritical = false;
                     }
                     else
                     {
                        _loc10_ = _loc8_.effect;
                     }
                     _loc11_ = new RunningEffect(fightContext.getFighterById(_loc8_.casterId),_loc8_.spell,_loc10_);
                     _loc11_.triggeredByEffectSetting(triggeringRunningEffect);
                     _loc11_.triggeringOutput = triggeringOutput;
                     _loc11_.isTriggered = true;
                     _loc11_.forceCritical = triggeringRunningEffect.forceCritical;
                     _loc12_ = fightContext.copy();
                     _loc12_.targetedCell = int(_loc9_.getBeforeLastSpellPosition());
                     if(param2)
                     {
                        _loc8_.hasBeenTriggeredOn.push(_loc9_.id);
                     }
                     _loc8_.incrementTriggerCount();
                     DamageCalculator.computeEffect(_loc12_,_loc11_,isPreview,[_loc9_],null);
                     hasTriggerEffect = true;
                  }
               }
            }
         };
         var _loc8_:HaxeFighter = triggeringRunningEffect.getCaster();
         _loc7_(target._buffs.copy(),false,function(param1:HaxeBuff):Boolean
         {
            return Boolean(param1.shouldBeTriggeredOnTarget(triggeringOutput,triggeringRunningEffect,target,melee,fightContext));
         },target);
         _loc7_(_loc8_._buffs.copy(),true,function(param1:HaxeBuff):Boolean
         {
            return Boolean(param1.shouldBeTriggeredOnCaster(triggeringOutput,triggeringRunningEffect,target,melee,fightContext));
         },_loc8_);
         return hasTriggerEffect;
      }
      
      public static function solveSpellExecution(param1:FightContext, param2:RunningEffect, param3:HaxeFighter, param4:Boolean) : Object
      {
         var _loc10_:int = 0;
         var _loc5_:HaxeFighter = param2.getCaster();
         var _loc6_:HaxeFighter = !!param2.isTriggered ? param2.triggeringFighter : _loc5_;
         var _loc7_:HaxeFighter = null;
         var _loc8_:HaxeFighter = null;
         var _loc9_:Boolean = false;
         _loc10_ = param2.getSpellEffect().actionId;
         if(_loc10_ != 792)
         {
            if(_loc10_ != 793)
            {
               if(_loc10_ != 2792)
               {
                  if(_loc10_ == 2793)
                  {
                     addr41:
                     _loc7_ = param3;
                     _loc8_ = param3;
                  }
                  else if(_loc10_ == 1018)
                  {
                     _loc7_ = _loc6_;
                     _loc8_ = param3;
                  }
                  else if(_loc10_ == 1019)
                  {
                     _loc7_ = _loc6_;
                     _loc8_ = _loc6_;
                  }
                  else
                  {
                     if(_loc10_ != 1017)
                     {
                        if(_loc10_ != 2017)
                        {
                           if(_loc10_ != 1008)
                           {
                              if(_loc10_ != 1160)
                              {
                                 if(_loc10_ != 2160)
                                 {
                                    if(_loc10_ != 2794)
                                    {
                                       if(_loc10_ != 2795)
                                       {
                                          throw "ActionId " + param2.getSpellEffect().actionId + " is not a spell execution";
                                       }
                                    }
                                    _loc7_ = param3;
                                    _loc8_ = param3;
                                    _loc9_ = true;
                                    addr123:
                                    var _loc11_:HaxeSpellEffect = param2.getSpellEffect();
                                    var _loc12_:Boolean = _loc9_;
                                    if(_loc12_ == false)
                                    {
                                       _loc10_ = _loc8_.getBeforeLastSpellPosition();
                                    }
                                    else if(_loc12_ == true)
                                    {
                                       _loc10_ = param1.targetedCell;
                                    }
                                    var _loc13_:FightContext = param1.copy();
                                    _loc13_.targetedCell = _loc10_;
                                    _loc12_ = param2.getFirstParentEffect().getSpellEffect().isCritical;
                                    var _loc14_:HaxeSpell = _loc11_.actionId == 1008 ? DamageCalculator.dataInterface.getBombCastOnFighterSpell(_loc11_.param1,_loc11_.param2) : DamageCalculator.dataInterface.createSpellFromId(_loc11_.param1,_loc11_.param2);
                                    if(_loc14_ != null)
                                    {
                                       return {
                                          "context":_loc13_,
                                          "caster":_loc7_,
                                          "spell":_loc14_,
                                          "isCritical":_loc12_
                                       };
                                    }
                                    return null;
                                 }
                                 §§goto(addr123);
                              }
                           }
                           _loc7_ = _loc5_;
                           _loc8_ = param3;
                        }
                        §§goto(addr123);
                     }
                     _loc7_ = param3;
                     _loc8_ = _loc6_;
                  }
                  §§goto(addr123);
               }
            }
         }
         §§goto(addr41);
      }
      
      public static function executeMarks(param1:FightContext, param2:RunningEffect, param3:HaxeFighter, param4:int, param5:Boolean) : void
      {
         var _loc7_:int = 0;
         var _loc8_:* = null as Mark;
         var _loc9_:int = 0;
         var _loc10_:* = null as Array;
         var _loc6_:Array = param1.map.getMarkInteractingWithCell(param4);
         if(_loc6_ != null)
         {
            _loc7_ = 0;
            while(_loc7_ < int(_loc6_.length))
            {
               _loc8_ = _loc6_[_loc7_];
               _loc7_++;
               if(!(!!_loc8_.active && int(param1.triggeredMarks.indexOf(_loc8_.markId)) == -1))
               {
                  continue;
               }
               switch(_loc8_.markType)
               {
                  case 2:
                     DamageCalculator.executeMarkSpell(param3,_loc8_,param2,param1,param5);
                     break;
                  case 3:
                     DamageCalculator.executeWallDamage(param3,_loc8_,param2,param1,param5);
                     break;
                  case 4:
                     _loc9_ = param1.map.getOutputPortalCell(param4);
                     _loc10_ = param1.map.getMarkInteractingWithCell(_loc9_,4);
                     param1.triggeredMarks.push(_loc8_.markId);
                     param1.triggeredMarks.push(_loc10_[0].markId);
                     param3.setCurrentPositionCell(_loc9_);
                     break;
               }
            }
         }
      }
      
      public static function executeMarkSpell(param1:HaxeFighter, param2:Mark, param3:RunningEffect, param4:FightContext, param5:Boolean) : void
      {
         if(!param2.active || FpUtils.arrayContains_Int(param4.triggeredMarks,param2.markId))
         {
            return;
         }
         param4.triggeredMarks.push(param2.markId);
         var _loc6_:FightContext = param4.copy();
         _loc6_.targetedCell = param2.mainCell;
         _loc6_.inMovement = true;
         var _loc7_:HaxeFighter = param4.getFighterById(param2.casterId);
         if(param1 != null)
         {
            param1.savePositionBeforeSpellExecution();
         }
         DamageCalculator.executeSpell(_loc6_,_loc7_,param2.associatedSpell,param3.forceCritical,param3,param5,!_loc7_.data.isAlly());
      }
      
      public static function executeWallDamage(param1:HaxeFighter, param2:Mark, param3:RunningEffect, param4:FightContext, param5:Boolean) : void
      {
         var _loc8_:* = null as HaxeFighter;
         var _loc9_:* = null as LinkedListNode;
         var _loc10_:* = null as LinkedListNode;
         var _loc11_:* = null as LinkedListNode;
         var _loc6_:int = 0;
         var _loc7_:Array = DamageCalculator.getBombsLinkedToWall(param1,param4);
         while(_loc6_ < int(_loc7_.length))
         {
            _loc8_ = _loc7_[_loc6_];
            _loc6_++;
            _loc9_ = _loc8_._buffs.head;
            while(_loc9_ != null)
            {
               _loc10_ = _loc9_;
               _loc9_ = _loc9_.next;
               _loc11_ = _loc10_;
               if(_loc11_.item.effect.actionId == 1027)
               {
                  _loc8_.getSummoner(param4).storePendingBuff(_loc11_.item);
               }
            }
            _loc8_.removeBuffByActionId(1027);
         }
         DamageCalculator.executeMarkSpell(param1,param2,param3,param4,param5);
      }
      
      public static function getBombsLinkedToWall(param1:HaxeFighter, param2:FightContext) : Array
      {
         var _loc6_:int = 0;
         var _loc7_:* = null as HaxeFighter;
         var _loc8_:int = 0;
         var _loc9_:* = null as HaxeFighter;
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var mainMark:Mark = param2.map.getMarkInteractingWithCell(int(param1.getCurrentPositionCell()),3)[0];
         var _loc5_:Array = param2.getFightersFromZone(DamageCalculator.WALL_ZONE,mainMark.mainCell,mainMark.mainCell);
         _loc5_.sort(function(param1:HaxeFighter, param2:HaxeFighter):int
         {
            return int(TargetManagement.comparePositions(mainMark.mainCell,false,int(param1.getCurrentPositionCell()),int(param2.getCurrentPositionCell())));
         });
         _loc6_ = 0;
         while(_loc6_ < int(_loc5_.length))
         {
            _loc7_ = _loc5_[_loc6_];
            _loc6_++;
            if(_loc7_.playerType == PlayerTypeEnum.MONSTER && _loc7_.data.isSummon() && int(HaxeFighter.BOMB_BREED_ID.indexOf(_loc7_.breed)) != -1 && Number(_loc7_.data.getSummonerId()) == mainMark.casterId)
            {
               if(int(_loc3_.length) == 0)
               {
                  _loc3_.push(_loc7_);
               }
               else
               {
                  _loc8_ = 0;
                  while(_loc8_ < int(_loc3_.length))
                  {
                     _loc9_ = _loc3_[_loc8_];
                     _loc8_++;
                     if(int(_loc3_.indexOf(_loc7_)) == -1)
                     {
                        _loc3_.push(_loc7_);
                     }
                     if(_loc9_ != _loc7_ && _loc7_.breed == _loc9_.breed && int(MapTools.getLookDirection4(int(_loc7_.getCurrentPositionCell()),int(_loc9_.getCurrentPositionCell()))) != -1 && int(MapTools.getDistance(int(_loc7_.getCurrentPositionCell()),int(_loc9_.getCurrentPositionCell()))) <= 7)
                     {
                        if(int(_loc4_.indexOf(_loc7_)) == -1)
                        {
                           _loc4_.push(_loc7_);
                        }
                        if(int(_loc4_.indexOf(_loc9_)) == -1)
                        {
                           _loc4_.push(_loc9_);
                        }
                        if(int(_loc4_.length) == 3)
                        {
                           return _loc4_;
                        }
                     }
                  }
               }
            }
         }
         if(int(_loc4_.length) < 3 && int(_loc3_.length) < 3)
         {
            _loc6_ = 0;
            while(_loc6_ < int(_loc4_.length))
            {
               _loc7_ = _loc4_[_loc6_];
               _loc6_++;
               if(int(_loc4_.length) == 3)
               {
                  break;
               }
               _loc5_ = param2.getFightersFromZone(DamageCalculator.WALL_ZONE,int(_loc7_.getCurrentPositionCell()),int(_loc7_.getCurrentPositionCell()));
               _loc8_ = 0;
               while(_loc8_ < int(_loc5_.length))
               {
                  _loc9_ = _loc5_[_loc8_];
                  _loc8_++;
                  if(Number(_loc9_.data.getSummonerId()) == mainMark.casterId && (_loc9_.playerType == PlayerTypeEnum.MONSTER && _loc9_.data.isSummon() && int(HaxeFighter.BOMB_BREED_ID.indexOf(_loc9_.breed)) != -1) && int(_loc4_.indexOf(_loc9_)) == -1 && _loc9_.breed == _loc7_.breed)
                  {
                     _loc4_.push(_loc9_);
                     break;
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public static function create32BitHashSpellLevel(param1:int, param2:int) : int
      {
         return param2 << 24 | param1;
      }
   }
}
