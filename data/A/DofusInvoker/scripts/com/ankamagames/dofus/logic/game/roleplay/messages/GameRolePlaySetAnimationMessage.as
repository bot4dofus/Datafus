package com.ankamagames.dofus.logic.game.roleplay.messages
{
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.jerakine.messages.Message;
   
   public class GameRolePlaySetAnimationMessage implements Message
   {
       
      
      private var _informations:GameContextActorInformations;
      
      private var _animation:String;
      
      private var _duration:uint;
      
      private var _spellLevelId:uint;
      
      private var _instant:Boolean;
      
      private var _directions8:Boolean;
      
      private var _playStaticOnly:Boolean;
      
      public function GameRolePlaySetAnimationMessage(informations:GameContextActorInformations, animation:String, spellLevelId:uint = 0, duration:uint = 0, instant:Boolean = true, directions8:Boolean = true, playStaticOnly:Boolean = false)
      {
         super();
         this._informations = informations;
         this._animation = animation;
         this._spellLevelId = spellLevelId;
         this._duration = duration;
         this._instant = instant;
         this._directions8 = directions8;
         this._playStaticOnly = playStaticOnly;
      }
      
      public function get informations() : GameContextActorInformations
      {
         return this._informations;
      }
      
      public function get animation() : String
      {
         return this._animation;
      }
      
      public function get duration() : uint
      {
         return this._duration;
      }
      
      public function get spellLevelId() : uint
      {
         return this._spellLevelId;
      }
      
      public function get instant() : Boolean
      {
         return this._instant;
      }
      
      public function get directions8() : Boolean
      {
         return this._directions8;
      }
      
      public function get playStaticOnly() : Boolean
      {
         return this._playStaticOnly;
      }
   }
}
