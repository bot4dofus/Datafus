package com.ankamagames.dofus.internalDatacenter.almanax
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AlmanaxEvent implements IDataCenter
   {
       
      
      public var id:int;
      
      public var name:String;
      
      public var bossText:String;
      
      public var ephemeris:String;
      
      public var rubrikabrax:String;
      
      public var isFest:Boolean;
      
      public var festText:String;
      
      public var webImageUrl:String;
      
      public function AlmanaxEvent()
      {
         super();
      }
   }
}
