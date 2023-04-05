package com.ankamagames.dofus.logic.game.roleplay.messages
{
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class InteractiveElementActivationMessage implements Message
   {
       
      
      private var _ie:InteractiveElement;
      
      private var _position:MapPoint;
      
      private var _skillInstanceId:uint;
      
      private var _additionalParam:int;
      
      public var fromStack:Boolean;
      
      public var fromAutotrip:Boolean;
      
      public function InteractiveElementActivationMessage(ie:InteractiveElement, position:MapPoint, skillInstanceId:uint, additionalParam:int = 0)
      {
         super();
         this._ie = ie;
         this._position = position;
         this._skillInstanceId = skillInstanceId;
         this._additionalParam = additionalParam;
      }
      
      public function get interactiveElement() : InteractiveElement
      {
         return this._ie;
      }
      
      public function get position() : MapPoint
      {
         return this._position;
      }
      
      public function get skillInstanceId() : uint
      {
         return this._skillInstanceId;
      }
      
      public function get additionalParam() : int
      {
         return this._additionalParam;
      }
   }
}
