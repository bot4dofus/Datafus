package Ankama_ContextMenu.behaviors
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   
   public interface IMenuBehavior
   {
       
      
      function canDestroyItem(param1:ItemWrapper) : Boolean;
   }
}
