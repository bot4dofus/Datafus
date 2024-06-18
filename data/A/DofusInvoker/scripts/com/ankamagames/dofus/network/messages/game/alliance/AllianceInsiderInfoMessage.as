package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.alliance.AllianceMemberInfo;
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.prism.PrismGeolocalizedInformation;
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceInsiderInfoMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4562;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceInfos:AllianceFactSheetInformation;
      
      public var members:Vector.<AllianceMemberInfo>;
      
      public var prisms:Vector.<PrismGeolocalizedInformation>;
      
      public var taxCollectors:Vector.<TaxCollectorInformations>;
      
      private var _allianceInfostree:FuncTree;
      
      private var _memberstree:FuncTree;
      
      private var _prismstree:FuncTree;
      
      private var _taxCollectorstree:FuncTree;
      
      public function AllianceInsiderInfoMessage()
      {
         this.allianceInfos = new AllianceFactSheetInformation();
         this.members = new Vector.<AllianceMemberInfo>();
         this.prisms = new Vector.<PrismGeolocalizedInformation>();
         this.taxCollectors = new Vector.<TaxCollectorInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4562;
      }
      
      public function initAllianceInsiderInfoMessage(allianceInfos:AllianceFactSheetInformation = null, members:Vector.<AllianceMemberInfo> = null, prisms:Vector.<PrismGeolocalizedInformation> = null, taxCollectors:Vector.<TaxCollectorInformations> = null) : AllianceInsiderInfoMessage
      {
         this.allianceInfos = allianceInfos;
         this.members = members;
         this.prisms = prisms;
         this.taxCollectors = taxCollectors;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceInfos = new AllianceFactSheetInformation();
         this.prisms = new Vector.<PrismGeolocalizedInformation>();
         this.taxCollectors = new Vector.<TaxCollectorInformations>();
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
         this.allianceInfos.serializeAs_AllianceFactSheetInformation(output);
         output.writeShort(this.members.length);
         for(var _i2:uint = 0; _i2 < this.members.length; _i2++)
         {
            (this.members[_i2] as AllianceMemberInfo).serializeAs_AllianceMemberInfo(output);
         }
         output.writeShort(this.prisms.length);
         for(var _i3:uint = 0; _i3 < this.prisms.length; _i3++)
         {
            output.writeShort((this.prisms[_i3] as PrismGeolocalizedInformation).getTypeId());
            (this.prisms[_i3] as PrismGeolocalizedInformation).serialize(output);
         }
         output.writeShort(this.taxCollectors.length);
         for(var _i4:uint = 0; _i4 < this.taxCollectors.length; _i4++)
         {
            (this.taxCollectors[_i4] as TaxCollectorInformations).serializeAs_TaxCollectorInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceInsiderInfoMessage(input);
      }
      
      public function deserializeAs_AllianceInsiderInfoMessage(input:ICustomDataInput) : void
      {
         var _item2:AllianceMemberInfo = null;
         var _id3:uint = 0;
         var _item3:PrismGeolocalizedInformation = null;
         var _item4:TaxCollectorInformations = null;
         this.allianceInfos = new AllianceFactSheetInformation();
         this.allianceInfos.deserialize(input);
         var _membersLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _membersLen; _i2++)
         {
            _item2 = new AllianceMemberInfo();
            _item2.deserialize(input);
            this.members.push(_item2);
         }
         var _prismsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _prismsLen; _i3++)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(PrismGeolocalizedInformation,_id3);
            _item3.deserialize(input);
            this.prisms.push(_item3);
         }
         var _taxCollectorsLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _taxCollectorsLen; _i4++)
         {
            _item4 = new TaxCollectorInformations();
            _item4.deserialize(input);
            this.taxCollectors.push(_item4);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceInsiderInfoMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceInsiderInfoMessage(tree:FuncTree) : void
      {
         this._allianceInfostree = tree.addChild(this._allianceInfostreeFunc);
         this._memberstree = tree.addChild(this._memberstreeFunc);
         this._prismstree = tree.addChild(this._prismstreeFunc);
         this._taxCollectorstree = tree.addChild(this._taxCollectorstreeFunc);
      }
      
      private function _allianceInfostreeFunc(input:ICustomDataInput) : void
      {
         this.allianceInfos = new AllianceFactSheetInformation();
         this.allianceInfos.deserializeAsync(this._allianceInfostree);
      }
      
      private function _memberstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._memberstree.addChild(this._membersFunc);
         }
      }
      
      private function _membersFunc(input:ICustomDataInput) : void
      {
         var _item:AllianceMemberInfo = new AllianceMemberInfo();
         _item.deserialize(input);
         this.members.push(_item);
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
         var _item:PrismGeolocalizedInformation = ProtocolTypeManager.getInstance(PrismGeolocalizedInformation,_id);
         _item.deserialize(input);
         this.prisms.push(_item);
      }
      
      private function _taxCollectorstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._taxCollectorstree.addChild(this._taxCollectorsFunc);
         }
      }
      
      private function _taxCollectorsFunc(input:ICustomDataInput) : void
      {
         var _item:TaxCollectorInformations = new TaxCollectorInformations();
         _item.deserialize(input);
         this.taxCollectors.push(_item);
      }
   }
}
