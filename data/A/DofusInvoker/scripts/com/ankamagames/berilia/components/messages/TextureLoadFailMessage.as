package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.berilia.components.TextureBase;
   
   public class TextureLoadFailMessage extends ComponentMessage
   {
       
      
      private var _texture:TextureBase;
      
      public function TextureLoadFailMessage(pTexture:TextureBase)
      {
         super(pTexture);
         this._texture = pTexture;
      }
      
      public function get texture() : TextureBase
      {
         return this._texture;
      }
   }
}
