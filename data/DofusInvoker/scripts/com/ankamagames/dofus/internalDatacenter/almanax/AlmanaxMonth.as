package com.ankamagames.dofus.internalDatacenter.almanax
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AlmanaxMonth implements IDataCenter
   {
       
      
      public var id:uint;
      
      public var monthNum:uint;
      
      public var protectorName:String;
      
      public var protectorDescription:String;
      
      public var webImageUrl:String;
      
      public function AlmanaxMonth()
      {
         super();
      }
   }
}
