package com.ankamagames.dofus.logic.game.common.types
{
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   
   public class PartyFightInformationsData
   {
       
      
      private var _fightMapId:Number;
      
      private var _fightId:int;
      
      private var _timeUntilFightbegin:BenchmarkTimer;
      
      private var _memberName:String;
      
      private var _memberId:Number;
      
      private var _timeBeforeStart:uint;
      
      private var _fightStartDate:Number;
      
      public function PartyFightInformationsData(fightMapId:Number, fightId:int, memberName:String, memberId:Number, timeBeforeStart:uint)
      {
         super();
         this._fightMapId = fightMapId;
         this._fightId = fightId;
         this._memberName = memberName;
         this._timeBeforeStart = timeBeforeStart;
         this._timeUntilFightbegin = new BenchmarkTimer(this._timeBeforeStart,1,"PartyFightInformationsData._timeUntilFightbegin");
         this._memberId = memberId;
         var currentDate:Date = new Date();
         this._fightStartDate = currentDate.getTime() + this._timeBeforeStart as Number;
      }
      
      public function get fightMapId() : Number
      {
         return this._fightMapId;
      }
      
      public function set fightMapId(value:Number) : void
      {
         this._fightMapId = value;
      }
      
      public function get fightId() : int
      {
         return this._fightId;
      }
      
      public function set fightId(value:int) : void
      {
         this._fightId = value;
      }
      
      public function get timeUntilFightbegin() : BenchmarkTimer
      {
         return this._timeUntilFightbegin;
      }
      
      public function set timeUntilFightbegin(value:BenchmarkTimer) : void
      {
         this._timeUntilFightbegin = value;
      }
      
      public function get memberName() : String
      {
         return this._memberName;
      }
      
      public function set memberName(value:String) : void
      {
         this._memberName = value;
      }
      
      public function get timeBeforeStart() : uint
      {
         return this._timeBeforeStart;
      }
      
      public function set timeBeforeStart(value:uint) : void
      {
         this._timeBeforeStart = value;
      }
      
      public function get fightStartDate() : uint
      {
         return this._fightStartDate;
      }
      
      public function get memberId() : Number
      {
         return this._memberId;
      }
   }
}
