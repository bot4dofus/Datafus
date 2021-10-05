package tools
{
   import haxe.IMap;
   import haxe.ds.IntMap;
   
   public class ActionIdHelper
   {
      
      public static var STAT_BUFF_ACTION_IDS:Array = [1027,283,293,110,118,125,2844,123,119,126,124,422,424,426,428,430,138,112,165,1054,414,416,418,420,1171,2808,2812,2800,2804,2802,2806,2814,2810,178,2872,226,225,1166,1167,240,243,241,242,244,1076,111,128,1144,182,210,211,212,213,214,117,115,174,176,1039,1040,220,158,161,160,752,753,776,412,410,121,150,2846,2848,2852,2850,2854,2856,2858,2860,2836,2838,2840,2834,2842,2844];
      
      public static var STAT_DEBUFF_ACTION_IDS:Array = [157,153,2845,152,154,155,156,423,425,427,429,431,186,145,415,417,419,421,1172,2809,2813,2801,2805,2803,2807,2815,2811,179,245,248,246,247,249,1077,168,169,215,216,217,218,219,116,171,175,177,159,163,162,754,755,413,411,2857,2855,2861,2859,2853,2851,2849,2847,2843,2841,2839,2837,2835];
      
      public static var actionIdToStatNameMap:IMap = _loc1_;
      
      public static var percentStatBoostActionIdToStat:IMap = _loc1_;
      
      public static var flatStatBoostActionIdToStat:IMap = _loc1_;
      
      public static var shieldActionIdToStatId:IMap = _loc1_;
       
      
      public function ActionIdHelper()
      {
      }
      
      public static function isBasedOnCasterLife(param1:int) : Boolean
      {
         if(!(ActionIdHelper.isBasedOnCasterLifePercent(param1) || ActionIdHelper.isBasedOnCasterLifeMidlife(param1) || ActionIdHelper.isBasedOnCasterLifeMissing(param1)))
         {
            return Boolean(ActionIdHelper.isBasedOnCasterLifeMissingMaxLife(param1));
         }
         return true;
      }
      
      public static function isBasedOnCasterLifePercent(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 85)
         {
            if(_loc2_ != 86)
            {
               if(_loc2_ != 87)
               {
                  if(_loc2_ != 88)
                  {
                     if(_loc2_ != 89)
                     {
                        if(_loc2_ != 90)
                        {
                           if(_loc2_ != 671)
                           {
                              return false;
                           }
                        }
                     }
                  }
               }
            }
         }
         return true;
      }
      
      public static function isBasedOnCasterLifeMissing(param1:int) : Boolean
      {
         if(param1 == 279 || param1 == 275 || param1 == 276 || param1 == 277 || param1 == 278)
         {
            return true;
         }
         return false;
      }
      
      public static function isBasedOnCasterLifeMissingMaxLife(param1:int) : Boolean
      {
         if(param1 == 1118 || param1 == 1121 || param1 == 1122 || param1 == 1119 || param1 == 1120)
         {
            return true;
         }
         return false;
      }
      
      public static function isBasedOnCasterLifeMidlife(param1:int) : Boolean
      {
         return param1 == 672;
      }
      
      public static function isSplash(param1:int) : Boolean
      {
         if(!ActionIdHelper.isSplashDamage(param1))
         {
            return Boolean(ActionIdHelper.isSplashHeal(param1));
         }
         return true;
      }
      
      public static function isSplashDamage(param1:int) : Boolean
      {
         if(!ActionIdHelper.isSplashFinalDamage(param1))
         {
            return Boolean(ActionIdHelper.isSplashRawDamage(param1));
         }
         return true;
      }
      
      public static function isSplashFinalDamage(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 1223)
         {
            if(_loc2_ != 1224)
            {
               if(_loc2_ != 1225)
               {
                  if(_loc2_ != 1226)
                  {
                     if(_loc2_ != 1227)
                     {
                        if(_loc2_ != 1228)
                        {
                           return false;
                        }
                     }
                  }
               }
            }
         }
         return true;
      }
      
      public static function isSplashRawDamage(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 1123)
         {
            if(_loc2_ != 1124)
            {
               if(_loc2_ != 1125)
               {
                  if(_loc2_ != 1126)
                  {
                     if(_loc2_ != 1127)
                     {
                        if(_loc2_ != 1128)
                        {
                           return false;
                        }
                     }
                  }
               }
            }
         }
         return true;
      }
      
      public static function isSplashHeal(param1:int) : Boolean
      {
         if(param1 == 2020)
         {
            return true;
         }
         return false;
      }
      
      public static function isBasedOnMovementPoints(param1:int) : Boolean
      {
         if(param1 == 1012 || param1 == 1013 || param1 == 1016 || param1 == 1015 || param1 == 1014)
         {
            return true;
         }
         return false;
      }
      
      public static function isBasedOnTargetLifePercent(param1:int) : Boolean
      {
         if(param1 == 1071 || param1 == 1068 || param1 == 1070 || param1 == 1067 || param1 == 1069 || param1 == 1048)
         {
            return true;
         }
         return false;
      }
      
      public static function isTargetMaxLifeAffected(param1:int) : Boolean
      {
         if(!(param1 == 1037 || param1 == 153 || param1 == 1033 || param1 == 125 || param1 == 1078 || param1 == 610 || param1 == 267 || param1 == 2844))
         {
            return param1 == 2845;
         }
         return true;
      }
      
      public static function isBasedOnTargetLife(param1:int) : Boolean
      {
         if(!(ActionIdHelper.isBasedOnTargetLifePercent(param1) || ActionIdHelper.isBasedOnTargetMaxLife(param1)))
         {
            return Boolean(ActionIdHelper.isBasedOnTargetLifeMissingMaxLife(param1));
         }
         return true;
      }
      
      public static function isBasedOnTargetMaxLife(param1:int) : Boolean
      {
         return param1 == 1109;
      }
      
      public static function isBasedOnTargetLifeMissingMaxLife(param1:int) : Boolean
      {
         if(param1 == 1092 || param1 == 1095 || param1 == 1096 || param1 == 1093 || param1 == 1094)
         {
            return true;
         }
         return false;
      }
      
      public static function isBoostable(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = param1;
         if(_loc3_ != 80)
         {
            if(_loc3_ != 82)
            {
               if(_loc3_ != 144)
               {
                  if(_loc3_ != 1063)
                  {
                     if(_loc3_ != 1064)
                     {
                        if(_loc3_ != 1065)
                        {
                           if(_loc3_ != 1066)
                           {
                              _loc2_ = ActionIdHelper.isBasedOnCasterLife(param1) || ActionIdHelper.isBasedOnTargetLife(param1) || ActionIdHelper.isSplash(param1);
                              if(_loc2_ == true)
                              {
                                 return false;
                              }
                              return true;
                           }
                        }
                     }
                  }
               }
            }
         }
         return false;
      }
      
      public static function isLifeSteal(param1:int) : Boolean
      {
         if(param1 == 95 || param1 == 2828 || param1 == 82 || param1 == 92 || param1 == 94 || param1 == 91 || param1 == 93)
         {
            return true;
         }
         return false;
      }
      
      public static function isHeal(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 81)
         {
            if(_loc2_ != 90)
            {
               if(_loc2_ != 108)
               {
                  if(_loc2_ != 143)
                  {
                     if(_loc2_ != 407)
                     {
                        if(_loc2_ != 786)
                        {
                           if(_loc2_ != 1037)
                           {
                              if(_loc2_ != 1109)
                              {
                                 if(_loc2_ != 2020)
                                 {
                                    return false;
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return true;
      }
      
      public static function isShield(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 1020)
         {
            if(_loc2_ != 1039)
            {
               if(_loc2_ != 1040)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public static function isTargetMarkDispell(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 2018)
         {
            if(_loc2_ != 2019)
            {
               if(_loc2_ != 2024)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public static function isStatBoost(param1:int) : Boolean
      {
         switch(param1)
         {
            case 266:
            case 268:
            case 269:
            case 270:
            case 271:
            case 414:
               return true;
            default:
               return false;
         }
      }
      
      public static function statBoostToStatName(param1:int) : String
      {
         switch(param1)
         {
            case 266:
               return "chance";
            case 268:
               return "agility";
            case 269:
               return "intelligence";
            case 270:
               return "wisdom";
            case 271:
               return "strength";
            default:
               return null;
         }
      }
      
      public static function statBoostToBuffActionId(param1:int) : int
      {
         switch(param1)
         {
            case 266:
               return 123;
            case 268:
               return 119;
            case 269:
               return 126;
            case 270:
               return 124;
            case 271:
               return 118;
            default:
               return 0;
         }
      }
      
      public static function statBoostToDebuffActionId(param1:int) : int
      {
         switch(param1)
         {
            case 266:
               return 152;
            case 268:
               return 154;
            case 269:
               return 155;
            case 270:
               return 156;
            case 271:
               return 157;
            default:
               return -1;
         }
      }
      
      public static function isDamage(param1:int, param2:int) : Boolean
      {
         if(param1 == 2 && param2 != 127 && param2 != 101)
         {
            return true;
         }
         return false;
      }
      
      public static function isPush(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 5)
         {
            if(_loc2_ != 1021)
            {
               if(_loc2_ != 1041)
               {
                  if(_loc2_ != 1103)
                  {
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      public static function isPull(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 6)
         {
            if(_loc2_ != 1022)
            {
               if(_loc2_ != 1042)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public static function isForcedDrag(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 1021)
         {
            if(_loc2_ != 1022)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function isDrag(param1:int) : Boolean
      {
         if(!ActionIdHelper.isPush(param1))
         {
            return Boolean(ActionIdHelper.isPull(param1));
         }
         return true;
      }
      
      public static function allowCollisionDamage(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 5)
         {
            if(_loc2_ != 1041)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function isSummon(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = param1;
         if(_loc3_ == 181)
         {
            _loc2_ = ActionIdHelper.isSummonWithSlot(param1);
            if(_loc2_ == true)
            {
               return true;
            }
            return true;
         }
         if(_loc3_ != 780)
         {
            if(_loc3_ != 1008)
            {
               if(_loc3_ != 1097)
               {
                  if(_loc3_ != 1189)
                  {
                     _loc2_ = ActionIdHelper.isSummonWithSlot(param1);
                     if(_loc2_ == true)
                     {
                        return true;
                     }
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      public static function isSummonWithSlot(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 180)
         {
            if(_loc2_ != 405)
            {
               if(_loc2_ != 1011)
               {
                  if(_loc2_ != 1034)
                  {
                     if(_loc2_ != 2796)
                     {
                        return false;
                     }
                  }
               }
            }
         }
         return true;
      }
      
      public static function isSummonWithoutTarget(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 180)
         {
            if(_loc2_ != 181)
            {
               if(_loc2_ != 780)
               {
                  if(_loc2_ != 1008)
                  {
                     if(_loc2_ != 1011)
                     {
                        if(_loc2_ != 1034)
                        {
                           if(_loc2_ != 1097)
                           {
                              if(_loc2_ != 1189)
                              {
                                 return false;
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return true;
      }
      
      public static function isKillAndSummon(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 405)
         {
            if(_loc2_ != 2796)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function isRevive(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 780)
         {
            if(_loc2_ != 1034)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function getSplashFinalTakenDamageElement(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 1224;
            case 1:
               return 1228;
            case 2:
               return 1226;
            case 3:
               return 1227;
            case 4:
               return 1225;
            default:
               return 1223;
         }
      }
      
      public static function getSplashRawTakenDamageElement(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 1124;
            case 1:
               return 1128;
            case 2:
               return 1126;
            case 3:
               return 1127;
            case 4:
               return 1125;
            default:
               return 1123;
         }
      }
      
      public static function isFakeDamage(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 90)
         {
            if(_loc2_ != 1047)
            {
               if(_loc2_ != 1048)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public static function isSpellExecution(param1:int) : Boolean
      {
         if(param1 == 1160 || param1 == 2160 || param1 == 1019 || param1 == 1018 || param1 == 792 || param1 == 2792 || param1 == 2794 || param1 == 2795 || param1 == 1017 || param1 == 2017 || param1 == 793 || param1 == 2793)
         {
            return true;
         }
         return false;
      }
      
      public static function isTeleport(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = param1;
         if(_loc3_ != 4)
         {
            if(_loc3_ != 1099)
            {
               if(_loc3_ != 1100)
               {
                  if(_loc3_ != 1101)
                  {
                     if(_loc3_ != 1104)
                     {
                        if(_loc3_ != 1105)
                        {
                           if(_loc3_ != 1106)
                           {
                              _loc2_ = ActionIdHelper.isExchange(param1);
                              if(_loc2_ == true)
                              {
                                 return true;
                              }
                              return false;
                           }
                        }
                     }
                  }
               }
            }
         }
         return true;
      }
      
      public static function isExchange(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 8)
         {
            if(_loc2_ != 1023)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function canTeleportOverBreedSwitchPos(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 4)
         {
            if(_loc2_ != 1023)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function allowAOEMalus(param1:int) : Boolean
      {
         if(!!ActionIdHelper.isSplash(param1) && false || ActionIdHelper.isShield(param1))
         {
            return false;
         }
         return true;
      }
      
      public static function canTriggerHealMultiplier(param1:int) : Boolean
      {
         if(param1 == 90)
         {
            return false;
         }
         return true;
      }
      
      public static function canTriggerDamageMultiplier(param1:int) : Boolean
      {
         if(param1 == 90)
         {
            return false;
         }
         return true;
      }
      
      public static function canTriggerOnHeal(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 90)
         {
            if(_loc2_ != 786)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function canTriggerOnDamage(param1:int) : Boolean
      {
         if(param1 == 1048)
         {
            return false;
         }
         return true;
      }
      
      public static function StatToBuffPercentActionIds(param1:int) : int
      {
         switch(param1)
         {
            case 1:
               return 2846;
            case 10:
               return 2834;
            case 11:
               return 2844;
            case 12:
               return 2842;
            case 13:
               return 2840;
            case 14:
               return 2836;
            case 15:
               return 2838;
            case 23:
            case 145:
               return 2848;
            default:
               return -1;
         }
      }
      
      public static function StatToDebuffPercentActionIds(param1:int) : int
      {
         switch(param1)
         {
            case 1:
               return 2847;
            case 10:
               return 2835;
            case 11:
               return 2845;
            case 12:
               return 2843;
            case 13:
               return 2841;
            case 14:
               return 2837;
            case 15:
               return 2839;
            case 23:
            case 145:
               return 2848;
            default:
               return -1;
         }
      }
      
      public static function isLinearBuffActionIds(param1:int) : Boolean
      {
         switch(param1)
         {
            case 31:
            case 33:
            case 34:
            case 35:
            case 36:
            case 37:
            case 59:
            case 60:
            case 61:
            case 62:
            case 63:
            case 69:
            case 101:
            case 121:
            case 124:
            case 141:
            case 142:
               return false;
            default:
               return true;
         }
      }
      
      public static function isStatModifier(param1:int) : Boolean
      {
         if((int(ActionIdHelper.STAT_BUFF_ACTION_IDS.indexOf(param1)) != -1 || int(ActionIdHelper.STAT_DEBUFF_ACTION_IDS.indexOf(param1)) != -1) && !ActionIdHelper.isShield(param1))
         {
            return true;
         }
         return false;
      }
      
      public static function isBuff(param1:int) : Boolean
      {
         return int(ActionIdHelper.STAT_BUFF_ACTION_IDS.indexOf(param1)) != -1;
      }
      
      public static function isDebuff(param1:int) : Boolean
      {
         return int(ActionIdHelper.STAT_DEBUFF_ACTION_IDS.indexOf(param1)) != -1;
      }
      
      public static function getActionIdStatName(param1:int) : String
      {
         return ActionIdHelper.actionIdToStatNameMap.h[param1];
      }
      
      public static function isPercentStatBoostActionId(param1:int) : Boolean
      {
         var _loc2_:IMap = ActionIdHelper.percentStatBoostActionIdToStat;
         return param1 in _loc2_.h;
      }
      
      public static function isFlatStatBoostActionId(param1:int) : Boolean
      {
         var _loc2_:IMap = ActionIdHelper.flatStatBoostActionIdToStat;
         return param1 in _loc2_.h;
      }
      
      public static function getStatIdFromStatActionId(param1:int) : int
      {
         var _loc2_:* = null as IMap;
         if(ActionIdHelper.isFlatStatBoostActionId(param1))
         {
            return ActionIdHelper.flatStatBoostActionIdToStat.h[param1];
         }
         if(ActionIdHelper.isPercentStatBoostActionId(param1))
         {
            return ActionIdHelper.percentStatBoostActionIdToStat.h[param1];
         }
         _loc2_ = ActionIdHelper.shieldActionIdToStatId;
         if(param1 in _loc2_.h)
         {
            return ActionIdHelper.shieldActionIdToStatId.h[param1];
         }
         return -1;
      }
      
      public static function isStatUpdated(param1:int) : Boolean
      {
         var _loc3_:* = null as IMap;
         var _loc2_:IMap = ActionIdHelper.flatStatBoostActionIdToStat;
         if(!(param1 in _loc2_.h))
         {
            _loc3_ = ActionIdHelper.flatStatBoostActionIdToStat;
            return param1 in _loc3_.h;
         }
         return true;
      }
      
      public static function isStatSteal(param1:int) : Boolean
      {
         if(!(param1 == 266 || param1 == 267 || param1 == 268 || param1 == 269 || param1 == 270))
         {
            return param1 == 271;
         }
         return true;
      }
      
      public static function spellExecutionHasGlobalLimitation(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         if(_loc2_ != 2017)
         {
            if(_loc2_ != 2160)
            {
               if(_loc2_ != 2792)
               {
                  if(_loc2_ != 2793)
                  {
                     if(_loc2_ != 2795)
                     {
                        return false;
                     }
                  }
               }
            }
         }
         return true;
      }
   }
}
