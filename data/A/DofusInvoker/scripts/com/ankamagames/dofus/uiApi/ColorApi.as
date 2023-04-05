package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.jerakine.types.Color;
   
   [InstanciedApi]
   public class ColorApi implements IApi
   {
       
      
      private var _module:UiModule;
      
      public function ColorApi()
      {
         super();
      }
      
      [ApiData(name="module")]
      public function set module(value:UiModule) : void
      {
         this._module = value;
      }
      
      public function destroy() : void
      {
         this._module = null;
      }
      
      public function changeLightness(c:uint, value:Number) : uint
      {
         return Color.setHSLlightness(c,value);
      }
      
      public function changeSaturation(c:uint, saturation:Number) : uint
      {
         return Color.setHSVSaturation(c,saturation);
      }
      
      public function generateColorList(methode:int) : Array
      {
         return Color.generateColorList(methode);
      }
   }
}
