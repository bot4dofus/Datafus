package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class AlignmentHookList
   {
      
      public static const AlignmentRankUpdate:String = "AlignmentRankUpdate";
      
      public static const AlignmentSubAreasList:String = "AlignmentSubAreasList";
      
      public static const AlignmentAreaUpdate:String = "AlignmentAreaUpdate";
      
      public static const KohUpdate:String = "KohUpdate";
      
      public static const CharacterAlignmentWarEffortProgressionHook:String = "CharacterAlignmentWarEffortProgressionHook";
      
      public static const AlignmentWarEffortProgressionMessageHook:String = "AlignmentWarEffortProgressionMessageHook";
      
      public static const UpdateWarEffortHook:String = "UpdateWarEffortHook";
       
      
      public function AlignmentHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(AlignmentRankUpdate);
         Hook.createHook(AlignmentSubAreasList);
         Hook.createHook(AlignmentAreaUpdate);
         Hook.createHook(KohUpdate);
         Hook.createHook(CharacterAlignmentWarEffortProgressionHook);
         Hook.createHook(AlignmentWarEffortProgressionMessageHook);
         Hook.createHook(UpdateWarEffortHook);
      }
   }
}
