package com.ankamagames.berilia.types.event
{
   import com.ankamagames.berilia.components.TextureBase;
   import com.ankamagames.jerakine.types.DynamicSecureObject;
   import flash.events.Event;
   
   public class TextureLoadFailedEvent extends Event
   {
      
      public static const EVENT_TEXTURE_LOAD_FAILED:String = "TextureLoadFailedEvent";
       
      
      private var _behavior:DynamicSecureObject;
      
      private var _targetedTexture:TextureBase;
      
      public function TextureLoadFailedEvent(target:TextureBase, behavior:DynamicSecureObject)
      {
         super(EVENT_TEXTURE_LOAD_FAILED,false,false);
         this._targetedTexture = target;
         this._behavior = behavior;
      }
      
      public function get behavior() : DynamicSecureObject
      {
         return this._behavior;
      }
      
      public function get targetedTexture() : TextureBase
      {
         return this._targetedTexture;
      }
   }
}
