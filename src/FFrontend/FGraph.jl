
#= /*
* This file is part of OpenModelica.
*
* Copyright (c) 1998-CurrentYear, Open Source Modelica Consortium (OSMC),
* c/o Linköpings universitet, Department of Computer and Information Science,
* SE-58183 Linköping, Sweden.
*
* All rights reserved.
*
* THIS PROGRAM IS PROVIDED UNDER THE TERMS OF GPL VERSION 3 LICENSE OR
* THIS OSMC PUBLIC LICENSE (OSMC-PL) VERSION 1.2.
* ANY USE, REPRODUCTION OR DISTRIBUTION OF THIS PROGRAM CONSTITUTES
* RECIPIENT'S ACCEPTANCE OF THE OSMC PUBLIC LICENSE OR THE GPL VERSION 3,
* ACCORDING TO RECIPIENTS CHOICE.
*
* The OpenModelica software and the Open Source Modelica
* Consortium (OSMC) Public License (OSMC-PL) are obtained
* from OSMC, either from the above address,
* from the URLs: http:www.ida.liu.se/projects/OpenModelica or
* http:www.openmodelica.org, and in the OpenModelica distribution.
* GNU version 3 is obtained from: http:www.gnu.org/copyleft/gpl.html.
*
* This program is distributed WITHOUT ANY WARRANTY; without
* even the implied warranty of  MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE, EXCEPT AS EXPRESSLY SET FORTH
* IN THE BY RECIPIENT SELECTED SUBSIDIARY LICENSE CONDITIONS OF OSMC-PL.
*
* See the full OSMC Public License conditions for more details.
*
*/ =#

module FGraph


using MetaModelica
#= ExportAll is not good practice but it makes it so that we do not have to write export after each function :( =#
using ExportAll

@importDBG Absyn
@importDBG AbsynUtil
@importDBG SCode
@importDBG DAE
@importDBG Prefix
@importDBG ClassInf
@importDBG FCore

const Name = FCore.Name
const Id = FCore.Id
const Seq = FCore.Seq
const Next = FCore.Next
const Node = FCore.Node
const Data = FCore.Data
const Kind = FCore.Kind
const MMRef = FCore.MMRef
const Refs = FCore.Refs
const RefTree = FCore.RefTree
const Children = FCore.Children
const Parents = FCore.Parents
const Scope = FCore.Scope
const Top = FCore.Top
const Graph = FCore.Graph
const Extra = FCore.Extra
const Visited = FCore.Visited
const Status = FCore.Status

@importDBG Config
@importDBG Debug
@importDBG Error
#@importDBG FGraphBuildEnv
@importDBG FNode
@importDBG Flags
@importDBG Global
@importDBG InnerOuterTypes
@importDBG ListUtil
import MetaModelica.Dangerous
@importDBG FGraphUtil
@importDBG SCodeDump
@importDBG SCodeUtil
@importDBG System
#@importDBG Types
@importDBG Util



#= get the top current scope from the graph =#
function currentScope(inGraph::Graph) ::Scope
     local outScope::Scope

     outScope = begin
       @match inGraph begin
         FCore.G(scope = outScope)  => begin
           outScope
         end

         FCore.EG(_)  => begin
           nil
         end
       end
     end
 outScope
end

#= get the last ref from the current scope the graph =#
function lastScopeRef(inGraph::Graph) ::MMRef
     local outRef::MMRef
     outRef = listHead(currentScope(inGraph))
 outRef
