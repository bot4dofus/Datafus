package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.tiphon.display.TiphonSprite;
   
   public class MultiPlayerMenuMaker implements IMenuMaker
   {
       
      
      public function MultiPlayerMenuMaker()
      {
         super();
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var entity:TiphonSprite = null;
         var infos:Object = null;
         var subMenu:Array = null;
         var menu:Array = [];
         var cellId:uint = param[0].position.cellId;
         var entities:Array = Api.roleplay.getEntitiesOnCell(cellId);
         var pmm:PlayerMenuMaker = new PlayerMenuMaker();
         var hvmm:HumanVendorMenuMaker = new HumanVendorMenuMaker();
         for each(entity in entities)
         {
            if(entity is AnimatedCharacter && (entity as AnimatedCharacter).id > 0)
            {
               infos = Api.roleplay.getEntityInfos(entity);
               if(infos)
               {
                  if(infos is GameRolePlayMerchantInformations)
                  {
                     subMenu = hvmm.createMenu(infos,[entity]);
                  }
                  else
                  {
                     subMenu = pmm.createMenu(infos,[entity]);
                  }
                  if(!infos.hasOwnProperty("fight"))
                  {
                     menu.push(Api.modMenu.createContextMenuItemObject(infos.name,this.onPutOnTop,[entity],false,subMenu));
                  }
               }
            }
         }
         return menu;
      }
      
      private function onPutOnTop(entity:AnimatedCharacter) : void
      {
         Api.roleplay.putEntityOnTop(entity);
      }
   }
}
