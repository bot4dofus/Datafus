package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
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
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MapComplementaryInformationsDataMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9792;
       
      
      private var _isInitialized:Boolean = false;
      
      public var subAreaId:uint = 0;
      
      public var mapId:Number = 0;
      
      public var houses:Vector.<HouseInformations>;
      
      public var actors:Vector.<GameRolePlayActorInformations>;
      
      public var interactiveElements:Vector.<InteractiveElement>;
      
      public var statedElements:Vector.<StatedElement>;
      
      public var obstacles:Vector.<MapObstacle>;
      
      public var fights:Vector.<FightCommonInformations>;
      
      public var hasAggressiveMonsters:Boolean = false;
      
      public var fightStartPositions:FightStartingPositions;
      
      private var _housestree:FuncTree;
      
      private var _actorstree:FuncTree;
      
      private var _interactiveElementstree:FuncTree;
      
      private var _statedElementstree:FuncTree;
      
      private var _obstaclestree:FuncTree;
      
      private var _fightstree:FuncTree;
      
      private var _fightStartPositionstree:FuncTree;
      
      public function MapComplementaryInformationsDataMessage()
      {
         this.houses = new Vector.<HouseInformations>();
         this.actors = new Vector.<GameRolePlayActorInformations>();
         this.interactiveElements = new Vector.<InteractiveElement>();
         this.statedElements = new Vector.<StatedElement>();
         this.obstacles = new Vector.<MapObstacle>();
         this.fights = new Vector.<FightCommonInformations>();
         this.fightStartPositions = new FightStartingPositions();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9792;
      }
      
      public function initMapComplementaryInformationsDataMessage(subAreaId:uint = 0, mapId:Number = 0, houses:Vector.<HouseInformations> = null, actors:Vector.<GameRolePlayActorInformations> = null, interactiveElements:Vector.<InteractiveElement> = null, statedElements:Vector.<StatedElement> = null, obstacles:Vector.<MapObstacle> = null, fights:Vector.<FightCommonInformations> = null, hasAggressiveMonsters:Boolean = false, fightStartPositions:FightStartingPositions = null) : MapComplementaryInformationsDataMessage
      {
         this.subAreaId = subAreaId;
         this.mapId = mapId;
         this.houses = houses;
         this.actors = actors;
         this.interactiveElements = interactiveElements;
         this.statedElements = statedElements;
         this.obstacles = obstacles;
         this.fights = fights;
         this.hasAggressiveMonsters = hasAggressiveMonsters;
         this.fightStartPositions = fightStartPositions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.subAreaId = 0;
         this.mapId = 0;
         this.houses = new Vector.<HouseInformations>();
         this.actors = new Vector.<GameRolePlayActorInformations>();
         this.interactiveElements = new Vector.<InteractiveElement>();
         this.statedElements = new Vector.<StatedElement>();
         this.obstacles = new Vector.<MapObstacle>();
         this.fights = new Vector.<FightCommonInformations>();
         this.hasAggressiveMonsters = false;
         this.fightStartPositions = new FightStartingPositions();
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
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_MapComplementaryInformationsDataMessage(output);
      }
      
      public function serializeAs_MapComplementaryInformationsDataMessage(output:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         output.writeShort(this.houses.length);
         for(var _i3:uint = 0; _i3 < this.houses.length; _i3++)
         {
            output.writeShort((this.houses[_i3] as HouseInformations).getTypeId());
            (this.houses[_i3] as HouseInformations).serialize(output);
         }
         output.writeShort(this.actors.length);
         for(var _i4:uint = 0; _i4 < this.actors.length; _i4++)
         {
            output.writeShort((this.actors[_i4] as GameRolePlayActorInformations).getTypeId());
            (this.actors[_i4] as GameRolePlayActorInformations).serialize(output);
         }
         output.writeShort(this.interactiveElements.length);
         for(var _i5:uint = 0; _i5 < this.interactiveElements.length; _i5++)
         {
            output.writeShort((this.interactiveElements[_i5] as InteractiveElement).getTypeId());
            (this.interactiveElements[_i5] as InteractiveElement).serialize(output);
         }
         output.writeShort(this.statedElements.length);
         for(var _i6:uint = 0; _i6 < this.statedElements.length; _i6++)
         {
            (this.statedElements[_i6] as StatedElement).serializeAs_StatedElement(output);
         }
         output.writeShort(this.obstacles.length);
         for(var _i7:uint = 0; _i7 < this.obstacles.length; _i7++)
         {
            (this.obstacles[_i7] as MapObstacle).serializeAs_MapObstacle(output);
         }
         output.writeShort(this.fights.length);
         for(var _i8:uint = 0; _i8 < this.fights.length; _i8++)
         {
            (this.fights[_i8] as FightCommonInformations).serializeAs_FightCommonInformations(output);
         }
         output.writeBoolean(this.hasAggressiveMonsters);
         this.fightStartPositions.serializeAs_FightStartingPositions(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MapComplementaryInformationsDataMessage(input);
      }
      
      public function deserializeAs_MapComplementaryInformationsDataMessage(input:ICustomDataInput) : void
      {
         var _id3:uint = 0;
         var _item3:HouseInformations = null;
         var _id4:uint = 0;
         var _item4:GameRolePlayActorInformations = null;
         var _id5:uint = 0;
         var _item5:InteractiveElement = null;
         var _item6:StatedElement = null;
         var _item7:MapObstacle = null;
         var _item8:FightCommonInformations = null;
         this._subAreaIdFunc(input);
         this._mapIdFunc(input);
         var _housesLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _housesLen; _i3++)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(HouseInformations,_id3);
            _item3.deserialize(input);
            this.houses.push(_item3);
         }
         var _actorsLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _actorsLen; _i4++)
         {
            _id4 = input.readUnsignedShort();
            _item4 = ProtocolTypeManager.getInstance(GameRolePlayActorInformations,_id4);
            _item4.deserialize(input);
            this.actors.push(_item4);
         }
         var _interactiveElementsLen:uint = input.readUnsignedShort();
         for(var _i5:uint = 0; _i5 < _interactiveElementsLen; _i5++)
         {
            _id5 = input.readUnsignedShort();
            _item5 = ProtocolTypeManager.getInstance(InteractiveElement,_id5);
            _item5.deserialize(input);
            this.interactiveElements.push(_item5);
         }
         var _statedElementsLen:uint = input.readUnsignedShort();
         for(var _i6:uint = 0; _i6 < _statedElementsLen; _i6++)
         {
            _item6 = new StatedElement();
            _item6.deserialize(input);
            this.statedElements.push(_item6);
         }
         var _obstaclesLen:uint = input.readUnsignedShort();
         for(var _i7:uint = 0; _i7 < _obstaclesLen; _i7++)
         {
            _item7 = new MapObstacle();
            _item7.deserialize(input);
            this.obstacles.push(_item7);
         }
         var _fightsLen:uint = input.readUnsignedShort();
         for(var _i8:uint = 0; _i8 < _fightsLen; _i8++)
         {
            _item8 = new FightCommonInformations();
            _item8.deserialize(input);
            this.fights.push(_item8);
         }
         this._hasAggressiveMonstersFunc(input);
         this.fightStartPositions = new FightStartingPositions();
         this.fightStartPositions.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MapComplementaryInformationsDataMessage(tree);
      }
      
      public function deserializeAsyncAs_MapComplementaryInformationsDataMessage(tree:FuncTree) : void
      {
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._mapIdFunc);
         this._housestree = tree.addChild(this._housestreeFunc);
         this._actorstree = tree.addChild(this._actorstreeFunc);
         this._interactiveElementstree = tree.addChild(this._interactiveElementstreeFunc);
         this._statedElementstree = tree.addChild(this._statedElementstreeFunc);
         this._obstaclestree = tree.addChild(this._obstaclestreeFunc);
         this._fightstree = tree.addChild(this._fightstreeFunc);
         tree.addChild(this._hasAggressiveMonstersFunc);
         this._fightStartPositionstree = tree.addChild(this._fightStartPositionstreeFunc);
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of MapComplementaryInformationsDataMessage.subAreaId.");
         }
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of MapComplementaryInformationsDataMessage.mapId.");
         }
      }
      
      private function _housestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._housestree.addChild(this._housesFunc);
         }
      }
      
      private function _housesFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:HouseInformations = ProtocolTypeManager.getInstance(HouseInformations,_id);
         _item.deserialize(input);
         this.houses.push(_item);
      }
      
      private function _actorstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._actorstree.addChild(this._actorsFunc);
         }
      }
      
      private function _actorsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:GameRolePlayActorInformations = ProtocolTypeManager.getInstance(GameRolePlayActorInformations,_id);
         _item.deserialize(input);
         this.actors.push(_item);
      }
      
      private function _interactiveElementstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._interactiveElementstree.addChild(this._interactiveElementsFunc);
         }
      }
      
      private function _interactiveElementsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:InteractiveElement = ProtocolTypeManager.getInstance(InteractiveElement,_id);
         _item.deserialize(input);
         this.interactiveElements.push(_item);
      }
      
      private function _statedElementstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._statedElementstree.addChild(this._statedElementsFunc);
         }
      }
      
      private function _statedElementsFunc(input:ICustomDataInput) : void
      {
         var _item:StatedElement = new StatedElement();
         _item.deserialize(input);
         this.statedElements.push(_item);
      }
      
      private function _obstaclestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._obstaclestree.addChild(this._obstaclesFunc);
         }
      }
      
      private function _obstaclesFunc(input:ICustomDataInput) : void
      {
         var _item:MapObstacle = new MapObstacle();
         _item.deserialize(input);
         this.obstacles.push(_item);
      }
      
      private function _fightstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._fightstree.addChild(this._fightsFunc);
         }
      }
      
      private function _fightsFunc(input:ICustomDataInput) : void
      {
         var _item:FightCommonInformations = new FightCommonInformations();
         _item.deserialize(input);
         this.fights.push(_item);
      }
      
      private function _hasAggressiveMonstersFunc(input:ICustomDataInput) : void
      {
         this.hasAggressiveMonsters = input.readBoolean();
      }
      
      private function _fightStartPositionstreeFunc(input:ICustomDataInput) : void
      {
         this.fightStartPositions = new FightStartingPositions();
         this.fightStartPositions.deserializeAsync(this._fightStartPositionstree);
      }
   }
}
