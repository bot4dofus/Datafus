package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectorySettings;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class JobCrafterDirectoryDefineSettingsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8806;
       
      
      private var _isInitialized:Boolean = false;
      
      public var settings:JobCrafterDirectorySettings;
      
      private var _settingstree:FuncTree;
      
      public function JobCrafterDirectoryDefineSettingsMessage()
      {
         this.settings = new JobCrafterDirectorySettings();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8806;
      }
      
      public function initJobCrafterDirectoryDefineSettingsMessage(settings:JobCrafterDirectorySettings = null) : JobCrafterDirectoryDefineSettingsMessage
      {
         this.settings = settings;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.settings = new JobCrafterDirectorySettings();
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
         this.serializeAs_JobCrafterDirectoryDefineSettingsMessage(output);
      }
      
      public function serializeAs_JobCrafterDirectoryDefineSettingsMessage(output:ICustomDataOutput) : void
      {
         this.settings.serializeAs_JobCrafterDirectorySettings(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobCrafterDirectoryDefineSettingsMessage(input);
      }
      
      public function deserializeAs_JobCrafterDirectoryDefineSettingsMessage(input:ICustomDataInput) : void
      {
         this.settings = new JobCrafterDirectorySettings();
         this.settings.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobCrafterDirectoryDefineSettingsMessage(tree);
      }
      
      public function deserializeAsyncAs_JobCrafterDirectoryDefineSettingsMessage(tree:FuncTree) : void
      {
         this._settingstree = tree.addChild(this._settingstreeFunc);
      }
      
      private function _settingstreeFunc(input:ICustomDataInput) : void
      {
         this.settings = new JobCrafterDirectorySettings();
         this.settings.deserializeAsync(this._settingstree);
      }
   }
}
