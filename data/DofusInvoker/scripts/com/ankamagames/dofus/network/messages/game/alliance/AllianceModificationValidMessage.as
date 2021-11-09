package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceModificationValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8073;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceName:String = "";
      
      public var allianceTag:String = "";
      
      public var Alliancemblem:GuildEmblem;
      
      private var _Alliancemblemtree:FuncTree;
      
      public function AllianceModificationValidMessage()
      {
         this.Alliancemblem = new GuildEmblem();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8073;
      }
      
      public function initAllianceModificationValidMessage(allianceName:String = "", allianceTag:String = "", Alliancemblem:GuildEmblem = null) : AllianceModificationValidMessage
      {
         this.allianceName = allianceName;
         this.allianceTag = allianceTag;
         this.Alliancemblem = Alliancemblem;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceName = "";
         this.allianceTag = "";
         this.Alliancemblem = new GuildEmblem();
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
         this.serializeAs_AllianceModificationValidMessage(output);
      }
      
      public function serializeAs_AllianceModificationValidMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.allianceName);
         output.writeUTF(this.allianceTag);
         this.Alliancemblem.serializeAs_GuildEmblem(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceModificationValidMessage(input);
      }
      
      public function deserializeAs_AllianceModificationValidMessage(input:ICustomDataInput) : void
      {
         this._allianceNameFunc(input);
         this._allianceTagFunc(input);
         this.Alliancemblem = new GuildEmblem();
         this.Alliancemblem.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceModificationValidMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceModificationValidMessage(tree:FuncTree) : void
      {
         tree.addChild(this._allianceNameFunc);
         tree.addChild(this._allianceTagFunc);
         this._Alliancemblemtree = tree.addChild(this._AlliancemblemtreeFunc);
      }
      
      private function _allianceNameFunc(input:ICustomDataInput) : void
      {
         this.allianceName = input.readUTF();
      }
      
      private function _allianceTagFunc(input:ICustomDataInput) : void
      {
         this.allianceTag = input.readUTF();
      }
      
      private function _AlliancemblemtreeFunc(input:ICustomDataInput) : void
      {
         this.Alliancemblem = new GuildEmblem();
         this.Alliancemblem.deserializeAsync(this._Alliancemblemtree);
      }
   }
}
