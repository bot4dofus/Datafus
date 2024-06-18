package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameContextSummonsInformation implements INetworkType
   {
      
      public static const protocolId:uint = 5419;
       
      
      public var spawnInformation:SpawnInformation;
      
      public var wave:uint = 0;
      
      public var look:EntityLook;
      
      public var stats:GameFightCharacteristics;
      
      public var summons:Vector.<GameContextBasicSpawnInformation>;
      
      private var _spawnInformationtree:FuncTree;
      
      private var _looktree:FuncTree;
      
      private var _statstree:FuncTree;
      
      private var _summonstree:FuncTree;
      
      public function GameContextSummonsInformation()
      {
         this.spawnInformation = new SpawnInformation();
         this.look = new EntityLook();
         this.stats = new GameFightCharacteristics();
         this.summons = new Vector.<GameContextBasicSpawnInformation>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 5419;
      }
      
      public function initGameContextSummonsInformation(spawnInformation:SpawnInformation = null, wave:uint = 0, look:EntityLook = null, stats:GameFightCharacteristics = null, summons:Vector.<GameContextBasicSpawnInformation> = null) : GameContextSummonsInformation
      {
         this.spawnInformation = spawnInformation;
         this.wave = wave;
         this.look = look;
         this.stats = stats;
         this.summons = summons;
         return this;
      }
      
      public function reset() : void
      {
         this.spawnInformation = new SpawnInformation();
         this.look = new EntityLook();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameContextSummonsInformation(output);
      }
      
      public function serializeAs_GameContextSummonsInformation(output:ICustomDataOutput) : void
      {
         output.writeShort(this.spawnInformation.getTypeId());
         this.spawnInformation.serialize(output);
         if(this.wave < 0)
         {
            throw new Error("Forbidden value (" + this.wave + ") on element wave.");
         }
         output.writeByte(this.wave);
         this.look.serializeAs_EntityLook(output);
         output.writeShort(this.stats.getTypeId());
         this.stats.serialize(output);
         output.writeShort(this.summons.length);
         for(var _i5:uint = 0; _i5 < this.summons.length; _i5++)
         {
            output.writeShort((this.summons[_i5] as GameContextBasicSpawnInformation).getTypeId());
            (this.summons[_i5] as GameContextBasicSpawnInformation).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameContextSummonsInformation(input);
      }
      
      public function deserializeAs_GameContextSummonsInformation(input:ICustomDataInput) : void
      {
         var _id5:uint = 0;
         var _item5:GameContextBasicSpawnInformation = null;
         var _id1:uint = input.readUnsignedShort();
         this.spawnInformation = ProtocolTypeManager.getInstance(SpawnInformation,_id1);
         this.spawnInformation.deserialize(input);
         this._waveFunc(input);
         this.look = new EntityLook();
         this.look.deserialize(input);
         var _id4:uint = input.readUnsignedShort();
         this.stats = ProtocolTypeManager.getInstance(GameFightCharacteristics,_id4);
         this.stats.deserialize(input);
         var _summonsLen:uint = input.readUnsignedShort();
         for(var _i5:uint = 0; _i5 < _summonsLen; _i5++)
         {
            _id5 = input.readUnsignedShort();
            _item5 = ProtocolTypeManager.getInstance(GameContextBasicSpawnInformation,_id5);
            _item5.deserialize(input);
            this.summons.push(_item5);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameContextSummonsInformation(tree);
      }
      
      public function deserializeAsyncAs_GameContextSummonsInformation(tree:FuncTree) : void
      {
         this._spawnInformationtree = tree.addChild(this._spawnInformationtreeFunc);
         tree.addChild(this._waveFunc);
         this._looktree = tree.addChild(this._looktreeFunc);
         this._statstree = tree.addChild(this._statstreeFunc);
         this._summonstree = tree.addChild(this._summonstreeFunc);
      }
      
      private function _spawnInformationtreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.spawnInformation = ProtocolTypeManager.getInstance(SpawnInformation,_id);
         this.spawnInformation.deserializeAsync(this._spawnInformationtree);
      }
      
      private function _waveFunc(input:ICustomDataInput) : void
      {
         this.wave = input.readByte();
         if(this.wave < 0)
         {
            throw new Error("Forbidden value (" + this.wave + ") on element of GameContextSummonsInformation.wave.");
         }
      }
      
      private function _looktreeFunc(input:ICustomDataInput) : void
      {
         this.look = new EntityLook();
         this.look.deserializeAsync(this._looktree);
      }
      
      private function _statstreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.stats = ProtocolTypeManager.getInstance(GameFightCharacteristics,_id);
         this.stats.deserializeAsync(this._statstree);
      }
      
      private function _summonstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._summonstree.addChild(this._summonsFunc);
         }
      }
      
      private function _summonsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:GameContextBasicSpawnInformation = ProtocolTypeManager.getInstance(GameContextBasicSpawnInformation,_id);
         _item.deserialize(input);
         this.summons.push(_item);
      }
   }
}
