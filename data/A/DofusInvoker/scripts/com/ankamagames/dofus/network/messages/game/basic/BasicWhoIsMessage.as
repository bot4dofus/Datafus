package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.dofus.network.types.game.social.AbstractSocialGroupInfos;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BasicWhoIsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8673;
       
      
      private var _isInitialized:Boolean = false;
      
      public var self:Boolean = false;
      
      public var position:int = -1;
      
      public var accountTag:AccountTagInformation;
      
      public var accountId:uint = 0;
      
      public var playerName:String = "";
      
      public var playerId:Number = 0;
      
      public var areaId:int = 0;
      
      public var serverId:int = 0;
      
      public var originServerId:int = 0;
      
      public var socialGroups:Vector.<AbstractSocialGroupInfos>;
      
      public var verbose:Boolean = false;
      
      public var playerState:uint = 99;
      
      private var _accountTagtree:FuncTree;
      
      private var _socialGroupstree:FuncTree;
      
      public function BasicWhoIsMessage()
      {
         this.accountTag = new AccountTagInformation();
         this.socialGroups = new Vector.<AbstractSocialGroupInfos>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8673;
      }
      
      public function initBasicWhoIsMessage(self:Boolean = false, position:int = -1, accountTag:AccountTagInformation = null, accountId:uint = 0, playerName:String = "", playerId:Number = 0, areaId:int = 0, serverId:int = 0, originServerId:int = 0, socialGroups:Vector.<AbstractSocialGroupInfos> = null, verbose:Boolean = false, playerState:uint = 99) : BasicWhoIsMessage
      {
         this.self = self;
         this.position = position;
         this.accountTag = accountTag;
         this.accountId = accountId;
         this.playerName = playerName;
         this.playerId = playerId;
         this.areaId = areaId;
         this.serverId = serverId;
         this.originServerId = originServerId;
         this.socialGroups = socialGroups;
         this.verbose = verbose;
         this.playerState = playerState;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.self = false;
         this.position = -1;
         this.accountTag = new AccountTagInformation();
         this.playerName = "";
         this.playerId = 0;
         this.areaId = 0;
         this.serverId = 0;
         this.originServerId = 0;
         this.socialGroups = new Vector.<AbstractSocialGroupInfos>();
         this.verbose = false;
         this.playerState = 99;
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
         this.serializeAs_BasicWhoIsMessage(output);
      }
      
      public function serializeAs_BasicWhoIsMessage(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.self);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.verbose);
         output.writeByte(_box0);
         output.writeByte(this.position);
         this.accountTag.serializeAs_AccountTagInformation(output);
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         output.writeInt(this.accountId);
         output.writeUTF(this.playerName);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         output.writeShort(this.areaId);
         output.writeShort(this.serverId);
         output.writeShort(this.originServerId);
         output.writeShort(this.socialGroups.length);
         for(var _i10:uint = 0; _i10 < this.socialGroups.length; _i10++)
         {
            output.writeShort((this.socialGroups[_i10] as AbstractSocialGroupInfos).getTypeId());
            (this.socialGroups[_i10] as AbstractSocialGroupInfos).serialize(output);
         }
         output.writeByte(this.playerState);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BasicWhoIsMessage(input);
      }
      
      public function deserializeAs_BasicWhoIsMessage(input:ICustomDataInput) : void
      {
         var _id10:uint = 0;
         var _item10:AbstractSocialGroupInfos = null;
         this.deserializeByteBoxes(input);
         this._positionFunc(input);
         this.accountTag = new AccountTagInformation();
         this.accountTag.deserialize(input);
         this._accountIdFunc(input);
         this._playerNameFunc(input);
         this._playerIdFunc(input);
         this._areaIdFunc(input);
         this._serverIdFunc(input);
         this._originServerIdFunc(input);
         var _socialGroupsLen:uint = input.readUnsignedShort();
         for(var _i10:uint = 0; _i10 < _socialGroupsLen; _i10++)
         {
            _id10 = input.readUnsignedShort();
            _item10 = ProtocolTypeManager.getInstance(AbstractSocialGroupInfos,_id10);
            _item10.deserialize(input);
            this.socialGroups.push(_item10);
         }
         this._playerStateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BasicWhoIsMessage(tree);
      }
      
      public function deserializeAsyncAs_BasicWhoIsMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._positionFunc);
         this._accountTagtree = tree.addChild(this._accountTagtreeFunc);
         tree.addChild(this._accountIdFunc);
         tree.addChild(this._playerNameFunc);
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._areaIdFunc);
         tree.addChild(this._serverIdFunc);
         tree.addChild(this._originServerIdFunc);
         this._socialGroupstree = tree.addChild(this._socialGroupstreeFunc);
         tree.addChild(this._playerStateFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.self = BooleanByteWrapper.getFlag(_box0,0);
         this.verbose = BooleanByteWrapper.getFlag(_box0,1);
      }
      
      private function _positionFunc(input:ICustomDataInput) : void
      {
         this.position = input.readByte();
      }
      
      private function _accountTagtreeFunc(input:ICustomDataInput) : void
      {
         this.accountTag = new AccountTagInformation();
         this.accountTag.deserializeAsync(this._accountTagtree);
      }
      
      private function _accountIdFunc(input:ICustomDataInput) : void
      {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of BasicWhoIsMessage.accountId.");
         }
      }
      
      private function _playerNameFunc(input:ICustomDataInput) : void
      {
         this.playerName = input.readUTF();
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of BasicWhoIsMessage.playerId.");
         }
      }
      
      private function _areaIdFunc(input:ICustomDataInput) : void
      {
         this.areaId = input.readShort();
      }
      
      private function _serverIdFunc(input:ICustomDataInput) : void
      {
         this.serverId = input.readShort();
      }
      
      private function _originServerIdFunc(input:ICustomDataInput) : void
      {
         this.originServerId = input.readShort();
      }
      
      private function _socialGroupstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._socialGroupstree.addChild(this._socialGroupsFunc);
         }
      }
      
      private function _socialGroupsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:AbstractSocialGroupInfos = ProtocolTypeManager.getInstance(AbstractSocialGroupInfos,_id);
         _item.deserialize(input);
         this.socialGroups.push(_item);
      }
      
      private function _playerStateFunc(input:ICustomDataInput) : void
      {
         this.playerState = input.readByte();
         if(this.playerState < 0)
         {
            throw new Error("Forbidden value (" + this.playerState + ") on element of BasicWhoIsMessage.playerState.");
         }
      }
   }
}
