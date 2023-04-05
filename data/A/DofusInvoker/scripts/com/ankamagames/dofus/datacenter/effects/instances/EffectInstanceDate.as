package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceDate extends EffectInstance implements IDataCenter
   {
       
      
      public var year:uint;
      
      public var month:uint;
      
      public var day:uint;
      
      public var hour:uint;
      
      public var minute:uint;
      
      public function EffectInstanceDate()
      {
         super();
      }
      
      override public function clone() : EffectInstance
      {
         var o:EffectInstanceDate = new EffectInstanceDate();
         o.rawZone = rawZone;
         o.effectId = effectId;
         o.duration = duration;
         o.delay = delay;
         o.year = this.year;
         o.month = this.month;
         o.day = this.day;
         o.hour = this.hour;
         o.minute = this.minute;
         o.random = random;
         o.group = group;
         o.targetId = targetId;
         o.targetMask = targetMask;
         return o;
      }
      
      override public function get parameter0() : Object
      {
         return String(this.year);
      }
      
      override public function get parameter1() : Object
      {
         var smonth:String = this.month > 9 ? String(this.month) : "0" + String(this.month);
         var sday:String = this.day > 9 ? String(this.day) : "0" + String(this.day);
         return smonth + sday;
      }
      
      override public function get parameter2() : Object
      {
         var shour:String = this.hour > 9 ? String(this.hour) : "0" + String(this.hour);
         var sminute:String = this.minute > 9 ? String(this.minute) : "0" + String(this.minute);
         return shour + sminute;
      }
      
      override public function get parameter3() : Object
      {
         return this.month;
      }
      
      override public function get parameter4() : Object
      {
         return this.day;
      }
      
      override public function setParameter(paramIndex:uint, value:*) : void
      {
         switch(paramIndex)
         {
            case 0:
               this.year = uint(value);
               break;
            case 1:
               this.month = uint(String(value).substr(0,2));
               this.day = uint(String(value).substr(2,2));
               break;
            case 2:
               this.hour = uint(String(value).substr(0,2));
               this.minute = uint(String(value).substr(2,2));
               break;
            case 3:
               this.month = uint(value);
               break;
            case 4:
               this.day = uint(value);
         }
      }
   }
}
