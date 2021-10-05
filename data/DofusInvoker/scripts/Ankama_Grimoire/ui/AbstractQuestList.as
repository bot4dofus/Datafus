package Ankama_Grimoire.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   
   public class AbstractQuestList
   {
       
      
      private var _uis:Array;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UiTutoApi")]
      public var hintApi:UiTutoApi;
      
      public function AbstractQuestList()
      {
         this._uis = ["cartographyUi","cinematic"];
         super();
      }
      
      public function main(params:Object) : void
      {
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this.sysApi.addHook(BeriliaHookList.UiUnloaded,this.onUiUnloaded);
         this.sysApi.addHook(HookList.ContextChanged,this.onContextChanged);
         if(!this.canBeVisible() || this.sysApi.isFightContext())
         {
            this.setVisible(false);
         }
      }
      
      public function onUiLoaded(uiName:String) : void
      {
         if(!this.canBeVisible())
         {
            this.setVisible(false);
         }
      }
      
      public function onUiUnloaded(uiName:String) : void
      {
         if(this.canBeVisible() && !this.sysApi.isFightContext())
         {
            this.setVisible(!this.uiApi.UiIsHiden(this.uiApi.me().name));
         }
      }
      
      public function onContextChanged(context:uint) : void
      {
         if(context == GameContextEnum.FIGHT)
         {
            this.setVisible(false);
         }
         else if(this.canBeVisible())
         {
            this.setVisible(true);
         }
      }
      
      protected function setVisible(value:Boolean) : void
      {
         this.uiApi.me().visible = value && !this.sysApi.isFightContext() && this.canBeVisible();
         this.uiApi.me().isMagnetic = value && !this.sysApi.isFightContext() && this.canBeVisible();
      }
      
      public function set visible(value:Boolean) : void
      {
         this.setVisible(value);
      }
      
      private function canBeVisible() : Boolean
      {
         var uiName:String = null;
         for each(uiName in this._uis)
         {
            if(this.uiApi.getUi(uiName))
            {
               return false;
            }
         }
         return true;
      }
   }
}
