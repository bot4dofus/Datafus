package damageCalculation.spellManagement
{
   import damageCalculation.FightContext;
   import damageCalculation.damageManagement.EffectOutput;
   import damageCalculation.fighterManagement.HaxeFighter;
   import damageCalculation.fighterManagement.PlayerTypeEnum;
   import damageCalculation.tools.Interval;
   import haxe.ds.List;
   
   public class SpellManager
   {
      
      public static var EXCLUSIVE_MASKS_LIST:String = "*bBeEfFzZKoOPpTWUvVrRQq";
      
      public static var TELEFRAG_STATE:int = 251;
       
      
      public function SpellManager()
      {
      }
      
      public static function isSelectedByMask(param1:HaxeFighter, param2:Array, param3:HaxeFighter, param4:HaxeFighter, param5:FightContext) : Boolean
      {
         if(param2 == null || int(param2.length) == 0)
         {
            return true;
         }
         if(param3 == null)
         {
            return false;
         }
         if(SpellManager.isIncludedByMask(param1,param2,param3))
         {
            return Boolean(SpellManager.passMaskExclusion(param1,param2,param3,param4,param5));
         }
         return false;
      }
      
      public static function isIncludedByMask(param1:HaxeFighter, param2:Array, param3:HaxeFighter) : Boolean
      {
         var _loc5_:* = false;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:* = null as String;
         var _loc9_:* = null as String;
         var _loc4_:* = param3.id == param1.id;
         if(_loc4_)
         {
            if(int(param2.indexOf("c")) != -1 || int(param2.indexOf("C")) != -1 || int(param2.indexOf("a")) != -1)
            {
               return true;
            }
         }
         else
         {
            _loc5_ = param1.teamId == param3.teamId;
            _loc6_ = param3.data.isSummon();
            _loc7_ = 0;
            while(_loc7_ < int(param2.length))
            {
               _loc8_ = param2[_loc7_];
               _loc7_++;
               _loc9_ = _loc8_;
               if(_loc9_ == "A")
               {
                  if(!_loc5_)
                  {
                     return true;
                  }
               }
               else if(_loc9_ == "D")
               {
                  if(!_loc5_ && param3.playerType == PlayerTypeEnum.SIDEKICK)
                  {
                     return true;
                  }
               }
               else if(_loc9_ == "H")
               {
                  if(!_loc5_ && param3.playerType == PlayerTypeEnum.HUMAN && !_loc6_)
                  {
                     return true;
                  }
               }
               else if(_loc9_ == "I")
               {
                  if(!_loc5_ && param3.playerType != PlayerTypeEnum.SIDEKICK && _loc6_ && !param3.isStaticElement)
                  {
                     return true;
                  }
               }
               else if(_loc9_ == "J")
               {
                  if(!_loc5_ && param3.playerType != PlayerTypeEnum.SIDEKICK && _loc6_)
                  {
                     return true;
                  }
               }
               else if(_loc9_ == "L")
               {
                  if(!_loc5_ && (param3.playerType == PlayerTypeEnum.HUMAN && !_loc6_ || param3.playerType == PlayerTypeEnum.SIDEKICK))
                  {
                     return true;
                  }
               }
               else if(_loc9_ == "M")
               {
                  if(!_loc5_ && param3.playerType != PlayerTypeEnum.HUMAN && !_loc6_ && !param3.isStaticElement)
                  {
                     return true;
                  }
               }
               else if(_loc9_ == "S")
               {
                  if(!_loc5_ && param3.playerType != PlayerTypeEnum.SIDEKICK && _loc6_ && param3.isStaticElement)
                  {
                     return true;
                  }
               }
               else
               {
                  if(_loc9_ != "a")
                  {
                     if(_loc9_ != "g")
                     {
                        if(_loc9_ == "d")
                        {
                           if(!!_loc5_ && param3.playerType == PlayerTypeEnum.SIDEKICK)
                           {
                              return true;
                           }
                        }
                        else if(_loc9_ == "h")
                        {
                           if(!!_loc5_ && param3.playerType == PlayerTypeEnum.HUMAN && !_loc6_)
                           {
                              return true;
                           }
                        }
                        else if(_loc9_ == "i")
                        {
                           if(!!_loc5_ && param3.playerType != PlayerTypeEnum.SIDEKICK && _loc6_ && !param3.isStaticElement)
                           {
                              return true;
                           }
                        }
                        else if(_loc9_ == "j")
                        {
                           if(!!_loc5_ && param3.playerType != PlayerTypeEnum.SIDEKICK && _loc6_)
                           {
                              return true;
                           }
                        }
                        else if(_loc9_ == "l")
                        {
                           if(!!_loc5_ && (param3.playerType == PlayerTypeEnum.HUMAN && !_loc6_ || param3.playerType == PlayerTypeEnum.SIDEKICK))
                           {
                              return true;
                           }
                        }
                        else if(_loc9_ == "m")
                        {
                           if(!!_loc5_ && param3.playerType != PlayerTypeEnum.HUMAN && !_loc6_ && !param3.isStaticElement)
                           {
                              return true;
                           }
                        }
                        else if(_loc9_ == "s")
                        {
                           if(!!_loc5_ && param3.playerType != PlayerTypeEnum.SIDEKICK && _loc6_ && param3.isStaticElement)
                           {
                              return true;
                           }
                        }
                        continue;
                     }
                  }
                  if(_loc5_)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public static function splitMasks(param1:String) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            while(param1.charAt(_loc3_) == " " || param1.charAt(_loc3_) == ",")
            {
               _loc3_++;
            }
            _loc4_ = _loc3_;
            while(_loc4_ < param1.length && param1.charAt(_loc4_) != ",")
            {
               _loc4_++;
            }
            if(_loc4_ != _loc3_)
            {
               _loc2_.push(param1.substring(_loc3_,_loc4_));
            }
            _loc3_ = _loc4_;
         }
         return _loc2_;
      }
      
      public static function splitTriggers(param1:String) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         if(param1 != null)
         {
            while(_loc3_ < param1.length)
            {
               while(param1.charAt(_loc3_) == " " || param1.charAt(_loc3_) == "|")
               {
                  _loc3_++;
               }
               _loc4_ = _loc3_;
               while(_loc4_ < param1.length && param1.charAt(_loc4_) != "|")
               {
                  _loc4_++;
               }
               if(_loc4_ != _loc3_)
               {
                  _loc2_.push(param1.substring(_loc3_,_loc4_));
               }
               _loc3_ = _loc4_;
            }
         }
         return _loc2_;
      }
      
      public static function maskIsOneOfCondition(param1:String) : Boolean
      {
         var _loc2_:String = param1.charAt(0) == "*" ? param1.charAt(1) : param1.charAt(0);
         if(_loc2_ != "B")
         {
            if(_loc2_ != "F")
            {
               if(_loc2_ != "Z")
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public static function passMaskExclusion(param1:HaxeFighter, param2:Array, param3:HaxeFighter, param4:HaxeFighter, param5:FightContext) : Boolean
      {
         var _loc8_:* = null as String;
         var _loc9_:* = null as HaxeFighter;
         var _loc10_:Boolean = false;
         var _loc6_:Boolean = param5.usingPortal();
         var _loc7_:int = 0;
         while(_loc7_ < int(param2.length))
         {
            _loc8_ = param2[_loc7_];
            _loc7_++;
            if(int("*bBeEfFzZKoOPpTWUvVrRQq".indexOf(_loc8_.charAt(0))) != -1)
            {
               if(_loc8_.charCodeAt(0) == "*".charCodeAt(0))
               {
                  _loc9_ = param1;
                  _loc10_ = true;
               }
               else
               {
                  _loc9_ = param3;
                  _loc10_ = false;
               }
               if(!SpellManager.targetPassMaskExclusion(param1,_loc9_,param4,param5,_loc8_,param2,_loc6_,_loc10_))
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public static function targetPassMaskExclusion(param1:HaxeFighter, param2:HaxeFighter, param3:HaxeFighter, param4:FightContext, param5:String, param6:Array, param7:Boolean, param8:Boolean) : Boolean
      {
         var _loc10_:* = null as Object;
         var _loc12_:* = false;
         var _loc14_:Number = NaN;
         var _loc15_:* = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var caster:HaxeFighter = param1;
         var _loc9_:int = !!param8 ? 1 : 0;
         switch(param5.length)
         {
            case 0:
            case 1:
               _loc10_ = 0;
               break;
            default:
               _loc10_ = Std.parseInt(param5.substring(_loc9_ + 1));
         }
         var _loc11_:String = param5.charAt(_loc9_);
         var _loc13_:String = _loc11_;
         if(_loc13_ == "B")
         {
            _loc12_ = Boolean(param2.playerType == PlayerTypeEnum.HUMAN && param2.breed == _loc10_);
         }
         else if(_loc13_ == "E")
         {
            _loc12_ = Boolean(param2.hasState(_loc10_));
         }
         else if(_loc13_ == "F")
         {
            _loc12_ = Boolean(param2.playerType != PlayerTypeEnum.HUMAN && param2.breed == _loc10_);
         }
         else if(_loc13_ == "K")
         {
            _loc12_ = Boolean(!!param2.hasState(8) && caster.getCarried(param4) == param2 || param2.pendingEffects.filter(function(param1:EffectOutput):Boolean
            {
               return param1.throwedBy == caster.id;
            }).length > 0);
         }
         else if(_loc13_ == "P")
         {
            _loc12_ = Boolean(param2.id == caster.id || !!param2.data.isSummon() && Number(param2.data.getSummonerId()) == caster.id || !!param2.data.isSummon() && Number(caster.data.getSummonerId()) == Number(param2.data.getSummonerId()) || !!caster.data.isSummon() && Number(caster.data.getSummonerId()) == param2.id);
         }
         else if(_loc13_ == "Q")
         {
            _loc12_ = int(param4.getFighterCurrentSummonCount(param2)) >= int(param2.data.getCharacteristicValue(26));
         }
         else if(_loc13_ == "R")
         {
            _loc12_ = Boolean(param7);
         }
         else if(_loc13_ == "T")
         {
            _loc12_ = Boolean(param2.wasTelefraggedThisTurn());
         }
         else if(_loc13_ == "U")
         {
            _loc12_ = Boolean(param2.isAppearing());
         }
         else if(_loc13_ == "V")
         {
            _loc14_ = param2.getPendingLifePoints().min / int(param2.data.getMaxHealthPoints()) * 100;
            _loc12_ = _loc14_ <= _loc10_;
         }
         else if(_loc13_ == "W")
         {
            _loc12_ = Boolean(param2.wasTeleportedInInvalidCellThisTurn(param4));
         }
         else if(_loc13_ == "Z")
         {
            _loc12_ = Boolean(param2.playerType == PlayerTypeEnum.SIDEKICK && param2.breed == _loc10_);
         }
         else if(_loc13_ == "b")
         {
            _loc12_ = Boolean(param2.playerType != PlayerTypeEnum.HUMAN || param2.breed != _loc10_);
         }
         else if(_loc13_ == "e")
         {
            _loc12_ = !param2.hasState(_loc10_);
         }
         else if(_loc13_ == "f")
         {
            _loc12_ = Boolean(param2.playerType == PlayerTypeEnum.HUMAN || param2.breed != _loc10_);
         }
         else
         {
            if(_loc13_ != "O")
            {
               if(_loc13_ != "o")
               {
                  if(_loc13_ == "p")
                  {
                     _loc12_ = !(param2.id == caster.id || !!param2.data.isSummon() && Number(param2.data.getSummonerId()) == caster.id || !!param2.data.isSummon() && Number(caster.data.getSummonerId()) == Number(param2.data.getSummonerId()) || !!caster.data.isSummon() && Number(caster.data.getSummonerId()) == param2.id);
                  }
                  else if(_loc13_ == "q")
                  {
                     _loc12_ = int(param4.getFighterCurrentSummonCount(param2)) < int(param2.data.getCharacteristicValue(26));
                  }
                  else if(_loc13_ == "r")
                  {
                     _loc12_ = !param7;
                  }
                  else if(_loc13_ == "v")
                  {
                     _loc14_ = param2.getPendingLifePoints().min / int(param2.data.getMaxHealthPoints()) * 100;
                     _loc12_ = _loc14_ > _loc10_;
                  }
                  else if(_loc13_ == "z")
                  {
                     _loc12_ = Boolean(param2.playerType != PlayerTypeEnum.SIDEKICK || param2.breed != _loc10_);
                  }
               }
               §§goto(addr475);
            }
            _loc12_ = Boolean(param3 != null && param2.id == param3.id);
         }
         addr475:
         if(SpellManager.maskIsOneOfCondition(param5))
         {
            _loc15_ = int(param6.indexOf(param5)) + 1;
            if(_loc12_)
            {
               _loc16_ = _loc15_;
               _loc17_ = param6.length;
               while(_loc16_ < _loc17_)
               {
                  _loc18_ = _loc16_++;
                  if(param6[_loc18_].charCodeAt(_loc9_) == param5.charCodeAt(_loc9_))
                  {
                     param6[_loc18_] = " ";
                  }
               }
            }
            else
            {
               _loc16_ = _loc15_;
               _loc17_ = param6.length;
               while(_loc16_ < _loc17_)
               {
                  _loc18_ = _loc16_++;
                  if(param6[_loc18_].charCodeAt(_loc9_) == param5.charCodeAt(_loc9_))
                  {
                     _loc12_ = true;
                     break;
                  }
               }
            }
         }
         return _loc12_;
      }
      
      public static function isInstantaneousSpellEffect(param1:HaxeSpellEffect) : Boolean
      {
         if(param1.triggers == null || int(param1.triggers.indexOf("I")) != -1)
         {
            return true;
         }
         return false;
      }
   }
}
