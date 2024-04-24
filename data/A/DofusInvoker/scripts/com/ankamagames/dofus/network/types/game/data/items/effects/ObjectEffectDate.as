package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectEffectDate extends ObjectEffect implements INetworkType
   {
      
      public static const protocolId:uint = 3111;
       
      
      public var year:uint = 0;
      
      public var month:uint = 0;
      
      public var day:uint = 0;
      
      public var hour:uint = 0;
      
      public var minute:uint = 0;
      
      public function ObjectEffectDate()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3111;
      }
      
      public function initObjectEffectDate(actionId:uint = 0, year:uint = 0, month:uint = 0, day:uint = 0, hour:uint = 0, minute:uint = 0) : ObjectEffectDate
      {
         super.initObjectEffect(actionId);
         this.year = year;
         this.month = month;
         this.day = day;
         this.hour = hour;
         this.minute = minute;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.year = 0;
         this.month = 0;
         this.day = 0;
         this.hour = 0;
         this.minute = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectEffectDate(output);
      }
      
      public function serializeAs_ObjectEffectDate(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectEffect(output);
         if(this.year < 0)
         {
            throw new Error("Forbidden value (" + this.year + ") on element year.");
         }
         output.writeVarShort(this.year);
         if(this.month < 0)
         {
            throw new Error("Forbidden value (" + this.month + ") on element month.");
         }
         output.writeByte(this.month);
         if(this.day < 0)
         {
            throw new Error("Forbidden value (" + this.day + ") on element day.");
         }
         output.writeByte(this.day);
         if(this.hour < 0)
         {
            throw new Error("Forbidden value (" + this.hour + ") on element hour.");
         }
         output.writeByte(this.hour);
         if(this.minute < 0)
         {
            throw new Error("Forbidden value (" + this.minute + ") on element minute.");
         }
         output.writeByte(this.minute);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectEffectDate(input);
      }
      
      public function deserializeAs_ObjectEffectDate(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._yearFunc(input);
         this._monthFunc(input);
         this._dayFunc(input);
         this._hourFunc(input);
         this._minuteFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectEffectDate(tree);
      }
      
      public function deserializeAsyncAs_ObjectEffectDate(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._yearFunc);
         tree.addChild(this._monthFunc);
         tree.addChild(this._dayFunc);
         tree.addChild(this._hourFunc);
         tree.addChild(this._minuteFunc);
      }
      
      private function _yearFunc(input:ICustomDataInput) : void
      {
         this.year = input.readVarUhShort();
         if(this.year < 0)
         {
            throw new Error("Forbidden value (" + this.year + ") on element of ObjectEffectDate.year.");
         }
      }
      
      private function _monthFunc(input:ICustomDataInput) : void
      {
         this.month = input.readByte();
         if(this.month < 0)
         {
            throw new Error("Forbidden value (" + this.month + ") on element of ObjectEffectDate.month.");
         }
      }
      
      private function _dayFunc(input:ICustomDataInput) : void
      {
         this.day = input.readByte();
         if(this.day < 0)
         {
            throw new Error("Forbidden value (" + this.day + ") on element of ObjectEffectDate.day.");
         }
      }
      
      private function _hourFunc(input:ICustomDataInput) : void
      {
         this.hour = input.readByte();
         if(this.hour < 0)
         {
            throw new Error("Forbidden value (" + this.hour + ") on element of ObjectEffectDate.hour.");
         }
      }
      
      private function _minuteFunc(input:ICustomDataInput) : void
      {
         this.minute = input.readByte();
         if(this.minute < 0)
         {
            throw new Error("Forbidden value (" + this.minute + ") on element of ObjectEffectDate.minute.");
         }
      }
   }
}
