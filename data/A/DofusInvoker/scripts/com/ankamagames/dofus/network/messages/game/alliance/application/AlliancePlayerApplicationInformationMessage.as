package com.ankamagames.dofus.network.messages.game.alliance.application
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformation;
   import com.ankamagames.dofus.network.types.game.social.application.SocialApplicationInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AlliancePlayerApplicationInformationMessage extends AlliancePlayerApplicationAbstractMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9416;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceInformation:AllianceInformation;
      
      public var apply:SocialApplicationInformation;
      
      private var _allianceInformationtree:FuncTree;
      
      private var _applytree:FuncTree;
      
      public function AlliancePlayerApplicationInformationMessage()
      {
         this.allianceInformation = new AllianceInformation();
         this.apply = new SocialApplicationInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9416;
      }
      
      public function initAlliancePlayerApplicationInformationMessage(allianceInformation:AllianceInformation = null, apply:SocialApplicationInformation = null) : AlliancePlayerApplicationInformationMessage
      {
         this.allianceInformation = allianceInformation;
         this.apply = apply;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceInformation = new AllianceInformation();
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
         this.serializeAs_AlliancePlayerApplicationInformationMessage(output);
      }
      
      public function serializeAs_AlliancePlayerApplicationInformationMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AlliancePlayerApplicationAbstractMessage(output);
         this.allianceInformation.serializeAs_AllianceInformation(output);
         this.apply.serializeAs_SocialApplicationInformation(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AlliancePlayerApplicationInformationMessage(input);
      }
      
      public function deserializeAs_AlliancePlayerApplicationInformationMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.allianceInformation = new AllianceInformation();
         this.allianceInformation.deserialize(input);
         this.apply = new SocialApplicationInformation();
         this.apply.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AlliancePlayerApplicationInformationMessage(tree);
      }
      
      public function deserializeAsyncAs_AlliancePlayerApplicationInformationMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._allianceInformationtree = tree.addChild(this._allianceInformationtreeFunc);
         this._applytree = tree.addChild(this._applytreeFunc);
      }
      
      private function _allianceInformationtreeFunc(input:ICustomDataInput) : void
      {
         this.allianceInformation = new AllianceInformation();
         this.allianceInformation.deserializeAsync(this._allianceInformationtree);
      }
      
      private function _applytreeFunc(input:ICustomDataInput) : void
      {
         this.apply = new SocialApplicationInformation();
         this.apply.deserializeAsync(this._applytree);
      }
   }
}
