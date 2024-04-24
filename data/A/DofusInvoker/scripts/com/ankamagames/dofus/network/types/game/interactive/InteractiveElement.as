package com.ankamagames.dofus.network.types.game.interactive
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class InteractiveElement implements INetworkType
   {
      
      public static const protocolId:uint = 6006;
       
      
      public var elementId:uint = 0;
      
      public var elementTypeId:int = 0;
      
      public var enabledSkills:Vector.<InteractiveElementSkill>;
      
      public var disabledSkills:Vector.<InteractiveElementSkill>;
      
      public var onCurrentMap:Boolean = false;
      
      private var _enabledSkillstree:FuncTree;
      
      private var _disabledSkillstree:FuncTree;
      
      public function InteractiveElement()
      {
         this.enabledSkills = new Vector.<InteractiveElementSkill>();
         this.disabledSkills = new Vector.<InteractiveElementSkill>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 6006;
      }
      
      public function initInteractiveElement(elementId:uint = 0, elementTypeId:int = 0, enabledSkills:Vector.<InteractiveElementSkill> = null, disabledSkills:Vector.<InteractiveElementSkill> = null, onCurrentMap:Boolean = false) : InteractiveElement
      {
         this.elementId = elementId;
         this.elementTypeId = elementTypeId;
         this.enabledSkills = enabledSkills;
         this.disabledSkills = disabledSkills;
         this.onCurrentMap = onCurrentMap;
         return this;
      }
      
      public function reset() : void
      {
         this.elementId = 0;
         this.elementTypeId = 0;
         this.enabledSkills = new Vector.<InteractiveElementSkill>();
         this.disabledSkills = new Vector.<InteractiveElementSkill>();
         this.onCurrentMap = false;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_InteractiveElement(output);
      }
      
      public function serializeAs_InteractiveElement(output:ICustomDataOutput) : void
      {
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element elementId.");
         }
         output.writeInt(this.elementId);
         output.writeInt(this.elementTypeId);
         output.writeShort(this.enabledSkills.length);
         for(var _i3:uint = 0; _i3 < this.enabledSkills.length; _i3++)
         {
            output.writeShort((this.enabledSkills[_i3] as InteractiveElementSkill).getTypeId());
            (this.enabledSkills[_i3] as InteractiveElementSkill).serialize(output);
         }
         output.writeShort(this.disabledSkills.length);
         for(var _i4:uint = 0; _i4 < this.disabledSkills.length; _i4++)
         {
            output.writeShort((this.disabledSkills[_i4] as InteractiveElementSkill).getTypeId());
            (this.disabledSkills[_i4] as InteractiveElementSkill).serialize(output);
         }
         output.writeBoolean(this.onCurrentMap);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_InteractiveElement(input);
      }
      
      public function deserializeAs_InteractiveElement(input:ICustomDataInput) : void
      {
         var _id3:uint = 0;
         var _item3:InteractiveElementSkill = null;
         var _id4:uint = 0;
         var _item4:InteractiveElementSkill = null;
         this._elementIdFunc(input);
         this._elementTypeIdFunc(input);
         var _enabledSkillsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _enabledSkillsLen; _i3++)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(InteractiveElementSkill,_id3);
            _item3.deserialize(input);
            this.enabledSkills.push(_item3);
         }
         var _disabledSkillsLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _disabledSkillsLen; _i4++)
         {
            _id4 = input.readUnsignedShort();
            _item4 = ProtocolTypeManager.getInstance(InteractiveElementSkill,_id4);
            _item4.deserialize(input);
            this.disabledSkills.push(_item4);
         }
         this._onCurrentMapFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_InteractiveElement(tree);
      }
      
      public function deserializeAsyncAs_InteractiveElement(tree:FuncTree) : void
      {
         tree.addChild(this._elementIdFunc);
         tree.addChild(this._elementTypeIdFunc);
         this._enabledSkillstree = tree.addChild(this._enabledSkillstreeFunc);
         this._disabledSkillstree = tree.addChild(this._disabledSkillstreeFunc);
         tree.addChild(this._onCurrentMapFunc);
      }
      
      private function _elementIdFunc(input:ICustomDataInput) : void
      {
         this.elementId = input.readInt();
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element of InteractiveElement.elementId.");
         }
      }
      
      private function _elementTypeIdFunc(input:ICustomDataInput) : void
      {
         this.elementTypeId = input.readInt();
      }
      
      private function _enabledSkillstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._enabledSkillstree.addChild(this._enabledSkillsFunc);
         }
      }
      
      private function _enabledSkillsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:InteractiveElementSkill = ProtocolTypeManager.getInstance(InteractiveElementSkill,_id);
         _item.deserialize(input);
         this.enabledSkills.push(_item);
      }
      
      private function _disabledSkillstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._disabledSkillstree.addChild(this._disabledSkillsFunc);
         }
      }
      
      private function _disabledSkillsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:InteractiveElementSkill = ProtocolTypeManager.getInstance(InteractiveElementSkill,_id);
         _item.deserialize(input);
         this.disabledSkills.push(_item);
      }
      
      private function _onCurrentMapFunc(input:ICustomDataInput) : void
      {
         this.onCurrentMap = input.readBoolean();
      }
   }
}
