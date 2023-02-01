package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMount;
   import com.ankamagames.dofus.datacenter.mounts.Mount;
   import com.ankamagames.dofus.internalDatacenter.guild.PaddockWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.InventoryManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.MountFrame;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   [InstanciedApi]
   public class MountApi implements IApi
   {
       
      
      public function MountApi()
      {
         super();
      }
      
      private function get mountFrame() : MountFrame
      {
         return Kernel.getWorker().getFrame(MountFrame) as MountFrame;
      }
      
      private function get inventoryFrame() : InventoryManagementFrame
      {
         return Kernel.getWorker().getFrame(InventoryManagementFrame) as InventoryManagementFrame;
      }
      
      private function get roleplayContextFrame() : RoleplayContextFrame
      {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      [NoBoxing]
      public function getRiderEntityLook(look:*) : TiphonEntityLook
      {
         return EntityLookAdapter.getRiderLook(look).clone();
      }
      
      public function getMount(modelId:uint) : Mount
      {
         return Mount.getMountById(modelId);
      }
      
      public function getStableList() : Array
      {
         return this.mountFrame.stableList;
      }
      
      public function getPaddockList() : Array
      {
         return this.mountFrame.paddockList;
      }
      
      public function getInventoryList() : Vector.<ItemWrapper>
      {
         return InventoryManager.getInstance().inventory.getView("certificate").content;
      }
      
      public function getCurrentPaddock() : PaddockWrapper
      {
         return this.roleplayContextFrame.currentPaddock;
      }
      
      public function isCertificateValid(certificate:ItemWrapper) : Boolean
      {
         if(!certificate.effects || certificate.effects.length == 0)
         {
            return false;
         }
         var mountEffect:EffectInstanceMount = certificate.effects[0] as EffectInstanceMount;
         if(!mountEffect)
         {
            return false;
         }
         var now:Date = new Date();
         return mountEffect.expirationDate >= now.time;
      }
   }
}
