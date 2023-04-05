package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.logic.game.common.misc.IInventoryView;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class CertificateView implements IInventoryView
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CertificateView));
       
      
      private var _content:Vector.<ItemWrapper>;
      
      private var _hookLock:HookLock;
      
      public function CertificateView(hookLock:HookLock)
      {
         super();
         this._hookLock = hookLock;
      }
      
      public function initialize(items:Vector.<ItemWrapper>) : void
      {
         var item:ItemWrapper = null;
         this._content = new Vector.<ItemWrapper>();
         for each(item in items)
         {
            if(this.isListening(item))
            {
               this.addItem(item,0,false);
            }
         }
         this.updateView();
      }
      
      public function get name() : String
      {
         return "certificate";
      }
      
      public function get content() : Vector.<ItemWrapper>
      {
         return this._content;
      }
      
      public function addItem(item:ItemWrapper, invisible:int, needUpdateView:Boolean = true) : void
      {
         this._content.unshift(item);
         if(needUpdateView)
         {
            this.updateView();
         }
      }
      
      public function removeItem(item:ItemWrapper, invisible:int) : void
      {
         var idx:int = this.content.indexOf(item);
         if(idx == -1)
         {
            _log.warn("L\'item qui doit être supprimé n\'est pas présent dans la liste");
            return;
         }
         this.content.splice(idx,1);
         this.updateView();
      }
      
      public function modifyItem(item:ItemWrapper, oldItem:ItemWrapper, invisible:int) : void
      {
         this.updateView();
      }
      
      public function isListening(item:ItemWrapper) : Boolean
      {
         return item.isCertificate;
      }
      
      public function updateView() : void
      {
         this._hookLock.addHook(MountHookList.MountStableUpdate,[null,null,this.content]);
      }
      
      public function empty() : void
      {
         this._content = new Vector.<ItemWrapper>();
         this.updateView();
      }
   }
}
