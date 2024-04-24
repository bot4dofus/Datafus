package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorPositionInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameContextBasicSpawnInformation implements INetworkType
   {
      
      public static const protocolId:uint = 2004;
       
      
      public var teamId:uint = 2;
      
      public var alive:Boolean = false;
      
      public var informations:GameContextActorPositionInformations;
      
      private var _informationstree:FuncTree;
      
      public function GameContextBasicSpawnInformation()
      {
         this.informations = new GameContextActorPositionInformations();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2004;
      }
      
      public function initGameContextBasicSpawnInformation(teamId:uint = 2, alive:Boolean = false, informations:GameContextActorPositionInformations = null) : GameContextBasicSpawnInformation
      {
         this.teamId = teamId;
         this.alive = alive;
         this.informations = informations;
         return this;
      }
      
      public function reset() : void
      {
         this.teamId = 2;
         this.alive = false;
         this.informations = new GameContextActorPositionInformations();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameContextBasicSpawnInformation(output);
      }
      
      public function serializeAs_GameContextBasicSpawnInformation(output:ICustomDataOutput) : void
      {
         output.writeByte(this.teamId);
         output.writeBoolean(this.alive);
         output.writeShort(this.informations.getTypeId());
         this.informations.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameContextBasicSpawnInformation(input);
      }
      
      public function deserializeAs_GameContextBasicSpawnInformation(input:ICustomDataInput) : void
      {
         this._teamIdFunc(input);
         this._aliveFunc(input);
         var _id3:uint = input.readUnsignedShort();
         this.informations = ProtocolTypeManager.getInstance(GameContextActorPositionInformations,_id3);
         this.informations.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameContextBasicSpawnInformation(tree);
      }
      
      public function deserializeAsyncAs_GameContextBasicSpawnInformation(tree:FuncTree) : void
      {
         tree.addChild(this._teamIdFunc);
         tree.addChild(this._aliveFunc);
         this._informationstree = tree.addChild(this._informationstreeFunc);
      }
      
      private function _teamIdFunc(input:ICustomDataInput) : void
      {
         this.teamId = input.readByte();
         if(this.teamId < 0)
         {
            throw new Error("Forbidden value (" + this.teamId + ") on element of GameContextBasicSpawnInformation.teamId.");
         }
      }
      
      private function _aliveFunc(input:ICustomDataInput) : void
      {
         this.alive = input.readBoolean();
      }
      
      private function _informationstreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.informations = ProtocolTypeManager.getInstance(GameContextActorPositionInformations,_id);
         this.informations.deserializeAsync(this._informationstree);
      }
   }
}
