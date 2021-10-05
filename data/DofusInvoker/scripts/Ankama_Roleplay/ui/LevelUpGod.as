package Ankama_Roleplay.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.TextureBitmap;
   
   public class LevelUpGod
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      public var tx_god:TextureBitmap;
      
      public function LevelUpGod()
      {
         super();
      }
      
      public function main(pParam:Object) : void
      {
         this.tx_god.uri = this.uiApi.createUri(this.uiApi.me().getConstant("god_" + pParam.breed));
         this.uiApi.me().childIndex = 0;
      }
   }
}
