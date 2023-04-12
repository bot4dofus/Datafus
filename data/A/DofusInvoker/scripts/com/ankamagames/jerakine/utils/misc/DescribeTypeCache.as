package com.ankamagames.jerakine.utils.misc
{
   import com.ankamagames.jerakine.utils.misc.classInfo.ClassInfo;
   import com.ankamagames.jerakine.utils.misc.classInfo.MetadataInfo;
   import flash.utils.Dictionary;
   import flash.utils.Proxy;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   public class DescribeTypeCache
   {
      
      private static var _classDesc:Dictionary = new Dictionary();
      
      private static var _variablesAndAccessorType:Dictionary = new Dictionary();
      
      private static var _variablesType:Dictionary = new Dictionary();
      
      private static var _classInfos:Dictionary = new Dictionary();
       
      
      public function DescribeTypeCache()
      {
         super();
      }
      
      private static function typeDescription(o:Object, useCache:Boolean = true) : XML
      {
         if(!useCache)
         {
            return describeType(o);
         }
         var c:String = getQualifiedClassName(o);
         if(!_classDesc[c])
         {
            _classDesc[c] = describeType(o);
         }
         return _classDesc[c];
      }
      
      public static function getVariableAndAccessorType(o:Object, onlyVar:Boolean = false) : Dictionary
      {
         var accessorNode:XML = null;
         var v:XML = null;
         var cn:String = getQualifiedClassName(o);
         if(_variablesAndAccessorType[cn])
         {
            return !!onlyVar ? _variablesType[cn] : _variablesAndAccessorType[cn];
         }
         var xmlClassDef:XML = getXmlWithoutFactory(typeDescription(o));
         var res:Dictionary = new Dictionary();
         var resOnly:Dictionary = new Dictionary();
         for each(accessorNode in xmlClassDef.child("accessor"))
         {
            if(accessorNode.attribute("access").toString() != "readOnly")
            {
               res[accessorNode.attribute("name").toString()] = accessorNode.attribute("type").toString();
            }
         }
         for each(v in xmlClassDef.child("variable"))
         {
            res[v.attribute("name").toString()] = v.attribute("type").toString();
            resOnly[v.attribute("name").toString()] = v.attribute("type").toString();
         }
         _variablesAndAccessorType[cn] = res;
         _variablesType[cn] = resOnly;
         return !!onlyVar ? resOnly : res;
      }
      
      public static function getVariables(o:Object, onlyVar:Boolean = false, useCache:Boolean = true, skipReadOnlyVar:Boolean = false, skipWriteOnlyVar:Boolean = false) : Vector.<String>
      {
         var classInfos:ClassInfo = null;
         var variables:Vector.<String> = null;
         var accessorsRW:Vector.<String> = null;
         var accessorsR:Vector.<String> = null;
         var accessorsW:Vector.<String> = null;
         var description:XML = null;
         var varXml:XML = null;
         var key:* = null;
         var className:String = getQualifiedClassName(o);
         if(className == "Object")
         {
            useCache = false;
         }
         if(useCache)
         {
            if(!_classInfos[className])
            {
               _classInfos[className] = new ClassInfo();
            }
            classInfos = _classInfos[className];
         }
         if(!useCache || classInfos.variables == null)
         {
            variables = new Vector.<String>();
            accessorsRW = new Vector.<String>();
            accessorsR = new Vector.<String>();
            accessorsW = new Vector.<String>();
            description = typeDescription(o,useCache);
            if(description.attribute("isDynamic").toString() == "true" || o is Proxy)
            {
               try
               {
                  for(key in o)
                  {
                     variables.push(key);
                  }
               }
               catch(e:Error)
               {
               }
            }
            for each(varXml in description.child("variable"))
            {
               addVariableInXMLToArray(classInfos,variables,varXml,useCache);
            }
            for each(varXml in description.child("factory").child("variable"))
            {
               addVariableInXMLToArray(classInfos,variables,varXml,useCache);
            }
            for each(varXml in description.child("accessor"))
            {
               addAccessorInXMLToArray(classInfos,accessorsRW,accessorsR,accessorsW,varXml,useCache);
            }
            for each(varXml in description.child("factory").child("accessor"))
            {
               addAccessorInXMLToArray(classInfos,accessorsRW,accessorsR,accessorsW,varXml,useCache);
            }
            if(useCache)
            {
               classInfos.variables = variables;
               classInfos.accessorsRW = accessorsRW;
               classInfos.accessorsR = accessorsR;
               classInfos.accessorsW = accessorsW;
            }
         }
         else
         {
            variables = classInfos.variables;
            accessorsRW = classInfos.accessorsRW;
            accessorsR = classInfos.accessorsR;
            accessorsW = classInfos.accessorsW;
         }
         if(!onlyVar)
         {
            variables = variables.concat(accessorsRW);
            if(!skipReadOnlyVar)
            {
               variables = variables.concat(accessorsR);
            }
            if(!skipWriteOnlyVar)
            {
               variables = variables.concat(accessorsW);
            }
         }
         return variables;
      }
      
      private static function addVariableInXMLToArray(classInfos:ClassInfo, variables:Vector.<String>, variableNode:XML, useCache:Boolean) : void
      {
         var metadata:Vector.<MetadataInfo> = null;
         var varName:String = variableNode.attribute("name").toString();
         if(varName != "MEMORY_LOG" && varName != "FLAG" && varName.indexOf("PATTERN") == -1 && varName.indexOf("OFFSET") == -1)
         {
            variables.push(varName);
            if(useCache)
            {
               metadata = createMetadasInfoFromVarXml(variableNode);
               if(metadata && metadata.length > 0)
               {
                  classInfos.variablesMetadatas[varName] = metadata;
               }
            }
         }
      }
      
      private static function addAccessorInXMLToArray(classInfos:ClassInfo, rw:Vector.<String>, r:Vector.<String>, w:Vector.<String>, variableNode:XML, useCache:Boolean) : void
      {
         var metadata:Vector.<MetadataInfo> = null;
         var varName:String = variableNode.attribute("name").toString();
         switch(variableNode.attribute("access").toString())
         {
            case "readonly":
               r.push(varName);
               break;
            case "writeonly":
               w.push(varName);
               break;
            default:
               rw.push(varName);
         }
         if(useCache)
         {
            metadata = createMetadasInfoFromVarXml(variableNode);
            if(metadata && metadata.length > 0)
            {
               classInfos.variablesMetadatas[varName] = metadata;
            }
         }
      }
      
      private static function createMetadasInfoFromVarXml(varXml:XML) : Vector.<MetadataInfo>
      {
         var md:XML = null;
         var name:String = null;
         var args:Dictionary = null;
         var argNode:XML = null;
         var metadatas:Vector.<MetadataInfo> = new Vector.<MetadataInfo>(0);
         for each(md in varXml.child("metadata"))
         {
            name = md.attribute("name").toString();
            args = new Dictionary();
            for each(argNode in md.child("arg"))
            {
               args[argNode.attribute("key").toString()] = argNode.attribute("value").toString();
            }
            metadatas.push(new MetadataInfo(name,args));
         }
         return metadatas;
      }
      
      public static function getAccessors(o:Object) : Vector.<String>
      {
         var className:String = getQualifiedClassName(o);
         if(!_classInfos[className] || !_classInfos[className].variables)
         {
            getVariables(o);
         }
         var classInfo:ClassInfo = _classInfos[className];
         return classInfo.accessorsRW.concat(classInfo.accessorsR).concat(classInfo.accessorsW);
      }
      
      public static function getVariableMetadata(o:Object, field:String) : Vector.<MetadataInfo>
      {
         var className:String = getQualifiedClassName(o);
         if(!_classInfos[className] || !_classInfos[className].variables)
         {
            getVariables(o);
         }
         return _classInfos[className].variablesMetadatas[field];
      }
      
      public static function getMetadata(o:Object) : Vector.<MetadataInfo>
      {
         var description:XML = null;
         var md:XML = null;
         var name:String = null;
         var args:Dictionary = null;
         var argNode:XML = null;
         var className:String = getQualifiedClassName(o);
         if(!_classInfos[className])
         {
            _classInfos[className] = new ClassInfo();
         }
         var classInfos:ClassInfo = _classInfos[className];
         if(classInfos.metadatas == null)
         {
            classInfos.metadatas = new Vector.<MetadataInfo>();
            description = getXmlWithoutFactory(typeDescription(o));
            for each(md in description.child("metadata"))
            {
               name = md.attribute("name").toString();
               args = new Dictionary();
               for each(argNode in md.child("arg"))
               {
                  args[argNode.attribute("key").toString()] = argNode.attribute("value").toString();
               }
               classInfos.metadatas.push(new MetadataInfo(name,args));
            }
         }
         return classInfos.metadatas;
      }
      
      public static function getImplementsInterfaces(o:Object) : Vector.<String>
      {
         var description:XML = null;
         var implemented:XML = null;
         var className:String = getQualifiedClassName(o);
         if(!_classInfos[className])
         {
            _classInfos[className] = new ClassInfo();
         }
         var classInfos:ClassInfo = _classInfos[className];
         if(classInfos.implementsInterfaces == null)
         {
            classInfos.implementsInterfaces = new Vector.<String>();
            description = typeDescription(o);
            for each(implemented in description.child("implementsInterface"))
            {
               classInfos.implementsInterfaces.push(implemented.attribute("type").toString());
            }
            for each(implemented in description.child("factory").child("implementsInterface"))
            {
               classInfos.implementsInterfaces.push(implemented.attribute("type").toString());
            }
         }
         return classInfos.implementsInterfaces;
      }
      
      public static function classImplementInterface(classDef:Class, interfaceDef:Class) : Boolean
      {
         var implemented:String = null;
         var interfaceName:String = getQualifiedClassName(interfaceDef);
         var desc:Vector.<String> = getImplementsInterfaces(classDef);
         for each(implemented in desc)
         {
            if(implemented == interfaceName)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function getExtendsClasses(o:Object) : Vector.<String>
      {
         var description:XML = null;
         var implemented:XML = null;
         var className:String = getQualifiedClassName(o);
         if(!_classInfos[className])
         {
            _classInfos[className] = new ClassInfo();
         }
         var classInfos:ClassInfo = _classInfos[className];
         if(classInfos.extendsClasses == null)
         {
            classInfos.extendsClasses = new Vector.<String>();
            description = typeDescription(o);
            for each(implemented in description.child("extendsClass"))
            {
               classInfos.extendsClasses.push(implemented.attribute("type").toString());
            }
            for each(implemented in description.child("factory").child("extendsClass"))
            {
               classInfos.extendsClasses.push(implemented.attribute("type").toString());
            }
         }
         return classInfos.extendsClasses;
      }
      
      private static function getXmlWithoutFactory(xml:XML) : XML
      {
         var factory:XMLList = xml.child("factory");
         if(factory.length() > 0)
         {
            return factory[0];
         }
         return xml;
      }
   }
}
