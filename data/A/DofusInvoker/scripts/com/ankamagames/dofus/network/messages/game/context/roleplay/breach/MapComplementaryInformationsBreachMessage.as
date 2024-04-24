package com.ankamagames.dofus.network.messages.game.context.roleplay.breach
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightStartingPositions;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.breach.BreachBranch;
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
   
   public class MapComplementaryInformationsBreachMessage extends MapComplementaryInformationsDataMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 748;
       
      
      private var _isInitialized:Boolean = false;
      
      public var floor:uint = 0;
      
      public var room:uint = 0;
      
      public var infinityMode:uint = 0;
      
      public var branches:Vector.<BreachBranch>;
      
      private var _branchestree:FuncTree;
      
      public function MapComplementaryInformationsBreachMessage()
      {
         this.branches = new Vector.<BreachBranch>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 748;
      }
      
      public function initMapComplementaryInformationsBreachMessage(subAreaId:uint = 0, mapId:Number = 0, houses:Vector.<HouseInformations> = null, actors:Vector.<GameRolePlayActorInformations> = null, interactiveElements:Vector.<InteractiveElement> = null, statedElements:Vector.<StatedElement> = null, obstacles:Vector.<MapObstacle> = null, fights:Vector.<FightCommonInformations> = null, hasAggressiveMonsters:Boolean = false, fightStartPositions:FightStartingPositions = null, floor:uint = 0, room:uint = 0, infinityMode:uint = 0, branches:Vector.<BreachBranch> = null) : MapComplementaryInformationsBreachMessage
      {
         super.initMapComplementaryInformationsDataMessage(subAreaId,mapId,houses,actors,interactiveElements,statedElements,obstacles,fights,hasAggressiveMonsters,fightStartPositions);
         this.floor = floor;
         this.room = room;
         this.infinityMode = infinityMode;
         this.branches = branches;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.floor = 0;
         this.room = 0;
         this.infinityMode = 0;
         this.branches = new Vector.<BreachBranch>();
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
         this.serializeAs_MapComplementaryInformationsBreachMessage(output);
      }
      
      public function serializeAs_MapComplementaryInformationsBreachMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_MapComplementaryInformationsDataMessage(output);
         if(this.floor < 0)
         {
            throw new Error("Forbidden value (" + this.floor + ") on element floor.");
         }
         output.writeVarInt(this.floor);
         if(this.room < 0)
         {
            throw new Error("Forbidden value (" + this.room + ") on element room.");
         }
         output.writeByte(this.room);
         if(this.infinityMode < 0)
         {
            throw new Error("Forbidden value (" + this.infinityMode + ") on element infinityMode.");
         }
         output.writeShort(this.infinityMode);
         output.writeShort(this.branches.length);
         for(var _i4:uint = 0; _i4 < this.branches.length; _i4++)
         {
            output.writeShort((this.branches[_i4] as BreachBranch).getTypeId());
            (this.branches[_i4] as BreachBranch).serialize(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MapComplementaryInformationsBreachMessage(input);
      }
      
      public function deserializeAs_MapComplementaryInformationsBreachMessage(input:ICustomDataInput) : void
      {
         var _id4:uint = 0;
         var _item4:BreachBranch = null;
         super.deserialize(input);
         this._floorFunc(input);
         this._roomFunc(input);
         this._infinityModeFunc(input);
         var _branchesLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _branchesLen; _i4++)
         {
            _id4 = input.readUnsignedShort();
            _item4 = ProtocolTypeManager.getInstance(BreachBranch,_id4);
            _item4.deserialize(input);
            this.branches.push(_item4);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MapComplementaryInformationsBreachMessage(tree);
      }
      
      public function deserializeAsyncAs_MapComplementaryInformationsBreachMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._floorFunc);
         tree.addChild(this._roomFunc);
         tree.addChild(this._infinityModeFunc);
         this._branchestree = tree.addChild(this._branchestreeFunc);
      }
      
      private function _floorFunc(input:ICustomDataInput) : void
      {
         this.floor = input.readVarUhInt();
         if(this.floor < 0)
         {
            throw new Error("Forbidden value (" + this.floor + ") on element of MapComplementaryInformationsBreachMessage.floor.");
         }
      }
      
      private function _roomFunc(input:ICustomDataInput) : void
      {
         this.room = input.readByte();
         if(this.room < 0)
         {
            throw new Error("Forbidden value (" + this.room + ") on element of MapComplementaryInformationsBreachMessage.room.");
         }
      }
      
      private function _infinityModeFunc(input:ICustomDataInput) : void
      {
         this.infinityMode = input.readShort();
         if(this.infinityMode < 0)
         {
            throw new Error("Forbidden value (" + this.infinityMode + ") on element of MapComplementaryInformationsBreachMessage.infinityMode.");
         }
      }
      
      private function _branchestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._branchestree.addChild(this._branchesFunc);
         }
      }
      
      private function _branchesFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:BreachBranch = ProtocolTypeManager.getInstance(BreachBranch,_id);
         _item.deserialize(input);
         this.branches.push(_item);
      }
   }
}
