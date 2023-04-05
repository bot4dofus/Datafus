package com.ankamagames.dofus.internalDatacenter.communication
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class DelayedActionItem implements IDataCenter
   {
       
      
      public var playerId:Number;
      
      public var type:uint;
      
      public var dataId:int;
      
      public var endTime:Number;
      
      public function DelayedActionItem(pPlayerId:Number, type:uint, dataId:int, endTime:Number)
      {
         super();
         this.playerId = pPlayerId;
         this.type = type;
         this.dataId = dataId;
         this.endTime = endTime;
      }
   }
}
