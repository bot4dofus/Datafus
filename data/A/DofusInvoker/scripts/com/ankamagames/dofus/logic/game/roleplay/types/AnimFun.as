package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.dofus.types.data.AnimFunData;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public final class AnimFun
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AnimFun));
       
      
      private var _actorId:Number;
      
      private var _animName:String;
      
      private var _animId:int;
      
      private var _delayTime:int;
      
      private var _fastAnim:Boolean;
      
      private var _data:AnimFunData;
      
      public function AnimFun(pActorId:Number, pAnim:AnimFunData, pDelayTime:int, pFastAnim:Boolean)
      {
         super();
         this._actorId = pActorId;
         this._animName = pAnim.animName;
         this._delayTime = pDelayTime;
         this._fastAnim = pFastAnim;
         this._animId = pAnim.animId;
         this._data = pAnim;
      }
      
      public function get actorId() : Number
      {
         return this._actorId;
      }
      
      public function get delayTime() : int
      {
         return this._delayTime;
      }
      
      public function get fastAnim() : Boolean
      {
         return this._fastAnim;
      }
      
      public function get animName() : String
      {
         return this._animName;
      }
      
      public function get animId() : int
      {
         return this._animId;
      }
      
      public function get data() : AnimFunData
      {
         return this._data;
      }
      
      public function toString() : String
      {
         return "[AnimFun " + this._actorId + " " + this._animName + " " + this._delayTime + " " + this._fastAnim + "]";
      }
   }
}
