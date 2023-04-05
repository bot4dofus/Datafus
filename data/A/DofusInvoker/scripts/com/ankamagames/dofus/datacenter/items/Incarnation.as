package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Incarnation implements IDataCenter
   {
      
      public static const MODULE:String = "Incarnation";
      
      private static var _incarnationsList:Array;
       
      
      public var id:uint;
      
      public var maleBoneId:uint;
      
      public var femaleBoneId:uint;
      
      public var lookMale:String;
      
      public var lookFemale:String;
      
      public function Incarnation()
      {
         super();
      }
      
      public static function getIncarnationById(id:uint) : Incarnation
      {
         return GameData.getObject(MODULE,id) as Incarnation;
      }
      
      public static function getAllIncarnation() : Array
      {
         if(!_incarnationsList)
         {
            _incarnationsList = GameData.getObjects(MODULE) as Array;
         }
         return _incarnationsList;
      }
   }
}
