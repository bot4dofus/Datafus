package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class LivingObjectHookList
   {
      
      public static const LivingObjectUpdate:String = "LivingObjectUpdate";
      
      public static const LivingObjectDissociate:String = "LivingObjectDissociate";
      
      public static const LivingObjectFeed:String = "LivingObjectFeed";
      
      public static const LivingObjectAssociate:String = "LivingObjectAssociate";
      
      public static const MimicryObjectPreview:String = "MimicryObjectPreview";
      
      public static const MimicryObjectAssociated:String = "MimicryObjectAssociated";
       
      
      public function LivingObjectHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(LivingObjectUpdate);
         Hook.createHook(LivingObjectDissociate);
         Hook.createHook(LivingObjectFeed);
         Hook.createHook(LivingObjectAssociate);
         Hook.createHook(MimicryObjectPreview);
         Hook.createHook(MimicryObjectAssociated);
      }
   }
}
