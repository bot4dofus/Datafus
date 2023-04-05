package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class PartyMemberWrapper implements IDataCenter
   {
       
      
      public var id:Number;
      
      public var name:String;
      
      public var isMember:Boolean;
      
      public var isLeader:Boolean;
      
      public var level:int;
      
      public var breedId:int;
      
      public var entityLook:EntityLook;
      
      public var lifePoints:int;
      
      public var maxLifePoints:int;
      
      public var maxInitiative:int;
      
      public var prospecting:int;
      
      public var rank:int;
      
      public var alignmentSide:int;
      
      public var regenRate:int;
      
      public var hostId:Number;
      
      public var hostName:String;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:Number = 0;
      
      public var subAreaId:uint = 0;
      
      public var status:uint = 1;
      
      public var companions:Array;
      
      public var isInArenaParty:Boolean = false;
      
      public function PartyMemberWrapper(id:Number, name:String, status:uint, isMember:Boolean, isLeader:Boolean = false, level:int = 0, entityLook:EntityLook = null, lifePoints:int = 0, maxLifePoints:int = 0, maxInitiative:int = 0, prospecting:int = 0, alignmentSide:int = 0, regenRate:int = 0, rank:int = 0, worldX:int = 0, worldY:int = 0, mapId:Number = 0, subAreaId:int = 0, breedId:int = 0, companions:Array = null)
      {
         this.companions = new Array();
         super();
         this.id = id;
         this.name = name;
         this.isMember = isMember;
         this.isLeader = isLeader;
         this.level = level;
         this.entityLook = entityLook;
         this.breedId = breedId;
         this.lifePoints = lifePoints;
         this.maxLifePoints = maxLifePoints;
         this.maxInitiative = maxInitiative;
         this.prospecting = prospecting;
         this.alignmentSide = alignmentSide;
         this.regenRate = regenRate;
         this.rank = rank;
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.status = status;
         if(!companions)
         {
            this.companions = new Array();
         }
         else
         {
            this.companions = companions;
         }
      }
      
      public function get initiative() : int
      {
         return this.maxInitiative * this.lifePoints / this.maxLifePoints;
      }
   }
}
