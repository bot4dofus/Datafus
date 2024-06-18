package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class QuestObjectiveInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7248;
       
      
      public var objectiveId:uint = 0;
      
      public var objectiveStatus:Boolean = false;
      
      public var dialogParams:Vector.<String>;
      
      private var _dialogParamstree:FuncTree;
      
      public function QuestObjectiveInformations()
      {
         this.dialogParams = new Vector.<String>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7248;
      }
      
      public function initQuestObjectiveInformations(objectiveId:uint = 0, objectiveStatus:Boolean = false, dialogParams:Vector.<String> = null) : QuestObjectiveInformations
      {
         this.objectiveId = objectiveId;
         this.objectiveStatus = objectiveStatus;
         this.dialogParams = dialogParams;
         return this;
      }
      
      public function reset() : void
      {
         this.objectiveId = 0;
         this.objectiveStatus = false;
         this.dialogParams = new Vector.<String>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_QuestObjectiveInformations(output);
      }
      
      public function serializeAs_QuestObjectiveInformations(output:ICustomDataOutput) : void
      {
         if(this.objectiveId < 0)
         {
            throw new Error("Forbidden value (" + this.objectiveId + ") on element objectiveId.");
         }
         output.writeVarShort(this.objectiveId);
         output.writeBoolean(this.objectiveStatus);
         output.writeShort(this.dialogParams.length);
         for(var _i3:uint = 0; _i3 < this.dialogParams.length; _i3++)
         {
            output.writeUTF(this.dialogParams[_i3]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_QuestObjectiveInformations(input);
      }
      
      public function deserializeAs_QuestObjectiveInformations(input:ICustomDataInput) : void
      {
         var _val3:String = null;
         this._objectiveIdFunc(input);
         this._objectiveStatusFunc(input);
         var _dialogParamsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _dialogParamsLen; _i3++)
         {
            _val3 = input.readUTF();
            this.dialogParams.push(_val3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_QuestObjectiveInformations(tree);
      }
      
      public function deserializeAsyncAs_QuestObjectiveInformations(tree:FuncTree) : void
      {
         tree.addChild(this._objectiveIdFunc);
         tree.addChild(this._objectiveStatusFunc);
         this._dialogParamstree = tree.addChild(this._dialogParamstreeFunc);
      }
      
      private function _objectiveIdFunc(input:ICustomDataInput) : void
      {
         this.objectiveId = input.readVarUhShort();
         if(this.objectiveId < 0)
         {
            throw new Error("Forbidden value (" + this.objectiveId + ") on element of QuestObjectiveInformations.objectiveId.");
         }
      }
      
      private function _objectiveStatusFunc(input:ICustomDataInput) : void
      {
         this.objectiveStatus = input.readBoolean();
      }
      
      private function _dialogParamstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._dialogParamstree.addChild(this._dialogParamsFunc);
         }
      }
      
      private function _dialogParamsFunc(input:ICustomDataInput) : void
      {
         var _val:String = input.readUTF();
         this.dialogParams.push(_val);
      }
   }
}
