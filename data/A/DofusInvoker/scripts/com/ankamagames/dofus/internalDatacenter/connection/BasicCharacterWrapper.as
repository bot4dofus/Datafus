package com.ankamagames.dofus.internalDatacenter.connection
{
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class BasicCharacterWrapper implements IDataCenter
   {
       
      
      public var id:Number;
      
      public var name:String;
      
      public var level:uint;
      
      public var entityLook:TiphonEntityLook;
      
      public var breedId:uint;
      
      public var sex:Boolean;
      
      public var deathState:uint;
      
      public var deathCount:uint;
      
      public var deathMaxLevel:uint;
      
      public var bonusXp:uint;
      
      public var unusable:Boolean;
      
      private var _breed:Breed;
      
      public function BasicCharacterWrapper()
      {
         super();
      }
      
      public static function create(id:Number, name:String, level:uint, entityLook:EntityLook, breed:uint, sex:Boolean, deathState:uint = 0, deathCount:uint = 0, deathMaxLevel:uint = 0, bonusXp:uint = 0, unusable:Boolean = false) : BasicCharacterWrapper
      {
         var obj:BasicCharacterWrapper = new BasicCharacterWrapper();
         obj.id = id;
         obj.name = name;
         obj.level = level;
         obj.entityLook = EntityLookAdapter.fromNetwork(entityLook);
         obj.breedId = breed;
         obj._breed = Breed.getBreedById(obj.breedId);
         obj.sex = sex;
         obj.deathState = deathState;
         obj.deathCount = deathCount;
         obj.deathMaxLevel = deathMaxLevel;
         obj.bonusXp = bonusXp;
         obj.unusable = unusable;
         return obj;
      }
      
      public function get breed() : Breed
      {
         if(!this._breed)
         {
            this._breed = Breed.getBreedById(this.breedId);
         }
         return this._breed;
      }
      
      public function toString() : String
      {
         return "[BasicCharacterWrapper#" + this.id + "_" + this.name + "]";
      }
   }
}
