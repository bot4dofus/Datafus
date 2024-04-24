package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
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
   
   public class MapComplementaryInformationsDataInHavenBagMessage extends MapComplementaryInformationsDataMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 88;
       
      
      private var _isInitialized:Boolean = false;
      
      public var ownerInformations:CharacterMinimalInformations;
      
      public var theme:int = 0;
      
      public var roomId:uint = 0;
      
      public var maxRoomId:uint = 0;
      
      private var _ownerInformationstree:FuncTree;
      
      public function MapComplementaryInformationsDataInHavenBagMessage()
      {
         this.ownerInformations = new CharacterMinimalInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 88;
      }
      
      public function initMapComplementaryInformationsDataInHavenBagMessage(subAreaId:uint = 0, mapId:Number = 0, houses:Vector.<HouseInformations> = null, actors:Vector.<GameRolePlayActorInformations> = null, interactiveElements:Vector.<InteractiveElement> = null, statedElements:Vector.<StatedElement> = null, obstacles:Vector.<MapObstacle> = null, fights:Vector.<FightCommonInformations> = null, hasAggressiveMonsters:Boolean = false, fightStartPositions:FightStartingPositions = null, ownerInformations:CharacterMinimalInformations = null, theme:int = 0, roomId:uint = 0, maxRoomId:uint = 0) : MapComplementaryInformationsDataInHavenBagMessage
      {
         super.initMapComplementaryInformationsDataMessage(subAreaId,mapId,houses,actors,interactiveElements,statedElements,obstacles,fights,hasAggressiveMonsters,fightStartPositions);
         this.ownerInformations = ownerInformations;
         this.theme = theme;
         this.roomId = roomId;
         this.maxRoomId = maxRoomId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.ownerInformations = new CharacterMinimalInformations();
         this.roomId = 0;
         this.maxRoomId = 0;
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
         this.serializeAs_MapComplementaryInformationsDataInHavenBagMessage(output);
      }
      
      public function serializeAs_MapComplementaryInformationsDataInHavenBagMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_MapComplementaryInformationsDataMessage(output);
         this.ownerInformations.serializeAs_CharacterMinimalInformations(output);
         output.writeByte(this.theme);
         if(this.roomId < 0)
         {
            throw new Error("Forbidden value (" + this.roomId + ") on element roomId.");
         }
         output.writeByte(this.roomId);
         if(this.maxRoomId < 0)
         {
            throw new Error("Forbidden value (" + this.maxRoomId + ") on element maxRoomId.");
         }
         output.writeByte(this.maxRoomId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MapComplementaryInformationsDataInHavenBagMessage(input);
      }
      
      public function deserializeAs_MapComplementaryInformationsDataInHavenBagMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.ownerInformations = new CharacterMinimalInformations();
         this.ownerInformations.deserialize(input);
         this._themeFunc(input);
         this._roomIdFunc(input);
         this._maxRoomIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MapComplementaryInformationsDataInHavenBagMessage(tree);
      }
      
      public function deserializeAsyncAs_MapComplementaryInformationsDataInHavenBagMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._ownerInformationstree = tree.addChild(this._ownerInformationstreeFunc);
         tree.addChild(this._themeFunc);
         tree.addChild(this._roomIdFunc);
         tree.addChild(this._maxRoomIdFunc);
      }
      
      private function _ownerInformationstreeFunc(input:ICustomDataInput) : void
      {
         this.ownerInformations = new CharacterMinimalInformations();
         this.ownerInformations.deserializeAsync(this._ownerInformationstree);
      }
      
      private function _themeFunc(input:ICustomDataInput) : void
      {
         this.theme = input.readByte();
      }
      
      private function _roomIdFunc(input:ICustomDataInput) : void
      {
         this.roomId = input.readByte();
         if(this.roomId < 0)
         {
            throw new Error("Forbidden value (" + this.roomId + ") on element of MapComplementaryInformationsDataInHavenBagMessage.roomId.");
         }
      }
      
      private function _maxRoomIdFunc(input:ICustomDataInput) : void
      {
         this.maxRoomId = input.readByte();
         if(this.maxRoomId < 0)
         {
            throw new Error("Forbidden value (" + this.maxRoomId + ") on element of MapComplementaryInformationsDataInHavenBagMessage.maxRoomId.");
         }
      }
   }
}
