package damageCalculation.fighterManagement
{
   import damageCalculation.FightContext;
   import damageCalculation.damageManagement.DamageRange;
   import damageCalculation.damageManagement.EffectOutput;
   import damageCalculation.damageManagement.MovementInfos;
   import damageCalculation.damageManagement.SummonInfos;
   import damageCalculation.fighterManagement.fighterstats.HaxeSimpleStat;
   import damageCalculation.fighterManagement.fighterstats.HaxeStat;
   import damageCalculation.spellManagement.HaxeSpell;
   import damageCalculation.spellManagement.HaxeSpellEffect;
   import damageCalculation.spellManagement.HaxeSpellState;
   import damageCalculation.spellManagement.RunningEffect;
   import damageCalculation.spellManagement.SpellManager;
   import damageCalculation.tools.Interval;
   import damageCalculation.tools.LinkedList;
   import damageCalculation.tools.LinkedListNode;
   import haxe.ds.List;
   import haxe.ds._List.ListNode;
   import mapTools.MapTools;
   import tools.ActionIdHelper;
   import tools.FpUtils;
   
   public class HaxeFighter
   {
      
      public static var MAX_RESIST_HUMAN:int = 50;
      
      public static var MAX_RESIST_MONSTER:int = 100;
      
      public static var INVALID_ID:Number = 0;
      
      public static var BOMB_BREED_ID:Array = [3112,3113,3114,5161];
      
      public static var STEAMER_TURRET_BREED_ID:Array = [3287,3288,3289,5143,5141,5142];
      
      public static var MIN_PERMANENT_DAMAGE_PERCENT:int = 0;
      
      public static var BASE_PERMANENT_DAMAGE_PERCENT:int = 10;
      
      public static var MAX_PERMANENT_DAMAGE_PERCENT:int = 50;
       
      
      public var totalEffects:List;
      
      public var teamId:uint;
      
      public var playerType:PlayerTypeEnum;
      
      public var pendingEffects:List;
      
      public var level:int;
      
      public var lastTheoreticalRawDamageTaken:DamageRange;
      
      public var lastRawDamageTaken:DamageRange;
      
      public var isSummonCastPreviewed:Boolean;
      
      public var isStaticElement:Boolean;
      
      public var id:Number;
      
      public var data:IFighterData;
      
      public var breed:int;
      
      public var beforeLastSpellPosition:int;
      
      public var _turnBeginPosition:int;
      
      public var _save:Object;
      
      public var _pendingPreviousPosition:int;
      
      public var _pendingDispelledBuffs:LinkedList;
      
      public var _pendingBuffHead:LinkedListNode;
      
      public var _currentPosition:int;
      
      public var _carriedFighter:HaxeFighter;
      
      public var _buffs:LinkedList;
      
      public function HaxeFighter(param1:Number, param2:int, param3:int, param4:PlayerTypeEnum, param5:uint, param6:Boolean, param7:Array, param8:IFighterData, param9:Boolean = false)
      {
         var _loc11_:* = null as HaxeBuff;
         _save = null;
         _carriedFighter = null;
         _currentPosition = -1;
         _pendingPreviousPosition = -1;
         _pendingDispelledBuffs = new LinkedList();
         _pendingBuffHead = null;
         _buffs = new LinkedList();
         totalEffects = new List();
         lastTheoreticalRawDamageTaken = null;
         lastRawDamageTaken = null;
         beforeLastSpellPosition = -1;
         pendingEffects = new List();
         isSummonCastPreviewed = false;
         isStaticElement = false;
         teamId = uint(0);
         playerType = PlayerTypeEnum.UNKNOWN;
         level = 200;
         breed = -1;
         id = param1;
         level = param2;
         breed = param3;
         playerType = param4;
         isStaticElement = param6;
         data = param8;
         teamId = param5;
         isSummonCastPreviewed = param9;
         var _loc10_:int = 0;
         while(_loc10_ < int(param7.length))
         {
            _loc11_ = param7[_loc10_];
            _loc10_++;
            _buffs.add(_loc11_);
         }
      }
      
      public function wasTeleportedInInvalidCellThisTurn(param1:FightContext) : Boolean
      {
         var _loc3_:* = null as EffectOutput;
         var _loc4_:* = null as EffectOutput;
         var _loc2_:ListNode = pendingEffects.h;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.item;
            _loc2_ = _loc2_.next;
            _loc4_ = _loc3_;
            if(_loc4_.movement != null && !param1.map.isCellWalkable(_loc4_.movement.newPosition))
            {
               return true;
            }
         }
         return false;
      }
      
      public function wasTelefraggedThisTurn() : Boolean
      {
         var _loc2_:* = null as EffectOutput;
         var _loc3_:* = null as EffectOutput;
         var _loc1_:ListNode = pendingEffects.h;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.item;
            _loc1_ = _loc1_.next;
            _loc3_ = _loc2_;
            if(_loc3_.movement != null && _loc3_.movement.swappedWith != null)
            {
               return true;
            }
         }
         return false;
      }
      
      public function updateStatWithPercentValue(param1:HaxeStat, param2:int, param3:Boolean) : int
      {
         var _loc4_:int = !!param3 ? 1 : -1;
         var _loc5_:int = param1.get_total();
         var _loc6_:int = Math.floor(_loc4_ * param2);
         return int(Math.floor(_loc5_ + _loc6_));
      }
      
      public function updateStatFromFlatValue(param1:HaxeStat, param2:int, param3:Boolean) : int
      {
         var _loc6_:* = 0;
         var _loc8_:* = 0;
         var _loc4_:int = !!param3 ? 1 : -1;
         var _loc5_:Boolean = ActionIdHelper.isLinearBuffActionIds(int(param1.get_id()));
         var _loc7_:int = param1.get_total();
         if(_loc5_)
         {
            _loc6_ = param2 * _loc4_;
            _loc8_ = _loc7_ + _loc6_;
         }
         else
         {
            _loc6_ = int(Math.floor(100 * (1 + _loc4_ * param2 * 0.01))) - 100;
            if(_loc7_ == 0)
            {
               _loc8_ = int(_loc6_);
            }
            else
            {
               _loc8_ = int(Math.floor(_loc7_ * (1 + _loc6_ * 0.01)));
            }
         }
         return _loc8_;
      }
      
      public function updateStatFromBuff(param1:HaxeBuff, param2:Boolean) : void
      {
         var _loc5_:* = null as HaxeStat;
         var _loc3_:HaxeSpellEffect = param1.effect;
         if(!SpellManager.isInstantaneousSpellEffect(_loc3_))
         {
            return;
         }
         var _loc4_:int = ActionIdHelper.getStatIdFromStatActionId(_loc3_.actionId);
         if(_loc4_ != -1)
         {
            _loc5_ = data.getStat(_loc4_);
            if(_loc5_ == null)
            {
               _loc5_ = new HaxeSimpleStat(_loc4_,0);
               data.setStat(_loc5_);
            }
            _loc5_.updateStatFromEffect(_loc3_,param2);
         }
      }
      
      public function underMaximizeRollEffect() : Boolean
      {
         var _loc2_:* = null as LinkedListNode;
         var _loc3_:* = null as LinkedListNode;
         var _loc4_:* = null as HaxeBuff;
         var _loc1_:LinkedListNode = _buffs.head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_;
            _loc1_ = _loc1_.next;
            _loc3_ = _loc2_;
            _loc4_ = _loc3_.item;
            if(_loc4_.effect.actionId == 782)
            {
               return true;
            }
         }
         return false;
      }
      
      public function storeSpellEffectStatBoost(param1:HaxeSpell, param2:HaxeSpellEffect) : void
      {
         var _loc3_:HaxeSpellEffect = param2.clone();
         var _loc4_:int = ActionIdHelper.statBoostToBuffActionId(param2.actionId);
         _loc3_.actionId = _loc4_;
         var _loc5_:HaxeBuff = new HaxeBuff(id,param1,_loc3_);
         storePendingBuff(_loc5_);
      }
      
      public function storePendingBuff(param1:HaxeBuff) : void
      {
         var _loc2_:* = null as Function;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as LinkedListNode;
         var _loc7_:* = null as LinkedListNode;
         var _loc8_:* = null as LinkedListNode;
         if(param1.spell.maxEffectsStack != -1)
         {
            _loc2_ = function(param1:HaxeBuff, param2:HaxeBuff):Boolean
            {
               if(param1.effect.id != param2.effect.id)
               {
                  if(param1.spell.id == param2.spell.id && param1.effect.actionId == param2.effect.actionId)
                  {
                     if(!(param1.effect.order == param2.effect.order && param1.effect.level != param2.effect.level))
                     {
                        return param1.effect.isCritical != param2.effect.isCritical;
                     }
                     return true;
                  }
                  return false;
               }
               return true;
            };
            _loc3_ = 0;
            _loc4_ = 0;
            _loc5_ = false;
            _loc6_ = _buffs.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_;
               _loc6_ = _loc6_.next;
               _loc8_ = _loc7_;
               if(_loc8_ == _pendingBuffHead)
               {
                  _loc5_ = true;
               }
               if(_loc2_(param1,_loc8_.item))
               {
                  if(!_loc5_)
                  {
                     _loc3_++;
                  }
                  else
                  {
                     _loc4_++;
                  }
               }
            }
            if(_loc3_ + _loc4_ >= param1.spell.maxEffectsStack)
            {
               _loc5_ = false;
               _loc6_ = _buffs.head;
               while(_loc6_ != null)
               {
                  _loc7_ = _loc6_;
                  _loc6_ = _loc6_.next;
                  _loc8_ = _loc7_;
                  if(_loc8_ == _pendingBuffHead)
                  {
                     _loc5_ = true;
                  }
                  if(_loc2_(_loc8_.item,param1))
                  {
                     if(!_loc5_)
                     {
                        _pendingDispelledBuffs.add(_loc8_.item);
                     }
                     safeRemoveBuff(_loc8_);
                     break;
                  }
               }
            }
         }
         addPendingBuff(param1);
      }
      
      public function setCurrentPositionCell(param1:int) : void
      {
         _pendingPreviousPosition = int(getCurrentPositionCell());
         _currentPosition = param1;
         if(!!hasState(3) && _carriedFighter != null)
         {
            _carriedFighter.setCurrentPositionCell(param1);
         }
      }
      
      public function setBeforeLastSpellPosition(param1:int) : void
      {
         beforeLastSpellPosition = param1;
      }
      
      public function savePositionBeforeSpellExecution() : void
      {
         setBeforeLastSpellPosition(int(getCurrentPositionCell()));
      }
      
      public function savePendingEffects() : void
      {
         if(totalEffects != null && pendingEffects != null)
         {
            totalEffects = FpUtils.listConcat_damageCalculation_damageManagement_EffectOutput(totalEffects,pendingEffects);
         }
         else
         {
            totalEffects = pendingEffects;
         }
         pendingEffects = new List();
      }
      
      public function save() : Object
      {
         _save = {
            "id":id,
            "outputs":pendingEffects.map(function(param1:EffectOutput):EffectOutput
            {
               return param1;
            }),
            "buffs":_buffs.copy(),
            "cell":int(getCurrentPositionCell()),
            "previousPosition":_pendingPreviousPosition
         };
         return _save;
      }
      
      public function safeRemoveBuff(param1:LinkedListNode) : void
      {
         var _loc2_:Boolean = false;
         if(ActionIdHelper.isStatModifier(param1.item.effect.actionId))
         {
            _loc2_ = ActionIdHelper.isBuff(param1.item.effect.actionId);
            updateStatFromBuff(param1.item,!_loc2_);
         }
         if(param1 == _pendingBuffHead)
         {
            _pendingBuffHead = param1.next;
         }
         _buffs.remove(param1);
      }
      
      public function resetToInitialState() : void
      {
         var _loc2_:* = null as LinkedListNode;
         var _loc3_:* = null as LinkedListNode;
         var _loc4_:* = null as HaxeBuff;
         lastRawDamageTaken = null;
         setCurrentPositionCell(-1);
         setBeforeLastSpellPosition(-1);
         _pendingPreviousPosition = -1;
         flushPendingBuffs();
         pendingEffects = new List();
         var _loc1_:LinkedListNode = _buffs.head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_;
            _loc1_ = _loc1_.next;
            _loc3_ = _loc2_;
            _loc4_ = _loc3_.item;
            _loc4_._triggerCount = _loc4_._startingTriggerCount;
         }
      }
      
      public function removeState(param1:int) : Boolean
      {
         var _loc4_:* = null as LinkedListNode;
         var _loc5_:* = null as LinkedListNode;
         var _loc2_:Boolean = false;
         var _loc3_:LinkedListNode = _buffs.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_;
            _loc3_ = _loc3_.next;
            _loc5_ = _loc4_;
            if(_loc5_.item.effect.actionId == 950 && int(_loc5_.item.effect.getMinRoll()) == param1)
            {
               if(_loc5_ == _pendingBuffHead)
               {
                  _loc2_ = true;
               }
               if(!_loc2_)
               {
                  _pendingDispelledBuffs.add(_loc5_.item);
               }
               safeRemoveBuff(_loc5_);
               return true;
            }
         }
         return false;
      }
      
      public function removeBuffBySpellId(param1:int) : void
      {
         var _loc4_:* = null as LinkedListNode;
         var _loc5_:* = null as LinkedListNode;
         var _loc2_:Boolean = false;
         var _loc3_:LinkedListNode = _buffs.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_;
            _loc3_ = _loc3_.next;
            _loc5_ = _loc4_;
            if(_loc5_.item.spell.id == param1)
            {
               if(_loc5_ == _pendingBuffHead)
               {
                  _loc2_ = true;
               }
               if(!_loc2_)
               {
                  _pendingDispelledBuffs.add(_loc5_.item);
               }
               safeRemoveBuff(_loc5_);
            }
         }
      }
      
      public function removeBuffByActionId(param1:int) : void
      {
         var _loc4_:* = null as LinkedListNode;
         var _loc5_:* = null as LinkedListNode;
         var _loc2_:Boolean = false;
         var _loc3_:LinkedListNode = _buffs.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_;
            _loc3_ = _loc3_.next;
            _loc5_ = _loc4_;
            if(_loc5_.item.effect.actionId == param1)
            {
               if(_loc5_ == _pendingBuffHead)
               {
                  _loc2_ = true;
               }
               if(!_loc2_)
               {
                  _pendingDispelledBuffs.add(_loc5_.item);
               }
               safeRemoveBuff(_loc5_);
            }
         }
      }
      
      public function reduceBuffDurations(param1:int) : Array
      {
         var _loc5_:* = null as LinkedListNode;
         var _loc6_:* = null as LinkedListNode;
         var _loc7_:* = null as HaxeBuff;
         var _loc2_:Array = [];
         var _loc3_:Boolean = false;
         var _loc4_:LinkedListNode = _buffs.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_;
            _loc4_ = _loc4_.next;
            _loc6_ = _loc5_;
            _loc7_ = _loc6_.item;
            if(_loc7_.effect.duration > 0 && _loc7_.effect.duration <= param1 && _loc7_.effect.isDispellable)
            {
               if(_loc6_ == _pendingBuffHead)
               {
                  _loc3_ = true;
               }
               if(!_loc3_)
               {
                  _loc2_.push(_loc7_);
                  _pendingDispelledBuffs.add(_loc7_);
               }
               safeRemoveBuff(_loc6_);
            }
         }
         return _loc2_;
      }
      
      public function load(param1:Object = undefined) : Boolean
      {
         if(param1 == null)
         {
            if(_save != null)
            {
               return Boolean(load(_save));
            }
            return false;
         }
         if(id == Number(param1.id))
         {
            pendingEffects = FpUtils.listCopy_damageCalculation_damageManagement_EffectOutput(param1.outputs);
            _buffs = param1.buffs.copy();
            setCurrentPositionCell(int(param1.cell));
            _pendingPreviousPosition = int(param1.previousPosition);
            return true;
         }
         return false;
      }
      
      public function isUnlucky() : Boolean
      {
         var _loc3_:* = null as LinkedListNode;
         var _loc4_:* = null as LinkedListNode;
         var _loc5_:* = null as HaxeBuff;
         var _loc1_:Boolean = false;
         var _loc2_:LinkedListNode = _buffs.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_;
            _loc2_ = _loc2_.next;
            _loc4_ = _loc3_;
            _loc5_ = _loc4_.item;
            if(_loc5_.effect.actionId == 781)
            {
               _loc1_ = true;
               break;
            }
         }
         return _loc1_;
      }
      
      public function isSwitchTeleport(param1:int = -1) : Boolean
      {
         if(!(param1 == 1104 || param1 == 1105 || param1 == 1106 || param1 == 784 || param1 == 1099 || param1 == 1100))
         {
            return param1 == 8;
         }
         return true;
      }
      
      public function isSteamerTurret() : Boolean
      {
         if(playerType == PlayerTypeEnum.MONSTER && data.isSummon())
         {
            return int(HaxeFighter.STEAMER_TURRET_BREED_ID.indexOf(breed)) != -1;
         }
         return false;
      }
      
      public function isPacifist() : Boolean
      {
         return Boolean(hasStateEffect(6));
      }
      
      public function isLinkedBomb(param1:HaxeFighter) : Boolean
      {
         if(param1 != null && (param1.playerType == PlayerTypeEnum.MONSTER && param1.data.isSummon() && int(HaxeFighter.BOMB_BREED_ID.indexOf(param1.breed)) != -1))
         {
            if(Number(param1.data.getSummonerId()) != Number(data.getSummonerId()))
            {
               return Number(param1.data.getSummonerId()) == id;
            }
            return true;
         }
         return false;
      }
      
      public function isInvulnerableWeapon() : Boolean
      {
         return Boolean(hasStateEffect(28));
      }
      
      public function isInvulnerableWater() : Boolean
      {
         return Boolean(hasStateEffect(23));
      }
      
      public function isInvulnerableTo(param1:RunningEffect, param2:Boolean = false, param3:int = undefined) : Boolean
      {
         var _loc4_:HaxeSpellEffect = param1.getSpellEffect();
         var _loc5_:HaxeFighter = param1.getCaster();
         if(hasStateEffect(7) || !!hasStateEffect(27) && _loc4_.isCritical || !!hasStateEffect(28) && param1.getSpell().isWeapon || !!hasStateEffect(31) && _loc5_ != null && _loc5_.data.isSummon() || !!hasStateEffect(26) && _loc4_.actionId == 80 || !!hasStateEffect(25) && param3 == 0 || !!hasStateEffect(24) && param3 == 1 || !!hasStateEffect(23) && param3 == 3 || !!hasStateEffect(21) && param3 == 2 || !!hasStateEffect(22) && param3 == 4 || !!hasStateEffect(19) && param2 || !!hasStateEffect(20) && !param2)
         {
            return true;
         }
         return false;
      }
      
      public function isInvulnerableSummon() : Boolean
      {
         return Boolean(hasStateEffect(31));
      }
      
      public function isInvulnerableRange() : Boolean
      {
         return Boolean(hasStateEffect(20));
      }
      
      public function isInvulnerablePush() : Boolean
      {
         return Boolean(hasStateEffect(26));
      }
      
      public function isInvulnerableNeutral() : Boolean
      {
         return Boolean(hasStateEffect(25));
      }
      
      public function isInvulnerableMelee() : Boolean
      {
         return Boolean(hasStateEffect(19));
      }
      
      public function isInvulnerableFire() : Boolean
      {
         return Boolean(hasStateEffect(21));
      }
      
      public function isInvulnerableEarth() : Boolean
      {
         return Boolean(hasStateEffect(24));
      }
      
      public function isInvulnerableCritical() : Boolean
      {
         return Boolean(hasStateEffect(27));
      }
      
      public function isInvulnerableAir() : Boolean
      {
         return Boolean(hasStateEffect(22));
      }
      
      public function isInvulnerable() : Boolean
      {
         return Boolean(hasStateEffect(7));
      }
      
      public function isInvisible() : Boolean
      {
         return Boolean(hasState(250));
      }
      
      public function isIncurable() : Boolean
      {
         return Boolean(hasStateEffect(5));
      }
      
      public function isCarrying() : Boolean
      {
         return Boolean(hasState(3));
      }
      
      public function isCarried() : Boolean
      {
         return Boolean(hasState(8));
      }
      
      public function isBomb() : Boolean
      {
         if(playerType == PlayerTypeEnum.MONSTER && data.isSummon())
         {
            return int(HaxeFighter.BOMB_BREED_ID.indexOf(breed)) != -1;
         }
         return false;
      }
      
      public function isAppearing() : Boolean
      {
         var _loc2_:* = null as EffectOutput;
         var _loc3_:* = null as EffectOutput;
         var _loc1_:ListNode = pendingEffects.h;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.item;
            _loc1_ = _loc1_.next;
            _loc3_ = _loc2_;
            if(_loc3_.summon != null)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isAlive() : Boolean
      {
         var _loc3_:* = null as EffectOutput;
         var _loc4_:* = null as EffectOutput;
         var _loc1_:Boolean = false;
         var _loc2_:ListNode = pendingEffects.h;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.item;
            _loc2_ = _loc2_.next;
            _loc4_ = _loc3_;
            if(_loc4_.death)
            {
               _loc1_ = true;
            }
            else if(_loc4_.summon != null)
            {
               _loc1_ = false;
            }
         }
         if(!_loc1_)
         {
            return int(data.getHealthPoints()) > 0;
         }
         return false;
      }
      
      public function hasStateEffect(param1:int) : Boolean
      {
         var _loc3_:* = null as LinkedListNode;
         var _loc4_:* = null as LinkedListNode;
         var _loc5_:* = null as HaxeBuff;
         var _loc2_:LinkedListNode = _buffs.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_;
            _loc2_ = _loc2_.next;
            _loc4_ = _loc3_;
            _loc5_ = _loc4_.item;
            if(_loc5_.spellState != null && int(_loc5_.spellState._stateEffects.indexOf(param1)) != -1 && SpellManager.isInstantaneousSpellEffect(_loc5_.effect))
            {
               if(hasState(_loc5_.effect.param3))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function hasState(param1:int) : Boolean
      {
         var _loc5_:* = null as LinkedListNode;
         var _loc6_:* = null as LinkedListNode;
         var _loc7_:* = null as HaxeBuff;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:LinkedListNode = _buffs.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_;
            _loc4_ = _loc4_.next;
            _loc6_ = _loc5_;
            _loc7_ = _loc6_.item;
            if(_loc7_.effect.actionId == 950 && int(_loc7_.effect.getMinRoll()) == param1 && SpellManager.isInstantaneousSpellEffect(_loc7_.effect))
            {
               _loc2_ = true;
            }
            if(_loc7_.effect.actionId == 952 && int(_loc7_.effect.getMinRoll()) == param1 && SpellManager.isInstantaneousSpellEffect(_loc7_.effect))
            {
               _loc3_ = true;
               break;
            }
         }
         if(_loc2_)
         {
            return !_loc3_;
         }
         return false;
      }
      
      public function getSummoner(param1:FightContext) : HaxeFighter
      {
         var _loc2_:Number = Number(data.getSummonerId());
         return param1.getFighterById(_loc2_);
      }
      
      public function getSpellDamageModification(param1:int) : int
      {
         var _loc4_:* = null as LinkedListNode;
         var _loc5_:* = null as LinkedListNode;
         var _loc6_:* = null as HaxeBuff;
         var _loc2_:* = 0;
         var _loc3_:LinkedListNode = _buffs.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_;
            _loc3_ = _loc3_.next;
            _loc5_ = _loc4_;
            _loc6_ = _loc5_.item;
            if(_loc6_.effect.actionId == 283 && _loc6_.effect.param1 == param1)
            {
               _loc2_ += _loc6_.effect.param3;
            }
         }
         return _loc2_;
      }
      
      public function getSpellBaseDamageModification(param1:int) : int
      {
         var _loc4_:* = null as LinkedListNode;
         var _loc5_:* = null as LinkedListNode;
         var _loc6_:* = null as HaxeBuff;
         var _loc2_:* = 0;
         var _loc3_:LinkedListNode = _buffs.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_;
            _loc3_ = _loc3_.next;
            _loc5_ = _loc4_;
            _loc6_ = _loc5_.item;
            if(_loc6_.effect.actionId == 293 && _loc6_.effect.param1 == param1)
            {
               _loc2_ += _loc6_.effect.param3;
            }
         }
         return _loc2_;
      }
      
      public function getSharingDamageTargets(param1:FightContext) : Array
      {
         var _loc2_:* = null as Array;
         var _loc5_:* = null as LinkedListNode;
         var _loc6_:* = null as LinkedListNode;
         var _loc7_:* = null as HaxeBuff;
         var _loc8_:int = 0;
         var _loc9_:* = null as Array;
         var _loc10_:* = null as HaxeFighter;
         var _loc11_:* = null as LinkedListNode;
         var _loc12_:* = null as LinkedListNode;
         var _loc13_:* = null as LinkedListNode;
         var _loc14_:* = null as HaxeBuff;
         var _loc3_:Array = [];
         var _loc4_:LinkedListNode = _buffs.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_;
            _loc4_ = _loc4_.next;
            _loc6_ = _loc5_;
            _loc7_ = _loc6_.item;
            if(_loc7_.effect.actionId == 1061)
            {
               _loc2_ = [];
               _loc8_ = 0;
               _loc9_ = param1.getEveryFighter();
               while(_loc8_ < int(_loc9_.length))
               {
                  _loc10_ = _loc9_[_loc8_];
                  _loc8_++;
                  if(_loc10_.id != id)
                  {
                     _loc11_ = _loc10_._buffs.head;
                     while(_loc11_ != null)
                     {
                        _loc12_ = _loc11_;
                        _loc11_ = _loc11_.next;
                        _loc13_ = _loc12_;
                        _loc14_ = _loc13_.item;
                        if(_loc14_.effect.actionId == 1061 && _loc7_.spell.id == _loc14_.spell.id && _loc7_.casterId == _loc14_.casterId)
                        {
                           _loc2_.push(_loc10_);
                           break;
                        }
                     }
                  }
               }
               _loc2_.push(this);
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getPendingShield() : Interval
      {
         var _loc3_:* = null as DamageRange;
         var _loc4_:* = null as DamageRange;
         var _loc1_:Interval = new Interval(int(data.getCharacteristicValue(96)),int(data.getCharacteristicValue(96)));
         var _loc2_:ListNode = FpUtils.listConcat_damageCalculation_damageManagement_DamageRange(pendingEffects.map(function(param1:EffectOutput):DamageRange
         {
            return param1.computeLifeDamage();
         }),pendingEffects.map(function(param1:EffectOutput):DamageRange
         {
            return param1.computeShieldDamage();
         })).h;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.item;
            _loc2_ = _loc2_.next;
            _loc4_ = _loc3_;
            if(!!_loc4_.isHeal && _loc4_.isShieldDamage)
            {
               _loc1_.addInterval(_loc4_);
            }
            else if(!_loc4_.isHeal && _loc4_.isShieldDamage)
            {
               _loc1_.subInterval(_loc4_);
            }
         }
         _loc1_.minimizeBy(0);
         return _loc1_;
      }
      
      public function getPendingPreviousPosition() : int
      {
         if(_pendingPreviousPosition != -1)
         {
            return _pendingPreviousPosition;
         }
         var _loc1_:int = data.getPreviousPosition();
         if(_loc1_ != -1)
         {
            return _loc1_;
         }
         return int(getCurrentPositionCell());
      }
      
      public function getPendingMissingLifePoints() : Interval
      {
         var _loc3_:* = null as EffectOutput;
         var _loc4_:* = null as EffectOutput;
         var _loc5_:* = null as DamageRange;
         var _loc1_:Interval = new Interval(int(data.getMaxHealthPoints()) - int(data.getHealthPoints()),int(data.getMaxHealthPoints()) - int(data.getHealthPoints()));
         var _loc2_:ListNode = pendingEffects.h;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.item;
            _loc2_ = _loc2_.next;
            _loc4_ = _loc3_;
            _loc5_ = _loc4_.damageRange;
            if(_loc5_ != null)
            {
               if(!!_loc5_.isHeal && !_loc5_.isShieldDamage)
               {
                  _loc1_.subInterval(_loc5_);
               }
               else if(!_loc5_.isHeal && !_loc5_.isShieldDamage && !_loc5_.isInvulnerable)
               {
                  _loc1_.addInterval(_loc5_);
               }
            }
         }
         _loc1_.minimizeBy(0);
         _loc1_.maximizeBy(int(data.getMaxHealthPoints()));
         return _loc1_;
      }
      
      public function getPendingLifePoints() : Interval
      {
         var _loc3_:* = null as EffectOutput;
         var _loc4_:* = null as EffectOutput;
         var _loc5_:* = null as DamageRange;
         var _loc1_:Interval = new Interval(int(data.getHealthPoints()),int(data.getHealthPoints()));
         var _loc2_:ListNode = pendingEffects.h;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.item;
            _loc2_ = _loc2_.next;
            _loc4_ = _loc3_;
            _loc5_ = _loc4_.damageRange;
            if(_loc5_ != null)
            {
               if(!!_loc5_.isHeal && !_loc5_.isShieldDamage)
               {
                  _loc1_.addInterval(_loc5_);
               }
               else if(!_loc5_.isHeal && !_loc5_.isShieldDamage && !_loc5_.isInvulnerable)
               {
                  _loc1_.subInterval(_loc4_.computeLifeDamage());
               }
            }
         }
         _loc1_.minimizeBy(0);
         _loc1_.maximizeBy(int(data.getMaxHealthPoints()));
         return _loc1_;
      }
      
      public function getPendingEffects() : List
      {
         return pendingEffects;
      }
      
      public function getModelId() : uint
      {
         return 0;
      }
      
      public function getMaxLife() : int
      {
         return int(data.getMaxHealthPoints());
      }
      
      public function getLifePoint() : int
      {
         return int(data.getHealthPoints());
      }
      
      public function getHealOnDamageRatio(param1:RunningEffect, param2:Boolean) : int
      {
         var _loc4_:* = null as LinkedListNode;
         var _loc5_:* = null as LinkedListNode;
         var _loc6_:* = null as HaxeBuff;
         var _loc3_:LinkedListNode = _buffs.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_;
            _loc3_ = _loc3_.next;
            _loc5_ = _loc4_;
            _loc6_ = _loc5_.item;
            if(_loc6_.effect.actionId == 1164 && (SpellManager.isInstantaneousSpellEffect(_loc6_.effect) || _loc6_.shouldBeTriggeredOnTargetDamage(param1,this,param2,false)))
            {
               return _loc6_.effect.param1;
            }
         }
         return 0;
      }
      
      public function getElementMainStat(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return int(data.getCharacteristicValue(10));
            case 1:
               return int(data.getCharacteristicValue(10));
            case 2:
               return int(data.getCharacteristicValue(15));
            case 3:
               return int(data.getCharacteristicValue(13));
            case 4:
               return int(data.getCharacteristicValue(14));
            case 6:
               return int(getElementMainStat(int(getBestElement())));
            default:
               return 0;
         }
      }
      
      public function getElementMainResist(param1:int) : int
      {
         var _loc3_:* = 0;
         var _loc2_:int = playerType == PlayerTypeEnum.HUMAN ? 50 : 100;
         switch(param1)
         {
            case 0:
               _loc3_ = int(data.getCharacteristicValue(37));
               break;
            case 1:
               _loc3_ = int(data.getCharacteristicValue(33));
               break;
            case 2:
               _loc3_ = int(data.getCharacteristicValue(34));
               break;
            case 3:
               _loc3_ = int(data.getCharacteristicValue(35));
               break;
            case 4:
               _loc3_ = int(data.getCharacteristicValue(36));
               break;
            default:
               _loc3_ = 0;
         }
         _loc3_ += int(data.getCharacteristicValue(101));
         return int(Math.round(Number(Math.min(_loc3_,_loc2_))));
      }
      
      public function getElementMainReduction(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return int(data.getCharacteristicValue(58));
            case 1:
               return int(data.getCharacteristicValue(54));
            case 2:
               return int(data.getCharacteristicValue(55));
            case 3:
               return int(data.getCharacteristicValue(56));
            case 4:
               return int(data.getCharacteristicValue(57));
            default:
               return 0;
         }
      }
      
      public function getElementFlatDamageBonus(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return int(data.getCharacteristicValue(92));
            case 1:
               return int(data.getCharacteristicValue(88));
            case 2:
               return int(data.getCharacteristicValue(89));
            case 3:
               return int(data.getCharacteristicValue(90));
            case 4:
               return int(data.getCharacteristicValue(91));
            case 6:
               return int(getElementFlatDamageBonus(int(getBestElement())));
            default:
               return 0;
         }
      }
      
      public function getEffectsDeltaFromSave() : List
      {
         var _loc1_:* = null as EffectOutput;
         var _loc2_:* = null as ListNode;
         var _loc3_:* = null as EffectOutput;
         if(_save != null && _save.outputs != null)
         {
            if(_save.outputs.isEmpty())
            {
               return pendingEffects;
            }
            _loc1_ = null;
            _loc2_ = _save.outputs.h;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.item;
               _loc2_ = _loc2_.next;
               _loc1_ = _loc3_;
            }
            return FpUtils.listAfter_damageCalculation_damageManagement_EffectOutput(pendingEffects,_loc1_);
         }
         return null;
      }
      
      public function getDynamicalDamageReflect() : DamageRange
      {
         var _loc3_:* = null as LinkedListNode;
         var _loc4_:* = null as LinkedListNode;
         var _loc5_:* = null as HaxeBuff;
         var _loc6_:* = null as Interval;
         var _loc1_:DamageRange = new DamageRange(0,0);
         var _loc2_:LinkedListNode = _buffs.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_;
            _loc2_ = _loc2_.next;
            _loc4_ = _loc3_;
            _loc5_ = _loc4_.item;
            if(_loc5_.effect.actionId == 220)
            {
               _loc1_.addInterval(_loc5_.effect.getDamageInterval());
            }
            else if(_loc5_.effect.actionId == 107)
            {
               _loc6_ = _loc5_.effect.getDamageInterval().multiply(int(level / 20) + 1);
               _loc1_.addInterval(_loc6_);
            }
         }
         return _loc1_;
      }
      
      public function getDamageReductor(param1:RunningEffect, param2:DamageRange, param3:Boolean) : Interval
      {
         var _loc5_:* = null as LinkedListNode;
         var _loc6_:* = null as LinkedListNode;
         var _loc7_:* = null as LinkedListNode;
         var _loc8_:* = null as HaxeBuff;
         var _loc4_:Interval = new Interval(0,0);
         if(ActionIdHelper.canTriggerDamageMultiplier(param1.getSpellEffect().actionId))
         {
            _loc5_ = _buffs.head;
            while(_loc5_ != null)
            {
               _loc6_ = _loc5_;
               _loc5_ = _loc5_.next;
               _loc7_ = _loc6_;
               _loc8_ = _loc7_.item;
               if(_loc8_.effect.actionId == 265 && (SpellManager.isInstantaneousSpellEffect(_loc8_.effect) || _loc8_.shouldBeTriggeredOnTargetDamage(param1,this,param3,param2.isCollision)))
               {
                  _loc4_.addInterval(_loc8_.effect.getDamageInterval().multiply(Number(level / 20 + 1)));
               }
            }
         }
         return _loc4_;
      }
      
      public function getDamageMultiplicator(param1:RunningEffect, param2:Boolean, param3:Boolean) : int
      {
         var _loc5_:* = null as LinkedListNode;
         var _loc6_:* = null as LinkedListNode;
         var _loc7_:* = null as LinkedListNode;
         var _loc8_:* = null as HaxeBuff;
         var _loc4_:int = 100;
         if(ActionIdHelper.canTriggerDamageMultiplier(param1.getSpellEffect().actionId))
         {
            _loc5_ = _buffs.head;
            while(_loc5_ != null)
            {
               _loc6_ = _loc5_;
               _loc5_ = _loc5_.next;
               _loc7_ = _loc6_;
               _loc8_ = _loc7_.item;
               if(_loc8_.effect.actionId == 1163 && (SpellManager.isInstantaneousSpellEffect(_loc8_.effect) || _loc8_.shouldBeTriggeredOnTargetDamage(param1,this,param2,param3)))
               {
                  _loc4_ = _loc4_ * _loc8_.effect.param1 * 0.01;
               }
            }
         }
         return _loc4_;
      }
      
      public function getDamageEffects() : List
      {
         return totalEffects.filter(function(param1:EffectOutput):Boolean
         {
            return param1.damageRange != null;
         }).map(function(param1:EffectOutput):DamageRange
         {
            return param1.damageRange;
         });
      }
      
      public function getCurrentReceivedDamageMultiplierMelee(param1:Boolean) : int
      {
         var _loc2_:int = !!param1 ? 124 : 121;
         var _loc3_:Number = int(data.getCharacteristicValue(_loc2_));
         return int(Number(Math.max(0,_loc3_)));
      }
      
      public function getCurrentReceivedDamageMultiplierCategory(param1:Boolean) : int
      {
         var _loc2_:int = !!param1 ? 142 : 141;
         var _loc3_:Number = int(data.getCharacteristicValue(_loc2_));
         return int(Number(Math.max(0,_loc3_)));
      }
      
      public function getCurrentPositionCell() : int
      {
         if(MapTools.isValidCellId(_currentPosition))
         {
            return _currentPosition;
         }
         return int(data.getStartedPositionCell());
      }
      
      public function getCurrentDealtDamageMultiplierMelee(param1:Boolean) : int
      {
         var _loc2_:int = !!param1 ? 125 : 120;
         var _loc3_:Number = int(data.getCharacteristicValue(_loc2_));
         return int(Number(Math.max(0,_loc3_)));
      }
      
      public function getCurrentDealtDamageMultiplierCategory(param1:Boolean) : int
      {
         var _loc2_:int = !!param1 ? 122 : 123;
         var _loc3_:Number = int(data.getCharacteristicValue(_loc2_));
         return int(Number(Math.max(0,_loc3_)));
      }
      
      public function getCarrier(param1:FightContext) : HaxeFighter
      {
         var _loc6_:* = null as HaxeFighter;
         var _loc2_:HaxeFighter = null;
         var _loc3_:int = getCurrentPositionCell();
         var _loc4_:int = 0;
         var _loc5_:Array = param1.fighters;
         while(_loc4_ < int(_loc5_.length))
         {
            _loc6_ = _loc5_[_loc4_];
            _loc4_++;
            if(int(_loc6_.getCurrentPositionCell()) == _loc3_ && _loc6_.getCarried(param1) == this)
            {
               return _loc6_;
            }
         }
         return null;
      }
      
      public function getCarried(param1:FightContext) : HaxeFighter
      {
         var _loc2_:* = null as HaxeFighter;
         if(_carriedFighter == null)
         {
            _loc2_ = param1.getCarriedFighterBy(this);
            if(_loc2_ != null && _loc2_.hasState(8))
            {
               _carriedFighter = _loc2_;
            }
         }
         return _carriedFighter;
      }
      
      public function getBuffs() : LinkedList
      {
         return _buffs;
      }
      
      public function getBestElement() : int
      {
         var _loc4_:int = 0;
         var _loc1_:int = 1;
         var _loc2_:Array = [0,2,3,4];
         var _loc3_:int = 0;
         while(_loc3_ < int(_loc2_.length))
         {
            _loc4_ = _loc2_[_loc3_];
            _loc3_++;
            if(int(getElementMainStat(_loc4_)) > int(getElementMainStat(_loc1_)) || int(getElementMainStat(_loc4_)) == int(getElementMainStat(_loc1_)) && int(getElementFlatDamageBonus(_loc4_)) > int(getElementFlatDamageBonus(_loc1_)))
            {
               _loc1_ = _loc4_;
            }
         }
         return _loc1_;
      }
      
      public function getBeforeLastSpellPosition() : int
      {
         if(beforeLastSpellPosition == -1)
         {
            return int(data.getStartedPositionCell());
         }
         return beforeLastSpellPosition;
      }
      
      public function getAllSacrificed() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:LinkedList = _buffs;
         var _loc3_:LinkedListNode = _loc2_.tail;
         var _loc4_:HaxeBuff = null;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.item;
            if(_loc4_.effect.actionId == 765)
            {
               _loc1_.push(_loc4_.casterId);
            }
            _loc3_ = _loc3_.previous;
         }
         return _loc1_;
      }
      
      public function flushPendingBuffs() : void
      {
         if(_pendingBuffHead != null)
         {
            if(_pendingBuffHead.previous != null)
            {
               _pendingBuffHead.previous.next = null;
               if(_pendingBuffHead == _buffs.tail)
               {
                  _buffs.tail = _pendingBuffHead.previous;
               }
            }
            else if(_pendingBuffHead == _buffs.head)
            {
               _buffs.clear();
            }
            _pendingBuffHead = null;
         }
         if(_pendingDispelledBuffs.head != null)
         {
            _buffs = _pendingDispelledBuffs.append(_buffs);
            _pendingDispelledBuffs = new LinkedList();
         }
      }
      
      public function copy(param1:FightContext) : HaxeFighter
      {
         var _loc10_:* = null as LinkedListNode;
         var _loc11_:* = null as LinkedListNode;
         var _loc2_:Number = Number(param1.getFreeId());
         var _loc3_:int = level;
         var _loc4_:int = breed;
         var _loc5_:PlayerTypeEnum = playerType;
         var _loc6_:uint = teamId;
         var _loc7_:Boolean = isStaticElement;
         var _loc8_:Array = [];
         var _loc9_:LinkedListNode = _buffs.head;
         while(_loc9_ != null)
         {
            _loc10_ = _loc9_;
            _loc9_ = _loc9_.next;
            _loc11_ = _loc10_;
            _loc8_.push(_loc11_.item);
         }
         return new HaxeFighter(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,data);
      }
      
      public function computeSeparatedPendingDamage() : List
      {
         return FpUtils.listConcat_damageCalculation_damageManagement_DamageRange(pendingEffects.map(function(param1:EffectOutput):DamageRange
         {
            return param1.computeLifeDamage();
         }),pendingEffects.map(function(param1:EffectOutput):DamageRange
         {
            return param1.computeShieldDamage();
         }));
      }
      
      public function carryFighter(param1:HaxeFighter) : void
      {
         _carriedFighter = param1;
      }
      
      public function canUsePortals() : Boolean
      {
         if(data.canBreedUsePortals())
         {
            return !hasStateEffect(17);
         }
         return false;
      }
      
      public function canTeleport(param1:int = -1, param2:Boolean = true, param3:int = undefined) : Boolean
      {
         if(!hasStateEffect(3) && !(!!hasStateEffect(18) && isSwitchTeleport(param1)))
         {
            if(param2)
            {
               return Boolean(data.canBreedSwitchPosOnTarget());
            }
            if(!data.canBreedSwitchPos())
            {
               return Boolean(ActionIdHelper.canTeleportOverBreedSwitchPos(param1));
            }
            return true;
         }
         return false;
      }
      
      public function canSwitchPosition(param1:HaxeFighter, param2:int = -1, param3:Boolean = true) : Boolean
      {
         if(hasState(3) || param1.hasState(3))
         {
            return false;
         }
         if(canTeleport(param2,param3,int(param1.getCurrentPositionCell())))
         {
            return !hasState(8);
         }
         return false;
      }
      
      public function canBePushed() : Boolean
      {
         if(!hasStateEffect(3) && data.canBreedBePushed())
         {
            return !hasStateEffect(0);
         }
         return false;
      }
      
      public function canBeMoved() : Boolean
      {
         return !hasStateEffect(3);
      }
      
      public function canBeCarried() : Boolean
      {
         if(!hasStateEffect(3) && data.canBreedBeCarried())
         {
            return !hasStateEffect(4);
         }
         return false;
      }
      
      public function addTotalEffects(param1:List) : void
      {
         if(totalEffects != null)
         {
            totalEffects = FpUtils.listConcat_damageCalculation_damageManagement_EffectOutput(totalEffects,param1);
         }
         else
         {
            totalEffects = param1;
         }
      }
      
      public function addPendingEffects(param1:EffectOutput) : void
      {
         pendingEffects.add(param1);
      }
      
      public function addPendingBuffs(param1:LinkedList) : void
      {
         var _loc3_:* = null as LinkedListNode;
         var _loc4_:* = null as LinkedListNode;
         var _loc5_:Boolean = false;
         var _loc2_:LinkedListNode = param1.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_;
            _loc2_ = _loc2_.next;
            _loc4_ = _loc3_;
            if(!!ActionIdHelper.isBuff(_loc4_.item.effect.actionId) && !ActionIdHelper.isShield(_loc4_.item.effect.actionId))
            {
               _loc5_ = true;
            }
            else
            {
               if(!(!!ActionIdHelper.isDebuff(_loc4_.item.effect.actionId) && !ActionIdHelper.isShield(_loc4_.item.effect.actionId)))
               {
                  continue;
               }
               _loc5_ = false;
            }
            updateStatFromBuff(_loc4_.item,_loc5_);
         }
         if(_pendingBuffHead == null)
         {
            _pendingBuffHead = param1.head;
         }
         _buffs = _buffs.append(param1);
      }
      
      public function addPendingBuff(param1:HaxeBuff) : void
      {
         var _loc2_:Boolean = false;
         if(_pendingBuffHead == null)
         {
            _pendingBuffHead = _buffs.add(param1);
         }
         else
         {
            _buffs.add(param1);
         }
         if(!!ActionIdHelper.isBuff(param1.effect.actionId) && !ActionIdHelper.isShield(param1.effect.actionId))
         {
            _loc2_ = true;
         }
         else
         {
            if(!(!!ActionIdHelper.isDebuff(param1.effect.actionId) && !ActionIdHelper.isShield(param1.effect.actionId)))
            {
               return;
            }
            _loc2_ = false;
         }
         updateStatFromBuff(param1,_loc2_);
      }
   }
}
