package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightStartingPositions;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.house.HouseInformations;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsInside;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MapComplementaryInformationsDataInHouseMessage extends MapComplementaryInformationsDataMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1071;
       
      
      private var _isInitialized:Boolean = false;
      
      public var currentHouse:HouseInformationsInside;
      
      private var _currentHousetree:FuncTree;
      
      public function MapComplementaryInformationsDataInHouseMessage()
      {
         this.currentHouse = new HouseInformationsInside();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1071;
      }
      
      public function initMapComplementaryInformationsDataInHouseMessage(subAreaId:uint = 0, mapId:Number = 0, houses:Vector.<HouseInformations> = null, actors:Vector.<GameRolePlayActorInformations> = null, interactiveElements:Vector.<InteractiveElement> = null, statedElements:Vector.<StatedElement> = null, obstacles:Vector.<MapObstacle> = null, fights:Vector.<FightCommonInformations> = null, hasAggressiveMonsters:Boolean = false, fightStartPositions:FightStartingPositions = null, currentHouse:HouseInformationsInside = null) : MapComplementaryInformationsDataInHouseMessage
      {
         super.initMapComplementaryInformationsDataMessage(subAreaId,mapId,houses,actors,interactiveElements,statedElements,obstacles,fights,hasAggressiveMonsters,fightStartPositions);
         this.currentHouse = currentHouse;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.currentHouse = new HouseInformationsInside();
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
         this.serializeAs_MapComplementaryInformationsDataInHouseMessage(output);
      }
      
      public function serializeAs_MapComplementaryInformationsDataInHouseMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_MapComplementaryInformationsDataMessage(output);
         this.currentHouse.serializeAs_HouseInformationsInside(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MapComplementaryInformationsDataInHouseMessage(input);
      }
      
      public function deserializeAs_MapComplementaryInformationsDataInHouseMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.currentHouse = new HouseInformationsInside();
         this.currentHouse.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MapComplementaryInformationsDataInHouseMessage(tree);
      }
      
      public function deserializeAsyncAs_MapComplementaryInformationsDataInHouseMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._currentHousetree = tree.addChild(this._currentHousetreeFunc);
      }
      
      private function _currentHousetreeFunc(input:ICustomDataInput) : void
      {
         this.currentHouse = new HouseInformationsInside();
         this.currentHouse.deserializeAsync(this._currentHousetree);
      }
   }
}
