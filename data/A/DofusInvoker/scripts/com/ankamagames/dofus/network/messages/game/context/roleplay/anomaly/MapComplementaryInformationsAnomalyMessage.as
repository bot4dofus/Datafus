package com.ankamagames.dofus.network.messages.game.context.roleplay.anomaly
{
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
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
   
   public class MapComplementaryInformationsAnomalyMessage extends MapComplementaryInformationsDataMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 527;
       
      
      private var _isInitialized:Boolean = false;
      
      public var level:uint = 0;
      
      public var closingTime:Number = 0;
      
      public function MapComplementaryInformationsAnomalyMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 527;
      }
      
      public function initMapComplementaryInformationsAnomalyMessage(subAreaId:uint = 0, mapId:Number = 0, houses:Vector.<HouseInformations> = null, actors:Vector.<GameRolePlayActorInformations> = null, interactiveElements:Vector.<InteractiveElement> = null, statedElements:Vector.<StatedElement> = null, obstacles:Vector.<MapObstacle> = null, fights:Vector.<FightCommonInformations> = null, hasAggressiveMonsters:Boolean = false, fightStartPositions:FightStartingPositions = null, level:uint = 0, closingTime:Number = 0) : MapComplementaryInformationsAnomalyMessage
      {
         super.initMapComplementaryInformationsDataMessage(subAreaId,mapId,houses,actors,interactiveElements,statedElements,obstacles,fights,hasAggressiveMonsters,fightStartPositions);
         this.level = level;
         this.closingTime = closingTime;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.level = 0;
         this.closingTime = 0;
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
         this.serializeAs_MapComplementaryInformationsAnomalyMessage(output);
      }
      
      public function serializeAs_MapComplementaryInformationsAnomalyMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_MapComplementaryInformationsDataMessage(output);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
         if(this.closingTime < 0 || this.closingTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.closingTime + ") on element closingTime.");
         }
         output.writeVarLong(this.closingTime);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MapComplementaryInformationsAnomalyMessage(input);
      }
      
      public function deserializeAs_MapComplementaryInformationsAnomalyMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._levelFunc(input);
         this._closingTimeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MapComplementaryInformationsAnomalyMessage(tree);
      }
      
      public function deserializeAsyncAs_MapComplementaryInformationsAnomalyMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._levelFunc);
         tree.addChild(this._closingTimeFunc);
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of MapComplementaryInformationsAnomalyMessage.level.");
         }
      }
      
      private function _closingTimeFunc(input:ICustomDataInput) : void
      {
         this.closingTime = input.readVarUhLong();
         if(this.closingTime < 0 || this.closingTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.closingTime + ") on element of MapComplementaryInformationsAnomalyMessage.closingTime.");
         }
      }
   }
}
