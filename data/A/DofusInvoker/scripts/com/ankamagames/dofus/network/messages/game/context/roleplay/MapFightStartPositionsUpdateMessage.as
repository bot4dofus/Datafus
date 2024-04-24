package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.context.fight.FightStartingPositions;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MapFightStartPositionsUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7578;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mapId:Number = 0;
      
      public var fightStartPositions:FightStartingPositions;
      
      private var _fightStartPositionstree:FuncTree;
      
      public function MapFightStartPositionsUpdateMessage()
      {
         this.fightStartPositions = new FightStartingPositions();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7578;
      }
      
      public function initMapFightStartPositionsUpdateMessage(mapId:Number = 0, fightStartPositions:FightStartingPositions = null) : MapFightStartPositionsUpdateMessage
      {
         this.mapId = mapId;
         this.fightStartPositions = fightStartPositions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mapId = 0;
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
         this.serializeAs_MapFightStartPositionsUpdateMessage(output);
      }
      
      public function serializeAs_MapFightStartPositionsUpdateMessage(output:ICustomDataOutput) : void
      {
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         this.fightStartPositions.serializeAs_FightStartingPositions(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MapFightStartPositionsUpdateMessage(input);
      }
      
      public function deserializeAs_MapFightStartPositionsUpdateMessage(input:ICustomDataInput) : void
      {
         this._mapIdFunc(input);
         this.fightStartPositions = new FightStartingPositions();
         this.fightStartPositions.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MapFightStartPositionsUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_MapFightStartPositionsUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._mapIdFunc);
         this._fightStartPositionstree = tree.addChild(this._fightStartPositionstreeFunc);
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of MapFightStartPositionsUpdateMessage.mapId.");
         }
      }
      
      private function _fightStartPositionstreeFunc(input:ICustomDataInput) : void
      {
         this.fightStartPositions = new FightStartingPositions();
         this.fightStartPositions.deserializeAsync(this._fightStartPositionstree);
      }
   }
}
