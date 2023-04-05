package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   
   public class SlotDragAndDropData
   {
       
      
      public var currentHolder:ISlotDataHolder;
      
      public var slotData:ISlotData;
      
      public function SlotDragAndDropData(currentHolder:ISlotDataHolder, slotData:ISlotData)
      {
         super();
         this.currentHolder = currentHolder;
         this.slotData = slotData;
      }
   }
}