end

         #= @author: adrpo
         THE MOST IMPORTANT FUNCTION IN THE COMPILER :)
         This function works like this:
         From source scope:
           A.B.C.D
         we lookup a target scope
           X.Y.Z.W
         to be used for a component, derived class, or extends
         We get back X.Y.Z + CLASS(W) via lookup.
         We build X.Y.Z.W_newVersion and return it.
         The newVersion name is generated by mkVersionName based on
         the source scope, the element name, prefix and modifiers.
         The newVersion scope is only created if there are non emtpy
         modifiers given to this functions =#
        function mkVersionNode(inSourceEnv::Graph, inSourceName::Name, inPrefix::Prefix.PrefixType, inMod::DAE.Mod, inTargetClassEnv::Graph, inTargetClass::SCode.Element, inIH::InnerOuterTypes.InstHierarchy) ::Tuple{Graph, SCode.Element, InnerOuterTypes.InstHierarchy}
              local outIH::InnerOuterTypes.InstHierarchy
              local outVersionedTargetClass::SCode.Element
              local outVersionedTargetClassEnv::Graph

              (outVersionedTargetClassEnv, outVersionedTargetClass, outIH) = begin
                  local gclass::Graph
                  local classRef::MMRef
                  local sourceRef::MMRef
                  local targetClassParentRef::MMRef
                  local versionRef::MMRef
                  local n::Node
                  local r::MMRef
                  local crefPrefix::Prefix.PrefixType
                  local sourceScope::Scope
                  local c::SCode.Element
                  local targetClassName::Name
                  local newTargetClassName::Name
                  local ih::InnerOuterTypes.InstHierarchy
                   #= /*
                      case (_, _, _, _, _, _, _)
                        equation
                          c = inTargetClass;
                          gclass = inTargetClassEnv;
                          targetClassName = SCodeUtil.elementName(c);

                          (newTargetClassName, crefPrefix) = mkVersionName(inSourceEnv, inSourceName, inPrefix, inMod, inTargetClassEnv, targetClassName);

                           get the last scope from target
                          targetClassParentRef = lastScopeRef(inTargetClassEnv);
                          classRef = FNode.child(targetClassParentRef, newTargetClassName);
                          c = FNode.getElementFromRef(classRef);
                        then
                          (inTargetClassEnv, c, inIH);*/ =#
                @matchcontinue (inSourceEnv, inSourceName, inPrefix, inMod, inTargetClassEnv, inTargetClass, inIH) begin
                  (_, _, _, _, _, _, _)  => begin
                      c = inTargetClass
                      gclass = inTargetClassEnv
                      targetClassName = SCodeUtil.elementName(c)
                      (newTargetClassName, crefPrefix) = mkVersionName(inSourceEnv, inSourceName, inPrefix, inMod, inTargetClassEnv, targetClassName)
                      sourceRef = FNode.child(lastScopeRef(inSourceEnv), inSourceName)
                      _ = _cons(sourceRef, currentScope(inSourceEnv))
                      targetClassParentRef = lastScopeRef(inTargetClassEnv)
                      classRef = FNode.child(targetClassParentRef, targetClassName)
                      classRef = FNode.copyRefNoUpdate(classRef)
                      @match FCore.CL(e = c) = FNode.refData(classRef)
                      c = SCodeUtil.setClassName(newTargetClassName, c)
                      classRef = updateClassElement(classRef, c, crefPrefix, inMod, FCore.CLS_INSTANCE(targetClassName), empty())
                      FNode.addChildRef(targetClassParentRef, newTargetClassName, classRef)
                      sourceRef = updateSourceTargetScope(sourceRef, _cons(classRef, currentScope(gclass)))
                      ih = inIH
                    (gclass, c, ih)
                  end

                  _  => begin
                        c = inTargetClass
                        targetClassName = SCodeUtil.elementName(c)
                        (newTargetClassName, _) = mkVersionName(inSourceEnv, inSourceName, inPrefix, inMod, inTargetClassEnv, targetClassName)
                        Error.addCompilerWarning("FGraphUtil.mkVersionNode: failed to create version node:\\n" + "Instance: CL(" + getGraphNameStr(inSourceEnv) + ").CO(" + inSourceName + ").CL(" + getGraphNameStr(inTargetClassEnv) + "." + targetClassName + "no mod printout" + ")\\n\\t" + newTargetClassName + "\\n")
                      (inTargetClassEnv, inTargetClass, inIH)
                  end
                end
              end
               #=  get the last item in the source env
               =#
               #=  get the last scope from target
               =#
               #=  get the class from class env
               =#
               #=  clone the class
               =#
               #=  check if the name of the class already exists!
               =#
               #=  failure(_ = FNode.child(targetClassParentRef, newTargetClassName));
               =#
               #=  change class name (so unqualified references to the same class reach the original element
               =#
               #= /* FCore.CLS_UNTYPED() */ =#
               #=  parent the classRef
               =#
               #=  update the source target scope
               =#
               #=  we never need to add the instance as inner!
               =#
               #=  ih = InnerOuter.addClassIfInner(c, crefPrefix, gclass, inIH);
               =#
               #= /*
                      print(\"Instance1: CL(\" + getGraphNameStr(inSourceEnv) + \").CO(\" +
                            inSourceName + \").CL(\" + getGraphNameStr(inTargetClassEnv) + \".\" +
                            targetClassName + SCodeDump.printModStr(Mod.unelabMod(inMod), SCodeDump.defaultOptions) + \")\\n\\t\" +
                            newTargetClassName + \"\\n\");*/ =#
          (outVersionedTargetClassEnv, outVersionedTargetClass, outIH)
        end

        function isTargetClassBuiltin(inGraph::Graph, inClass::SCode.Element) ::Bool
              local yes::Bool

              yes = begin
                  local r::MMRef
                @matchcontinue (inGraph, inClass) begin
                  (_, _)  => begin
                      r = FNode.child(lastScopeRef(inGraph), SCodeUtil.elementName(inClass))
                      yes = FNode.isRefBasicType(r) || FNode.isRefBuiltin(r)
                    yes
                  end

                  _  => begin
                      false
                  end
                end
              end
          yes
        end

        function createVersionScope(inSourceEnv::Graph, inSourceName::Name, inPrefix::Prefix.PrefixType, inMod::DAE.Mod, inTargetClassEnv::Graph, inTargetClass::SCode.Element, inIH::InnerOuterTypes.InstHierarchy) ::Tuple{Graph, SCode.Element, InnerOuterTypes.InstHierarchy}
              local outIH::InnerOuterTypes.InstHierarchy
              local outVersionedTargetClass::SCode.Element
              local outVersionedTargetClassEnv::Graph

              (outVersionedTargetClassEnv, outVersionedTargetClass, outIH) = begin
                  local gclass::Graph
                  local c::SCode.Element
                   #= /*
                      case (_, _, _, _, _, _, _)
                        equation
                          print(AbsynUtil.pathString(prefixToPath(inPrefix)) + \" S:\" + getGraphNameStr(inSourceEnv) + \"/\" + inSourceName + \" ||| \" + \"T:\" + getGraphNameStr(inTargetClassEnv) + \"/\" + SCodeUtil.elementName(inTargetClass) + \"\\n\");
                        then
                          fail();*/ =#
                   #=  case (_, _, _, _, _, _, _) then (inTargetClassEnv, inTargetClass, inIH);
                   =#
                   #=  don't do this if there is no modifications on the class
                   =#
                   #=  TODO! FIXME! wonder if we can skip this if it has only a binding, not an actual type modifier
                   =#
                @matchcontinue (inSourceEnv, inSourceName, inPrefix, inMod, inTargetClassEnv, inTargetClass, inIH) begin
                  (_, _, _, DAE.NOMOD(__), _, _, _)  => begin
                    (inTargetClassEnv, inTargetClass, inIH)
                  end

                  (_, _, _, DAE.MOD(subModLst =  nil()), _, _, _)  => begin
                    (inTargetClassEnv, inTargetClass, inIH)
                  end

                  (_, _, _, _, _, _, _)  => begin
                      @match true = Config.acceptMetaModelicaGrammar() || isTargetClassBuiltin(inTargetClassEnv, inTargetClass) || FGraphUtil.inFunctionScope(inSourceEnv) || SCodeUtil.isOperatorRecord(inTargetClass)
                    (inTargetClassEnv, inTargetClass, inIH)
                  end

                  (_, _, _, _, _, _, _)  => begin
                      @match true = stringEq(AbsynUtil.pathFirstIdent(FGraphUtil.getGraphName(inTargetClassEnv)), "OpenModelica")
                    (inTargetClassEnv, inTargetClass, inIH)
                  end

                  (_, _, _, _, _, _, _)  => begin
                      (gclass, c, outIH) = mkVersionNode(inSourceEnv, inSourceName, inPrefix, inMod, inTargetClassEnv, inTargetClass, inIH)
                    (gclass, c, outIH)
                  end
                end
              end
               #=  don't do this for MetaModelica, target class is builtin or builtin type, functions
               =#
               #=  or OpenModelica scripting stuff
               =#
               #=  need to create a new version of the class
               =#
          (outVersionedTargetClassEnv, outVersionedTargetClass, outIH)
        end

        #= This function is used to extend a prefix with another level.  If
         the prefix `a.b{10}.c\\' is extended with `d\\' and an empty subscript
         list, the resulting prefix is `a.b{10}.c.d\\'.  Remember that
         prefixes components are stored in the opposite order from the
         normal order used when displaying them. =#
       function prefixAdd(inIdent::String, inType::List{<:DAE.Dimension}, inIntegerLst::List{<:DAE.Subscript}, inPrefix::Prefix.PrefixType, vt::SCode.Variability, ci_state::ClassInf.SMNode, inInfo::SourceInfo) ::Prefix.PrefixType
             local outPrefix::Prefix.PrefixType

             outPrefix = begin
                 local i::String
                 local s::List{DAE.Subscript}
                 local p::Prefix.ComponentPrefix
               @match (inIdent, inType, inIntegerLst, inPrefix, vt, ci_state) begin
                 (i, _, s, Prefix.PREFIX(p, _), _, _)  => begin
                   Prefix.PREFIX(Prefix.PRE(i, inType, s, p, ci_state, inInfo), Prefix.CLASSPRE(vt))
                 end

                 (i, _, s, Prefix.NOPRE(__), _, _)  => begin
                   Prefix.PREFIX(Prefix.PRE(i, inType, s, Prefix.NOCOMPPRE(), ci_state, inInfo), Prefix.CLASSPRE(vt))
                 end
               end
             end
         outPrefix
       end

       #= Convert a Prefix to a Path =#
      function componentPrefixToPath(pre::Prefix.ComponentPrefix) ::Absyn.Path
            local path::Absyn.Path

            path = begin
                local s::String
                local ss::Prefix.ComponentPrefix
              @match pre begin
                Prefix.PRE(prefix = s, next = Prefix.NOCOMPPRE(__))  => begin
                  Absyn.IDENT(s)
                end

                Prefix.PRE(prefix = s, next = ss)  => begin
                  Absyn.QUALIFIED(s, componentPrefixToPath(ss))
                end
              end
            end
        path
      end

       #= Convert a Prefix to a Path =#
      function prefixToPath(inPrefix::Prefix.PrefixType) ::Absyn.Path
            local outPath::Absyn.Path

            outPath = begin
                local ss::Prefix.ComponentPrefix
              @match inPrefix begin
                Prefix.PREFIX(ss, _)  => begin
                  componentPrefixToPath(ss)
                end
              end
            end
        outPath
      end


        function mkVersionName(inSourceEnv::Graph, inSourceName::Name, inPrefix::Prefix.PrefixType, inMod::DAE.Mod, inTargetClassEnv::Graph, inTargetClassName::Name) ::Tuple{Name, Prefix.PrefixType}
              local outCrefPrefix::Prefix.PrefixType
              local outName::Name

              (outName, outCrefPrefix) = begin
                  local gcomp::Graph
                  local gclass::Graph
                  local classRef::MMRef
                  local compRef::MMRef
                  local n::Node
                  local r::MMRef
                  local crefPrefix::Prefix.PrefixType
                  local name::Name
                @match (inSourceEnv, inSourceName, inPrefix, inMod, inTargetClassEnv, inTargetClassName) begin
                  (_, _, _, _, _, _)  => begin
                      crefPrefix = prefixAdd(inSourceName, nil, nil, inPrefix, SCode.CONST(), ClassInf.UNKNOWN(Absyn.IDENT("")), AbsynUtil.dummyInfo)
                      name = inTargetClassName + "" + AbsynUtil.pathString(AbsynUtil.stringListPath(listReverse(AbsynUtil.pathToStringList(prefixToPath(crefPrefix)))), "", usefq = false)
                    (name, crefPrefix)
                  end
                end
              end
               #=  variability doesn't matter
               =#
               #=  name = inTargetClassName + \"$\" + ComponentReference.printComponentRefStr(prefixToCref(crefPrefix));
               =#
               #=  + \"$\" + AbsynUtil.pathString2NoLeadingDot(FGraphUtil.getGraphName(inSourceEnv), \"$\");
               =#
               #=  name = \"'$\" + inTargetClassName + \"@\" + AbsynUtil.pathString(AbsynUtil.stringListPath(listReverse(AbsynUtil.pathToStringList(prefixToPath(crefPrefix))))) + \"'\";
               =#
               #=  name = \"'$\" + getGraphNameStr(inSourceEnv) + \".\" + AbsynUtil.pathString(AbsynUtil.stringListPath(listReverse(AbsynUtil.pathToStringList(prefixToPath(crefPrefix))))) + \"'\";
               =#
               #=  name = \"$'\" + getGraphNameStr(inSourceEnv) + \".\" +
               =#
               #=         AbsynUtil.pathString(AbsynUtil.stringListPath(listReverse(AbsynUtil.pathToStringList(prefixToPath(crefPrefix))))) +
               =#
               #=         SCodeDump.printModStr(Mod.unelabMod(inMod), SCodeDump.defaultOptions);
               =#
          (outName, outCrefPrefix)
        end

    #= So that we can use wildcard imports and named imports when they do occur. Not good Julia practice =#
    @exportAll()
  end
