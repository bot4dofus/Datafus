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
   
   public class JobCrafterDirectorySettingsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5924;
       
      
      private var _isInitialized:Boolean = false;
      
      public var craftersSettings:Vector.<JobCrafterDirectorySettings>;
      
      private var _craftersSettingstree:FuncTree;
      
      public function JobCrafterDirectorySettingsMessage()
      {
         this.craftersSettings = new Vector.<JobCrafterDirectorySettings>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5924;
      }
      
      public function initJobCrafterDirectorySettingsMessage(craftersSettings:Vector.<JobCrafterDirectorySettings> = null) : JobCrafterDirectorySettingsMessage
      {
         this.craftersSettings = craftersSettings;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.craftersSettings = new Vector.<JobCrafterDirectorySettings>();
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
         this.serializeAs_JobCrafterDirectorySettingsMessage(output);
      }
      
      public function serializeAs_JobCrafterDirectorySettingsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.craftersSettings.length);
         for(var _i1:uint = 0; _i1 < this.craftersSettings.length; _i1++)
         {
            (this.craftersSettings[_i1] as JobCrafterDirectorySettings).serializeAs_JobCrafterDirectorySettings(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobCrafterDirectorySettingsMessage(input);
      }
      
      public function deserializeAs_JobCrafterDirectorySettingsMessage(input:ICustomDataInput) : void
      {
         var _item1:JobCrafterDirectorySettings = null;
         var _craftersSettingsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _craftersSettingsLen; _i1++)
         {
            _item1 = new JobCrafterDirectorySettings();
            _item1.deserialize(input);
            this.craftersSettings.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobCrafterDirectorySettingsMessage(tree);
      }
      
      public function deserializeAsyncAs_JobCrafterDirectorySettingsMessage(tree:FuncTree) : void
      {
         this._craftersSettingstree = tree.addChild(this._craftersSettingstreeFunc);
      }
      
      private function _craftersSettingstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._craftersSettingstree.addChild(this._craftersSettingsFunc);
         }
      }
      
      private function _craftersSettingsFunc(input:ICustomDataInput) : void
      {
         var _item:JobCrafterDirectorySettings = new JobCrafterDirectorySettings();
         _item.deserialize(input);
         this.craftersSettings.push(_item);
      }
   }
}
