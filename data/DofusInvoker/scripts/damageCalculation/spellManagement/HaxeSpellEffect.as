package damageCalculation.spellManagement
{
   import damageCalculation.tools.Interval;
   import mapTools.SpellZone;
   import tools.enumeration.ElementEnum;
   
   public class HaxeSpellEffect
   {
      
      public static var INVALID_ACTION_ID:int = -1;
      
      public static var EMPTY:HaxeSpellEffect = new HaxeSpellEffect(0,1,0,666,0,0,0,0,false,"I","","",0,0,false,0,0);
       
      
      public var zone:SpellZone;
      
      public var triggers:Array;
      
      public var rawZone:String;
      
      public var randomWeight:Number;
      
      public var randomGroup:int;
      
      public var param3:int;
      
      public var param2:int;
      
      public var param1:int;
      
      public var order:int;
      
      public var masks:Array;
      
      public var level:int;
      
      public var isDispellable:Boolean;
      
      public var isCritical:Boolean;
      
      public var id:uint;
      
      public var duration:int;
      
      public var delay:int;
      
      public var category:int;
      
      public var actionId:int;
      
      public function HaxeSpellEffect(param1:uint, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:Boolean, param10:String, param11:String, param12:String, param13:Number, param14:int, param15:Boolean, param16:int, param17:int)
      {
         id = param1;
         level = param2;
         order = param3;
         actionId = param4;
         param1 = param5;
         param2 = param6;
         param3 = param7;
         duration = param8;
         isCritical = param9;
         triggers = SpellManager.splitTriggers(param10);
         rawZone = param11;
         masks = SpellManager.splitMasks(param12);
         masks.sort(function(param1:String, param2:String):int
         {
            return int(HaxeSpellEffect.sortMasks(param1,param2));
         });
         randomWeight = param13;
         randomGroup = param14;
         isDispellable = param15;
         delay = param16;
         category = param17;
         zone = SpellZone.fromRawZone(param11);
      }
      
      public static function sortMasks(param1:String, param2:String) : int
      {
         if(int("*bBeEfFzZKoOPpTWUvVrRQq".indexOf(param1.charAt(0))) != -1)
         {
            if(int("*bBeEfFzZKoOPpTWUvVrRQq".indexOf(param2.charAt(0))) != -1)
            {
               if(param1.charCodeAt(0) == "*".charCodeAt(0) && param2.charCodeAt(0) != "*".charCodeAt(0))
               {
                  return -1;
               }
               if(param2.charCodeAt(0) == "*".charCodeAt(0) && param1.charCodeAt(0) != "*".charCodeAt(0))
               {
                  return 1;
               }
            }
            return -1;
         }
         if(int("*bBeEfFzZKoOPpTWUvVrRQq".indexOf(param2.charAt(0))) != -1)
         {
            return 1;
         }
         return 0;
      }
      
      public function isRandom() : Boolean
      {
         return randomWeight > 0;
      }
      
      public function isAOE() : Boolean
      {
         return zone.radius >= 1;
      }
      
      public function getRandomRoll() : int
      {
         var _loc1_:int = getMinRoll();
         var _loc2_:int = getMaxRoll();
         var _loc3_:Number = Number(Math.random());
         var _loc4_:Number = _loc3_ * (_loc2_ - _loc1_);
         return int(Math.floor(Number(Number(_loc1_ + _loc4_) + 0.5)));
      }
      
      public function getMinRoll() : int
      {
         return param1 + param3;
      }
      
      public function getMaxRoll() : int
      {
         return param1 * param2 + param3;
      }
      
      public function getElement() : int
      {
         return int(ElementEnum.getElementFromActionId(actionId));
      }
      
      public function getDamageInterval() : Interval
      {
         return new Interval(int(getMinRoll()),int(getMaxRoll()));
      }
      
      public function clone() : HaxeSpellEffect
      {
         var _loc1_:HaxeSpellEffect = new HaxeSpellEffect(id,level,order,actionId,param1,param2,param3,duration,isCritical,"",rawZone,"",randomWeight,randomGroup,isDispellable,delay,category);
         _loc1_.triggers = triggers;
         _loc1_.masks = masks;
         return _loc1_;
      }
   }
}
