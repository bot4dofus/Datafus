package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.types.game.social.SocialEmblem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceCreationValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 909;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceName:String = "";
      
      public var allianceTag:String = "";
      
      public var allianceEmblem:SocialEmblem;
      
      private var _allianceEmblemtree:FuncTree;
      
      public function AllianceCreationValidMessage()
      {
         this.allianceEmblem = new SocialEmblem();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 909;
      }
      
      public function initAllianceCreationValidMessage(allianceName:String = "", allianceTag:String = "", allianceEmblem:SocialEmblem = null) : AllianceCreationValidMessage
      {
         this.allianceName = allianceName;
         this.allianceTag = allianceTag;
         this.allianceEmblem = allianceEmblem;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceName = "";
         this.allianceTag = "";
         this.allianceEmblem = new SocialEmblem();
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
         this.serializeAs_AllianceCreationValidMessage(output);
      }
      
      public function serializeAs_AllianceCreationValidMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.allianceName);
         output.writeUTF(this.allianceTag);
         this.allianceEmblem.serializeAs_SocialEmblem(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceCreationValidMessage(input);
      }
      
      public function deserializeAs_AllianceCreationValidMessage(input:ICustomDataInput) : void
      {
         this._allianceNameFunc(input);
         this._allianceTagFunc(input);
         this.allianceEmblem = new SocialEmblem();
         this.allianceEmblem.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceCreationValidMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceCreationValidMessage(tree:FuncTree) : void
      {
         tree.addChild(this._allianceNameFunc);
         tree.addChild(this._allianceTagFunc);
         this._allianceEmblemtree = tree.addChild(this._allianceEmblemtreeFunc);
      }
      
      private function _allianceNameFunc(input:ICustomDataInput) : void
      {
         this.allianceName = input.readUTF();
      }
      
      private function _allianceTagFunc(input:ICustomDataInput) : void
      {
         this.allianceTag = input.readUTF();
      }
      
      private function _allianceEmblemtreeFunc(input:ICustomDataInput) : void
      {
         this.allianceEmblem = new SocialEmblem();
         this.allianceEmblem.deserializeAsync(this._allianceEmblemtree);
      }
   }
}
