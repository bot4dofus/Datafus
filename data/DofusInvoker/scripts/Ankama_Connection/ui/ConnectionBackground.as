package Ankama_Connection.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class ConnectionBackground
   {
       
      
      public var output:Object;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      private var _files:Array;
      
      private var _backgroundImagesCount:int;
      
      public var tx_bg:Texture;
      
      public var btn_changeBg:ButtonContainer;
      
      public function ConnectionBackground()
      {
         super();
      }
      
      public function main(... args) : void
      {
         var file:Object = null;
         if(this.sysApi.getBuildType() >= BuildTypeEnum.INTERNAL)
         {
            this._files = this.sysApi.getDirectoryContent();
            this._backgroundImagesCount = 0;
            for each(file in this._files)
            {
               if(file.name.indexOf("bg") == 0)
               {
                  ++this._backgroundImagesCount;
               }
            }
            if(this._backgroundImagesCount > 1)
            {
               this.btn_changeBg.visible = true;
               this.changeBackground();
            }
         }
      }
      
      public function unload() : void
      {
      }
      
      private function changeBackground() : void
      {
         var rnd:int = Math.floor(Math.random() * this._backgroundImagesCount) + 1;
         this.tx_bg.width = 1980;
         this.tx_bg.height = 1024;
         this.tx_bg.uri = this.uiApi.createUri("bg" + rnd + ".jpg");
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target == this.btn_changeBg)
         {
            this.changeBackground();
         }
      }
   }
}
