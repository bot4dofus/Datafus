package damageCalculation.debug
{
   import com.ankama.dofus.enums.ActionIds;
   import damageCalculation.FightContext;
   import damageCalculation.fighterManagement.HaxeBuff;
   import damageCalculation.fighterManagement.HaxeFighter;
   import damageCalculation.fighterManagement.PlayerTypeEnum;
   import damageCalculation.fighterManagement.fighterstats.HaxeDetailedStat;
   import damageCalculation.fighterManagement.fighterstats.HaxeSimpleStat;
   import damageCalculation.fighterManagement.fighterstats.HaxeStat;
   import damageCalculation.spellManagement.HaxeSpell;
   import damageCalculation.spellManagement.HaxeSpellEffect;
   import damageCalculation.spellManagement.Mark;
   import damageCalculation.tools.Const;
   import damageCalculation.tools.LinkedListNode;
   import damageCalculation.tools.StatIds;
   import haxe.IMap;
   import haxe.ds.IntMap;
   
   public class Debug
   {
      
      public static var INDENTATION:String = "    ";
      
      public static var INDENTATION_COUNTER:uint = uint(1);
      
      public static var CASTER_NAME:String = "caster";
      
      public static var ALLY_NAME:String = "ally";
      
      public static var ENEMY_NAME:String = "enemy";
      
      public static var additionalSpellLog:String = "";
      
      public static var additionalSpellUsed:Array = [];
       
      
      public function Debug()
      {
      }
      
      public static function traceSpell(param1:HaxeSpell) : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = null as HaxeSpellEffect;
         var _loc2_:String = "";
         _loc2_ += "new MockSpell(\n";
         var _loc3_:Array = param1.getEffects();
         var _loc4_:Array = param1.getCriticalEffects();
         _loc2_ += "    " + "    [\n";
         if(_loc3_ != null && int(_loc3_.length) > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < int(_loc3_.length))
            {
               _loc6_ = _loc3_[_loc5_];
               _loc5_++;
               _loc2_ += Debug.getEffectsDeclaration(_loc6_);
            }
         }
         _loc2_ += "    " + "    ],\n";
         _loc2_ += "    " + "    [\n";
         if(_loc4_ != null && int(_loc4_.length) > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < int(_loc4_.length))
            {
               _loc6_ = _loc4_[_loc5_];
               _loc5_++;
               _loc2_ += Debug.getEffectsDeclaration(_loc6_);
            }
         }
         _loc2_ += "    " + "    ],\n";
         _loc2_ += "    " + "    " + param1.id + "\n    );";
      }
      
      public static function traceTestEnvironment(param1:FightContext, param2:HaxeSpell, param3:Boolean = false, param4:Boolean = false) : String
      {
         var _loc11_:* = null as String;
         var _loc12_:int = 0;
         var _loc13_:* = null as HaxeFighter;
         var _loc14_:* = null as String;
         var _loc15_:* = null as LinkedListNode;
         var _loc16_:* = null as LinkedListNode;
         var _loc17_:* = null as LinkedListNode;
         var _loc19_:* = null as Mark;
         var _loc5_:String = "//===================== TEST =====================";
         _loc5_ += "\n";
         _loc5_ += "// Note:\n";
         _loc5_ += "//" + "    " + "* Please rename the function test name accordingly (it MUST start with \"test\" and have a comprehensible name).";
         _loc5_ += "\n\n";
         _loc5_ += "// Link(s) to the YouTrack issue(s) (DOF-XXXXX) should be included here, if necessary.";
         _loc5_ += "\n";
         _loc5_ += "public function testInsertTestNameHere() : Void\n";
         _loc5_ += "{\n";
         Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER + 1;
         _loc5_ = Debug.indent(_loc5_);
         _loc5_ += "// Here are all the necessary variable declarations. Please remove useless ones and fix the code if needed.\n";
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Boolean = true;
         var _loc9_:Array = param1.getEveryFighter();
         var _loc10_:IMap = new IntMap();
         _loc12_ = 0;
         while(_loc12_ < int(_loc9_.length))
         {
            _loc13_ = _loc9_[_loc12_];
            _loc12_++;
            if(_loc13_.id == param1.originalCaster.id)
            {
               _loc11_ = "caster";
               _loc8_ = false;
            }
            else
            {
               _loc8_ = true;
               if(_loc13_.teamId != param1.originalCaster.teamId)
               {
                  _loc7_++;
                  _loc11_ = "enemy" + _loc7_;
               }
               else
               {
                  _loc6_++;
                  _loc11_ = "ally" + _loc6_;
               }
            }
            _loc5_ = Debug.indent(_loc5_);
            if(_loc8_)
            {
               _loc5_ += "var ";
            }
            _loc14_ = _loc11_;
            if(_loc14_ != "caster")
            {
               _loc14_ += " : MockFighter";
            }
            _loc5_ += "" + _loc14_ + " = new MockFighter(";
            Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER + 1;
            if(param3)
            {
               _loc5_ += Debug.indent("\n") + Debug.getFighterStatsDeclaration(_loc13_);
               _loc5_ += ",";
               _loc5_ += Debug.indent("\n");
            }
            _loc5_ += Debug.getInfoDeclaration(_loc13_,param4);
            _loc5_ += ");\n\n";
            Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER - 1;
            §§push(_loc10_.h);
            §§push(_loc13_.id);
            if(!(_loc13_.id is Number))
            {
               throw "Class cast error";
            }
            §§pop()[§§pop()] = _loc11_;
         }
         _loc12_ = 0;
         while(_loc12_ < int(_loc9_.length))
         {
            _loc13_ = _loc9_[_loc12_];
            _loc12_++;
            §§push(_loc10_.h);
            §§push(_loc13_.id);
            if(!(_loc13_.id is Number))
            {
               throw "Class cast error";
            }
            _loc11_ = §§pop()[§§pop()];
            if(_loc13_._buffs.head != null)
            {
               _loc5_ = Debug.indent(_loc5_);
               _loc5_ += "" + _loc11_ + ".addBuffs([\n";
               Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER + 1;
               _loc15_ = _loc13_._buffs.head;
               while(_loc15_ != null)
               {
                  _loc16_ = _loc15_;
                  _loc15_ = _loc15_.next;
                  _loc17_ = _loc16_;
                  §§push(_loc5_);
                  §§push("");
                  §§push(Debug);
                  §§push(_loc17_.item);
                  §§push(_loc10_.h);
                  §§push(_loc17_.item.casterId);
                  if(!(_loc17_.item.casterId is Number))
                  {
                     throw "Class cast error";
                  }
                  _loc5_ = §§pop() + (§§pop() + §§pop().getBuffDeclaration(§§pop(),§§pop()[§§pop()]) + ",\n");
               }
               _loc5_ = Debug.indent(_loc5_);
               Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER - 1;
               _loc5_ += "]); \n";
            }
            _loc5_ = Debug.indent(_loc5_);
            _loc5_ += "" + _loc11_ + ".setStartedPositionCell(" + int(_loc13_.data.getStartedPositionCell()) + "); \n";
            _loc5_ = Debug.indent(_loc5_);
            _loc5_ += "map.addFighter(" + _loc11_ + ");\n\n";
         }
         var _loc18_:Array = param1.map.getMarks();
         if(_loc18_ != null && int(_loc18_.length) > 0)
         {
            _loc12_ = 0;
            while(_loc12_ < int(_loc18_.length))
            {
               _loc19_ = _loc18_[_loc12_];
               _loc12_++;
               §§push(_loc5_);
               §§push(Debug);
               §§push(_loc19_);
               §§push(_loc10_.h);
               §§push(_loc19_.casterId);
               if(!(_loc19_.casterId is Number))
               {
                  throw "Class cast error";
               }
               _loc5_ = §§pop() + §§pop().getMarkDeclaration(§§pop(),§§pop()[§§pop()]);
            }
         }
         _loc5_ = Debug.indent(_loc5_);
         _loc5_ += "spell = MockSpell." + Debug.getSpellName(param2) + ";\n";
         _loc5_ = Debug.indent(_loc5_);
         _loc5_ += "targetedCell = " + param1.targetedCell + ";\n\n";
         _loc5_ = Debug.indent(_loc5_);
         _loc5_ += "// Please insert your test case here. For example:\n";
         _loc5_ = Debug.indent(_loc5_);
         _loc5_ += "//" + "    " + "var baseDamage : Interval = spell.getBaseDamage();\n";
         _loc5_ = Debug.indent(_loc5_);
         _loc5_ += "//" + "    " + "var criticalDamage : Interval = spell.getCriticalBaseDamage();\n";
         _loc5_ = Debug.indent(_loc5_);
         _loc5_ += "//" + "    " + "\n";
         _loc5_ = Debug.indent(_loc5_);
         _loc5_ += "//" + "    " + "createExpectedSimpleDamage(" + "enemy" + _loc7_ + ", baseDamage.toArray(), criticalDamage.toArray(), false, false, 0, null);\n\n";
         _loc5_ = Debug.indent(_loc5_);
         _loc5_ += "run();\n";
         Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER - 1;
         return _loc5_ + "}";
      }
      
      public static function getInfoDeclaration(param1:HaxeFighter, param2:Boolean = false) : String
      {
         var _loc3_:String = "[";
         Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER + 1;
         _loc3_ += "" + Debug.indent("\n") + "Const.MOCK_INFO_TEAM_ID => " + Std.string(param1.teamId == 1) + ",";
         _loc3_ += "" + Debug.indent("\n") + "Const.MOCK_INFO_ALLY => " + (!!param1.data.isAlly() ? "true" : "false") + ",";
         if(param2)
         {
            _loc3_ += "" + Debug.indent("\n") + "Const.MOCK_INFO_HUMAN => " + Std.string(param1.playerType == PlayerTypeEnum.HUMAN) + ",";
            _loc3_ += "" + Debug.indent("\n") + "Const.MOCK_INFO_CARRIED => " + Std.string(Boolean(param1.hasState(8))) + " \",";
            _loc3_ += "" + Debug.indent("\n") + "Const.MOCK_INFO_SIDEKICK => " + Std.string(param1.playerType == PlayerTypeEnum.SIDEKICK) + ",";
            _loc3_ += "" + Debug.indent("\n") + "Const.MOCK_INFO_IS_SUMMONED => " + Std.string(Boolean(param1.data.isSummon())) + ",";
            _loc3_ += "" + Debug.indent("\n") + "Const.MOCK_INFO_IS_STATIC => " + ("" + param1.isStaticElement) + ",";
            _loc3_ += "" + Debug.indent("\n") + "Const.MOCK_INFO_BREED_SWITCH_POS => " + Std.string(Boolean(param1.data.canBreedSwitchPos())) + ",";
            _loc3_ += "" + Debug.indent("\n") + "Const.MOCK_INFO_BREED_SWITCH_POS => " + Std.string(Boolean(param1.data.canBreedSwitchPosOnTarget())) + ",";
            _loc3_ += "" + Debug.indent("\n") + "Const.MOCK_INFO_BREED_USE_PORTALS => " + Std.string(Boolean(param1.data.canBreedUsePortals())) + ",";
            _loc3_ += "" + Debug.indent("\n") + "Const.MOCK_INFO_BREED_BE_PUSHED => " + Std.string(Boolean(param1.data.canBreedBePushed())) + ",";
            _loc3_ += "" + Debug.indent("\n") + "Const.MOCK_INFO_BREED_BE_CARRIED => " + Std.string(Boolean(param1.data.canBreedBeCarried())) + ",";
         }
         Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER - 1;
         return _loc3_ + ("" + Debug.indent("\n") + "]");
      }
      
      public static function getFighterStatsDeclaration(param1:HaxeFighter) : String
      {
         var _loc9_:int = 0;
         var _loc2_:Array = param1.data.getStatIds();
         if(int(_loc2_.length) <= 0)
         {
            return "null";
         }
         var _loc3_:String = "[";
         var _loc4_:HaxeStat = null;
         var _loc5_:String = null;
         var _loc6_:HaxeDetailedStat = null;
         var _loc7_:String = null;
         Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER + 1;
         var _loc8_:int = 0;
         while(_loc8_ < int(_loc2_.length))
         {
            _loc9_ = _loc2_[_loc8_];
            _loc8_++;
            _loc4_ = param1.data.getStat(_loc9_);
            _loc5_ = Debug.getAttributeNameFromValue(_loc9_,int,StatIds);
            if(!(_loc4_ == null || _loc5_ == null))
            {
               if(_loc4_ is HaxeSimpleStat)
               {
                  _loc7_ = "new HaxeSimpleStat(" + _loc5_ + ", " + int(_loc4_.get_total()) + ")";
               }
               else
               {
                  if(!(_loc4_ is HaxeDetailedStat))
                  {
                     continue;
                  }
                  _loc6_ = _loc4_;
                  _loc7_ = "new HaxeDetailedStat(" + _loc5_ + ", " + int(_loc6_.get_base()) + ", " + int(_loc6_.get_additional()) + ", " + int(_loc6_.get_objectsAndMountBonus()) + ", " + int(_loc6_.get_alignGiftBonus()) + ", " + int(_loc6_.get_contextModif()) + ")";
               }
               _loc3_ += "" + Debug.indent("\n") + "    " + _loc5_ + " => " + _loc7_ + ",";
            }
         }
         Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER - 1;
         return _loc3_ + ("" + Debug.indent("\n") + "]");
      }
      
      public static function getBuffDeclaration(param1:HaxeBuff, param2:String) : String
      {
         var _loc3_:* = null as String;
         if(param2 == null)
         {
            _loc3_ = Std.string(param1.casterId);
         }
         else
         {
            _loc3_ = "" + param2 + ".id";
         }
         var _loc4_:String = "";
         _loc4_ = Debug.indent(_loc4_);
         _loc4_ += "new MockBuff(" + _loc3_ + ",\n";
         Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER + 1;
         _loc4_ = Debug.indent(_loc4_);
         _loc4_ += "new MockSpell(null, null, " + param1.spell.id + "),\n";
         _loc4_ = Debug.indent(_loc4_);
         _loc4_ += Debug.getEffectsDeclaration(param1.effect);
         _loc4_ += ")";
         Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER - 1;
         return _loc4_;
      }
      
      public static function getAttributeNameFromValue(param1:*, param2:*, param3:*, param4:String = undefined) : String
      {
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc8_:* = null as Array;
         var _loc9_:* = null as String;
         if(param4 == null)
         {
            param4 = "";
         }
         var _loc6_:Array = Type.getClassName(param3).split(".");
         if(int(_loc6_.length) > 0)
         {
            _loc7_ = 0;
            _loc8_ = Type.getClassFields(param3);
            while(_loc7_ < int(_loc8_.length))
            {
               _loc9_ = _loc8_[_loc7_];
               _loc7_++;
               if(StringTools.startsWith(_loc9_,param4))
               {
                  _loc5_ = Reflect.field(param3,_loc9_);
                  if(!!Std.§is§(_loc5_,param2) && param1 == _loc5_)
                  {
                     return "" + _loc6_[int(_loc6_.length) - 1] + "." + _loc9_;
                  }
               }
            }
         }
         return Std.string(param1);
      }
      
      public static function getEffectsDeclaration(param1:HaxeSpellEffect) : String
      {
         var _loc2_:String = Debug.getAttributeNameFromValue(param1.actionId,int,ActionIds,"ACTION_");
         var _loc3_:String = Debug.getAttributeNameFromValue(param1.category,int,Const);
         return "MockSpellEffect.fromAGT(" + ("" + param1.id) + ", " + param1.level + ", " + param1.order + ", " + _loc2_ + ", " + param1.param1 + ", " + param1.param2 + ", " + param1.param3 + ", " + param1.duration + ", " + ("" + param1.isCritical) + ", \"" + param1.triggers.join("|") + "\", \"" + param1.rawZone + "\", \"" + param1.masks.join(",") + "\", " + param1.randomWeight + ", " + param1.randomGroup + ", " + ("" + param1.isDispellable) + ", " + param1.delay + ", " + _loc3_ + ")";
      }
      
      public static function getSpellDeclaration(param1:HaxeSpell) : String
      {
         var _loc5_:int = 0;
         var _loc6_:* = null as HaxeSpellEffect;
         var _loc2_:String = "";
         _loc2_ = Debug.indent(_loc2_);
         _loc2_ += "new MockSpell(\n";
         var _loc3_:Array = param1.getEffects();
         var _loc4_:Array = param1.getCriticalEffects();
         Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER + 1;
         _loc2_ = Debug.indent(_loc2_);
         _loc2_ += "[\n";
         Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER + 1;
         if(_loc3_ != null && int(_loc3_.length) > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < int(_loc3_.length))
            {
               _loc6_ = _loc3_[_loc5_];
               _loc5_++;
               _loc2_ = Debug.indent(_loc2_);
               _loc2_ += Debug.getEffectsDeclaration(_loc6_) + ",\n";
            }
            _loc2_.substr(0,_loc2_.length - 2);
         }
         Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER - 1;
         _loc2_ = Debug.indent(_loc2_);
         _loc2_ += "],\n";
         _loc2_ = Debug.indent(_loc2_);
         _loc2_ += "[";
         if(_loc4_ != null && int(_loc4_.length) > 0)
         {
            Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER + 1;
            _loc2_ += "\n";
            _loc5_ = 0;
            while(_loc5_ < int(_loc4_.length))
            {
               _loc6_ = _loc4_[_loc5_];
               _loc5_++;
               _loc2_ = Debug.indent(_loc2_);
               _loc2_ += Debug.getEffectsDeclaration(_loc6_) + ",\n";
            }
            _loc2_.substr(0,_loc2_.length - 2);
            Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER - 1;
            _loc2_ = Debug.indent(_loc2_);
         }
         _loc2_ += "],\n";
         _loc2_ = Debug.indent(_loc2_);
         _loc2_ += param1.id + ")";
         Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER - 1;
         return _loc2_;
      }
      
      public static function getMarkDeclaration(param1:Mark, param2:String) : String
      {
         var _loc3_:* = null as String;
         if(param2 == null)
         {
            _loc3_ = "" + param1.casterId;
         }
         else
         {
            _loc3_ = "" + param2 + ".id";
         }
         var _loc4_:String = "";
         _loc4_ = "" + Debug.indent(_loc4_) + "var mark" + param1.markId + " : Mark = new Mark();\n";
         _loc4_ = "" + Debug.indent(_loc4_) + "mark" + param1.markId + ".markId = " + param1.markId + ";\n";
         _loc4_ = "" + Debug.indent(_loc4_) + "mark" + param1.markId + ".setMarkType(" + param1.markType + ");\n";
         _loc4_ = "" + Debug.indent(_loc4_) + "mark" + param1.markId + ".mainCell = " + param1.mainCell + ";\n";
         _loc4_ = "" + Debug.indent(_loc4_) + "mark" + param1.markId + ".cells = " + Std.string(param1.cells) + ";\n";
         _loc4_ = "" + Debug.indent(_loc4_) + "mark" + param1.markId + ".casterId = " + _loc3_ + ";\n";
         _loc4_ = "" + Debug.indent(_loc4_) + "mark" + param1.markId + ".teamId = " + ("" + param1.teamId) + ";\n";
         _loc4_ = "" + Debug.indent(_loc4_) + "mark" + param1.markId + ".active = " + ("" + param1.active) + ";\n";
         _loc4_ = "" + Debug.indent(_loc4_) + "mark" + param1.markId + ".setAssociatedSpell(\n";
         Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER + 1;
         _loc4_ += Debug.getSpellDeclaration(param1.associatedSpell);
         Debug.INDENTATION_COUNTER = Debug.INDENTATION_COUNTER - 1;
         _loc4_ += ");\n";
         return "" + Debug.indent(_loc4_) + "map.addMark(mark" + param1.markId + ");\n\n";
      }
      
      public static function indent(param1:String) : String
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = Debug.INDENTATION_COUNTER;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc2_++;
            param1 += "    ";
         }
         return param1;
      }
      
      public static function storeSpell(param1:HaxeSpell) : void
      {
         var _loc2_:* = param1.level << 24 | param1.id;
         if(int(Debug.additionalSpellUsed.indexOf(_loc2_)) == -1)
         {
            Debug.additionalSpellUsed.push(_loc2_);
            Debug.additionalSpellLog += "public static var " + Debug.getSpellName(param1) + " : MockSpell = " + StringTools.trim(Debug.getSpellDeclaration(param1)) + ";";
            Debug.additionalSpellLog += "\n";
         }
      }
      
      public static function getSpellName(param1:HaxeSpell) : String
      {
         return "insertSpellNameHere_level" + param1.level + "_" + param1.id;
      }
      
      public static function printStoredSpell() : String
      {
         var _loc1_:String = "\n\n//===================== ADDITIONAL SPELLS =====================";
         _loc1_ += "\n";
         _loc1_ += "// Note:\n";
         _loc1_ += "//" + "    " + "* Certain spell parameters (param1/param2/param3) may be incorrect, as it may be wrongly exported. Please check the parameters with the AGT.\n";
         _loc1_ += "//" + "    " + "* Please rename the spell variable names with the following convention: spellName_levelN_XXXXX.";
         _loc1_ += "\n\n";
         _loc1_ += Debug.additionalSpellLog;
         Debug.additionalSpellLog = "";
         Debug.additionalSpellUsed = [];
         return _loc1_;
      }
   }
}
