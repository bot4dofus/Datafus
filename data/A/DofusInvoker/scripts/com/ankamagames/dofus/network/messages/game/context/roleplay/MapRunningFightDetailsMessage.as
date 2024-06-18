package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterLightInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MapRunningFightDetailsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2005;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fightId:uint = 0;
      
      public var attackers:Vector.<GameFightFighterLightInformations>;
      
      public var defenders:Vector.<GameFightFighterLightInformations>;
      
      private var _attackerstree:FuncTree;
      
      private var _defenderstree:FuncTree;
      
      public function MapRunningFightDetailsMessage()
      {
         this.attackers = new Vector.<GameFightFighterLightInformations>();
         this.defenders = new Vector.<GameFightFighterLightInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2005;
      }
      
      public function initMapRunningFightDetailsMessage(fightId:uint = 0, attackers:Vector.<GameFightFighterLightInformations> = null, defenders:Vector.<GameFightFighterLightInformations> = null) : MapRunningFightDetailsMessage
      {
         this.fightId = fightId;
         this.attackers = attackers;
         this.defenders = defenders;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightId = 0;
         this.attackers = new Vector.<GameFightFighterLightInformations>();
         this.defenders = new Vector.<GameFightFighterLightInformations>();
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
         this.serializeAs_MapRunningFightDetailsMessage(output);
      }
      
      public function serializeAs_MapRunningFightDetailsMessage(output:ICustomDataOutput) : void
      {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
         output.writeShort(this.attackers.length);
         for(var _i2:uint = 0; _i2 < this.attackers.length; _i2++)
         {
            output.writeShort((this.attackers[_i2] as GameFightFighterLightInformations).getTypeId());
            (this.attackers[_i2] as GameFightFighterLightInformations).serialize(output);
         }
         output.writeShort(this.defenders.length);
         for(var _i3:uint = 0; _i3 < this.defenders.length; _i3++)
         {
            output.writeShort((this.defenders[_i3] as GameFightFighterLightInformations).getTypeId());
            (this.defenders[_i3] as GameFightFighterLightInformations).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MapRunningFightDetailsMessage(input);
      }
      
      public function deserializeAs_MapRunningFightDetailsMessage(input:ICustomDataInput) : void
      {
         var _id2:uint = 0;
         var _item2:GameFightFighterLightInformations = null;
         var _id3:uint = 0;
         var _item3:GameFightFighterLightInformations = null;
         this._fightIdFunc(input);
         var _attackersLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _attackersLen; _i2++)
         {
            _id2 = input.readUnsignedShort();
            _item2 = ProtocolTypeManager.getInstance(GameFightFighterLightInformations,_id2);
            _item2.deserialize(input);
            this.attackers.push(_item2);
         }
         var _defendersLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _defendersLen; _i3++)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(GameFightFighterLightInformations,_id3);
            _item3.deserialize(input);
            this.defenders.push(_item3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MapRunningFightDetailsMessage(tree);
      }
      
      public function deserializeAsyncAs_MapRunningFightDetailsMessage(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
         this._attackerstree = tree.addChild(this._attackerstreeFunc);
         this._defenderstree = tree.addChild(this._defenderstreeFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of MapRunningFightDetailsMessage.fightId.");
         }
      }
      
      private function _attackerstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._attackerstree.addChild(this._attackersFunc);
         }
      }
      
      private function _attackersFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:GameFightFighterLightInformations = ProtocolTypeManager.getInstance(GameFightFighterLightInformations,_id);
         _item.deserialize(input);
         this.attackers.push(_item);
      }
      
      private function _defenderstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._defenderstree.addChild(this._defendersFunc);
         }
      }
      
      private function _defendersFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:GameFightFighterLightInformations = ProtocolTypeManager.getInstance(GameFightFighterLightInformations,_id);
         _item.deserialize(input);
         this.defenders.push(_item);
      }
   }
}
