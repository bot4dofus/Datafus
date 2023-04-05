package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.berilia.components.Texture;
   
   public class TextureReadyMessage extends ComponentMessage
   {
       
      
      private var _texture:Texture;
      
      public function TextureReadyMessage(texture:Texture)
      {
         super(texture);
         this._texture = texture;
      }
      
      public function get texture() : Texture
      {
         return this._texture;
      }
   }
}
