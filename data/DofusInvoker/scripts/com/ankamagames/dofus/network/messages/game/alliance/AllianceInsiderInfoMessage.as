package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.prism.PrismSubareaEmptyInfo;
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformations;
   import com.ankamagames.dofus.network.types.game.social.GuildInsiderFactSheetInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceInsiderInfoMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4780;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceInfos:AllianceFactSheetInformations;
      
      public var guilds:Vector.<GuildInsiderFactSheetInformations>;
      
      public var prisms:Vector.<PrismSubareaEmptyInfo>;
      
      private var _allianceInfostree:FuncTree;
      
      private var _guildstree:FuncTree;
      
      private var _prismstree:FuncTree;
      
      public function AllianceInsiderInfoMessage()
      {
         this.allianceInfos = new AllianceFactSheetInformations();
         this.guilds = new Vector.<GuildInsiderFactSheetInformations>();
         this.prisms = new Vector.<PrismSubareaEmptyInfo>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4780;
      }
      
      public function initAllianceInsiderInfoMessage(allianceInfos:AllianceFactSheetInformations = null, guilds:Vector.<GuildInsiderFactSheetInformations> = null, prisms:Vector.<PrismSubareaEmptyInfo> = null) : AllianceInsiderInfoMessage
      {
         this.allianceInfos = allianceInfos;
         this.guilds = guilds;
         this.prisms = prisms;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceInfos = new AllianceFactSheetInformations();
         this.prisms = new Vector.<PrismSubareaEmptyInfo>();
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
         this.serializeAs_AllianceInsiderInfoMessage(output);
      }
      
      public function serializeAs_AllianceInsiderInfoMessage(output:ICustomDataOutput) : void
      {
         this.allianceInfos.serializeAs_AllianceFactSheetInformations(output);
         output.writeShort(this.guilds.length);
         for(var _i2:uint = 0; _i2 < this.guilds.length; _i2++)
         {
            (this.guilds[_i2] as GuildInsiderFactSheetInformations).serializeAs_GuildInsiderFactSheetInformations(output);
         }
         output.writeShort(this.prisms.length);
         for(var _i3:uint = 0; _i3 < this.prisms.length; _i3++)
         {
            output.writeShort((this.prisms[_i3] as PrismSubareaEmptyInfo).getTypeId());
            (this.prisms[_i3] as PrismSubareaEmptyInfo).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceInsiderInfoMessage(input);
      }
      
      public function deserializeAs_AllianceInsiderInfoMessage(input:ICustomDataInput) : void
      {
         var _item2:GuildInsiderFactSheetInformations = null;
         var _id3:uint = 0;
         var _item3:PrismSubareaEmptyInfo = null;
         this.allianceInfos = new AllianceFactSheetInformations();
         this.allianceInfos.deserialize(input);
         var _guildsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _guildsLen; _i2++)
         {
            _item2 = new GuildInsiderFactSheetInformations();
            _item2.deserialize(input);
            this.guilds.push(_item2);
         }
         var _prismsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _prismsLen; _i3++)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(PrismSubareaEmptyInfo,_id3);
            _item3.deserialize(input);
            this.prisms.push(_item3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceInsiderInfoMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceInsiderInfoMessage(tree:FuncTree) : void
      {
         this._allianceInfostree = tree.addChild(this._allianceInfostreeFunc);
         this._guildstree = tree.addChild(this._guildstreeFunc);
         this._prismstree = tree.addChild(this._prismstreeFunc);
      }
      
      private function _allianceInfostreeFunc(input:ICustomDataInput) : void
      {
         this.allianceInfos = new AllianceFactSheetInformations();
         this.allianceInfos.deserializeAsync(this._allianceInfostree);
      }
      
      private function _guildstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._guildstree.addChild(this._guildsFunc);
         }
      }
      
      private function _guildsFunc(input:ICustomDataInput) : void
      {
         var _item:GuildInsiderFactSheetInformations = new GuildInsiderFactSheetInformations();
         _item.deserialize(input);
         this.guilds.push(_item);
      }
      
      private function _prismstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._prismstree.addChild(this._prismsFunc);
         }
      }
      
      private function _prismsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:PrismSubareaEmptyInfo = ProtocolTypeManager.getInstance(PrismSubareaEmptyInfo,_id);
         _item.deserialize(input);
         this.prisms.push(_item);
      }
   }
}
