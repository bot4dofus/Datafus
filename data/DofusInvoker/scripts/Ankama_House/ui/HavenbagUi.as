package Ankama_House.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagExitAction;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class HavenbagUi
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      public var btn_havenbag:ButtonContainer;
      
      public var btn_leave:ButtonContainer;
      
      public function HavenbagUi()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target == this.btn_havenbag)
         {
            (this.uiApi.getUi("havenbagManager").uiClass as HavenbagManager).openHavenbagMenu();
         }
         else if(target == this.btn_leave)
         {
            this.sysApi.sendAction(new HavenbagExitAction([]));
         }
      }
   }
}
