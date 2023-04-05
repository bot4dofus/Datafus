package com.ankamagames.dofus.internalDatacenter.connection
{
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class CreationCharacterWrapper implements IDataCenter
   {
       
      
      public var name:String = "";
      
      public var gender:Boolean = false;
      
      public var breed:int = 0;
      
      public var cosmeticId:uint = 0;
      
      public var colors:Vector.<int>;
      
      public var entityLook:TiphonEntityLook;
      
      public function CreationCharacterWrapper()
      {
         this.colors = new Vector.<int>();
         super();
      }
      
      public static function create(name:String, gender:Boolean, breed:uint, cosmeticId:int, colors:Vector.<int>, entityLook:EntityLook = null) : CreationCharacterWrapper
      {
         var obj:CreationCharacterWrapper = new CreationCharacterWrapper();
         obj.name = name;
         obj.gender = gender;
         obj.breed = breed;
         obj.cosmeticId = cosmeticId;
         obj.colors = colors;
         if(entityLook)
         {
            obj.entityLook = EntityLookAdapter.fromNetwork(entityLook);
         }
         return obj;
      }
      
      public function toString() : String
      {
         return "[CreationCharacterWrapper#" + this.name + "_" + this.gender + "_" + this.breed + "_" + this.cosmeticId + "_" + this.colors + "_" + this.entityLook + "]";
      }
   }
}
