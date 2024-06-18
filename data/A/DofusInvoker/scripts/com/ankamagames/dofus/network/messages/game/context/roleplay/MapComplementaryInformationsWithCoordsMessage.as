package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightStartingPositions;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.house.HouseInformations;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MapComplementaryInformationsWithCoordsMessage extends MapComplementaryInformationsDataMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5198;
       
      
      private var _isInitialized:Boolean = false;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public function MapComplementaryInformationsWithCoordsMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5198;
      }
      
      public function initMapComplementaryInformationsWithCoordsMessage(subAreaId:uint = 0, mapId:Number = 0, houses:Vector.<HouseInformations> = null, actors:Vector.<GameRolePlayActorInformations> = null, interactiveElements:Vector.<InteractiveElement> = null, statedElements:Vector.<StatedElement> = null, obstacles:Vector.<MapObstacle> = null, fights:Vector.<FightCommonInformations> = null, hasAggressiveMonsters:Boolean = false, fightStartPositions:FightStartingPositions = null, worldX:int = 0, worldY:int = 0) : MapComplementaryInformationsWithCoordsMessage
      {
         super.initMapComplementaryInformationsDataMessage(subAreaId,mapId,houses,actors,interactiveElements,statedElements,obstacles,fights,hasAggressiveMonsters,fightStartPositions);
         this.worldX = worldX;
         this.worldY = worldY;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.worldX = 0;
         this.worldY = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_MapComplementaryInformationsWithCoordsMessage(output);
      }
      
      public function serializeAs_MapComplementaryInformationsWithCoordsMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_MapComplementaryInformationsDataMessage(output);
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         output.writeShort(this.worldX);
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
         }
         output.writeShort(this.worldY);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MapComplementaryInformationsWithCoordsMessage(input);
      }
      
      public function deserializeAs_MapComplementaryInformationsWithCoordsMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MapComplementaryInformationsWithCoordsMessage(tree);
      }
      
      public function deserializeAsyncAs_MapComplementaryInformationsWithCoordsMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of MapComplementaryInformationsWithCoordsMessage.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of MapComplementaryInformationsWithCoordsMessage.worldY.");
         }
      }
   }
}
