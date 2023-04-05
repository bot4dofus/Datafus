package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.logic.game.common.misc.IInventoryView;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class ListView implements IInventoryView
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ListView));
       
      
      protected var _view:Vector.<ItemWrapper>;
      
      protected var _hookLock:HookLock;
      
      public function ListView(hookLock:HookLock)
      {
         this._view = new Vector.<ItemWrapper>();
         super();
         this._hookLock = hookLock;
      }
      
      public function get name() : String
      {
         throw new Error("get name() is abstract method, it should be implemented");
      }
      
      public function initialize(items:Vector.<ItemWrapper>) : void
      {
         var item:ItemWrapper = null;
         this._view.splice(0,this._view.length);
         for each(item in items)
         {
            this._view.push(item);
         }
         this.updateView();
      }
      
      public function get content() : Vector.<ItemWrapper>
      {
         return this._view;
      }
      
      public function addItem(item:ItemWrapper, invisible:int, needUpdateView:Boolean = true) : void
      {
         this._view.push(item);
      }
      
      public function removeItem(item:ItemWrapper, invisible:int) : void
      {
         var i:int = this._view.indexOf(item);
         if(i == -1)
         {
            throw new Error("Demande de suppression d\'un item (id " + item.objectUID + ") qui n\'existe pas dans la vue " + this.name);
         }
         this._view.splice(i,1);
      }
      
      public function modifyItem(item:ItemWrapper, oldItem:ItemWrapper, invisible:int) : void
      {
         var i:int = this._view.indexOf(item);
         if(i == -1)
         {
            throw new Error("Demande de modification d\'un item (id " + item.objectUID + ") qui n\'existe pas dans la vue " + this.name);
         }
         this._view[i] = item;
      }
      
      public function isListening(item:ItemWrapper) : Boolean
      {
         throw new Error("isListening() is abstract method, it should be implemented");
      }
      
      public function updateView() : void
      {
         throw new Error("updateView() is abstract method, it should be implemented");
      }
      
      public function empty() : void
      {
         this._view = new Vector.<ItemWrapper>();
         this.updateView();
      }
   }
}
