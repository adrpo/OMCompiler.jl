  module AbsynUtil


    using MetaModelica
    #= ExportAll is not good practice but it makes it so that we do not have to write export after each function :( =#
    using ExportAll
    #= Necessary to write declarations for your uniontypes until Julia adds support for mutually recursive types =#


    FuncTplToTpl = Function

    FuncTplToTpl = Function

    FuncTplToTpl = Function

    FuncTplToTpl = Function

    FuncTplToTpl = Function

    FuncTplToTpl = Function

    FuncTplToTpl = Function

    FuncTplToTpl = Function

    FuncType = Function

    FuncType = Function

    FuncTplToTpl = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    ModFunc = Function

    ModFunc = Function

    MapFunc = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncT = Function

    FuncT = Function

    FuncT = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

    FuncType = Function

         #= /*
         * This file is part of OpenModelica.
         *
         * Copyright (c) 1998-2014, Open Source Modelica Consortium (OSMC),
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

        using Absyn


  const dummyParts = PARTS(nil, nil, nil, nil, NONE())::ClassDef

  const dummyInfo = SOURCEINFO("", false, 0, 0, 0, 0, 0.0)::Info

  const dummyProgram = PROGRAM(nil, TOP())::Program

        import Dump

        import Error

        import ListUtil

        import System

        import Util

        TypeA = Any
        Type_a = Any
        Argument = Any
        Arg = Any
         #=  stefan
         =#

         #= Traverses all subequations of an equation.
           Takes a function and an extra argument passed through the traversal =#
        function traverseEquation(inEquation::Equation, inFunc::FuncTplToTpl, inTypeA::TypeA) ::Tuple{Equation, TypeA}
              local outTpl::Tuple{Equation, TypeA}

              outTpl = begin
                  local arg::TypeA
                  local arg_1::TypeA
                  local arg_2::TypeA
                  local arg_3::TypeA
                  local arg_4::TypeA
                  local eq::Equation
                  local eq_1::Equation
                  local rel::FuncTplToTpl
                  local e::Exp
                  local e_1::Exp
                  local eqilst::List{EquationItem}
                  local eqilst1::List{EquationItem}
                  local eqilst2::List{EquationItem}
                  local eqilst_1::List{EquationItem}
                  local eqilst1_1::List{EquationItem}
                  local eqilst2_1::List{EquationItem}
                  local eeqitlst::List{Tuple{Exp, List{EquationItem}}}
                  local eeqitlst_1::List{Tuple{Exp, List{EquationItem}}}
                  local fis::ForIterators
                  local fis_1::ForIterators
                  local ei::EquationItem
                  local ei_1::EquationItem
                @matchcontinue (inEquation, inFunc, inTypeA) begin
                  (eq && EQ_IF(e, eqilst1, eeqitlst, eqilst2), rel, arg)  => begin
                      (eqilst1_1, arg_1) = traverseEquationItemList(eqilst1, rel, arg)
                      (eeqitlst_1, arg_2) = traverseExpEqItemTupleList(eeqitlst, rel, arg_1)
                      (eqilst2_1, arg_3) = traverseEquationItemList(eqilst2, rel, arg_2)
                      @match (EQ_IF(), arg_4) = rel((eq, arg_3))
                    (EQ_IF(e, eqilst1_1, eeqitlst_1, eqilst2_1), arg_4)
                  end

                  (eq && EQ_FOR(_, eqilst), rel, arg)  => begin
                      (eqilst_1, arg_1) = traverseEquationItemList(eqilst, rel, arg)
                      @match (EQ_FOR(fis_1, _), arg_2) = rel((eq, arg_1))
                    (EQ_FOR(fis_1, eqilst_1), arg_2)
                  end

                  (eq && EQ_WHEN_E(_, eqilst, eeqitlst), rel, arg)  => begin
                      (eqilst_1, arg_1) = traverseEquationItemList(eqilst, rel, arg)
                      (eeqitlst_1, arg_2) = traverseExpEqItemTupleList(eeqitlst, rel, arg_1)
                      @match (EQ_WHEN_E(e_1, _, _), arg_3) = rel((eq, arg_2))
                    (EQ_WHEN_E(e_1, eqilst_1, eeqitlst_1), arg_3)
                  end

                  (eq && EQ_FAILURE(ei), rel, arg)  => begin
                      (ei_1, arg_1) = traverseEquationItem(ei, rel, arg)
                      @match (EQ_FAILURE(), arg_2) = rel((eq, arg_1))
                    (EQ_FAILURE(ei_1), arg_2)
                  end

                  (eq, rel, arg)  => begin
                      (eq_1, arg_1) = rel((eq, arg))
                    (eq_1, arg_1)
                  end
                end
              end
          outTpl
        end

         #=  stefan
         =#

         #= Traverses the equation inside an equationitem =#
        function traverseEquationItem(inEquationItem::EquationItem, inFunc::FuncTplToTpl, inTypeA::TypeA) ::Tuple{EquationItem, TypeA}
              local outTpl::Tuple{EquationItem, TypeA}

              outTpl = begin
                  local ei::EquationItem
                  local rel::FuncTplToTpl
                  local arg::TypeA
                  local arg_1::TypeA
                  local eq::Equation
                  local eq_1::Equation
                  local oc::Option{Comment}
                  local info::Info
                @matchcontinue (inEquationItem, inFunc, inTypeA) begin
                  (EQUATIONITEM(eq, oc, info), rel, arg)  => begin
                      (eq_1, arg_1) = traverseEquation(eq, rel, arg)
                    (EQUATIONITEM(eq_1, oc, info), arg_1)
                  end

                  (ei, _, arg)  => begin
                    (ei, arg)
                  end
                end
              end
          outTpl
        end

         #=  stefan
         =#

         #= calls traverseEquationItem on every element of the given list =#
        function traverseEquationItemList(inEquationItemList::List{<:EquationItem}, inFunc::FuncTplToTpl, inTypeA::TypeA) ::Tuple{List{EquationItem}, TypeA}
              local outTpl::Tuple{List{EquationItem}, TypeA}

              local arg2::TypeA = inTypeA

              outTpl = (list(begin
                  local ei::EquationItem
                  local ei_1::EquationItem
                @match el begin
                  ei  => begin
                      (ei_1, arg2) = traverseEquationItem(ei, inFunc, arg2)
                    ei_1
                  end
                end
              end for el in inEquationItemList), arg2)
          outTpl
        end

         #=  stefan
         =#

         #= traverses a list of Exp * EquationItem list tuples
          mostly used for else-if blocks =#
        function traverseExpEqItemTupleList(inList::List{<:Tuple{<:Exp, List{<:EquationItem}}}, inFunc::FuncTplToTpl, inTypeA::TypeA) ::Tuple{List{Tuple{Exp, List{EquationItem}}}, TypeA}
              local outTpl::Tuple{List{Tuple{Exp, List{EquationItem}}}, TypeA}

              local arg2::TypeA = inTypeA

              outTpl = (list(begin
                  local e::Exp
                  local eilst::List{EquationItem}
                  local eilst_1::List{EquationItem}
                @match el begin
                  (e, eilst)  => begin
                      (eilst_1, arg2) = traverseEquationItemList(eilst, inFunc, arg2)
                    (e, eilst_1)
                  end
                end
              end for el in inList), arg2)
          outTpl
        end

         #=  stefan
         =#

         #= Traverses all subalgorithms of an algorithm
          Takes a function and an extra argument passed through the traversal =#
        function traverseAlgorithm(inAlgorithm::Algorithm, inFunc::FuncTplToTpl, inTypeA::TypeA) ::Tuple{Algorithm, TypeA}
              local outTpl::Tuple{Algorithm, TypeA}

              outTpl = begin
                  local arg::TypeA
                  local arg_1::TypeA
                  local arg1_1::TypeA
                  local arg2_1::TypeA
                  local arg3_1::TypeA
                  local alg::Algorithm
                  local alg_1::Algorithm
                  local alg1_1::Algorithm
                  local alg2_1::Algorithm
                  local alg3_1::Algorithm
                  local ailst::List{AlgorithmItem}
                  local ailst1::List{AlgorithmItem}
                  local ailst2::List{AlgorithmItem}
                  local ailst_1::List{AlgorithmItem}
                  local ailst1_1::List{AlgorithmItem}
                  local ailst2_1::List{AlgorithmItem}
                  local eaitlst::List{Tuple{Exp, List{AlgorithmItem}}}
                  local eaitlst_1::List{Tuple{Exp, List{AlgorithmItem}}}
                  local rel::FuncTplToTpl
                  local ai::AlgorithmItem
                  local ai_1::AlgorithmItem
                  local e::Exp
                  local e_1::Exp
                  local fis::ForIterators
                  local fis_1::ForIterators
                @matchcontinue (inAlgorithm, inFunc, inTypeA) begin
                  (alg && ALG_IF(_, ailst1, eaitlst, ailst2), rel, arg)  => begin
                      (ailst1_1, arg1_1) = traverseAlgorithmItemList(ailst1, rel, arg)
                      (eaitlst_1, arg2_1) = traverseExpAlgItemTupleList(eaitlst, rel, arg1_1)
                      (ailst2_1, arg3_1) = traverseAlgorithmItemList(ailst2, rel, arg2_1)
                      @match (ALG_IF(e_1, _, _, _), arg_1) = rel((alg, arg3_1))
                    (ALG_IF(e_1, ailst1_1, eaitlst_1, ailst2_1), arg_1)
                  end

                  (alg && ALG_FOR(_, ailst), rel, arg)  => begin
                      (ailst_1, arg1_1) = traverseAlgorithmItemList(ailst, rel, arg)
                      @match (ALG_FOR(fis_1, _), arg_1) = rel((alg, arg1_1))
                    (ALG_FOR(fis_1, ailst_1), arg_1)
                  end

                  (alg && ALG_PARFOR(_, ailst), rel, arg)  => begin
                      (ailst_1, arg1_1) = traverseAlgorithmItemList(ailst, rel, arg)
                      @match (ALG_PARFOR(fis_1, _), arg_1) = rel((alg, arg1_1))
                    (ALG_PARFOR(fis_1, ailst_1), arg_1)
                  end

                  (alg && ALG_WHILE(_, ailst), rel, arg)  => begin
                      (ailst_1, arg1_1) = traverseAlgorithmItemList(ailst, rel, arg)
                      @match (ALG_WHILE(e_1, _), arg_1) = rel((alg, arg1_1))
                    (ALG_WHILE(e_1, ailst_1), arg_1)
                  end

                  (alg && ALG_WHEN_A(_, ailst, eaitlst), rel, arg)  => begin
                      (ailst_1, arg1_1) = traverseAlgorithmItemList(ailst, rel, arg)
                      (eaitlst_1, arg2_1) = traverseExpAlgItemTupleList(eaitlst, rel, arg1_1)
                      @match (ALG_WHEN_A(e_1, _, _), arg_1) = rel((alg, arg2_1))
                    (ALG_WHEN_A(e_1, ailst_1, eaitlst_1), arg_1)
                  end

                  (alg, rel, arg)  => begin
                      (alg_1, arg_1) = rel((alg, arg))
                    (alg_1, arg_1)
                  end
                end
              end
          outTpl
        end

         #=  stefan
         =#

         #= traverses the Algorithm contained in an AlgorithmItem, if any
          see traverseAlgorithm =#
        function traverseAlgorithmItem(inAlgorithmItem::AlgorithmItem, inFunc::FuncTplToTpl, inTypeA::TypeA) ::Tuple{AlgorithmItem, TypeA}
              local outTpl::Tuple{AlgorithmItem, TypeA}

              outTpl = begin
                  local rel::FuncTplToTpl
                  local arg::TypeA
                  local arg_1::TypeA
                  local alg::Algorithm
                  local alg_1::Algorithm
                  local oc::Option{Comment}
                  local ai::AlgorithmItem
                  local info::Info
                @matchcontinue (inAlgorithmItem, inFunc, inTypeA) begin
                  (ALGORITHMITEM(alg, oc, info), rel, arg)  => begin
                      (alg_1, arg_1) = traverseAlgorithm(alg, rel, arg)
                    (ALGORITHMITEM(alg_1, oc, info), arg_1)
                  end

                  (ai, _, arg)  => begin
                    (ai, arg)
                  end
                end
              end
          outTpl
        end

         #=  stefan
         =#

         #= calls traverseAlgorithmItem on each item in a list of AlgorithmItems =#
        function traverseAlgorithmItemList(inAlgorithmItemList::List{<:AlgorithmItem}, inFunc::FuncTplToTpl, inTypeA::TypeA) ::Tuple{List{AlgorithmItem}, TypeA}
              local outTpl::Tuple{List{AlgorithmItem}, TypeA}

              outTpl = begin
                  local rel::FuncTplToTpl
                  local arg::TypeA
                  local arg_1::TypeA
                  local arg_2::TypeA
                  local ai::AlgorithmItem
                  local ai_1::AlgorithmItem
                  local cdr::List{AlgorithmItem}
                  local cdr_1::List{AlgorithmItem}
                @match (inAlgorithmItemList, inFunc, inTypeA) begin
                  ( nil(), _, arg)  => begin
                    (nil, arg)
                  end

                  (ai <| cdr, rel, arg)  => begin
                      (ai_1, arg_1) = traverseAlgorithmItem(ai, rel, arg)
                      (cdr_1, arg_2) = traverseAlgorithmItemList(cdr, rel, arg_1)
                    (_cons(ai_1, cdr_1), arg_2)
                  end
                end
              end
          outTpl
        end

         #=  stefan
         =#

         #= traverses a list of Exp * AlgorithmItem list tuples
          mostly used for else-if blocks =#
        function traverseExpAlgItemTupleList(inList::List{<:Tuple{<:Exp, List{<:AlgorithmItem}}}, inFunc::FuncTplToTpl, inTypeA::TypeA) ::Tuple{List{Tuple{Exp, List{AlgorithmItem}}}, TypeA}
              local outTpl::Tuple{List{Tuple{Exp, List{AlgorithmItem}}}, TypeA}

              outTpl = begin
                  local rel::FuncTplToTpl
                  local arg::TypeA
                  local arg_1::TypeA
                  local arg_2::TypeA
                  local cdr::List{Tuple{Exp, List{AlgorithmItem}}}
                  local cdr_1::List{Tuple{Exp, List{AlgorithmItem}}}
                  local e::Exp
                  local ailst::List{AlgorithmItem}
                  local ailst_1::List{AlgorithmItem}
                @match (inList, inFunc, inTypeA) begin
                  ( nil(), _, arg)  => begin
                    (nil, arg)
                  end

                  ((e, ailst) <| cdr, rel, arg)  => begin
                      (ailst_1, arg_1) = traverseAlgorithmItemList(ailst, rel, arg)
                      (cdr_1, arg_2) = traverseExpAlgItemTupleList(cdr, rel, arg_1)
                    (_cons((e, ailst_1), cdr_1), arg_2)
                  end
                end
              end
          outTpl
        end

         #=  Traverses all subexpressions of an Exp expression.
          Takes a function and an extra argument passed through the traversal.
          NOTE:This function was copied from Expression.traverseExpression. =#
        function traverseExp(inExp::Exp, inFunc::FuncType, inArg::Type_a) ::Tuple{Exp, Type_a}
              local outArg::Type_a
              local outExp::Exp

              (outExp, outArg) = traverseExpBidir(inExp, dummyTraverseExp, inFunc, inArg)
          (outExp, outArg)
        end

         #=  Traverses all subexpressions of an Exp expression.
          Takes a function and an extra argument passed through the traversal. =#
        function traverseExpTopDown(inExp::Exp, inFunc::FuncType, inArg::Type_a) ::Tuple{Exp, Type_a}
              local outArg::Type_a
              local outExp::Exp

              (outExp, outArg) = traverseExpBidir(inExp, inFunc, dummyTraverseExp, inArg)
          (outExp, outArg)
        end

         #= calls traverseExp on each element in the given list =#
        function traverseExpList(inExpList::List{<:Exp}, inFunc::FuncTplToTpl, inArg::Type_a) ::Tuple{List{Exp}, Type_a}
              local outArg::Type_a
              local outExpList::List{Exp}

              (outExpList, outArg) = traverseExpListBidir(inExpList, dummyTraverseExp, inFunc, inArg)
          (outExpList, outArg)
        end

         #= Traverses a list of expressions, calling traverseExpBidir on each
          expression. =#
        function traverseExpListBidir(inExpl::List{<:Exp}, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{List{Exp}, Argument}
              local outArg::Argument
              local outExpl::List{Exp}

              (outExpl, outArg) = ListUtil.map2FoldCheckReferenceEq(inExpl, traverseExpBidir, enterFunc, exitFunc, inArg)
          (outExpl, outArg)
        end

         #= This function takes an expression and a tuple with an enter function, an exit
          function, and an extra argument. For each expression it encounters it calls
          the enter function with the expression and the extra argument. It then
          traverses all subexpressions in the expression and calls traverseExpBidir on
          them with the updated argument. Finally it calls the exit function, again with
          the updated argument. This means that this function is bidirectional, and can
          be used to emulate both top-down and bottom-up traversal. =#
        function traverseExpBidir(inExp::Exp, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{Exp, Argument}
              local arg::Argument
              local e::Exp

              (e, arg) = enterFunc(inExp, inArg)
              (e, arg) = traverseExpBidirSubExps(e, enterFunc, exitFunc, arg)
              (e, arg) = exitFunc(e, arg)
          (e, arg)
        end

         #= Same as traverseExpBidir, but with an optional expression. Calls
          traverseExpBidir if the option is SOME(), or just returns the input if it's
          NONE() =#
        function traverseExpOptBidir(inExp::Option{<:Exp}, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{Option{Exp}, Argument}
              local arg::Argument
              local outExp::Option{Exp}

              (outExp, arg) = begin
                  local e1::Exp
                  local e2::Exp
                  local tup::Tuple{FuncType, FuncType, Argument}
                @match (inExp, enterFunc, exitFunc, inArg) begin
                  (SOME(e1), _, _, _)  => begin
                      (e2, arg) = traverseExpBidir(e1, enterFunc, exitFunc, inArg)
                    (if referenceEq(e1, e2)
                          inExp
                        else
                          SOME(e2)
                        end, arg)
                  end

                  _  => begin
                      (inExp, inArg)
                  end
                end
              end
          (outExp, arg)
        end

         #= Helper function to traverseExpBidir. Traverses the subexpressions of an
          expression and calls traverseExpBidir on them. =#
        function traverseExpBidirSubExps(inExp::Exp, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{Exp, Argument}
              local arg::Argument
              local e::Exp

              (e, arg) = begin
                  local e1::Exp
                  local e1m::Exp
                  local e2::Exp
                  local e2m::Exp
                  local e3::Exp
                  local e3m::Exp
                  local oe1::Option{Exp}
                  local oe1m::Option{Exp}
                  local tup::Tuple{FuncType, FuncType, Argument}
                  local op::Operator
                  local cref::ComponentRef
                  local crefm::ComponentRef
                  local else_ifs1::List{Tuple{Exp, Exp}}
                  local else_ifs2::List{Tuple{Exp, Exp}}
                  local expl1::List{Exp}
                  local expl2::List{Exp}
                  local mat_expl::List{List{Exp}}
                  local fargs1::FunctionArgs
                  local fargs2::FunctionArgs
                  local error_msg::String
                  local id::Ident
                  local enterName::Ident
                  local exitName::Ident
                  local match_ty::MatchType
                  local match_decls::List{ElementItem}
                  local match_cases::List{Case}
                  local cmt::Option{String}
                @match (inExp, enterFunc, exitFunc, inArg) begin
                  (INTEGER(__), _, _, _)  => begin
                    (inExp, inArg)
                  end

                  (REAL(__), _, _, _)  => begin
                    (inExp, inArg)
                  end

                  (STRING(__), _, _, _)  => begin
                    (inExp, inArg)
                  end

                  (BOOL(__), _, _, _)  => begin
                    (inExp, inArg)
                  end

                  (CREF(componentRef = cref), _, _, arg)  => begin
                      (crefm, arg) = traverseExpBidirCref(cref, enterFunc, exitFunc, arg)
                    (if referenceEq(cref, crefm)
                          inExp
                        else
                          CREF(crefm)
                        end, arg)
                  end

                  (BINARY(exp1 = e1, op = op, exp2 = e2), _, _, arg)  => begin
                      (e1m, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (e2m, arg) = traverseExpBidir(e2, enterFunc, exitFunc, arg)
                    (if referenceEq(e1, e1m) && referenceEq(e2, e2m)
                          inExp
                        else
                          BINARY(e1m, op, e2m)
                        end, arg)
                  end

                  (UNARY(op = op, exp = e1), _, _, arg)  => begin
                      (e1m, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                    (if referenceEq(e1, e1m)
                          inExp
                        else
                          UNARY(op, e1m)
                        end, arg)
                  end

                  (LBINARY(exp1 = e1, op = op, exp2 = e2), _, _, arg)  => begin
                      (e1m, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (e2m, arg) = traverseExpBidir(e2, enterFunc, exitFunc, arg)
                    (if referenceEq(e1, e1m) && referenceEq(e2, e2m)
                          inExp
                        else
                          LBINARY(e1m, op, e2m)
                        end, arg)
                  end

                  (LUNARY(op = op, exp = e1), _, _, arg)  => begin
                      (e1m, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                    (if referenceEq(e1, e1m)
                          inExp
                        else
                          LUNARY(op, e1m)
                        end, arg)
                  end

                  (RELATION(exp1 = e1, op = op, exp2 = e2), _, _, arg)  => begin
                      (e1m, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (e2m, arg) = traverseExpBidir(e2, enterFunc, exitFunc, arg)
                    (if referenceEq(e1, e1m) && referenceEq(e2, e2m)
                          inExp
                        else
                          RELATION(e1m, op, e2m)
                        end, arg)
                  end

                  (IFEXP(ifExp = e1, trueBranch = e2, elseBranch = e3, elseIfBranch = else_ifs1), _, _, arg)  => begin
                      (e1m, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (e2m, arg) = traverseExpBidir(e2, enterFunc, exitFunc, arg)
                      (e3m, arg) = traverseExpBidir(e3, enterFunc, exitFunc, arg)
                      (else_ifs2, arg) = ListUtil.map2FoldCheckReferenceEq(else_ifs1, traverseExpBidirElseIf, enterFunc, exitFunc, arg)
                    (if referenceEq(e1, e1m) && referenceEq(e2, e2m) && referenceEq(e3, e3m) && referenceEq(else_ifs1, else_ifs2)
                          inExp
                        else
                          IFEXP(e1m, e2m, e3m, else_ifs2)
                        end, arg)
                  end

                  (CALL(function_ = cref, functionArgs = fargs1), _, _, arg)  => begin
                      (fargs2, arg) = traverseExpBidirFunctionArgs(fargs1, enterFunc, exitFunc, arg)
                    (if referenceEq(fargs1, fargs2)
                          inExp
                        else
                          CALL(cref, fargs2)
                        end, arg)
                  end

                  (PARTEVALFUNCTION(function_ = cref, functionArgs = fargs1), _, _, arg)  => begin
                      (fargs2, arg) = traverseExpBidirFunctionArgs(fargs1, enterFunc, exitFunc, arg)
                    (if referenceEq(fargs1, fargs2)
                          inExp
                        else
                          PARTEVALFUNCTION(cref, fargs2)
                        end, arg)
                  end

                  (ARRAY(arrayExp = expl1), _, _, arg)  => begin
                      (expl2, arg) = traverseExpListBidir(expl1, enterFunc, exitFunc, arg)
                    (if referenceEq(expl1, expl2)
                          inExp
                        else
                          ARRAY(expl2)
                        end, arg)
                  end

                  (MATRIX(matrix = mat_expl), _, _, arg)  => begin
                      (mat_expl, arg) = ListUtil.map2FoldCheckReferenceEq(mat_expl, traverseExpListBidir, enterFunc, exitFunc, arg)
                    (MATRIX(mat_expl), arg)
                  end

                  (RANGE(start = e1, step = oe1, stop = e2), _, _, arg)  => begin
                      (e1m, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (oe1m, arg) = traverseExpOptBidir(oe1, enterFunc, exitFunc, arg)
                      (e2m, arg) = traverseExpBidir(e2, enterFunc, exitFunc, arg)
                    (if referenceEq(e1, e1m) && referenceEq(e2, e2m) && referenceEq(oe1, oe1m)
                          inExp
                        else
                          RANGE(e1m, oe1m, e2m)
                        end, arg)
                  end

                  (END(__), _, _, _)  => begin
                    (inExp, inArg)
                  end

                  (TUPLE(expressions = expl1), _, _, arg)  => begin
                      (expl2, arg) = traverseExpListBidir(expl1, enterFunc, exitFunc, arg)
                    (if referenceEq(expl1, expl2)
                          inExp
                        else
                          TUPLE(expl2)
                        end, arg)
                  end

                  (AS(id = id, exp = e1), _, _, arg)  => begin
                      (e1m, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                    (if referenceEq(e1, e1m)
                          inExp
                        else
                          AS(id, e1m)
                        end, arg)
                  end

                  (CONS(head = e1, rest = e2), _, _, arg)  => begin
                      (e1m, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (e2m, arg) = traverseExpBidir(e2, enterFunc, exitFunc, arg)
                    (if referenceEq(e1, e1m) && referenceEq(e2, e2m)
                          inExp
                        else
                          CONS(e1m, e2m)
                        end, arg)
                  end

                  (MATCHEXP(matchTy = match_ty, inputExp = e1, localDecls = match_decls, cases = match_cases, comment = cmt), _, _, arg)  => begin
                      (e1, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (match_cases, arg) = ListUtil.map2FoldCheckReferenceEq(match_cases, traverseMatchCase, enterFunc, exitFunc, arg)
                    (MATCHEXP(match_ty, e1, match_decls, match_cases, cmt), arg)
                  end

                  (LIST(exps = expl1), _, _, arg)  => begin
                      (expl2, arg) = traverseExpListBidir(expl1, enterFunc, exitFunc, arg)
                    (if referenceEq(expl1, expl2)
                          inExp
                        else
                          LIST(expl2)
                        end, arg)
                  end

                  (CODE(__), _, _, _)  => begin
                    (inExp, inArg)
                  end

                  (DOT(__), _, _, arg)  => begin
                      (e1, arg) = traverseExpBidir(inExp.exp, enterFunc, exitFunc, arg)
                      (e2, arg) = traverseExpBidir(inExp.index, enterFunc, exitFunc, arg)
                    (if referenceEq(inExp.exp, e1) && referenceEq(inExp.index, e2)
                          inExp
                        else
                          DOT(e1, e2)
                        end, arg)
                  end

                  _  => begin
                        (_, _, enterName) = System.dladdr(enterFunc)
                        (_, _, exitName) = System.dladdr(exitFunc)
                        error_msg = "in traverseExpBidirSubExps(" + enterName + ", " + exitName + ") - Unknown expression: "
                        error_msg = error_msg + Dump.printExpStr(inExp)
                        Error.addMessage(Error.INTERNAL_ERROR, list(error_msg))
                      fail()
                  end
                end
              end
          (e, arg)
        end

         #= Helper function to traverseExpBidirSubExps. Traverses any expressions in a
          component reference (i.e. in it's subscripts). =#
        function traverseExpBidirCref(inCref::ComponentRef, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{ComponentRef, Argument}
              local arg::Argument
              local outCref::ComponentRef

              (outCref, arg) = begin
                  local name::Ident
                  local cr1::ComponentRef
                  local cr2::ComponentRef
                  local subs1::List{Subscript}
                  local subs2::List{Subscript}
                  local tup::Tuple{FuncType, FuncType, Argument}
                @match (inCref, enterFunc, exitFunc, inArg) begin
                  (CREF_FULLYQUALIFIED(componentRef = cr1), _, _, arg)  => begin
                      (cr2, arg) = traverseExpBidirCref(cr1, enterFunc, exitFunc, arg)
                    (if referenceEq(cr1, cr2)
                          inCref
                        else
                          crefMakeFullyQualified(cr2)
                        end, arg)
                  end

                  (CREF_QUAL(name = name, subscripts = subs1, componentRef = cr1), _, _, arg)  => begin
                      (subs2, arg) = ListUtil.map2FoldCheckReferenceEq(subs1, traverseExpBidirSubs, enterFunc, exitFunc, arg)
                      (cr2, arg) = traverseExpBidirCref(cr1, enterFunc, exitFunc, arg)
                    (if referenceEq(cr1, cr2) && referenceEq(subs1, subs2)
                          inCref
                        else
                          CREF_QUAL(name, subs2, cr2)
                        end, arg)
                  end

                  (CREF_IDENT(name = name, subscripts = subs1), _, _, arg)  => begin
                      (subs2, arg) = ListUtil.map2FoldCheckReferenceEq(subs1, traverseExpBidirSubs, enterFunc, exitFunc, arg)
                    (if referenceEq(subs1, subs2)
                          inCref
                        else
                          CREF_IDENT(name, subs2)
                        end, arg)
                  end

                  (ALLWILD(__), _, _, _)  => begin
                    (inCref, inArg)
                  end

                  (WILD(__), _, _, _)  => begin
                    (inCref, inArg)
                  end
                end
              end
          (outCref, arg)
        end

         #= Helper function to traverseExpBidirCref. Traverses expressions in a
          subscript. =#
        function traverseExpBidirSubs(inSubscript::Subscript, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{Subscript, Argument}
              local arg::Argument
              local outSubscript::Subscript

              (outSubscript, arg) = begin
                  local e1::Exp
                  local e2::Exp
                @match (inSubscript, enterFunc, exitFunc, inArg) begin
                  (SUBSCRIPT(subscript = e1), _, _, arg)  => begin
                      (e2, arg) = traverseExpBidir(e1, enterFunc, exitFunc, inArg)
                    (if referenceEq(e1, e2)
                          inSubscript
                        else
                          SUBSCRIPT(e2)
                        end, arg)
                  end

                  (NOSUB(__), _, _, _)  => begin
                    (inSubscript, inArg)
                  end
                end
              end
          (outSubscript, arg)
        end

         #= Helper function to traverseExpBidirSubExps. Traverses the expressions in an
          elseif branch. =#
        function traverseExpBidirElseIf(inElseIf::Tuple{<:Exp, Exp}, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{Tuple{Exp, Exp}, Argument}
              local arg::Argument
              local outElseIf::Tuple{Exp, Exp}

              local e1::Exp
              local e2::Exp
              local tup::Tuple{FuncType, FuncType, Argument}

              (e1, e2) = inElseIf
              (e1, arg) = traverseExpBidir(e1, enterFunc, exitFunc, inArg)
              (e2, arg) = traverseExpBidir(e2, enterFunc, exitFunc, arg)
              outElseIf = (e1, e2)
          (outElseIf, arg)
        end

         #= Helper function to traverseExpBidirSubExps. Traverses the expressions in a
          list of function argument. =#
        function traverseExpBidirFunctionArgs(inArgs::FunctionArgs, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{FunctionArgs, Argument}
              local outArg::Argument
              local outArgs::FunctionArgs

              (outArgs, outArg) = begin
                  local e1::Exp
                  local e2::Exp
                  local expl1::List{Exp}
                  local expl2::List{Exp}
                  local named_args1::List{NamedArg}
                  local named_args2::List{NamedArg}
                  local iters1::ForIterators
                  local iters2::ForIterators
                  local arg::Argument
                  local iterType::ReductionIterType
                @match (inArgs, enterFunc, exitFunc, inArg) begin
                  (FUNCTIONARGS(args = expl1, argNames = named_args1), _, _, arg)  => begin
                      (expl2, arg) = traverseExpListBidir(expl1, enterFunc, exitFunc, arg)
                      (named_args2, arg) = ListUtil.map2FoldCheckReferenceEq(named_args1, traverseExpBidirNamedArg, enterFunc, exitFunc, arg)
                    (if referenceEq(expl1, expl2) && referenceEq(named_args1, named_args2)
                          inArgs
                        else
                          FUNCTIONARGS(expl2, named_args2)
                        end, arg)
                  end

                  (FOR_ITER_FARG(e1, iterType, iters1), _, _, arg)  => begin
                      (e2, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (iters2, arg) = ListUtil.map2FoldCheckReferenceEq(iters1, traverseExpBidirIterator, enterFunc, exitFunc, arg)
                    (if referenceEq(e1, e2) && referenceEq(iters1, iters2)
                          inArgs
                        else
                          FOR_ITER_FARG(e2, iterType, iters2)
                        end, arg)
                  end
                end
              end
          (outArgs, outArg)
        end

         #= Helper function to traverseExpBidirFunctionArgs. Traverses the expressions in
          a named function argument. =#
        function traverseExpBidirNamedArg(inArg::NamedArg, enterFunc::FuncType, exitFunc::FuncType, inExtra::Argument) ::Tuple{NamedArg, Argument}
              local outExtra::Argument
              local outArg::NamedArg

              local name::Ident
              local value1::Exp
              local value2::Exp

              @match NAMEDARG(name, value1) = inArg
              (value2, outExtra) = traverseExpBidir(value1, enterFunc, exitFunc, inExtra)
              outArg = if referenceEq(value1, value2)
                    inArg
                  else
                    NAMEDARG(name, value2)
                  end
          (outArg, outExtra)
        end

         #= Helper function to traverseExpBidirFunctionArgs. Traverses the expressions in
          an iterator. =#
        function traverseExpBidirIterator(inIterator::ForIterator, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{ForIterator, Argument}
              local outArg::Argument
              local outIterator::ForIterator

              local name::Ident
              local guardExp1::Option{Exp}
              local guardExp2::Option{Exp}
              local range1::Option{Exp}
              local range2::Option{Exp}

              @match ITERATOR(name = name, guardExp = guardExp1, range = range1) = inIterator
              (guardExp2, outArg) = traverseExpOptBidir(guardExp1, enterFunc, exitFunc, inArg)
              (range2, outArg) = traverseExpOptBidir(range1, enterFunc, exitFunc, outArg)
              outIterator = if referenceEq(guardExp1, guardExp2) && referenceEq(range1, range2)
                    inIterator
                  else
                    ITERATOR(name, guardExp2, range2)
                  end
          (outIterator, outArg)
        end

        function traverseMatchCase(inMatchCase::Case, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{Case, Argument}
              local outArg::Argument
              local outMatchCase::Case

              (outMatchCase, outArg) = begin
                  local arg::Argument
                  local pattern::Exp
                  local result::Exp
                  local info::Info
                  local resultInfo::Info
                  local pinfo::Info
                  local ldecls::List{ElementItem}
                  local cp::ClassPart
                  local cmt::Option{String}
                  local patternGuard::Option{Exp}
                @match (inMatchCase, enterFunc, exitFunc, inArg) begin
                  (CASE(pattern, patternGuard, pinfo, ldecls, cp, result, resultInfo, cmt, info), _, _, arg)  => begin
                      (pattern, arg) = traverseExpBidir(pattern, enterFunc, exitFunc, arg)
                      (patternGuard, arg) = traverseExpOptBidir(patternGuard, enterFunc, exitFunc, arg)
                      (cp, arg) = traverseClassPartBidir(cp, enterFunc, exitFunc, arg)
                      (result, arg) = traverseExpBidir(result, enterFunc, exitFunc, arg)
                    (CASE(pattern, patternGuard, pinfo, ldecls, cp, result, resultInfo, cmt, info), arg)
                  end

                  (ELSE(localDecls = ldecls, classPart = cp, result = result, resultInfo = resultInfo, comment = cmt, info = info), _, _, arg)  => begin
                      (cp, arg) = traverseClassPartBidir(cp, enterFunc, exitFunc, arg)
                      (result, arg) = traverseExpBidir(result, enterFunc, exitFunc, arg)
                    (ELSE(ldecls, cp, result, resultInfo, cmt, info), arg)
                  end
                end
              end
          (outMatchCase, outArg)
        end

        function traverseClassPartBidir(cp::ClassPart, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{ClassPart, Argument}
              local outArg::Argument
              local outCp::ClassPart

              (outCp, outArg) = begin
                  local algs::List{AlgorithmItem}
                  local eqs::List{EquationItem}
                  local arg::Argument
                @match (cp, enterFunc, exitFunc, inArg) begin
                  (ALGORITHMS(algs), _, _, arg)  => begin
                      (algs, arg) = ListUtil.map2FoldCheckReferenceEq(algs, traverseAlgorithmItemBidir, enterFunc, exitFunc, arg)
                    (ALGORITHMS(algs), arg)
                  end

                  (EQUATIONS(eqs), _, _, arg)  => begin
                      (eqs, arg) = ListUtil.map2FoldCheckReferenceEq(eqs, traverseEquationItemBidir, enterFunc, exitFunc, arg)
                    (EQUATIONS(eqs), arg)
                  end
                end
              end
          (outCp, outArg)
        end

        function traverseEquationItemListBidir(inEquationItems::List{<:EquationItem}, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{List{EquationItem}, Argument}
              local outArg::Argument
              local outEquationItems::List{EquationItem}

              (outEquationItems, outArg) = ListUtil.map2FoldCheckReferenceEq(inEquationItems, traverseEquationItemBidir, enterFunc, exitFunc, inArg)
          (outEquationItems, outArg)
        end

        function traverseAlgorithmItemListBidir(inAlgs::List{<:AlgorithmItem}, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{List{AlgorithmItem}, Argument}
              local outArg::Argument
              local outAlgs::List{AlgorithmItem}

              (outAlgs, outArg) = ListUtil.map2FoldCheckReferenceEq(inAlgs, traverseAlgorithmItemBidir, enterFunc, exitFunc, inArg)
          (outAlgs, outArg)
        end

        function traverseAlgorithmItemBidir(inAlgorithmItem::AlgorithmItem, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{AlgorithmItem, Argument}
              local outArg::Argument
              local outAlgorithmItem::AlgorithmItem

              (outAlgorithmItem, outArg) = begin
                  local arg::Argument
                  local alg::Algorithm
                  local cmt::Option{Comment}
                  local info::Info
                @match (inAlgorithmItem, enterFunc, exitFunc, inArg) begin
                  (ALGORITHMITEM(algorithm_ = alg, comment = cmt, info = info), _, _, arg)  => begin
                      (alg, arg) = traverseAlgorithmBidir(alg, enterFunc, exitFunc, arg)
                    (ALGORITHMITEM(alg, cmt, info), arg)
                  end

                  (ALGORITHMITEMCOMMENT(__), _, _, _)  => begin
                    (inAlgorithmItem, inArg)
                  end
                end
              end
          (outAlgorithmItem, outArg)
        end

        function traverseEquationItemBidir(inEquationItem::EquationItem, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{EquationItem, Argument}
              local outArg::Argument
              local outEquationItem::EquationItem

              (outEquationItem, outArg) = begin
                  local arg::Argument
                  local eq::Equation
                  local cmt::Option{Comment}
                  local info::Info
                @match (inEquationItem, enterFunc, exitFunc, inArg) begin
                  (EQUATIONITEM(equation_ = eq, comment = cmt, info = info), _, _, arg)  => begin
                      (eq, arg) = traverseEquationBidir(eq, enterFunc, exitFunc, arg)
                    (EQUATIONITEM(eq, cmt, info), arg)
                  end
                end
              end
          (outEquationItem, outArg)
        end

        function traverseEquationBidir(inEquation::Equation, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{Equation, Argument}
              local outArg::Argument
              local outEquation::Equation

              (outEquation, outArg) = begin
                  local arg::Argument
                  local e1::Exp
                  local e2::Exp
                  local eqil1::List{EquationItem}
                  local eqil2::List{EquationItem}
                  local else_branch::List{Tuple{Exp, List{EquationItem}}}
                  local cref1::ComponentRef
                  local cref2::ComponentRef
                  local iters::ForIterators
                  local func_args::FunctionArgs
                  local eq::EquationItem
                @match (inEquation, enterFunc, exitFunc, inArg) begin
                  (EQ_IF(ifExp = e1, equationTrueItems = eqil1, elseIfBranches = else_branch, equationElseItems = eqil2), _, _, arg)  => begin
                      (e1, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (eqil1, arg) = traverseEquationItemListBidir(eqil1, enterFunc, exitFunc, arg)
                      (else_branch, arg) = ListUtil.map2FoldCheckReferenceEq(else_branch, traverseEquationBidirElse, enterFunc, exitFunc, arg)
                      (eqil2, arg) = traverseEquationItemListBidir(eqil2, enterFunc, exitFunc, arg)
                    (EQ_IF(e1, eqil1, else_branch, eqil2), arg)
                  end

                  (EQ_EQUALS(leftSide = e1, rightSide = e2), _, _, arg)  => begin
                      (e1, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (e2, arg) = traverseExpBidir(e2, enterFunc, exitFunc, arg)
                    (EQ_EQUALS(e1, e2), arg)
                  end

                  (EQ_PDE(leftSide = e1, rightSide = e2, domain = cref1), _, _, arg)  => begin
                      (e1, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (e2, arg) = traverseExpBidir(e2, enterFunc, exitFunc, arg)
                      cref1 = traverseExpBidirCref(cref1, enterFunc, exitFunc, arg)
                    (EQ_PDE(e1, e2, cref1), arg)
                  end

                  (EQ_CONNECT(connector1 = cref1, connector2 = cref2), _, _, arg)  => begin
                      (cref1, arg) = traverseExpBidirCref(cref1, enterFunc, exitFunc, arg)
                      (cref2, arg) = traverseExpBidirCref(cref2, enterFunc, exitFunc, arg)
                    (EQ_CONNECT(cref1, cref2), arg)
                  end

                  (EQ_FOR(iterators = iters, forEquations = eqil1), _, _, arg)  => begin
                      (iters, arg) = ListUtil.map2FoldCheckReferenceEq(iters, traverseExpBidirIterator, enterFunc, exitFunc, arg)
                      (eqil1, arg) = traverseEquationItemListBidir(eqil1, enterFunc, exitFunc, arg)
                    (EQ_FOR(iters, eqil1), arg)
                  end

                  (EQ_WHEN_E(whenExp = e1, whenEquations = eqil1, elseWhenEquations = else_branch), _, _, arg)  => begin
                      (e1, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (eqil1, arg) = traverseEquationItemListBidir(eqil1, enterFunc, exitFunc, arg)
                      (else_branch, arg) = ListUtil.map2FoldCheckReferenceEq(else_branch, traverseEquationBidirElse, enterFunc, exitFunc, arg)
                    (EQ_WHEN_E(e1, eqil1, else_branch), arg)
                  end

                  (EQ_NORETCALL(functionName = cref1, functionArgs = func_args), _, _, arg)  => begin
                      (cref1, arg) = traverseExpBidirCref(cref1, enterFunc, exitFunc, arg)
                      (func_args, arg) = traverseExpBidirFunctionArgs(func_args, enterFunc, exitFunc, arg)
                    (EQ_NORETCALL(cref1, func_args), arg)
                  end

                  (EQ_FAILURE(equ = eq), _, _, arg)  => begin
                      (eq, arg) = traverseEquationItemBidir(eq, enterFunc, exitFunc, arg)
                    (EQ_FAILURE(eq), arg)
                  end
                end
              end
          (outEquation, outArg)
        end

        function traverseEquationBidirElse(inElse::Tuple{<:Exp, List{<:EquationItem}}, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{Tuple{Exp, List{EquationItem}}, Argument}
              local arg::Argument
              local outElse::Tuple{Exp, List{EquationItem}}

              local e::Exp
              local eqil::List{EquationItem}

              (e, eqil) = inElse
              (e, arg) = traverseExpBidir(e, enterFunc, exitFunc, inArg)
              (eqil, arg) = traverseEquationItemListBidir(eqil, enterFunc, exitFunc, arg)
              outElse = (e, eqil)
          (outElse, arg)
        end

        function traverseAlgorithmBidirElse(inElse::Tuple{<:Exp, List{<:AlgorithmItem}}, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{Tuple{Exp, List{AlgorithmItem}}, Argument}
              local arg::Argument
              local outElse::Tuple{Exp, List{AlgorithmItem}}

              local e::Exp
              local algs::List{AlgorithmItem}

              (e, algs) = inElse
              (e, arg) = traverseExpBidir(e, enterFunc, exitFunc, inArg)
              (algs, arg) = traverseAlgorithmItemListBidir(algs, enterFunc, exitFunc, arg)
              outElse = (e, algs)
          (outElse, arg)
        end

        function traverseAlgorithmBidir(inAlg::Algorithm, enterFunc::FuncType, exitFunc::FuncType, inArg::Argument) ::Tuple{Algorithm, Argument}
              local outArg::Argument
              local outAlg::Algorithm

              (outAlg, outArg) = begin
                  local arg::Argument
                  local e1::Exp
                  local e2::Exp
                  local algs1::List{AlgorithmItem}
                  local algs2::List{AlgorithmItem}
                  local else_branch::List{Tuple{Exp, List{AlgorithmItem}}}
                  local cref1::ComponentRef
                  local cref2::ComponentRef
                  local iters::ForIterators
                  local func_args::FunctionArgs
                  local alg::AlgorithmItem
                @match (inAlg, enterFunc, exitFunc, inArg) begin
                  (ALG_ASSIGN(e1, e2), _, _, arg)  => begin
                      (e1, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (e2, arg) = traverseExpBidir(e2, enterFunc, exitFunc, arg)
                    (ALG_ASSIGN(e1, e2), arg)
                  end

                  (ALG_IF(e1, algs1, else_branch, algs2), _, _, arg)  => begin
                      (e1, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (algs1, arg) = traverseAlgorithmItemListBidir(algs1, enterFunc, exitFunc, arg)
                      (else_branch, arg) = ListUtil.map2FoldCheckReferenceEq(else_branch, traverseAlgorithmBidirElse, enterFunc, exitFunc, arg)
                      (algs2, arg) = traverseAlgorithmItemListBidir(algs2, enterFunc, exitFunc, arg)
                    (ALG_IF(e1, algs1, else_branch, algs2), arg)
                  end

                  (ALG_FOR(iters, algs1), _, _, arg)  => begin
                      (iters, arg) = ListUtil.map2FoldCheckReferenceEq(iters, traverseExpBidirIterator, enterFunc, exitFunc, arg)
                      (algs1, arg) = traverseAlgorithmItemListBidir(algs1, enterFunc, exitFunc, arg)
                    (ALG_FOR(iters, algs1), arg)
                  end

                  (ALG_PARFOR(iters, algs1), _, _, arg)  => begin
                      (iters, arg) = ListUtil.map2FoldCheckReferenceEq(iters, traverseExpBidirIterator, enterFunc, exitFunc, arg)
                      (algs1, arg) = traverseAlgorithmItemListBidir(algs1, enterFunc, exitFunc, arg)
                    (ALG_PARFOR(iters, algs1), arg)
                  end

                  (ALG_WHILE(e1, algs1), _, _, arg)  => begin
                      (e1, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (algs1, arg) = traverseAlgorithmItemListBidir(algs1, enterFunc, exitFunc, arg)
                    (ALG_WHILE(e1, algs1), arg)
                  end

                  (ALG_WHEN_A(e1, algs1, else_branch), _, _, arg)  => begin
                      (e1, arg) = traverseExpBidir(e1, enterFunc, exitFunc, arg)
                      (algs1, arg) = traverseAlgorithmItemListBidir(algs1, enterFunc, exitFunc, arg)
                      (else_branch, arg) = ListUtil.map2FoldCheckReferenceEq(else_branch, traverseAlgorithmBidirElse, enterFunc, exitFunc, arg)
                    (ALG_WHEN_A(e1, algs1, else_branch), arg)
                  end

                  (ALG_NORETCALL(cref1, func_args), _, _, arg)  => begin
                      (cref1, arg) = traverseExpBidirCref(cref1, enterFunc, exitFunc, arg)
                      (func_args, arg) = traverseExpBidirFunctionArgs(func_args, enterFunc, exitFunc, arg)
                    (ALG_NORETCALL(cref1, func_args), arg)
                  end

                  (ALG_RETURN(__), _, _, arg)  => begin
                    (inAlg, arg)
                  end

                  (ALG_BREAK(__), _, _, arg)  => begin
                    (inAlg, arg)
                  end

                  (ALG_CONTINUE(__), _, _, arg)  => begin
                    (inAlg, arg)
                  end

                  (ALG_FAILURE(algs1), _, _, arg)  => begin
                      (algs1, arg) = traverseAlgorithmItemListBidir(algs1, enterFunc, exitFunc, arg)
                    (ALG_FAILURE(algs1), arg)
                  end

                  (ALG_TRY(algs1, algs2), _, _, arg)  => begin
                      (algs1, arg) = traverseAlgorithmItemListBidir(algs1, enterFunc, exitFunc, arg)
                      (algs2, arg) = traverseAlgorithmItemListBidir(algs2, enterFunc, exitFunc, arg)
                    (ALG_TRY(algs1, algs2), arg)
                  end
                end
              end
          (outAlg, outArg)
        end

        function makeIdentPathFromString(s::String) ::Path
              local p::Path

              p = IDENT(s)
          p
        end

        function makeQualifiedPathFromStrings(s1::String, s2::String) ::Path
              local p::Path

              p = QUALIFIED(s1, IDENT(s2))
          p
        end

         #= returns the class name of a Class as a Path =#
        function className(cl::Class) ::Path
              local name::Path

              local id::String

              @match CLASS(name = id) = cl
              name = IDENT(id)
          name
        end

        function isClassNamed(inName::String, inClass::Class) ::Bool
              local outIsNamed::Bool

              outIsNamed = begin
                @match inClass begin
                  CLASS(__)  => begin
                    inName == inClass.name
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsNamed
        end

         #= The ElementSpec type contains the name of the element, and this function
           extracts this name. =#
        function elementSpecName(inElementSpec::ElementSpec) ::Ident
              local outIdent::Ident

              outIdent = begin
                  local n::Ident
                @match inElementSpec begin
                  CLASSDEF(class_ = CLASS(name = n))  => begin
                    n
                  end

                  COMPONENTS(components = COMPONENTITEM(component = COMPONENT(name = n)) <|  nil())  => begin
                    n
                  end
                end
              end
          outIdent
        end

        function isClassdef(inElement::Element) ::Bool
              local b::Bool

              b = begin
                @match inElement begin
                  ELEMENT(specification = CLASSDEF(__))  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          b
        end

         #= This function takes a Import and prints it as a flat-string. =#
        function printImportString(imp::Import) ::String
              local ostring::String

              ostring = begin
                  local path::Path
                  local name::String
                @match imp begin
                  NAMED_IMPORT(name, _)  => begin
                    name
                  end

                  QUAL_IMPORT(path)  => begin
                      name = pathString(path)
                    name
                  end

                  UNQUAL_IMPORT(path)  => begin
                      name = pathString(path)
                    name
                  end
                end
              end
          ostring
        end

         #= returns the string of an expression if it is a string constant. =#
        function expString(exp::Exp) ::String
              local str::String

              @match STRING(str) = exp
          str
        end

         #= returns the componentRef of an expression if matches. =#
        function expCref(exp::Exp) ::ComponentRef
              local cr::ComponentRef

              @match CREF(cr) = exp
          cr
        end

         #= returns the componentRef of an expression if matches. =#
        function crefExp(cr::ComponentRef) ::Exp
              local exp::Exp

              exp = CREF(cr)
          exp
        end

        function expComponentRefStr(aexp::Exp) ::String
              local outString::String

              outString = printComponentRefStr(expCref(aexp))
          outString
        end

        function printComponentRefStr(cr::ComponentRef) ::String
              local ostring::String

              ostring = begin
                  local s1::String
                  local s2::String
                  local child::ComponentRef
                @match cr begin
                  CREF_IDENT(s1, _)  => begin
                    s1
                  end

                  CREF_QUAL(s1, _, child)  => begin
                      s2 = printComponentRefStr(child)
                      s1 = s1 + "." + s2
                    s1
                  end

                  CREF_FULLYQUALIFIED(child)  => begin
                      s2 = printComponentRefStr(child)
                      s1 = "." + s2
                    s1
                  end

                  ALLWILD(__)  => begin
                    "__"
                  end

                  WILD(__)  => begin
                    "_"
                  end
                end
              end
          ostring
        end

         #= Returns true if two paths are equal. =#
        function pathEqual(inPath1::Path, inPath2::Path) ::Bool
              local outBoolean::Bool

              outBoolean = begin
                  local id1::String
                  local id2::String
                  local res::Bool
                  local path1::Path
                  local path2::Path
                   #=  fully qual vs. path
                   =#
                @match (inPath1, inPath2) begin
                  (FULLYQUALIFIED(path1), path2)  => begin
                    pathEqual(path1, path2)
                  end

                  (path1, FULLYQUALIFIED(path2))  => begin
                    pathEqual(path1, path2)
                  end

                  (IDENT(id1), IDENT(id2))  => begin
                    stringEq(id1, id2)
                  end

                  (QUALIFIED(id1, path1), QUALIFIED(id2, path2))  => begin
                      res = if stringEq(id1, id2)
                            pathEqual(path1, path2)
                          else
                            false
                          end
                    res
                  end

                  _  => begin
                      false
                  end
                end
              end
               #=  path vs. fully qual
               =#
               #=  ident vs. ident
               =#
               #=  qual ident vs. qual ident
               =#
               #=  other return false
               =#
          outBoolean
        end

         #= Author BZ 2009-01
           Check whether two type specs are equal or not. =#
        function typeSpecEqual(a::TypeSpec, b::TypeSpec) ::Bool
              local ob::Bool

              ob = begin
                  local p1::Path
                  local p2::Path
                  local oad1::Option{ArrayDim}
                  local oad2::Option{ArrayDim}
                  local lst1::List{TypeSpec}
                  local lst2::List{TypeSpec}
                  local i1::Ident
                  local i2::Ident
                  local pos1::ModelicaInteger
                  local pos2::ModelicaInteger
                   #=  first try full equality
                   =#
                @matchcontinue (a, b) begin
                  (TPATH(p1, oad1), TPATH(p2, oad2))  => begin
                      @match true = pathEqual(p1, p2)
                      @match true = optArrayDimEqual(oad1, oad2)
                    true
                  end

                  (TCOMPLEX(p1, lst1, oad1), TCOMPLEX(p2, lst2, oad2))  => begin
                      @match true = pathEqual(p1, p2)
                      @match true = ListUtil.isEqualOnTrue(lst1, lst2, typeSpecEqual)
                      @match true = optArrayDimEqual(oad1, oad2)
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          ob
        end

         #= Author BZ
           helper function for typeSpecEqual =#
        function optArrayDimEqual(oad1::Option{<:ArrayDim}, oad2::Option{<:ArrayDim}) ::Bool
              local b::Bool

              b = begin
                  local ad1::List{Subscript}
                  local ad2::List{Subscript}
                @matchcontinue (oad1, oad2) begin
                  (SOME(ad1), SOME(ad2))  => begin
                      @match true = ListUtil.isEqualOnTrue(ad1, ad2, subscriptEqual)
                    true
                  end

                  (NONE(), NONE())  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          b
        end

         #= This function simply converts a Path to a string. =#
        function typeSpecPathString(tp::TypeSpec) ::String
              local s::String

              s = begin
                  local p::Path
                @match tp begin
                  TCOMPLEX(path = p)  => begin
                    pathString(p)
                  end

                  TPATH(path = p)  => begin
                    pathString(p)
                  end
                end
              end
          s
        end

         #= Converts a TypeSpec to Path =#
        function typeSpecPath(tp::TypeSpec) ::Path
              local op::Path

              op = begin
                  local p::Path
                @match tp begin
                  TCOMPLEX(path = p)  => begin
                    p
                  end

                  TPATH(path = p)  => begin
                    p
                  end
                end
              end
          op
        end

         #= Returns the dimensions of a TypeSpec. =#
        function typeSpecDimensions(inTypeSpec::TypeSpec) ::ArrayDim
              local outDimensions::ArrayDim

              outDimensions = begin
                  local dim::ArrayDim
                @match inTypeSpec begin
                  TPATH(arrayDim = SOME(dim))  => begin
                    dim
                  end

                  TCOMPLEX(arrayDim = SOME(dim))  => begin
                    dim
                  end

                  _  => begin
                      nil
                  end
                end
              end
          outDimensions
        end

         #= This function simply converts a Path to a string. =#
        function pathString(path::Path, delimiter::String = ".", usefq::Bool = true, reverse::Bool = false) ::String
              local s::String

              local p1::Path
              local p2::Path
              local count::ModelicaInteger = 0
              local len::ModelicaInteger = 0
              local dlen::ModelicaInteger = stringLength(delimiter)
              local b::Bool

               #=  First, calculate the length of the string to be generated
               =#
              p1 = if usefq
                    path
                  else
                    makeNotFullyQualified(path)
                  end
              _ = begin
                @match p1 begin
                  IDENT(__)  => begin
                       #=  Do not allocate memory if we're just going to copy the only identifier
                       =#
                      s = p1.name
                      return
                    ()
                  end

                  _  => begin
                      ()
                  end
                end
              end
              p2 = p1
              b = true
              while b
                (p2, len, count, b) = begin
                  @match p2 begin
                    IDENT(__)  => begin
                      (p2, len + 1, count + stringLength(p2.name), false)
                    end

                    QUALIFIED(__)  => begin
                      (p2.path, len + 1, count + stringLength(p2.name), true)
                    end

                    FULLYQUALIFIED(__)  => begin
                      (p2.path, len + 1, count, true)
                    end
                  end
                end
              end
              s = pathStringWork(p1, (len - 1) * dlen + count, delimiter, dlen, reverse)
          s
        end

        function pathStringWork(inPath::Path, len::ModelicaInteger, delimiter::String, dlen::ModelicaInteger, reverse::Bool) ::String
              local s::String = ""

              local p::Path = inPath
              local b::Bool = true
              local count::ModelicaInteger = 0
               #=  Allocate a string of the exact required length
               =#
              local sb::System.StringAllocator = System.StringAllocator(len)

               #=  Fill the string
               =#
              while b
                (p, count, b) = begin
                  @match p begin
                    IDENT(__)  => begin
                        System.stringAllocatorStringCopy(sb, p.name, if reverse
                              len - count - stringLength(p.name)
                            else
                              count
                            end)
                      (p, count + stringLength(p.name), false)
                    end

                    QUALIFIED(__)  => begin
                        System.stringAllocatorStringCopy(sb, p.name, if reverse
                              len - count - dlen - stringLength(p.name)
                            else
                              count
                            end)
                        System.stringAllocatorStringCopy(sb, delimiter, if reverse
                              len - count - dlen
                            else
                              count + stringLength(p.name)
                            end)
                      (p.path, count + stringLength(p.name) + dlen, true)
                    end

                    FULLYQUALIFIED(__)  => begin
                        System.stringAllocatorStringCopy(sb, delimiter, if reverse
                              len - count - dlen
                            else
                              count
                            end)
                      (p.path, count + dlen, true)
                    end
                  end
                end
              end
               #=  Return the string
               =#
              s = System.stringAllocatorResult(sb, s)
          s
        end

          @ExtendedFunction pathStringNoQual pathString(usefq = false)

        function pathStringDefault(path::Path) ::String
              local s::String = pathString(path)
          s
        end

        function classNameCompare(c1::Class, c2::Class) ::ModelicaInteger
              local o::ModelicaInteger

              o = stringCompare(c1.name, c2.name)
          o
        end

        function classNameGreater(c1::Class, c2::Class) ::Bool
              local b::Bool

              b = stringCompare(c1.name, c2.name) > 0
          b
        end

        function pathCompare(ip1::Path, ip2::Path) ::ModelicaInteger
              local o::ModelicaInteger

              o = begin
                  local p1::Path
                  local p2::Path
                  local i1::String
                  local i2::String
                @match (ip1, ip2) begin
                  (FULLYQUALIFIED(p1), FULLYQUALIFIED(p2))  => begin
                    pathCompare(p1, p2)
                  end

                  (FULLYQUALIFIED(__), _)  => begin
                    1
                  end

                  (_, FULLYQUALIFIED(__))  => begin
                    -1
                  end

                  (QUALIFIED(i1, p1), QUALIFIED(i2, p2))  => begin
                      o = stringCompare(i1, i2)
                      o = if o == 0
                            pathCompare(p1, p2)
                          else
                            o
                          end
                    o
                  end

                  (QUALIFIED(__), _)  => begin
                    1
                  end

                  (_, QUALIFIED(__))  => begin
                    -1
                  end

                  (IDENT(i1), IDENT(i2))  => begin
                    stringCompare(i1, i2)
                  end
                end
              end
          o
        end

        function pathCompareNoQual(ip1::Path, ip2::Path) ::ModelicaInteger
              local o::ModelicaInteger

              o = begin
                  local p1::Path
                  local p2::Path
                  local i1::String
                  local i2::String
                @match (ip1, ip2) begin
                  (FULLYQUALIFIED(p1), p2)  => begin
                    pathCompareNoQual(p1, p2)
                  end

                  (p1, FULLYQUALIFIED(p2))  => begin
                    pathCompareNoQual(p1, p2)
                  end

                  (QUALIFIED(i1, p1), QUALIFIED(i2, p2))  => begin
                      o = stringCompare(i1, i2)
                      o = if o == 0
                            pathCompare(p1, p2)
                          else
                            o
                          end
                    o
                  end

                  (QUALIFIED(__), _)  => begin
                    1
                  end

                  (_, QUALIFIED(__))  => begin
                    -1
                  end

                  (IDENT(i1), IDENT(i2))  => begin
                    stringCompare(i1, i2)
                  end
                end
              end
          o
        end

         #= Hashes a path. =#
        function pathHashMod(path::Path, mod::ModelicaInteger) ::ModelicaInteger
              local hash::ModelicaInteger

               #=  hash := valueHashMod(path,mod);
               =#
               #=  print(pathString(path) + \" => \" + intString(hash) + \"\\n\");
               =#
               #=  hash := stringHashDjb2Mod(pathString(path),mod);
               =#
               #=  TODO: stringHashDjb2 is missing a default value for the seed; add this once we bootstrapped omc so we can use that function instead of our own hack
               =#
              hash = intAbs(intMod(pathHashModWork(path, 5381), mod))
          hash
        end

         #= Hashes a path. =#
        function pathHashModWork(path::Path, acc::ModelicaInteger) ::ModelicaInteger
              local hash::ModelicaInteger

              hash = begin
                  local p::Path
                  local s::String
                  local i::ModelicaInteger
                  local i2::ModelicaInteger
                @match (path, acc) begin
                  (FULLYQUALIFIED(p), _)  => begin
                    pathHashModWork(p, acc * 31 + 46)
                  end

                  (QUALIFIED(s, p), _)  => begin
                      i = stringHashDjb2(s)
                      i2 = acc * 31 + 46
                    pathHashModWork(p, i2 * 31 + i)
                  end

                  (IDENT(s), _)  => begin
                      i = stringHashDjb2(s)
                      i2 = acc * 31 + 46
                    i2 * 31 + i
                  end
                end
              end
               #= /* '.' */ =#
          hash
        end

         #= Returns a path converted to string or an empty string if nothing exist =#
        function optPathString(inPathOption::Option{<:Path}) ::String
              local outString::String

              outString = begin
                  local str::Ident
                  local p::Path
                @match inPathOption begin
                  NONE()  => begin
                    ""
                  end

                  SOME(p)  => begin
                      str = pathString(p)
                    str
                  end
                end
              end
          outString
        end

         #=  Changes a path to string. Uses the input string as separator.
          If the separtor exists in the string then it is doubled (sep _ then
          a_b changes to a__b) before delimiting
          (Replaces dots with that separator). And also unquotes each ident.
         =#
        function pathStringUnquoteReplaceDot(inPath::Path, repStr::String) ::String
              local outString::String

              local strlst::List{String}
              local rep_rep::String

              rep_rep = repStr + repStr
              strlst = pathToStringList(inPath)
              strlst = ListUtil.map2(strlst, System.stringReplace, repStr, rep_rep)
              strlst = ListUtil.map(strlst, System.unquoteIdentifier)
              outString = stringDelimitList(strlst, repStr)
          outString
        end

         #= Converts a string into a qualified path. =#
        function stringPath(str::String) ::Path
              local qualifiedPath::Path

              local paths::List{String}

              paths = Util.stringSplitAtChar(str, ".")
              qualifiedPath = stringListPath(paths)
          qualifiedPath
        end

         #= Converts a list of strings into a qualified path. =#
        function stringListPath(paths::List{<:String}) ::Path
              local qualifiedPath::Path

              qualifiedPath = begin
                  local str::String
                  local rest_str::List{String}
                  local p::Path
                @matchcontinue paths begin
                   nil()  => begin
                    fail()
                  end

                  str <|  nil()  => begin
                    IDENT(str)
                  end

                  str <| rest_str  => begin
                      p = stringListPath(rest_str)
                    QUALIFIED(str, p)
                  end
                end
              end
          qualifiedPath
        end

         #= Converts a list of strings into a qualified path, in reverse order.
           Ex: {'a', 'b', 'c'} => c.b.a =#
        function stringListPathReversed(inStrings::List{<:String}) ::Path
              local outPath::Path

              local id::String
              local rest_str::List{String}
              local path::Path

              @match _cons(id, rest_str) = inStrings
              path = IDENT(id)
              outPath = stringListPathReversed2(rest_str, path)
          outPath
        end

        function stringListPathReversed2(inStrings::List{<:String}, inAccumPath::Path) ::Path
              local outPath::Path

              outPath = begin
                  local id::String
                  local rest_str::List{String}
                  local path::Path
                @match (inStrings, inAccumPath) begin
                  ( nil(), _)  => begin
                    inAccumPath
                  end

                  (id <| rest_str, _)  => begin
                      path = QUALIFIED(id, inAccumPath)
                    stringListPathReversed2(rest_str, path)
                  end
                end
              end
          outPath
        end

         #= Returns the two last idents of a path =#
        function pathTwoLastIdents(inPath::Path) ::Path
              local outTwoLast::Path

              outTwoLast = begin
                  local p::Path
                @match inPath begin
                  QUALIFIED(path = IDENT(__))  => begin
                    inPath
                  end

                  QUALIFIED(path = p)  => begin
                    pathTwoLastIdents(p)
                  end

                  FULLYQUALIFIED(path = p)  => begin
                    pathTwoLastIdents(p)
                  end
                end
              end
          outTwoLast
        end

         #= Returns the last ident (after last dot) in a path =#
        function pathLastIdent(inPath::Path) ::String
              local outIdent::String

              outIdent = begin
                  local id::Ident
                  local p::Path
                @match inPath begin
                  QUALIFIED(path = p)  => begin
                    pathLastIdent(p)
                  end

                  IDENT(name = id)  => begin
                    id
                  end

                  FULLYQUALIFIED(path = p)  => begin
                    pathLastIdent(p)
                  end
                end
              end
          outIdent
        end

         #= Returns the last ident (after last dot) in a path =#
        function pathLast(path::Path) ::Path


              path = begin
                  local p::Path
                @match path begin
                  QUALIFIED(path = p)  => begin
                    pathLast(p)
                  end

                  IDENT(__)  => begin
                    path
                  end

                  FULLYQUALIFIED(path = p)  => begin
                    pathLast(p)
                  end
                end
              end
          path
        end

         #= Returns the first ident (before first dot) in a path =#
        function pathFirstIdent(inPath::Path) ::Ident
              local outIdent::Ident

              outIdent = begin
                  local n::Ident
                  local p::Path
                @match inPath begin
                  FULLYQUALIFIED(path = p)  => begin
                    pathFirstIdent(p)
                  end

                  QUALIFIED(name = n)  => begin
                    n
                  end

                  IDENT(name = n)  => begin
                    n
                  end
                end
              end
          outIdent
        end

        function pathFirstPath(inPath::Path) ::Path
              local outPath::Path

              outPath = begin
                  local n::Ident
                @match inPath begin
                  IDENT(__)  => begin
                    inPath
                  end

                  QUALIFIED(name = n)  => begin
                    IDENT(n)
                  end

                  FULLYQUALIFIED(path = outPath)  => begin
                    pathFirstPath(outPath)
                  end
                end
              end
          outPath
        end

        function pathSecondIdent(inPath::Path) ::Ident
              local outIdent::Ident

              outIdent = begin
                  local n::Ident
                  local p::Path
                @match inPath begin
                  QUALIFIED(path = QUALIFIED(name = n))  => begin
                    n
                  end

                  QUALIFIED(path = IDENT(name = n))  => begin
                    n
                  end

                  FULLYQUALIFIED(path = p)  => begin
                    pathSecondIdent(p)
                  end
                end
              end
          outIdent
        end

        function pathRest(inPath::Path) ::Path
              local outPath::Path

              outPath = begin
                @match inPath begin
                  QUALIFIED(path = outPath)  => begin
                    outPath
                  end

                  FULLYQUALIFIED(path = outPath)  => begin
                    pathRest(outPath)
                  end
                end
              end
          outPath
        end

         #= strips the same prefix paths and returns the stripped path. e.g pathStripSamePrefix(P.M.A, P.M.B) => A =#
        function pathStripSamePrefix(inPath1::Absyn.Path, inPath2::Absyn.Path) ::Absyn.Path
              local outPath::Absyn.Path

              outPath = begin
                  local ident1::Ident
                  local ident2::Ident
                  local path1::Absyn.Path
                  local path2::Absyn.Path
                @matchcontinue (inPath1, inPath2) begin
                  (_, _)  => begin
                      ident1 = pathFirstIdent(inPath1)
                      ident2 = pathFirstIdent(inPath2)
                      @match true = stringEq(ident1, ident2)
                      path1 = stripFirst(inPath1)
                      path2 = stripFirst(inPath2)
                    pathStripSamePrefix(path1, path2)
                  end

                  _  => begin
                      inPath1
                  end
                end
              end
          outPath
        end

         #= Returns the prefix of a path, i.e. this.is.a.path => this.is.a =#
        function pathPrefix(path::Path) ::Path
              local prefix::Path

              prefix = begin
                  local p::Path
                  local n::Ident
                @matchcontinue path begin
                  FULLYQUALIFIED(path = p)  => begin
                    pathPrefix(p)
                  end

                  QUALIFIED(name = n, path = IDENT(__))  => begin
                    IDENT(n)
                  end

                  QUALIFIED(name = n, path = p)  => begin
                      p = pathPrefix(p)
                    QUALIFIED(n, p)
                  end
                end
              end
          prefix
        end

         #= Prefixes a path with an identifier. =#
        function prefixPath(prefix::Ident, path::Path) ::Path
              local outPath::Path

              outPath = QUALIFIED(prefix, path)
          outPath
        end

         #= Prefixes an optional path with an identifier. =#
        function prefixOptPath(prefix::Ident, optPath::Option{<:Path}) ::Option{Path}
              local outPath::Option{Path}

              outPath = begin
                  local path::Path
                @match (prefix, optPath) begin
                  (_, NONE())  => begin
                    SOME(IDENT(prefix))
                  end

                  (_, SOME(path))  => begin
                    SOME(QUALIFIED(prefix, path))
                  end
                end
              end
          outPath
        end

         #= Adds a suffix to a path. Ex:
             suffixPath(a.b.c, 'd') => a.b.c.d =#
        function suffixPath(inPath::Path, inSuffix::Ident) ::Path
              local outPath::Path

              outPath = begin
                  local name::Ident
                  local path::Path
                @match (inPath, inSuffix) begin
                  (IDENT(name), _)  => begin
                    QUALIFIED(name, IDENT(inSuffix))
                  end

                  (QUALIFIED(name, path), _)  => begin
                      path = suffixPath(path, inSuffix)
                    QUALIFIED(name, path)
                  end

                  (FULLYQUALIFIED(path), _)  => begin
                      path = suffixPath(path, inSuffix)
                    FULLYQUALIFIED(path)
                  end
                end
              end
          outPath
        end

         #= returns true if suffix_path is a suffix of path =#
        function pathSuffixOf(suffix_path::Path, path::Path) ::Bool
              local res::Bool

              res = begin
                  local p::Path
                @matchcontinue (suffix_path, path) begin
                  (_, _)  => begin
                      @match true = pathEqual(suffix_path, path)
                    true
                  end

                  (_, FULLYQUALIFIED(path = p))  => begin
                    pathSuffixOf(suffix_path, p)
                  end

                  (_, QUALIFIED(path = p))  => begin
                    pathSuffixOf(suffix_path, p)
                  end

                  _  => begin
                      false
                  end
                end
              end
          res
        end

         #= returns true if suffix_path is a suffix of path =#
        function pathSuffixOfr(path::Path, suffix_path::Path) ::Bool
              local res::Bool

              res = pathSuffixOf(suffix_path, path)
          res
        end

        function pathToStringList(path::Path) ::List{String}
              local outPaths::List{String}

              outPaths = listReverse(pathToStringListWork(path, nil))
          outPaths
        end

        function pathToStringListWork(path::Path, acc::List{<:String}) ::List{String}
              local outPaths::List{String}

              outPaths = begin
                  local n::String
                  local p::Path
                  local strings::List{String}
                @match (path, acc) begin
                  (IDENT(name = n), _)  => begin
                    _cons(n, acc)
                  end

                  (FULLYQUALIFIED(path = p), _)  => begin
                    pathToStringListWork(p, acc)
                  end

                  (QUALIFIED(name = n, path = p), _)  => begin
                    pathToStringListWork(p, _cons(n, acc))
                  end
                end
              end
          outPaths
        end

         #=
          Replaces the first part of a path with a replacement path:
          (a.b.c, d.e) => d.e.b.c
          (a, b.c.d) => b.c.d
         =#
        function pathReplaceFirstIdent(path::Path, replPath::Path) ::Path
              local outPath::Path

              outPath = begin
                  local p::Path
                   #=  Should not be possible to replace FQ paths
                   =#
                @match (path, replPath) begin
                  (QUALIFIED(path = p), _)  => begin
                    joinPaths(replPath, p)
                  end

                  (IDENT(__), _)  => begin
                    replPath
                  end
                end
              end
          outPath
        end

         #= Function for appending subscripts at end of last ident =#
        function addSubscriptsLast(icr::ComponentRef, i::List{<:Subscript}) ::ComponentRef
              local ocr::ComponentRef

              ocr = begin
                  local subs::List{Subscript}
                  local id::String
                  local cr::ComponentRef
                @match (icr, i) begin
                  (CREF_IDENT(id, subs), _)  => begin
                    CREF_IDENT(id, listAppend(subs, i))
                  end

                  (CREF_QUAL(id, subs, cr), _)  => begin
                      cr = addSubscriptsLast(cr, i)
                    CREF_QUAL(id, subs, cr)
                  end

                  (CREF_FULLYQUALIFIED(cr), _)  => begin
                      cr = addSubscriptsLast(cr, i)
                    crefMakeFullyQualified(cr)
                  end
                end
              end
          ocr
        end

         #=
          Replaces the first part of a cref with a replacement path:
          (a[4].b.c[3], d.e) => d.e[4].b.c[3]
          (a[3], b.c.d) => b.c.d[3]
         =#
        function crefReplaceFirstIdent(icref::ComponentRef, replPath::Path) ::ComponentRef
              local outCref::ComponentRef

              outCref = begin
                  local subs::List{Subscript}
                  local cr::ComponentRef
                  local cref::ComponentRef
                @match (icref, replPath) begin
                  (CREF_FULLYQUALIFIED(componentRef = cr), _)  => begin
                      cr = crefReplaceFirstIdent(cr, replPath)
                    crefMakeFullyQualified(cr)
                  end

                  (CREF_QUAL(componentRef = cr, subscripts = subs), _)  => begin
                      cref = pathToCref(replPath)
                      cref = addSubscriptsLast(cref, subs)
                    joinCrefs(cref, cr)
                  end

                  (CREF_IDENT(subscripts = subs), _)  => begin
                      cref = pathToCref(replPath)
                      cref = addSubscriptsLast(cref, subs)
                    cref
                  end
                end
              end
          outCref
        end

         #= Returns true if prefixPath is a prefix of path, false otherwise. =#
        function pathPrefixOf(prefixPath::Path, path::Path) ::Bool
              local isPrefix::Bool

              isPrefix = begin
                  local p::Path
                  local p2::Path
                  local id::String
                  local id2::String
                @matchcontinue (prefixPath, path) begin
                  (FULLYQUALIFIED(p), p2)  => begin
                    pathPrefixOf(p, p2)
                  end

                  (p, FULLYQUALIFIED(p2))  => begin
                    pathPrefixOf(p, p2)
                  end

                  (IDENT(id), IDENT(id2))  => begin
                    stringEq(id, id2)
                  end

                  (IDENT(id), QUALIFIED(name = id2))  => begin
                    stringEq(id, id2)
                  end

                  (QUALIFIED(id, p), QUALIFIED(id2, p2))  => begin
                      @match true = stringEq(id, id2)
                      @match true = pathPrefixOf(p, p2)
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          isPrefix
        end

         #= Alternative names: crefIsPrefixOf, isPrefixOf, prefixOf
          Author: DH 2010-03

          Returns true if prefixCr is a prefix of cr, i.e., false otherwise.
          Subscripts are NOT checked. =#
        function crefPrefixOf(prefixCr::ComponentRef, cr::ComponentRef) ::Bool
              local out::Bool

              out = begin
                @matchcontinue (prefixCr, cr) begin
                  (_, _)  => begin
                      @match true = crefEqualNoSubs(prefixCr, cr)
                    true
                  end

                  (_, _)  => begin
                    crefPrefixOf(prefixCr, crefStripLast(cr))
                  end

                  _  => begin
                      false
                  end
                end
              end
          out
        end

         #= removes the prefix_path from path, and returns the rest of path =#
        function removePrefix(prefix_path::Path, path::Path) ::Path
              local newPath::Path

              newPath = begin
                  local p::Path
                  local p2::Path
                  local id1::Ident
                  local id2::Ident
                   #=  fullyqual path
                   =#
                @match (prefix_path, path) begin
                  (p, FULLYQUALIFIED(p2))  => begin
                    removePrefix(p, p2)
                  end

                  (QUALIFIED(name = id1, path = p), QUALIFIED(name = id2, path = p2))  => begin
                      @match true = stringEq(id1, id2)
                    removePrefix(p, p2)
                  end

                  (IDENT(id1), QUALIFIED(name = id2, path = p2))  => begin
                      @match true = stringEq(id1, id2)
                    p2
                  end
                end
              end
               #=  qual
               =#
               #=  ids
               =#
          newPath
        end

         #= Tries to remove a given prefix from a path with removePrefix. If it fails it
          removes the first identifier in the prefix and tries again, until it either
          succeeds or reaches the end of the prefix. Ex:
            removePartialPrefix(A.B.C, B.C.D.E) => D.E
           =#
        function removePartialPrefix(inPrefix::Path, inPath::Path) ::Path
              local outPath::Path

              outPath = begin
                  local p::Path
                @matchcontinue (inPrefix, inPath) begin
                  (_, _)  => begin
                      p = removePrefix(inPrefix, inPath)
                    p
                  end

                  (QUALIFIED(path = p), _)  => begin
                      p = removePrefix(p, inPath)
                    p
                  end

                  (FULLYQUALIFIED(path = p), _)  => begin
                      p = removePartialPrefix(p, inPath)
                    p
                  end

                  _  => begin
                      inPath
                  end
                end
              end
          outPath
        end

         #=
          function: crefRemovePrefix
          Alternative names: removePrefix
          Author: DH 2010-03

          If prefixCr is a prefix of cr, removes prefixCr from cr and returns the remaining reference,
          otherwise fails. Subscripts are NOT checked.
         =#
        function crefRemovePrefix(prefixCr::ComponentRef, cr::ComponentRef) ::ComponentRef
              local out::ComponentRef

              out = begin
                  local prefixIdent::Ident
                  local ident::Ident
                  local prefixRestCr::ComponentRef
                  local restCr::ComponentRef
                   #=  fqual
                   =#
                @match (prefixCr, cr) begin
                  (CREF_FULLYQUALIFIED(componentRef = prefixRestCr), CREF_FULLYQUALIFIED(componentRef = restCr))  => begin
                    crefRemovePrefix(prefixRestCr, restCr)
                  end

                  (CREF_QUAL(name = prefixIdent, componentRef = prefixRestCr), CREF_QUAL(name = ident, componentRef = restCr))  => begin
                      @match true = stringEq(prefixIdent, ident)
                    crefRemovePrefix(prefixRestCr, restCr)
                  end

                  (CREF_IDENT(name = prefixIdent), CREF_QUAL(name = ident, componentRef = restCr))  => begin
                      @match true = stringEq(prefixIdent, ident)
                    restCr
                  end

                  (CREF_IDENT(name = prefixIdent), CREF_IDENT(name = ident))  => begin
                      @match true = stringEq(prefixIdent, ident)
                    CREF_IDENT("", nil)
                  end
                end
              end
               #=  qual
               =#
               #=  id vs. qual
               =#
               #=  id vs. id
               =#
          out
        end

         #= Author BZ,
           checks if one IDENT(..) is contained in path. =#
        function pathContains(fullPath::Path, pathId::Path) ::Bool
              local b::Bool

              b = begin
                  local str1::String
                  local str2::String
                  local qp::Path
                  local b1::Bool
                  local b2::Bool
                @match (fullPath, pathId) begin
                  (IDENT(str1), IDENT(str2))  => begin
                    stringEq(str1, str2)
                  end

                  (QUALIFIED(str1, qp), IDENT(str2))  => begin
                      b1 = stringEq(str1, str2)
                      b2 = pathContains(qp, pathId)
                      b1 = boolOr(b1, b2)
                    b1
                  end

                  (FULLYQUALIFIED(qp), _)  => begin
                    pathContains(qp, pathId)
                  end
                end
              end
          b
        end

         #= Author OT,
           checks if Path contains the given string. =#
        function pathContainsString(p1::Path, str::String) ::Bool
              local b::Bool

              b = begin
                  local str1::String
                  local searchStr::String
                  local qp::Path
                  local b1::Bool
                  local b2::Bool
                  local b3::Bool
                @match (p1, str) begin
                  (IDENT(str1), searchStr)  => begin
                      b1 = System.stringFind(str1, searchStr) != (-1)
                    b1
                  end

                  (QUALIFIED(str1, qp), searchStr)  => begin
                      b1 = System.stringFind(str1, searchStr) != (-1)
                      b2 = pathContainsString(qp, searchStr)
                      b3 = boolOr(b1, b2)
                    b3
                  end

                  (FULLYQUALIFIED(qp), searchStr)  => begin
                    pathContainsString(qp, searchStr)
                  end
                end
              end
          b
        end

         #= This function checks if subPath is contained in path.
           If it is the complete path is returned. Otherwise the function fails.
           For example,
             pathContainedIn( C.D, A.B.C) => A.B.C.D
             pathContainedIn(C.D, A.B.C.D) => A.B.C.D
             pathContainedIn(A.B.C.D, A.B.C.D) => A.B.C.D
             pathContainedIn(B.C,A.B) => A.B.C =#
        function pathContainedIn(subPath::Path, path::Path) ::Path
              local completePath::Path

              completePath = begin
                  local ident::Ident
                  local newPath::Path
                  local newSubPath::Path
                   #=  A suffix, e.g. C.D in A.B.C.D
                   =#
                @matchcontinue (subPath, path) begin
                  (_, _)  => begin
                      @match true = pathSuffixOf(subPath, path)
                    path
                  end

                  (_, _)  => begin
                      ident = pathLastIdent(path)
                      newPath = stripLast(path)
                      newPath = pathContainedIn(subPath, newPath)
                    joinPaths(newPath, IDENT(ident))
                  end

                  _  => begin
                        ident = pathLastIdent(subPath)
                        newSubPath = stripLast(subPath)
                        newSubPath = pathContainedIn(newSubPath, path)
                      joinPaths(newSubPath, IDENT(ident))
                  end
                end
              end
               #=  strip last ident of path and recursively check if suffix.
               =#
               #=  strip last ident of subpath and recursively check if suffix.
               =#
          completePath
        end

         #= Author BZ 2009-08
           Function for getting ComponentRefs out from Subscripts =#
        function getCrefsFromSubs(isubs::List{<:Subscript}, includeSubs::Bool #= include crefs from array subscripts =#, includeFunctions::Bool #= note that if you say includeSubs = false then you won't get the functions from array subscripts =#) ::List{ComponentRef}
              local crefs::List{ComponentRef}

              crefs = begin
                  local crefs1::List{ComponentRef}
                  local exp::Exp
                  local subs::List{Subscript}
                @match (isubs, includeSubs, includeFunctions) begin
                  ( nil(), _, _)  => begin
                    nil
                  end

                  (NOSUB(__) <| subs, _, _)  => begin
                    getCrefsFromSubs(subs, includeSubs, includeFunctions)
                  end

                  (SUBSCRIPT(exp) <| subs, _, _)  => begin
                      crefs1 = getCrefsFromSubs(subs, includeSubs, includeFunctions)
                      crefs = getCrefFromExp(exp, includeSubs, includeFunctions)
                    listAppend(crefs, crefs1)
                  end
                end
              end
          crefs
        end

         #= Returns a flattened list of the
           component references in an expression =#
        function getCrefFromExp(inExp::Exp, includeSubs::Bool #= include crefs from array subscripts =#, includeFunctions::Bool #= note that if you say includeSubs = false then you won't get the functions from array subscripts =#) ::List{ComponentRef}
              local outComponentRefLst::List{ComponentRef}

              outComponentRefLst = begin
                  local cr::ComponentRef
                  local l1::List{ComponentRef}
                  local l2::List{ComponentRef}
                  local res::List{ComponentRef}
                  local e1::ComponentCondition
                  local e2::ComponentCondition
                  local e3::ComponentCondition
                  local op::Operator
                  local e4::List{Tuple{ComponentCondition, ComponentCondition}}
                  local farg::FunctionArgs
                  local expl::List{ComponentCondition}
                  local expll::List{List{ComponentCondition}}
                  local subs::List{Subscript}
                  local lstres1::List{List{ComponentRef}}
                  local crefll::List{List{ComponentRef}}
                @match (inExp, includeSubs, includeFunctions) begin
                  (INTEGER(__), _, _)  => begin
                    nil
                  end

                  (REAL(__), _, _)  => begin
                    nil
                  end

                  (STRING(__), _, _)  => begin
                    nil
                  end

                  (BOOL(__), _, _)  => begin
                    nil
                  end

                  (CREF(componentRef = ALLWILD(__)), _, _)  => begin
                    nil
                  end

                  (CREF(componentRef = WILD(__)), _, _)  => begin
                    nil
                  end

                  (CREF(componentRef = cr), false, _)  => begin
                    list(cr)
                  end

                  (CREF(componentRef = cr), true, _)  => begin
                      subs = getSubsFromCref(cr, includeSubs, includeFunctions)
                      l1 = getCrefsFromSubs(subs, includeSubs, includeFunctions)
                    _cons(cr, l1)
                  end

                  (BINARY(exp1 = e1, exp2 = e2), _, _)  => begin
                      l1 = getCrefFromExp(e1, includeSubs, includeFunctions)
                      l2 = getCrefFromExp(e2, includeSubs, includeFunctions)
                      res = listAppend(l1, l2)
                    res
                  end

                  (UNARY(exp = e1), _, _)  => begin
                      res = getCrefFromExp(e1, includeSubs, includeFunctions)
                    res
                  end

                  (LBINARY(exp1 = e1, exp2 = e2), _, _)  => begin
                      l1 = getCrefFromExp(e1, includeSubs, includeFunctions)
                      l2 = getCrefFromExp(e2, includeSubs, includeFunctions)
                      res = listAppend(l1, l2)
                    res
                  end

                  (LUNARY(exp = e1), _, _)  => begin
                      res = getCrefFromExp(e1, includeSubs, includeFunctions)
                    res
                  end

                  (RELATION(exp1 = e1, exp2 = e2), _, _)  => begin
                      l1 = getCrefFromExp(e1, includeSubs, includeFunctions)
                      l2 = getCrefFromExp(e2, includeSubs, includeFunctions)
                      res = listAppend(l1, l2)
                    res
                  end

                  (IFEXP(ifExp = e1, trueBranch = e2, elseBranch = e3), _, _)  => begin
                    ListUtil.flatten(list(getCrefFromExp(e1, includeSubs, includeFunctions), getCrefFromExp(e2, includeSubs, includeFunctions), getCrefFromExp(e3, includeSubs, includeFunctions)))
                  end

                  (CALL(function_ = cr, functionArgs = farg), _, _)  => begin
                      res = getCrefFromFarg(farg, includeSubs, includeFunctions)
                      res = if includeFunctions
                            _cons(cr, res)
                          else
                            res
                          end
                    res
                  end

                  (PARTEVALFUNCTION(function_ = cr, functionArgs = farg), _, _)  => begin
                      res = getCrefFromFarg(farg, includeSubs, includeFunctions)
                      res = if includeFunctions
                            _cons(cr, res)
                          else
                            res
                          end
                    res
                  end

                  (ARRAY(arrayExp = expl), _, _)  => begin
                      lstres1 = ListUtil.map2(expl, getCrefFromExp, includeSubs, includeFunctions)
                      res = ListUtil.flatten(lstres1)
                    res
                  end

                  (MATRIX(matrix = expll), _, _)  => begin
                      res = ListUtil.flatten(ListUtil.flatten(ListUtil.map2List(expll, getCrefFromExp, includeSubs, includeFunctions)))
                    res
                  end

                  (RANGE(start = e1, step = SOME(e3), stop = e2), _, _)  => begin
                      l1 = getCrefFromExp(e1, includeSubs, includeFunctions)
                      l2 = getCrefFromExp(e2, includeSubs, includeFunctions)
                      l2 = listAppend(l1, l2)
                      l1 = getCrefFromExp(e3, includeSubs, includeFunctions)
                      res = listAppend(l1, l2)
                    res
                  end

                  (RANGE(start = e1, step = NONE(), stop = e2), _, _)  => begin
                      l1 = getCrefFromExp(e1, includeSubs, includeFunctions)
                      l2 = getCrefFromExp(e2, includeSubs, includeFunctions)
                      res = listAppend(l1, l2)
                    res
                  end

                  (END(__), _, _)  => begin
                    nil
                  end

                  (TUPLE(expressions = expl), _, _)  => begin
                      crefll = ListUtil.map2(expl, getCrefFromExp, includeSubs, includeFunctions)
                      res = ListUtil.flatten(crefll)
                    res
                  end

                  (CODE(__), _, _)  => begin
                    nil
                  end

                  (AS(exp = e1), _, _)  => begin
                    getCrefFromExp(e1, includeSubs, includeFunctions)
                  end

                  (CONS(e1, e2), _, _)  => begin
                      l1 = getCrefFromExp(e1, includeSubs, includeFunctions)
                      l2 = getCrefFromExp(e2, includeSubs, includeFunctions)
                      res = listAppend(l1, l2)
                    res
                  end

                  (LIST(expl), _, _)  => begin
                      crefll = ListUtil.map2(expl, getCrefFromExp, includeSubs, includeFunctions)
                      res = ListUtil.flatten(crefll)
                    res
                  end

                  (MATCHEXP(__), _, _)  => begin
                    fail()
                  end

                  (DOT(__), _, _)  => begin
                    getCrefFromExp(inExp.exp, includeSubs, includeFunctions)
                  end

                  _  => begin
                        Error.addInternalError(getInstanceName() + " failed " + Dump.printExpStr(inExp), sourceInfo())
                      fail()
                  end
                end
              end
               #=  TODO: Handle else if-branches.
               =#
               #=  inExp.index is only allowed to contain names to index the function call; not crefs that are evaluated in any way
               =#
          outComponentRefLst
        end

         #= Returns the flattened list of all component references
          present in a list of function arguments. =#
        function getCrefFromFarg(inFunctionArgs::FunctionArgs, includeSubs::Bool #= include crefs from array subscripts =#, includeFunctions::Bool #= note that if you say includeSubs = false then you won't get the functions from array subscripts =#) ::List{ComponentRef}
              local outComponentRefLst::List{ComponentRef}

              outComponentRefLst = begin
                  local l1::List{List{ComponentRef}}
                  local l2::List{List{ComponentRef}}
                  local fl1::List{ComponentRef}
                  local fl2::List{ComponentRef}
                  local fl3::List{ComponentRef}
                  local res::List{ComponentRef}
                  local expl::List{ComponentCondition}
                  local nargl::List{NamedArg}
                  local iterators::ForIterators
                  local exp::Exp
                @match (inFunctionArgs, includeSubs, includeFunctions) begin
                  (FUNCTIONARGS(args = expl, argNames = nargl), _, _)  => begin
                      l1 = ListUtil.map2(expl, getCrefFromExp, includeSubs, includeFunctions)
                      fl1 = ListUtil.flatten(l1)
                      l2 = ListUtil.map2(nargl, getCrefFromNarg, includeSubs, includeFunctions)
                      fl2 = ListUtil.flatten(l2)
                      res = listAppend(fl1, fl2)
                    res
                  end

                  (FOR_ITER_FARG(exp, _, iterators), _, _)  => begin
                      l1 = ListUtil.map2Option(ListUtil.map(iterators, iteratorRange), getCrefFromExp, includeSubs, includeFunctions)
                      l2 = ListUtil.map2Option(ListUtil.map(iterators, iteratorGuard), getCrefFromExp, includeSubs, includeFunctions)
                      fl1 = ListUtil.flatten(l1)
                      fl2 = ListUtil.flatten(l2)
                      fl3 = getCrefFromExp(exp, includeSubs, includeFunctions)
                      res = listAppend(fl1, listAppend(fl2, fl3))
                    res
                  end
                end
              end
          outComponentRefLst
        end

        function iteratorName(iterator::ForIterator) ::String
              local name::String

              @match ITERATOR(name = name) = iterator
          name
        end

        function iteratorRange(iterator::ForIterator) ::Option{Exp}
              local range::Option{Exp}

              @match ITERATOR(range = range) = iterator
          range
        end

        function iteratorGuard(iterator::ForIterator) ::Option{Exp}
              local guardExp::Option{Exp}

              @match ITERATOR(guardExp = guardExp) = iterator
          guardExp
        end

         #=  stefan
         =#

         #= returns the names from a list of NamedArgs as a string list =#
        function getNamedFuncArgNamesAndValues(inNamedArgList::List{<:NamedArg}) ::Tuple{List{String}, List{Exp}}
              local outExpList::List{Exp}
              local outStringList::List{String}

              (outStringList, outExpList) = begin
                  local cdr::List{NamedArg}
                  local s::String
                  local e::Exp
                  local slst::List{String}
                  local elst::List{Exp}
                @match inNamedArgList begin
                   nil()  => begin
                    (nil, nil)
                  end

                  NAMEDARG(argName = s, argValue = e) <| cdr  => begin
                      (slst, elst) = getNamedFuncArgNamesAndValues(cdr)
                    (_cons(s, slst), _cons(e, elst))
                  end
                end
              end
          (outStringList, outExpList)
        end

         #= Returns the flattened list of all component references
          present in a list of named function arguments. =#
        function getCrefFromNarg(inNamedArg::NamedArg, includeSubs::Bool #= include crefs from array subscripts =#, includeFunctions::Bool #= note that if you say includeSubs = false then you won't get the functions from array subscripts =#) ::List{ComponentRef}
              local outComponentRefLst::List{ComponentRef}

              outComponentRefLst = begin
                  local res::List{ComponentRef}
                  local exp::ComponentCondition
                @match (inNamedArg, includeSubs, includeFunctions) begin
                  (NAMEDARG(argValue = exp), _, _)  => begin
                      res = getCrefFromExp(exp, includeSubs, includeFunctions)
                    res
                  end
                end
              end
          outComponentRefLst
        end

         #= This function joins two paths =#
        function joinPaths(inPath1::Path, inPath2::Path) ::Path
              local outPath::Path

              outPath = begin
                  local str::Ident
                  local p2::Path
                  local p_1::Path
                  local p::Path
                @match (inPath1, inPath2) begin
                  (IDENT(name = str), p2)  => begin
                    QUALIFIED(str, p2)
                  end

                  (QUALIFIED(name = str, path = p), p2)  => begin
                      p_1 = joinPaths(p, p2)
                    QUALIFIED(str, p_1)
                  end

                  (FULLYQUALIFIED(p), p2)  => begin
                    joinPaths(p, p2)
                  end

                  (p, FULLYQUALIFIED(p2))  => begin
                    joinPaths(p, p2)
                  end
                end
              end
          outPath
        end

         #= This function joins two paths when the first one might be NONE =#
        function joinPathsOpt(inPath1::Option{<:Path}, inPath2::Path) ::Path
              local outPath::Path

              outPath = begin
                  local p::Path
                @match (inPath1, inPath2) begin
                  (NONE(), _)  => begin
                    inPath2
                  end

                  (SOME(p), _)  => begin
                    joinPaths(p, inPath2)
                  end
                end
              end
          outPath
        end

        function joinPathsOptSuffix(inPath1::Path, inPath2::Option{<:Path}) ::Path
              local outPath::Path

              outPath = begin
                  local p::Path
                @match (inPath1, inPath2) begin
                  (_, SOME(p))  => begin
                    joinPaths(inPath1, p)
                  end

                  _  => begin
                      inPath1
                  end
                end
              end
          outPath
        end

         #= This function selects the second path when the first one
          is NONE() otherwise it will select the first one. =#
        function selectPathsOpt(inPath1::Option{<:Path}, inPath2::Path) ::Path
              local outPath::Path

              outPath = begin
                  local p::Path
                @match (inPath1, inPath2) begin
                  (NONE(), p)  => begin
                    p
                  end

                  (SOME(p), _)  => begin
                    p
                  end
                end
              end
          outPath
        end

         #= author Lucian
          This function joins a path list =#
        function pathAppendList(inPathLst::List{<:Path}) ::Path
              local outPath::Path

              outPath = begin
                  local path::Path
                  local res_path::Path
                  local first::Path
                  local rest::List{Path}
                @match inPathLst begin
                   nil()  => begin
                    IDENT("")
                  end

                  path <|  nil()  => begin
                    path
                  end

                  first <| rest  => begin
                      path = pathAppendList(rest)
                      res_path = joinPaths(first, path)
                    res_path
                  end
                end
              end
          outPath
        end

         #= Returns the path given as argument to
          the function minus the last ident. =#
        function stripLast(inPath::Path) ::Path
              local outPath::Path

              outPath = begin
                  local str::Ident
                  local p::Path
                @match inPath begin
                  QUALIFIED(name = str, path = IDENT(__))  => begin
                    IDENT(str)
                  end

                  QUALIFIED(name = str, path = p)  => begin
                      p = stripLast(p)
                    QUALIFIED(str, p)
                  end

                  FULLYQUALIFIED(p)  => begin
                      p = stripLast(p)
                    FULLYQUALIFIED(p)
                  end
                end
              end
          outPath
        end

        function stripLastOpt(inPath::Path) ::Option{Path}
              local outPath::Option{Path}

              outPath = begin
                  local p::Path
                @match inPath begin
                  IDENT(__)  => begin
                    NONE()
                  end

                  _  => begin
                        p = stripLast(inPath)
                      SOME(p)
                  end
                end
              end
          outPath
        end

         #= Returns the path given as argument to
          the function minus the last ident. =#
        function crefStripLast(inCref::ComponentRef) ::ComponentRef
              local outCref::ComponentRef

              outCref = begin
                  local str::Ident
                  local c_1::ComponentRef
                  local c::ComponentRef
                  local subs::List{Subscript}
                @match inCref begin
                  CREF_IDENT(__)  => begin
                    fail()
                  end

                  CREF_QUAL(name = str, subscripts = subs, componentRef = CREF_IDENT(__))  => begin
                    CREF_IDENT(str, subs)
                  end

                  CREF_QUAL(name = str, subscripts = subs, componentRef = c)  => begin
                      c_1 = crefStripLast(c)
                    CREF_QUAL(str, subs, c_1)
                  end

                  CREF_FULLYQUALIFIED(componentRef = c)  => begin
                      c_1 = crefStripLast(c)
                    crefMakeFullyQualified(c_1)
                  end
                end
              end
          outCref
        end

         #=
        Author BZ 2008-04
        Function for splitting Absynpath into two parts,
        qualified part, and ident part (all_but_last, last);
         =#
        function splitQualAndIdentPath(inPath::Path) ::Tuple{Path, Path}
              local outPath2::Path
              local outPath1::Path

              (outPath1, outPath2) = begin
                  local qPath::Path
                  local curPath::Path
                  local identPath::Path
                  local s1::String
                  local s2::String
                @match inPath begin
                  QUALIFIED(name = s1, path = IDENT(name = s2))  => begin
                    (IDENT(s1), IDENT(s2))
                  end

                  QUALIFIED(name = s1, path = qPath)  => begin
                      (curPath, identPath) = splitQualAndIdentPath(qPath)
                    (QUALIFIED(s1, curPath), identPath)
                  end

                  FULLYQUALIFIED(qPath)  => begin
                      (curPath, identPath) = splitQualAndIdentPath(qPath)
                    (curPath, identPath)
                  end
                end
              end
          (outPath1, outPath2)
        end

         #= Returns the path given as argument
          to the function minus the first ident. =#
        function stripFirst(inPath::Path) ::Path
              local outPath::Path

              outPath = begin
                  local p::Path
                @match inPath begin
                  QUALIFIED(path = p)  => begin
                    p
                  end

                  FULLYQUALIFIED(p)  => begin
                    stripFirst(p)
                  end
                end
              end
          outPath
        end

         #= This function converts a ComponentRef to a Path, if possible.
          If the component reference contains subscripts, it will silently fail. =#
        function crefToPath(inComponentRef::ComponentRef) ::Path
              local outPath::Path

              outPath = begin
                  local i::Ident
                  local p::Path
                  local c::ComponentRef
                @match inComponentRef begin
                  CREF_IDENT(name = i, subscripts =  nil())  => begin
                    IDENT(i)
                  end

                  CREF_QUAL(name = i, subscripts =  nil(), componentRef = c)  => begin
                      p = crefToPath(c)
                    QUALIFIED(i, p)
                  end

                  CREF_FULLYQUALIFIED(componentRef = c)  => begin
                      p = crefToPath(c)
                    FULLYQUALIFIED(p)
                  end
                end
              end
          outPath
        end

         #= This function converts a ElementSpec to a Path, if possible.
          If the ElementSpec is not EXTENDS, it will silently fail. =#
        function elementSpecToPath(inElementSpec::ElementSpec) ::Path
              local outPath::Path

              outPath = begin
                  local p::Path
                @match inElementSpec begin
                  EXTENDS(path = p)  => begin
                    p
                  end
                end
              end
          outPath
        end

         #= Converts a ComponentRef to a Path, ignoring any subscripts. =#
        function crefToPathIgnoreSubs(inComponentRef::ComponentRef) ::Path
              local outPath::Path

              outPath = begin
                  local i::Ident
                  local p::Path
                  local c::ComponentRef
                @match inComponentRef begin
                  CREF_IDENT(name = i)  => begin
                    IDENT(i)
                  end

                  CREF_QUAL(name = i, componentRef = c)  => begin
                      p = crefToPathIgnoreSubs(c)
                    QUALIFIED(i, p)
                  end

                  CREF_FULLYQUALIFIED(componentRef = c)  => begin
                      p = crefToPathIgnoreSubs(c)
                    FULLYQUALIFIED(p)
                  end
                end
              end
          outPath
        end

         #= This function converts a Path to a ComponentRef. =#
        function pathToCref(inPath::Path) ::ComponentRef
              local outComponentRef::ComponentRef

              outComponentRef = begin
                  local i::Ident
                  local c::ComponentRef
                  local p::Path
                @match inPath begin
                  IDENT(name = i)  => begin
                    CREF_IDENT(i, nil)
                  end

                  QUALIFIED(name = i, path = p)  => begin
                      c = pathToCref(p)
                    CREF_QUAL(i, nil, c)
                  end

                  FULLYQUALIFIED(p)  => begin
                      c = pathToCref(p)
                    crefMakeFullyQualified(c)
                  end
                end
              end
          outComponentRef
        end

         #= This function converts a Path to a ComponentRef, and applies the given
          subscripts to the last identifier. =#
        function pathToCrefWithSubs(inPath::Path, inSubs::List{<:Subscript}) ::ComponentRef
              local outComponentRef::ComponentRef

              outComponentRef = begin
                  local i::Ident
                  local c::ComponentRef
                  local p::Path
                @match (inPath, inSubs) begin
                  (IDENT(name = i), _)  => begin
                    CREF_IDENT(i, inSubs)
                  end

                  (QUALIFIED(name = i, path = p), _)  => begin
                      c = pathToCrefWithSubs(p, inSubs)
                    CREF_QUAL(i, nil, c)
                  end

                  (FULLYQUALIFIED(p), _)  => begin
                      c = pathToCrefWithSubs(p, inSubs)
                    crefMakeFullyQualified(c)
                  end
                end
              end
          outComponentRef
        end

         #= Returns the last identifier in a component reference. =#
        function crefLastIdent(inComponentRef::ComponentRef) ::Ident
              local outIdent::Ident

              outIdent = begin
                  local cref::ComponentRef
                  local id::Ident
                @match inComponentRef begin
                  CREF_IDENT(name = id)  => begin
                    id
                  end

                  CREF_QUAL(componentRef = cref)  => begin
                    crefLastIdent(cref)
                  end

                  CREF_FULLYQUALIFIED(componentRef = cref)  => begin
                    crefLastIdent(cref)
                  end
                end
              end
          outIdent
        end

         #= Returns the basename of the component reference, but fails if it encounters
          any subscripts. =#
        function crefFirstIdentNoSubs(inCref::ComponentRef) ::Ident
              local outIdent::Ident

              outIdent = begin
                  local id::Ident
                  local cr::ComponentRef
                @match inCref begin
                  CREF_IDENT(name = id, subscripts =  nil())  => begin
                    id
                  end

                  CREF_QUAL(name = id, subscripts =  nil())  => begin
                    id
                  end

                  CREF_FULLYQUALIFIED(componentRef = cr)  => begin
                    crefFirstIdentNoSubs(cr)
                  end
                end
              end
          outIdent
        end

         #= Returns true if the component reference is a simple identifier, otherwise false. =#
        function crefIsIdent(inComponentRef::ComponentRef) ::Bool
              local outIsIdent::Bool

              outIsIdent = begin
                @match inComponentRef begin
                  CREF_IDENT(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsIdent
        end

         #= Returns true if the component reference is a qualified identifier, otherwise false. =#
        function crefIsQual(inComponentRef::ComponentRef) ::Bool
              local outIsQual::Bool

              outIsQual = begin
                @match inComponentRef begin
                  CREF_QUAL(__)  => begin
                    true
                  end

                  CREF_FULLYQUALIFIED(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsQual
        end

         #= Return the last subscripts of an ComponentRef =#
        function crefLastSubs(inComponentRef::ComponentRef) ::List{Subscript}
              local outSubscriptLst::List{Subscript}

              outSubscriptLst = begin
                  local id::Ident
                  local subs::List{Subscript}
                  local res::List{Subscript}
                  local cr::ComponentRef
                @match inComponentRef begin
                  CREF_IDENT(subscripts = subs)  => begin
                    subs
                  end

                  CREF_QUAL(componentRef = cr)  => begin
                      res = crefLastSubs(cr)
                    res
                  end

                  CREF_FULLYQUALIFIED(componentRef = cr)  => begin
                      res = crefLastSubs(cr)
                    res
                  end
                end
              end
          outSubscriptLst
        end

        function crefSetLastSubs(inCref::ComponentRef, inSubscripts::List{<:Subscript}) ::ComponentRef
              local outCref::ComponentRef = inCref

              outCref = begin
                @match outCref begin
                  CREF_IDENT(__)  => begin
                      outCref.subscripts = inSubscripts
                    outCref
                  end

                  CREF_QUAL(__)  => begin
                      outCref.componentRef = crefSetLastSubs(outCref.componentRef, inSubscripts)
                    outCref
                  end

                  CREF_FULLYQUALIFIED(__)  => begin
                      outCref.componentRef = crefSetLastSubs(outCref.componentRef, inSubscripts)
                    outCref
                  end
                end
              end
          outCref
        end

         #= This function finds if a cref has subscripts =#
        function crefHasSubscripts(cref::ComponentRef) ::Bool
              local hasSubscripts::Bool

              hasSubscripts = begin
                @match cref begin
                  CREF_IDENT(__)  => begin
                    ! listEmpty(cref.subscripts)
                  end

                  CREF_QUAL(subscripts =  nil())  => begin
                    crefHasSubscripts(cref.componentRef)
                  end

                  CREF_FULLYQUALIFIED(__)  => begin
                    crefHasSubscripts(cref.componentRef)
                  end

                  WILD(__)  => begin
                    false
                  end

                  ALLWILD(__)  => begin
                    false
                  end

                  _  => begin
                      true
                  end
                end
              end
          hasSubscripts
        end

         #=
        Author: BZ, 2009-09
         Extract subscripts of crefs. =#
        function getSubsFromCref(cr::ComponentRef, includeSubs::Bool #= include crefs from array subscripts =#, includeFunctions::Bool #= note that if you say includeSubs = false then you won't get the functions from array subscripts =#) ::List{Subscript}
              local subscripts::List{Subscript}

              subscripts = begin
                  local subs2::List{Subscript}
                  local child::ComponentRef
                @match (cr, includeSubs, includeFunctions) begin
                  (CREF_IDENT(_, subs2), _, _)  => begin
                    subs2
                  end

                  (CREF_QUAL(_, subs2, child), _, _)  => begin
                      subscripts = getSubsFromCref(child, includeSubs, includeFunctions)
                      subscripts = ListUtil.unionOnTrue(subscripts, subs2, subscriptEqual)
                    subscripts
                  end

                  (CREF_FULLYQUALIFIED(child), _, _)  => begin
                      subscripts = getSubsFromCref(child, includeSubs, includeFunctions)
                    subscripts
                  end
                end
              end
          subscripts
        end

         #=  stefan
         =#

         #= Gets the last ident in a ComponentRef =#
        function crefGetLastIdent(inComponentRef::ComponentRef) ::ComponentRef
              local outComponentRef::ComponentRef

              outComponentRef = begin
                  local cref::ComponentRef
                  local cref_1::ComponentRef
                  local id::Ident
                  local subs::List{Subscript}
                @match inComponentRef begin
                  CREF_IDENT(id, subs)  => begin
                    CREF_IDENT(id, subs)
                  end

                  CREF_QUAL(_, _, cref)  => begin
                      cref_1 = crefGetLastIdent(cref)
                    cref_1
                  end

                  CREF_FULLYQUALIFIED(cref)  => begin
                      cref_1 = crefGetLastIdent(cref)
                    cref_1
                  end
                end
              end
          outComponentRef
        end

         #= Strips the last subscripts of a ComponentRef =#
        function crefStripLastSubs(inComponentRef::ComponentRef) ::ComponentRef
              local outComponentRef::ComponentRef

              outComponentRef = begin
                  local id::Ident
                  local subs::List{Subscript}
                  local s::List{Subscript}
                  local cr_1::ComponentRef
                  local cr::ComponentRef
                @match inComponentRef begin
                  CREF_IDENT(name = id)  => begin
                    CREF_IDENT(id, nil)
                  end

                  CREF_QUAL(name = id, subscripts = s, componentRef = cr)  => begin
                      cr_1 = crefStripLastSubs(cr)
                    CREF_QUAL(id, s, cr_1)
                  end

                  CREF_FULLYQUALIFIED(componentRef = cr)  => begin
                      cr_1 = crefStripLastSubs(cr)
                    crefMakeFullyQualified(cr_1)
                  end
                end
              end
          outComponentRef
        end

         #= This function joins two ComponentRefs. =#
        function joinCrefs(inComponentRef1::ComponentRef, inComponentRef2::ComponentRef) ::ComponentRef
              local outComponentRef::ComponentRef

              outComponentRef = begin
                  local id::Ident
                  local sub::List{Subscript}
                  local cr2::ComponentRef
                  local cr_1::ComponentRef
                  local cr::ComponentRef
                @match (inComponentRef1, inComponentRef2) begin
                  (CREF_IDENT(name = id, subscripts = sub), cr2)  => begin
                      @shouldFail @match CREF_FULLYQUALIFIED() = cr2
                    CREF_QUAL(id, sub, cr2)
                  end

                  (CREF_QUAL(name = id, subscripts = sub, componentRef = cr), cr2)  => begin
                      cr_1 = joinCrefs(cr, cr2)
                    CREF_QUAL(id, sub, cr_1)
                  end

                  (CREF_FULLYQUALIFIED(componentRef = cr), cr2)  => begin
                      cr_1 = joinCrefs(cr, cr2)
                    crefMakeFullyQualified(cr_1)
                  end
                end
              end
          outComponentRef
        end

         #= Returns first ident from a ComponentRef =#
        function crefFirstIdent(inCref::ComponentRef) ::Ident
              local outIdent::Ident

              outIdent = begin
                @match inCref begin
                  CREF_IDENT(__)  => begin
                    inCref.name
                  end

                  CREF_QUAL(__)  => begin
                    inCref.name
                  end

                  CREF_FULLYQUALIFIED(__)  => begin
                    crefFirstIdent(inCref.componentRef)
                  end
                end
              end
          outIdent
        end

        function crefSecondIdent(cref::ComponentRef) ::Ident
              local ident::Ident

              ident = begin
                @match cref begin
                  CREF_QUAL(__)  => begin
                    crefFirstIdent(cref.componentRef)
                  end

                  CREF_FULLYQUALIFIED(__)  => begin
                    crefSecondIdent(cref.componentRef)
                  end
                end
              end
          ident
        end

         #= Returns the first part of a cref. =#
        function crefFirstCref(inCref::ComponentRef) ::ComponentRef
              local outCref::ComponentRef

              outCref = begin
                @match inCref begin
                  CREF_QUAL(__)  => begin
                    CREF_IDENT(inCref.name, inCref.subscripts)
                  end

                  CREF_FULLYQUALIFIED(__)  => begin
                    crefFirstCref(inCref.componentRef)
                  end

                  _  => begin
                      inCref
                  end
                end
              end
          outCref
        end

         #= Strip the first ident from a ComponentRef =#
        function crefStripFirst(inComponentRef::ComponentRef) ::ComponentRef
              local outComponentRef::ComponentRef

              outComponentRef = begin
                  local cr::ComponentRef
                @match inComponentRef begin
                  CREF_QUAL(componentRef = cr)  => begin
                    cr
                  end

                  CREF_FULLYQUALIFIED(componentRef = cr)  => begin
                    crefStripFirst(cr)
                  end
                end
              end
          outComponentRef
        end

        function crefIsFullyQualified(inCref::ComponentRef) ::Bool
              local outIsFullyQualified::Bool

              outIsFullyQualified = begin
                @match inCref begin
                  CREF_FULLYQUALIFIED(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsFullyQualified
        end

         #= Makes a component reference fully qualified unless it already is. =#
        function crefMakeFullyQualified(inComponentRef::ComponentRef) ::ComponentRef
              local outComponentRef::ComponentRef

              outComponentRef = begin
                @match inComponentRef begin
                  CREF_FULLYQUALIFIED(__)  => begin
                    inComponentRef
                  end

                  _  => begin
                      CREF_FULLYQUALIFIED(inComponentRef)
                  end
                end
              end
          outComponentRef
        end

         #= Maps a class restriction to the corresponding string for printing =#
        function restrString(inRestriction::Restriction) ::String
              local outString::String

              outString = begin
                @match inRestriction begin
                  R_CLASS(__)  => begin
                    "CLASS"
                  end

                  R_OPTIMIZATION(__)  => begin
                    "OPTIMIZATION"
                  end

                  R_MODEL(__)  => begin
                    "MODEL"
                  end

                  R_RECORD(__)  => begin
                    "RECORD"
                  end

                  R_BLOCK(__)  => begin
                    "BLOCK"
                  end

                  R_CONNECTOR(__)  => begin
                    "CONNECTOR"
                  end

                  R_EXP_CONNECTOR(__)  => begin
                    "EXPANDABLE CONNECTOR"
                  end

                  R_TYPE(__)  => begin
                    "TYPE"
                  end

                  R_PACKAGE(__)  => begin
                    "PACKAGE"
                  end

                  R_FUNCTION(FR_NORMAL_FUNCTION(PURE(__)))  => begin
                    "PURE FUNCTION"
                  end

                  R_FUNCTION(FR_NORMAL_FUNCTION(IMPURE(__)))  => begin
                    "IMPURE FUNCTION"
                  end

                  R_FUNCTION(FR_NORMAL_FUNCTION(NO_PURITY(__)))  => begin
                    "FUNCTION"
                  end

                  R_FUNCTION(FR_OPERATOR_FUNCTION(__))  => begin
                    "OPERATOR FUNCTION"
                  end

                  R_PREDEFINED_INTEGER(__)  => begin
                    "PREDEFINED_INT"
                  end

                  R_PREDEFINED_REAL(__)  => begin
                    "PREDEFINED_REAL"
                  end

                  R_PREDEFINED_STRING(__)  => begin
                    "PREDEFINED_STRING"
                  end

                  R_PREDEFINED_BOOLEAN(__)  => begin
                    "PREDEFINED_BOOL"
                  end

                  R_PREDEFINED_CLOCK(__)  => begin
                    "PREDEFINED_CLOCK"
                  end

                  R_UNIONTYPE(__)  => begin
                    "UNIONTYPE"
                  end

                  _  => begin
                      "* Unknown restriction *"
                  end
                end
              end
               #=  BTH
               =#
               #= /* MetaModelica restriction */ =#
          outString
        end

         #= Returns the path (=name) of the last class in a program =#
        function lastClassname(inProgram::Program) ::Path
              local outPath::Path

              local lst::List{Class}
              local id::Ident

              @match PROGRAM(classes = lst) = inProgram
              @match CLASS(name = id) = ListUtil.last(lst)
              outPath = IDENT(id)
          outPath
        end

         #= Retrieves the filename where the class is stored. =#
        function classFilename(inClass::Class) ::String
              local outFilename::String

              @match CLASS(info = SOURCEINFO(fileName = outFilename)) = inClass
          outFilename
        end

         #= Sets the filename where the class is stored. =#
        function setClassFilename(inClass::Class, fileName::String) ::Class
              local outClass::Class

              outClass = begin
                  local info::SourceInfo
                  local cl::Class
                @match inClass begin
                  cl && CLASS(info = info && SOURCEINFO(__))  => begin
                      info.fileName = fileName
                      cl.info = info
                    cl
                  end
                end
              end
          outClass
        end

         #= author: BZ
          Sets the name of the class =#
        function setClassName(inClass::Class, newName::String) ::Class
              local outClass::Class = inClass

              outClass = begin
                @match outClass begin
                  CLASS(__)  => begin
                      outClass.name = newName
                    outClass
                  end
                end
              end
          outClass
        end

        function setClassBody(inClass::Class, inBody::ClassDef) ::Class
              local outClass::Class = inClass

              outClass = begin
                @match outClass begin
                  CLASS(__)  => begin
                      outClass.body = inBody
                    outClass
                  end
                end
              end
          outClass
        end

         #=  Checks if the name of a ComponentRef is
         equal to the name of another ComponentRef, including subscripts.
         See also crefEqualNoSubs. =#
        function crefEqual(iCr1::ComponentRef, iCr2::ComponentRef) ::Bool
              local outBoolean::Bool

              outBoolean = begin
                  local id::Ident
                  local id2::Ident
                  local ss1::List{Subscript}
                  local ss2::List{Subscript}
                  local cr1::ComponentRef
                  local cr2::ComponentRef
                @matchcontinue (iCr1, iCr2) begin
                  (CREF_IDENT(name = id, subscripts = ss1), CREF_IDENT(name = id2, subscripts = ss2))  => begin
                      @match true = stringEq(id, id2)
                      @match true = subscriptsEqual(ss1, ss2)
                    true
                  end

                  (CREF_QUAL(name = id, subscripts = ss1, componentRef = cr1), CREF_QUAL(name = id2, subscripts = ss2, componentRef = cr2))  => begin
                      @match true = stringEq(id, id2)
                      @match true = subscriptsEqual(ss1, ss2)
                      @match true = crefEqual(cr1, cr2)
                    true
                  end

                  (CREF_FULLYQUALIFIED(componentRef = cr1), CREF_FULLYQUALIFIED(componentRef = cr2))  => begin
                    crefEqual(cr1, cr2)
                  end

                  _  => begin
                      false
                  end
                end
              end
          outBoolean
        end

         #= @author: adrpo
           a.b, a -> true
           b.c, a -> false =#
        function crefFirstEqual(iCr1::ComponentRef, iCr2::ComponentRef) ::Bool
              local outBoolean::Bool

              outBoolean = stringEq(crefFirstIdent(iCr1), crefFirstIdent(iCr2))
          outBoolean
        end

        function subscriptEqual(inSubscript1::Subscript, inSubscript2::Subscript) ::Bool
              local outIsEqual::Bool

              outIsEqual = begin
                  local e1::Exp
                  local e2::Exp
                @match (inSubscript1, inSubscript2) begin
                  (NOSUB(__), NOSUB(__))  => begin
                    true
                  end

                  (SUBSCRIPT(e1), SUBSCRIPT(e2))  => begin
                    expEqual(e1, e2)
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsEqual
        end

         #= Checks if two subscript lists are equal. =#
        function subscriptsEqual(inSubList1::List{<:Subscript}, inSubList2::List{<:Subscript}) ::Bool
              local outIsEqual::Bool

              outIsEqual = ListUtil.isEqualOnTrue(inSubList1, inSubList2, subscriptEqual)
          outIsEqual
        end

         #= Checks if the name of a ComponentRef is equal to the name
           of another ComponentRef without checking subscripts.
           See also crefEqual. =#
        function crefEqualNoSubs(cr1::ComponentRef, cr2::ComponentRef) ::Bool
              local outBoolean::Bool

              outBoolean = begin
                  local rest1::ComponentRef
                  local rest2::ComponentRef
                  local id::Ident
                  local id2::Ident
                @matchcontinue (cr1, cr2) begin
                  (CREF_IDENT(name = id), CREF_IDENT(name = id2))  => begin
                      @match true = stringEq(id, id2)
                    true
                  end

                  (CREF_QUAL(name = id, componentRef = rest1), CREF_QUAL(name = id2, componentRef = rest2))  => begin
                      @match true = stringEq(id, id2)
                      @match true = crefEqualNoSubs(rest1, rest2)
                    true
                  end

                  (CREF_FULLYQUALIFIED(componentRef = rest1), CREF_FULLYQUALIFIED(componentRef = rest2))  => begin
                    crefEqualNoSubs(rest1, rest2)
                  end

                  _  => begin
                      false
                  end
                end
              end
          outBoolean
        end

         #= checks if the provided parameter is a package or not =#
        function isPackageRestriction(inRestriction::Restriction) ::Bool
              local outIsPackage::Bool

              outIsPackage = begin
                @match inRestriction begin
                  R_PACKAGE(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsPackage
        end

         #= checks if restriction is a function or not =#
        function isFunctionRestriction(inRestriction::Restriction) ::Bool
              local outIsFunction::Bool

              outIsFunction = begin
                @match inRestriction begin
                  R_FUNCTION(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsFunction
        end

         #= Returns true if two expressions are equal =#
        function expEqual(exp1::Exp, exp2::Exp) ::Bool
              local equal::Bool

              equal = begin
                  local b::Bool
                  local x::Exp
                  local y::Exp
                  local i::ModelicaInteger
                  local r::String
                   #=  real vs. integer
                   =#
                @matchcontinue (exp1, exp2) begin
                  (INTEGER(i), REAL(r))  => begin
                      b = realEq(intReal(i), System.stringReal(r))
                    b
                  end

                  (REAL(r), INTEGER(i))  => begin
                      b = realEq(intReal(i), System.stringReal(r))
                    b
                  end

                  (x, y)  => begin
                    valueEq(x, y)
                  end
                end
              end
               #=  anything else, exact match!
               =#
          equal
        end

         #= Returns true if two each attributes are equal =#
        function eachEqual(each1::Each, each2::Each) ::Bool
              local equal::Bool

              equal = begin
                @match (each1, each2) begin
                  (NON_EACH(__), NON_EACH(__))  => begin
                    true
                  end

                  (EACH(__), EACH(__))  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          equal
        end

         #= Returns true if two FunctionArgs are equal =#
        function functionArgsEqual(args1::FunctionArgs, args2::FunctionArgs) ::Bool
              local equal::Bool

              equal = begin
                  local expl1::List{Exp}
                  local expl2::List{Exp}
                @match (args1, args2) begin
                  (FUNCTIONARGS(args = expl1), FUNCTIONARGS(args = expl2))  => begin
                    ListUtil.isEqualOnTrue(expl1, expl2, expEqual)
                  end

                  _  => begin
                      false
                  end
                end
              end
          equal
        end

         #= author: adrpo
          gets the name of the class. =#
        function getClassName(inClass::Class) ::String
              local outName::String

              @match CLASS(name = outName) = inClass
          outName
        end

        IteratorIndexedCref = Tuple

         #= Find all crefs in an expression which are subscripted with the given
           iterator, and return a list of cref-Integer tuples, where the cref is the
           index of the subscript. =#
        function findIteratorIndexedCrefs(inExp::Exp, inIterator::String, inCrefs::List{<:IteratorIndexedCref} = nil) ::List{IteratorIndexedCref}
              local outCrefs::List{IteratorIndexedCref}

              (_, outCrefs) = traverseExp(inExp, (inIterator) -> findIteratorIndexedCrefs_traverser(inIterator = inIterator), nil)
              outCrefs = ListUtil.fold(outCrefs, (iteratorIndexedCrefsEqual) -> ListUtil.unionEltOnTrue(inCompFunc = iteratorIndexedCrefsEqual), inCrefs)
          outCrefs
        end

         #= Traversal function used by deduceReductionIterationRange. Used to find crefs
           which are subscripted by a given iterator. =#
        function findIteratorIndexedCrefs_traverser(inExp::Exp, inCrefs::List{<:IteratorIndexedCref}, inIterator::String) ::Tuple{Exp, List{IteratorIndexedCref}}
              local outCrefs::List{IteratorIndexedCref}
              local outExp::Exp = inExp

              outCrefs = begin
                  local cref::ComponentRef
                @match inExp begin
                  CREF(componentRef = cref)  => begin
                    getIteratorIndexedCrefs(cref, inIterator, inCrefs)
                  end

                  _  => begin
                      inCrefs
                  end
                end
              end
          (outExp, outCrefs)
        end

         #= Checks whether two cref-index pairs are equal. =#
        function iteratorIndexedCrefsEqual(inCref1::IteratorIndexedCref, inCref2::IteratorIndexedCref) ::Bool
              local outEqual::Bool

              local cr1::ComponentRef
              local cr2::ComponentRef
              local idx1::ModelicaInteger
              local idx2::ModelicaInteger

              (cr1, idx1) = inCref1
              (cr2, idx2) = inCref2
              outEqual = idx1 == idx2 && crefEqual(cr1, cr2)
          outEqual
        end

         #= Checks if the given component reference is subscripted by the given iterator.
           Only cases where a subscript consists of only the iterator is considered.
           If so it adds a cref-index pair to the list, where the cref is the subscripted
           cref without subscripts, and the index is the subscripted dimension. E.g. for
           iterator i:
             a[i] => (a, 1), b[1, i] => (b, 2), c[i+1] => (), d[2].e[i] => (d[2].e, 1) =#
        function getIteratorIndexedCrefs(inCref::ComponentRef, inIterator::String, inCrefs::List{<:IteratorIndexedCref}) ::List{IteratorIndexedCref}
              local outCrefs::List{IteratorIndexedCref} = inCrefs

              local crefs::List{Tuple{ComponentRef, ModelicaInteger}}

              outCrefs = begin
                  local subs::List{Subscript}
                  local idx::ModelicaInteger
                  local name::String
                  local id::String
                  local cref::ComponentRef
                @match inCref begin
                  CREF_IDENT(name = id, subscripts = subs)  => begin
                       #=  For each subscript, check if the subscript consists of only the
                       =#
                       #=  iterator we're looking for.
                       =#
                      idx = 1
                      for sub in subs
                        _ = begin
                          @match sub begin
                            SUBSCRIPT(subscript = CREF(componentRef = CREF_IDENT(name = name, subscripts =  nil())))  => begin
                                if name == inIterator
                                  outCrefs = _cons((CREF_IDENT(id, nil), idx), outCrefs)
                                end
                              ()
                            end

                            _  => begin
                                ()
                            end
                          end
                        end
                        idx = idx + 1
                      end
                    outCrefs
                  end

                  CREF_QUAL(name = id, subscripts = subs, componentRef = cref)  => begin
                      crefs = getIteratorIndexedCrefs(cref, inIterator, nil)
                       #=  Append the prefix from the qualified cref to any matches, and add
                       =#
                       #=  them to the result list.
                       =#
                      for cr in crefs
                        (cref, idx) = cr
                        outCrefs = _cons((CREF_QUAL(id, subs, cref), idx), outCrefs)
                      end
                    getIteratorIndexedCrefs(CREF_IDENT(id, subs), inIterator, outCrefs)
                  end

                  CREF_FULLYQUALIFIED(componentRef = cref)  => begin
                      crefs = getIteratorIndexedCrefs(cref, inIterator, nil)
                       #=  Make any matches fully qualified, and add them to the result list.
                       =#
                      for cr in crefs
                        (cref, idx) = cr
                        outCrefs = _cons((CREF_FULLYQUALIFIED(cref), idx), outCrefs)
                      end
                    outCrefs
                  end

                  _  => begin
                      inCrefs
                  end
                end
              end
          outCrefs
        end

        function pathReplaceIdent(path::Path, last::String) ::Path
              local out::Path

              out = begin
                  local p::Path
                  local n::String
                  local s::String
                @match (path, last) begin
                  (FULLYQUALIFIED(p), s)  => begin
                      p = pathReplaceIdent(p, s)
                    FULLYQUALIFIED(p)
                  end

                  (QUALIFIED(n, p), s)  => begin
                      p = pathReplaceIdent(p, s)
                    QUALIFIED(n, p)
                  end

                  (IDENT(__), s)  => begin
                    IDENT(s)
                  end
                end
              end
          out
        end

        function getFileNameFromInfo(inInfo::SourceInfo) ::String
              local inFileName::String

              @match SOURCEINFO(fileName = inFileName) = inInfo
          inFileName
        end

         #= @author: adrpo
          this function returns true if the given InnerOuter
          is one of INNER_OUTER() or OUTER() =#
        function isOuter(io::InnerOuter) ::Bool
              local isItAnOuter::Bool

              isItAnOuter = begin
                @match io begin
                  INNER_OUTER(__)  => begin
                    true
                  end

                  OUTER(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          isItAnOuter
        end

         #= @author: adrpo
          this function returns true if the given InnerOuter
          is one of INNER_OUTER() or INNER() =#
        function isInner(io::InnerOuter) ::Bool
              local isItAnInner::Bool

              isItAnInner = begin
                @match io begin
                  INNER_OUTER(__)  => begin
                    true
                  end

                  INNER(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          isItAnInner
        end

         #= Returns true if the InnerOuter is INNER, false otherwise. =#
        function isOnlyInner(inIO::InnerOuter) ::Bool
              local outOnlyInner::Bool

              outOnlyInner = begin
                @match inIO begin
                  INNER(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outOnlyInner
        end

         #= Returns true if the InnerOuter is OUTER, false otherwise. =#
        function isOnlyOuter(inIO::InnerOuter) ::Bool
              local outOnlyOuter::Bool

              outOnlyOuter = begin
                @match inIO begin
                  OUTER(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outOnlyOuter
        end

        function isInnerOuter(inIO::InnerOuter) ::Bool
              local outIsInnerOuter::Bool

              outIsInnerOuter = begin
                @match inIO begin
                  INNER_OUTER(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsInnerOuter
        end

        function isNotInnerOuter(inIO::InnerOuter) ::Bool
              local outIsNotInnerOuter::Bool

              outIsNotInnerOuter = begin
                @match inIO begin
                  NOT_INNER_OUTER(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsNotInnerOuter
        end

         #= Returns true if two InnerOuter's are equal =#
        function innerOuterEqual(io1::InnerOuter, io2::InnerOuter) ::Bool
              local res::Bool

              res = begin
                @match (io1, io2) begin
                  (INNER(__), INNER(__))  => begin
                    true
                  end

                  (OUTER(__), OUTER(__))  => begin
                    true
                  end

                  (INNER_OUTER(__), INNER_OUTER(__))  => begin
                    true
                  end

                  (NOT_INNER_OUTER(__), NOT_INNER_OUTER(__))  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          res
        end

         #= Makes a path fully qualified unless it already is. =#
        function makeFullyQualified(inPath::Path) ::Path
              local outPath::Path

              outPath = begin
                @match inPath begin
                  FULLYQUALIFIED(__)  => begin
                    inPath
                  end

                  _  => begin
                      FULLYQUALIFIED(inPath)
                  end
                end
              end
          outPath
        end

         #= Makes a path not fully qualified unless it already is. =#
        function makeNotFullyQualified(inPath::Path) ::Path
              local outPath::Path

              outPath = begin
                  local path::Path
                @match inPath begin
                  FULLYQUALIFIED(path)  => begin
                    path
                  end

                  _  => begin
                      inPath
                  end
                end
              end
          outPath
        end

         #= Compares two import elements.  =#
        function importEqual(im1::Import, im2::Import) ::Bool
              local outBoolean::Bool

              outBoolean = begin
                  local id::Ident
                  local id2::Ident
                  local p1::Path
                  local p2::Path
                @matchcontinue (im1, im2) begin
                  (NAMED_IMPORT(name = id, path = p1), NAMED_IMPORT(name = id2, path = p2))  => begin
                      @match true = stringEq(id, id2)
                      @match true = pathEqual(p1, p2)
                    true
                  end

                  (QUAL_IMPORT(path = p1), QUAL_IMPORT(path = p2))  => begin
                      @match true = pathEqual(p1, p2)
                    true
                  end

                  (UNQUAL_IMPORT(path = p1), UNQUAL_IMPORT(path = p2))  => begin
                      @match true = pathEqual(p1, p2)
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outBoolean
        end

         #= Transforms an if-expression to canonical form (without else-if branches) =#
        function canonIfExp(inExp::Exp) ::Exp
              local outExp::Exp

              outExp = begin
                  local cond::Exp
                  local tb::Exp
                  local eb::Exp
                  local ei_cond::Exp
                  local ei_tb::Exp
                  local e::Exp
                  local eib::List{Tuple{Exp, Exp}}
                @match inExp begin
                  IFEXP(elseIfBranch =  nil())  => begin
                    inExp
                  end

                  IFEXP(ifExp = cond, trueBranch = tb, elseBranch = eb, elseIfBranch = (ei_cond, ei_tb) <| eib)  => begin
                      e = canonIfExp(IFEXP(ei_cond, ei_tb, eb, eib))
                    IFEXP(cond, tb, e, nil)
                  end
                end
              end
          outExp
        end

         #= @author: adrpo
          This function checks if a modification only contains literal expressions =#
        function onlyLiteralsInAnnotationMod(inMod::List{<:ElementArg}) ::Bool
              local onlyLiterals::Bool

              onlyLiterals = begin
                  local dive::List{ElementArg}
                  local rest::List{ElementArg}
                  local eqMod::EqMod
                  local b1::Bool
                  local b2::Bool
                  local b3::Bool
                  local b::Bool
                @matchcontinue inMod begin
                   nil()  => begin
                    true
                  end

                  MODIFICATION(path = IDENT(name = "interaction")) <| rest  => begin
                      b = onlyLiteralsInAnnotationMod(rest)
                    b
                  end

                  MODIFICATION(modification = SOME(CLASSMOD(dive, eqMod))) <| rest  => begin
                      b1 = onlyLiteralsInEqMod(eqMod)
                      b2 = onlyLiteralsInAnnotationMod(dive)
                      b3 = onlyLiteralsInAnnotationMod(rest)
                      b = boolAnd(b1, boolAnd(b2, b3))
                    b
                  end

                  _ <| rest  => begin
                      b = onlyLiteralsInAnnotationMod(rest)
                    b
                  end

                  _  => begin
                      false
                  end
                end
              end
               #=  skip \"interaction\" annotation!
               =#
               #=  search inside, some(exp)
               =#
               #=  failed above, return false
               =#
          onlyLiterals
        end

         #= @author: adrpo
          This function checks if an optional expression only contains literal expressions =#
        function onlyLiteralsInEqMod(eqMod::EqMod) ::Bool
              local onlyLiterals::Bool

              onlyLiterals = begin
                  local exp::Exp
                  local lst::List{Exp}
                  local b::Bool
                @match eqMod begin
                  NOMOD(__)  => begin
                    true
                  end

                  EQMOD(exp = exp)  => begin
                      @match (_, _cons(lst, nil)) = traverseExpBidir(exp, onlyLiteralsInExpEnter, onlyLiteralsInExpExit, _cons(nil, nil))
                      b = listEmpty(lst)
                    b
                  end
                end
              end
               #=  search inside, some(exp)
               =#
          onlyLiterals
        end

         #= @author: adrpo
         Visitor function for checking if Exp contains only literals, NO CREFS!
         It returns an empty list if it doesn't contain any crefs! =#
        function onlyLiteralsInExpEnter(inExp::Exp, inLst::List{<:List{<:Exp}}) ::Tuple{Exp, List{List{Exp}}}
              local outLst::List{List{Exp}}
              local outExp::Exp

              (outExp, outLst) = begin
                  local b::Bool
                  local e::Exp
                  local cr::ComponentRef
                  local lst::List{Exp}
                  local rest::List{List{Exp}}
                  local name::String
                  local fargs::FunctionArgs
                   #=  first handle all graphic enumerations!
                   =#
                   #=  FillPattern.*, Smooth.*, TextAlignment.*, etc!
                   =#
                @match (inExp, inLst) begin
                  (e && CREF(CREF_QUAL(name = name)), lst <| rest)  => begin
                      b = listMember(name, list("LinePattern", "Arrow", "FillPattern", "BorderPattern", "TextStyle", "Smooth", "TextAlignment"))
                      lst = ListUtil.consOnTrue(! b, e, lst)
                    (inExp, _cons(lst, rest))
                  end

                  (CREF(__), lst <| rest)  => begin
                    (inExp, _cons(_cons(inExp, lst), rest))
                  end

                  _  => begin
                      (inExp, inLst)
                  end
                end
              end
               #=  crefs, add to list
               =#
               #=  anything else, return the same!
               =#
          (outExp, outLst)
        end

         #= @author: adrpo
         Visitor function for checking if Exp contains only literals, NO CREFS!
         It returns an empty list if it doesn't contain any crefs! =#
        function onlyLiteralsInExpExit(inExp::Exp, inLst::List{<:List{<:Exp}}) ::Tuple{Exp, List{List{Exp}}}
              local outLst::List{List{Exp}}
              local outExp::Exp

              (outExp, outLst) = begin
                  local lst::List{List{Exp}}
                   #=  first handle DynamicSelect; pop the stack (ignore any crefs inside DynamicSelect)
                   =#
                @match (inExp, inLst) begin
                  (CALL(function_ = CREF_IDENT(name = "DynamicSelect")), lst)  => begin
                    (inExp, lst)
                  end

                  _  => begin
                      (inExp, inLst)
                  end
                end
              end
               #=  anything else, return the same!
               =#
          (outExp, outLst)
        end

        function makeCons(e1::Exp, e2::Exp) ::Exp
              local e::Exp

              e = CONS(e1, e2)
          e
        end

        function crefIdent(cr::ComponentRef) ::String
              local str::String

              @match CREF_IDENT(str, nil) = cr
          str
        end

        function unqotePathIdents(inPath::Path) ::Path
              local path::Path

              path = stringListPath(ListUtil.map(pathToStringList(inPath), System.unquoteIdentifier))
          path
        end

         #= If the given component reference is fully qualified this function removes the
          fully qualified qualifier, otherwise does nothing. =#
        function unqualifyCref(inCref::ComponentRef) ::ComponentRef
              local outCref::ComponentRef

              outCref = begin
                  local cref::ComponentRef
                @match inCref begin
                  CREF_FULLYQUALIFIED(componentRef = cref)  => begin
                    cref
                  end

                  _  => begin
                      inCref
                  end
                end
              end
          outCref
        end

        function pathIsFullyQualified(inPath::Path) ::Bool
              local outIsQualified::Bool

              outIsQualified = begin
                @match inPath begin
                  FULLYQUALIFIED(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsQualified
        end

        function pathIsIdent(inPath::Path) ::Bool
              local outIsIdent::Bool

              outIsIdent = begin
                @match inPath begin
                  IDENT(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsIdent
        end

        function pathIsQual(inPath::Path) ::Bool
              local outIsQual::Bool

              outIsQual = begin
                @match inPath begin
                  QUALIFIED(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsQual
        end

        function withinEqual(within1::Within, within2::Within) ::Bool
              local b::Bool

              b = begin
                  local p1::Path
                  local p2::Path
                @match (within1, within2) begin
                  (TOP(__), TOP(__))  => begin
                    true
                  end

                  (WITHIN(p1), WITHIN(p2))  => begin
                    pathEqual(p1, p2)
                  end

                  _  => begin
                      false
                  end
                end
              end
          b
        end

        function withinString(w1::Within) ::String
              local str::String

              str = begin
                  local p1::Path
                @match w1 begin
                  TOP(__)  => begin
                    "within ;"
                  end

                  WITHIN(p1)  => begin
                    "within " + pathString(p1) + ";"
                  end
                end
              end
          str
        end

        function joinWithinPath(within_::Within, path::Path) ::Path
              local outPath::Path

              outPath = begin
                  local path1::Path
                @match (within_, path) begin
                  (TOP(__), _)  => begin
                    path
                  end

                  (WITHIN(path1), _)  => begin
                    joinPaths(path1, path)
                  end
                end
              end
          outPath
        end

        function innerOuterStr(io::InnerOuter) ::String
              local str::String

              str = begin
                @match io begin
                  INNER_OUTER(__)  => begin
                    "inner outer "
                  end

                  INNER(__)  => begin
                    "inner "
                  end

                  OUTER(__)  => begin
                    "outer "
                  end

                  NOT_INNER_OUTER(__)  => begin
                    ""
                  end
                end
              end
          str
        end

        function subscriptExpOpt(inSub::Subscript) ::Option{Exp}
              local outExpOpt::Option{Exp}

              outExpOpt = begin
                  local e::Exp
                @match inSub begin
                  SUBSCRIPT(subscript = e)  => begin
                    SOME(e)
                  end

                  NOSUB(__)  => begin
                    NONE()
                  end
                end
              end
          outExpOpt
        end

        function crefInsertSubscriptLstLst(inExp::Exp, inLst::List{<:List{<:Subscript}}) ::Tuple{Exp, List{List{Subscript}}}
              local outLst::List{List{Subscript}}
              local outExp::Exp

              (outExp, outLst) = begin
                  local cref::ComponentRef
                  local cref2::ComponentRef
                  local subs::List{List{Subscript}}
                  local e::Exp
                @matchcontinue (inExp, inLst) begin
                  (CREF(componentRef = cref), subs)  => begin
                      cref2 = crefInsertSubscriptLstLst2(cref, subs)
                    (CREF(cref2), subs)
                  end

                  _  => begin
                      (inExp, inLst)
                  end
                end
              end
          (outExp, outLst)
        end

         #= Helper function to crefInsertSubscriptLstLst =#
        function crefInsertSubscriptLstLst2(inCref::ComponentRef, inSubs::List{<:List{<:Subscript}}) ::ComponentRef
              local outCref::ComponentRef

              outCref = begin
                  local cref::ComponentRef
                  local cref2::ComponentRef
                  local n::Ident
                  local subs::List{List{Subscript}}
                  local s::List{Subscript}
                @matchcontinue (inCref, inSubs) begin
                  (cref,  nil())  => begin
                    cref
                  end

                  (CREF_IDENT(name = n), s <|  nil())  => begin
                    CREF_IDENT(n, s)
                  end

                  (CREF_QUAL(name = n, componentRef = cref), s <| subs)  => begin
                      cref2 = crefInsertSubscriptLstLst2(cref, subs)
                    CREF_QUAL(n, s, cref2)
                  end

                  (CREF_FULLYQUALIFIED(componentRef = cref), subs)  => begin
                      cref2 = crefInsertSubscriptLstLst2(cref, subs)
                    crefMakeFullyQualified(cref2)
                  end
                end
              end
          outCref
        end

        function isCref(exp::Exp) ::Bool
              local b::Bool

              b = begin
                @match exp begin
                  CREF(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          b
        end

        function isTuple(exp::Exp) ::Bool
              local b::Bool

              b = begin
                @match exp begin
                  TUPLE(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          b
        end

         #= @author: johti
           Returns true if all fields are crefs =#
        function allFieldsAreCrefs(expLst::List{<:Exp}) ::Bool
              local b::Bool

              b = ListUtil.mapAllValueBool(expLst, complexIsCref, true)
          b
        end

         #=  @author: johti
            Returns true if everything contained
            in the tuple or a cons cell is a constant reference. =#
        function complexIsCref(inExp::Exp) ::Bool
              local b::Bool

              b = begin
                @match inExp begin
                  TUPLE(__)  => begin
                    allFieldsAreCrefs(inExp.expressions)
                  end

                  CONS(__)  => begin
                    complexIsCref(inExp.head) && complexIsCref(inExp.rest)
                  end

                  _  => begin
                    isCref(inExp)
                  end
                end
              end
          b
        end

        function isDerCref(exp::Exp) ::Bool
              local b::Bool

              b = begin
                @match exp begin
                  CALL(CREF_IDENT("der",  nil()), FUNCTIONARGS(CREF(__) <|  nil(),  nil()))  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          b
        end

        function isDerCrefFail(exp::Exp)
              @match CALL(CREF_IDENT("der", nil), FUNCTIONARGS(list(CREF()), nil)) = exp
        end

         #= author: adrpo
          returns all the expressions from array dimension as a list
          also returns if we have unknown dimensions in the array dimension =#
        function getExpsFromArrayDim(inAd::ArrayDim) ::Tuple{Bool, List{Exp}}
              local outExps::List{Exp}
              local hasUnknownDimensions::Bool

              (hasUnknownDimensions, outExps) = getExpsFromArrayDim_tail(inAd, nil)
          (hasUnknownDimensions, outExps)
        end

         #= author: adrpo
          returns all the expressions from array dimension as a list
          also returns if we have unknown dimensions in the array dimension =#
        function getExpsFromArrayDimOpt(inAdO::Option{<:ArrayDim}) ::Tuple{Bool, List{Exp}}
              local outExps::List{Exp}
              local hasUnknownDimensions::Bool

              (hasUnknownDimensions, outExps) = begin
                  local ad::ArrayDim
                @match inAdO begin
                  NONE()  => begin
                    (false, nil)
                  end

                  SOME(ad)  => begin
                      (hasUnknownDimensions, outExps) = getExpsFromArrayDim_tail(ad, nil)
                    (hasUnknownDimensions, outExps)
                  end
                end
              end
          (hasUnknownDimensions, outExps)
        end

         #= author: adrpo
          returns all the expressions from array dimension as a list
          also returns if we have unknown dimensions in the array dimension =#
        function getExpsFromArrayDim_tail(inAd::ArrayDim, inAccumulator::List{<:Exp}) ::Tuple{Bool, List{Exp}}
              local outExps::List{Exp}
              local hasUnknownDimensions::Bool

              (hasUnknownDimensions, outExps) = begin
                  local rest::List{Subscript}
                  local e::Exp
                  local exps::List{Exp}
                  local acc::List{Exp}
                  local b::Bool
                   #=  handle empty list
                   =#
                @match (inAd, inAccumulator) begin
                  ( nil(), acc)  => begin
                    (false, listReverse(acc))
                  end

                  (SUBSCRIPT(e) <| rest, acc)  => begin
                      (b, exps) = getExpsFromArrayDim_tail(rest, _cons(e, acc))
                    (b, exps)
                  end

                  (NOSUB(__) <| rest, acc)  => begin
                      (_, exps) = getExpsFromArrayDim_tail(rest, acc)
                    (true, exps)
                  end
                end
              end
               #=  handle SUBSCRIPT
               =#
               #=  handle NOSUB
               =#
          (hasUnknownDimensions, outExps)
        end

         #= @author: adrpo
         returns true if the given direction is input or output =#
        function isInputOrOutput(direction::Direction) ::Bool
              local isIorO::Bool #= input or output only =#

              isIorO = begin
                @match direction begin
                  INPUT(__)  => begin
                    true
                  end

                  OUTPUT(__)  => begin
                    true
                  end

                  INPUT_OUTPUT(__)  => begin
                    true
                  end

                  BIDIR(__)  => begin
                    false
                  end
                end
              end
          isIorO #= input or output only =#
        end

        function isInput(inDirection::Direction) ::Bool
              local outIsInput::Bool

              outIsInput = begin
                @match inDirection begin
                  INPUT(__)  => begin
                    true
                  end

                  INPUT_OUTPUT(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsInput
        end

        function isOutput(inDirection::Direction) ::Bool
              local outIsOutput::Bool

              outIsOutput = begin
                @match inDirection begin
                  OUTPUT(__)  => begin
                    true
                  end

                  INPUT_OUTPUT(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsOutput
        end

        function directionEqual(inDirection1::Direction, inDirection2::Direction) ::Bool
              local outEqual::Bool

              outEqual = begin
                @match (inDirection1, inDirection2) begin
                  (BIDIR(__), BIDIR(__))  => begin
                    true
                  end

                  (INPUT(__), INPUT(__))  => begin
                    true
                  end

                  (OUTPUT(__), OUTPUT(__))  => begin
                    true
                  end

                  (INPUT_OUTPUT(__), INPUT_OUTPUT(__))  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outEqual
        end

        function isFieldEqual(isField1::IsField, isField2::IsField) ::Bool
              local outEqual::Bool

              outEqual = begin
                @match (isField1, isField2) begin
                  (NONFIELD(__), NONFIELD(__))  => begin
                    true
                  end

                  (FIELD(__), FIELD(__))  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outEqual
        end

        function pathLt(path1::Path, path2::Path) ::Bool
              local lt::Bool

              lt = stringCompare(pathString(path1), pathString(path2)) < 0
          lt
        end

        function pathGe(path1::Path, path2::Path) ::Bool
              local ge::Bool

              ge = ! pathLt(path1, path2)
          ge
        end

         #= Strips out long class definitions =#
        function getShortClass(cl::Class) ::Class
              local o::Class

              o = begin
                  local name::Ident
                  local pa::Bool
                  local fi::Bool
                  local en::Bool
                  local re::Restriction
                  local body::ClassDef
                  local info::Info
                @match cl begin
                  CLASS(body = PARTS(__))  => begin
                    fail()
                  end

                  CLASS(body = CLASS_EXTENDS(__))  => begin
                    fail()
                  end

                  CLASS(name, pa, fi, en, re, body, info)  => begin
                      body = stripClassDefComment(body)
                    CLASS(name, pa, fi, en, re, body, info)
                  end
                end
              end
          o
        end

         #= Strips out class definition comments. =#
        function stripClassDefComment(cl::ClassDef) ::ClassDef
              local o::ClassDef

              o = begin
                  local enumLiterals::EnumDef
                  local typeSpec::TypeSpec
                  local attributes::ElementAttributes
                  local arguments::List{ElementArg}
                  local functionNames::List{Path}
                  local functionName::Path
                  local vars::List{Ident}
                  local typeVars::List{String}
                  local baseClassName::Ident
                  local modifications::List{ElementArg}
                  local parts::List{ClassPart}
                  local classAttrs::List{NamedArg}
                  local ann::List{Annotation}
                @match cl begin
                  PARTS(typeVars, classAttrs, parts, ann, _)  => begin
                    PARTS(typeVars, classAttrs, parts, ann, NONE())
                  end

                  CLASS_EXTENDS(baseClassName, modifications, _, parts, ann)  => begin
                    CLASS_EXTENDS(baseClassName, modifications, NONE(), parts, ann)
                  end

                  DERIVED(typeSpec, attributes, arguments, _)  => begin
                    DERIVED(typeSpec, attributes, arguments, NONE())
                  end

                  ENUMERATION(enumLiterals, _)  => begin
                    ENUMERATION(enumLiterals, NONE())
                  end

                  OVERLOAD(functionNames, _)  => begin
                    OVERLOAD(functionNames, NONE())
                  end

                  PDER(functionName, vars, _)  => begin
                    PDER(functionName, vars, NONE())
                  end

                  _  => begin
                      cl
                  end
                end
              end
          o
        end

         #= Strips out the parts of a function definition that are not needed for the interface =#
        function getFunctionInterface(cl::Class) ::Class
              local o::Class

              o = begin
                  local name::Ident
                  local partialPrefix::Bool
                  local finalPrefix::Bool
                  local encapsulatedPrefix::Bool
                  local info::Info
                  local typeVars::List{String}
                  local classParts::List{ClassPart}
                  local elts::List{ElementItem}
                  local funcRest::FunctionRestriction
                  local classAttr::List{NamedArg}
                @match cl begin
                  CLASS(name, partialPrefix, finalPrefix, encapsulatedPrefix, R_FUNCTION(funcRest), PARTS(typeVars, classAttr, classParts, _, _), info)  => begin
                      @match (@match _cons(_, _) = elts) = ListUtil.fold(listReverse(classParts), getFunctionInterfaceParts, nil)
                    CLASS(name, partialPrefix, finalPrefix, encapsulatedPrefix, R_FUNCTION(funcRest), PARTS(typeVars, classAttr, _cons(PUBLIC(elts), nil), nil, NONE()), info)
                  end
                end
              end
          o
        end

        function getFunctionInterfaceParts(part::ClassPart, elts::List{<:ElementItem}) ::List{ElementItem}
              local oelts::List{ElementItem}

              oelts = begin
                  local elts1::List{ElementItem}
                  local elts2::List{ElementItem}
                @match (part, elts) begin
                  (PUBLIC(elts1), elts2)  => begin
                      elts1 = ListUtil.filterOnTrue(elts1, filterAnnotationItem)
                    listAppend(elts1, elts2)
                  end

                  _  => begin
                      elts
                  end
                end
              end
          oelts
        end

        function filterAnnotationItem(elt::ElementItem) ::Bool
              local outB::Bool

              outB = begin
                @match elt begin
                  ELEMENTITEM(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outB
        end

         #= Filter outs the nested classes from the class if any. =#
        function filterNestedClasses(cl::Class) ::Class
              local o::Class

              o = begin
                  local name::Ident
                  local partialPrefix::Bool
                  local finalPrefix::Bool
                  local encapsulatedPrefix::Bool
                  local restriction::Restriction
                  local typeVars::List{String}
                  local classAttrs::List{NamedArg}
                  local classParts::List{ClassPart}
                  local annotations::List{Annotation}
                  local comment::Option{String}
                  local info::Info
                @match cl begin
                  CLASS(name, partialPrefix, finalPrefix, encapsulatedPrefix, restriction, PARTS(typeVars, classAttrs, classParts, annotations, comment), info)  => begin
                      @match (@match _cons(_, _) = classParts) = ListUtil.fold(listReverse(classParts), filterNestedClassesParts, nil)
                    CLASS(name, partialPrefix, finalPrefix, encapsulatedPrefix, restriction, PARTS(typeVars, classAttrs, classParts, annotations, comment), info)
                  end

                  _  => begin
                      cl
                  end
                end
              end
          o
        end

         #= Helper funciton for filterNestedClassesParts. =#
        function filterNestedClassesParts(classPart::ClassPart, inClassParts::List{<:ClassPart}) ::List{ClassPart}
              local outClassPart::List{ClassPart}

              outClassPart = begin
                  local classParts::List{ClassPart}
                  local elts::List{ElementItem}
                @match (classPart, inClassParts) begin
                  (PUBLIC(elts), classParts)  => begin
                      classPart.contents = ListUtil.filterOnFalse(elts, isElementItemClass)
                    _cons(classPart, classParts)
                  end

                  (PROTECTED(elts), classParts)  => begin
                      classPart.contents = ListUtil.filterOnFalse(elts, isElementItemClass)
                    _cons(classPart, classParts)
                  end

                  _  => begin
                      _cons(classPart, inClassParts)
                  end
                end
              end
          outClassPart
        end

         #= @author: adrpo
           returns the EXTERNAL form parts if there is any.
           if there is none, it fails! =#
        function getExternalDecl(inCls::Class) ::ClassPart
              local outExternal::ClassPart

              local cp::ClassPart
              local class_parts::List{ClassPart}

              @match CLASS(body = PARTS(classParts = class_parts)) = inCls
              outExternal = ListUtil.find(class_parts, isExternalPart)
          outExternal
        end

        function isExternalPart(inClassPart::ClassPart) ::Bool
              local outFound::Bool

              outFound = begin
                @match inClassPart begin
                  EXTERNAL(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outFound
        end

        function isParts(cl::ClassDef) ::Bool
              local b::Bool

              b = begin
                @match cl begin
                  PARTS(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          b
        end

         #= Makes a class into an ElementItem =#
        function makeClassElement(cl::Class) ::ElementItem
              local el::ElementItem

              local info::Info
              local fp::Bool

              @match CLASS(finalPrefix = fp, info = info) = cl
              el = ELEMENTITEM(ELEMENT(fp, NONE(), NOT_INNER_OUTER(), CLASSDEF(false, cl), info, NONE()))
          el
        end

        function componentName(c::ComponentItem) ::String
              local name::String

              @match COMPONENTITEM(component = COMPONENT(name = name)) = c
          name
        end

        function pathSetLastIdent(inPath::Path, inLastIdent::Path) ::Path
              local outPath::Path

              outPath = begin
                  local p::Path
                  local n::String
                @match (inPath, inLastIdent) begin
                  (IDENT(__), _)  => begin
                    inLastIdent
                  end

                  (QUALIFIED(n, p), _)  => begin
                      p = pathSetLastIdent(p, inLastIdent)
                    QUALIFIED(n, p)
                  end

                  (FULLYQUALIFIED(p), _)  => begin
                      p = pathSetLastIdent(p, inLastIdent)
                    FULLYQUALIFIED(p)
                  end
                end
              end
          outPath
        end

         #= @author:
          returns true if expression contains initial() =#
        function expContainsInitial(inExp::Exp) ::Bool
              local hasInitial::Bool

              hasInitial = begin
                  local b::Bool
                @matchcontinue inExp begin
                  _  => begin
                      (_, b) = traverseExp(inExp, isInitialTraverseHelper, false)
                    b
                  end

                  _  => begin
                      false
                  end
                end
              end
          hasInitial
        end

         #= @author:
          returns true if expression is initial() =#
        function isInitialTraverseHelper(inExp::Exp, inBool::Bool) ::Tuple{Exp, Bool}
              local outBool::Bool
              local outExp::Exp

              (outExp, outBool) = begin
                  local e::Exp
                  local b::Bool
                   #=  make sure we don't have not initial()
                   =#
                @match (inExp, inBool) begin
                  (UNARY(NOT(__), _), _)  => begin
                    (inExp, inBool)
                  end

                  (e, _)  => begin
                      b = isInitial(e)
                    (e, b)
                  end

                  _  => begin
                      (inExp, inBool)
                  end
                end
              end
               #=  we have initial
               =#
          (outExp, outBool)
        end

         #= @author:
          returns true if expression is initial() =#
        function isInitial(inExp::Exp) ::Bool
              local hasReinit::Bool

              hasReinit = begin
                @match inExp begin
                  CALL(function_ = CREF_IDENT("initial", _))  => begin
                    true
                  end

                  CALL(function_ = CREF_FULLYQUALIFIED(CREF_IDENT("initial", _)))  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          hasReinit
        end

         #= Return the path of the given import. =#
        function importPath(inImport::Import) ::Path
              local outPath::Path

              outPath = begin
                  local path::Path
                @match inImport begin
                  NAMED_IMPORT(path = path)  => begin
                    path
                  end

                  QUAL_IMPORT(path = path)  => begin
                    path
                  end

                  UNQUAL_IMPORT(path = path)  => begin
                    path
                  end

                  GROUP_IMPORT(prefix = path)  => begin
                    path
                  end
                end
              end
          outPath
        end

         #= Returns the import name of a named or qualified import. =#
        function importName(inImport::Import) ::Ident
              local outName::Ident

              outName = begin
                  local name::Ident
                  local path::Path
                   #=  Named import has a given name, 'import D = A.B.C' => D.
                   =#
                @match inImport begin
                  NAMED_IMPORT(name = name)  => begin
                    name
                  end

                  QUAL_IMPORT(path = path)  => begin
                    pathLastIdent(path)
                  end
                end
              end
               #=  Qualified import uses the last identifier, 'import A.B.C' => C.
               =#
          outName
        end

         #=  This function takes an old annotation as first argument and a new
           annotation as  second argument and merges the two.
           Annotation \\\"parts\\\" that exist in both the old and the new annotation
           will be changed according to the new definition. For instance,
           merge_annotations(annotation(x=1,y=2),annotation(x=3))
           => annotation(x=3,y=2) =#
        function mergeAnnotations(inAnnotation1::Annotation, inAnnotation2::Annotation) ::Annotation
              local outAnnotation::Annotation

              outAnnotation = begin
                  local oldmods::List{ElementArg}
                  local newmods::List{ElementArg}
                  local a::Annotation
                @match (inAnnotation1, inAnnotation2) begin
                  (ANNOTATION(elementArgs =  nil()), a)  => begin
                    a
                  end

                  (ANNOTATION(elementArgs = oldmods), ANNOTATION(elementArgs = newmods))  => begin
                    ANNOTATION(mergeAnnotations2(oldmods, newmods))
                  end
                end
              end
          outAnnotation
        end

        function mergeAnnotations2(oldmods::List{<:ElementArg}, newmods::List{<:ElementArg}) ::List{ElementArg}
              local res::List{ElementArg} = listReverse(oldmods)

              local mods::List{ElementArg}
              local b::Bool
              local p::Path
              local mod1::ElementArg
              local mod2::ElementArg

              for mod in newmods
                @match MODIFICATION(path = p) = mod
                try
                  mod2 = ListUtil.find(res, (p) -> isModificationOfPath(path = p))
                  mod1 = subModsInSameOrder(mod2, mod)
                  @match (res, true) = ListUtil.replaceOnTrue(mod1, res, (p) -> isModificationOfPath(path = p))
                catch
                  res = _cons(mod, res)
                end
              end
              res = listReverse(res)
          res
        end

         #= Merges an annotation into a Comment option. =#
        function mergeCommentAnnotation(inAnnotation::Annotation, inComment::Option{<:Comment}) ::Option{Comment}
              local outComment::Option{Comment}

              outComment = begin
                  local ann::Annotation
                  local cmt::Option{String}
                   #=  No comment, create a new one.
                   =#
                @match inComment begin
                  NONE()  => begin
                    SOME(COMMENT(SOME(inAnnotation), NONE()))
                  end

                  SOME(COMMENT(annotation_ = NONE(), comment = cmt))  => begin
                    SOME(COMMENT(SOME(inAnnotation), cmt))
                  end

                  SOME(COMMENT(annotation_ = SOME(ann), comment = cmt))  => begin
                    SOME(COMMENT(SOME(mergeAnnotations(ann, inAnnotation)), cmt))
                  end
                end
              end
               #=  A comment without annotation, insert the annotation.
               =#
               #=  A comment with annotation, merge the annotations.
               =#
          outComment
        end

         #= returns true or false if the given path is in the list of modifications =#
        function isModificationOfPath(mod::ElementArg, path::Path) ::Bool
              local yes::Bool

              yes = begin
                  local id1::String
                  local id2::String
                @match (mod, path) begin
                  (MODIFICATION(path = IDENT(name = id1)), IDENT(name = id2))  => begin
                    id1 == id2
                  end

                  _  => begin
                      false
                  end
                end
              end
          yes
        end

        function subModsInSameOrder(oldmod::ElementArg, newmod::ElementArg) ::ElementArg
              local mod::ElementArg

              mod = begin
                  local args1::List{ElementArg}
                  local args2::List{ElementArg}
                  local res::List{ElementArg}
                  local arg2::ElementArg
                  local eq1::EqMod
                  local eq2::EqMod
                  local p::Path
                   #=  mod1 or mod2 has no submods
                   =#
                @match (oldmod, newmod) begin
                  (_, MODIFICATION(modification = NONE()))  => begin
                    newmod
                  end

                  (MODIFICATION(modification = NONE()), _)  => begin
                    newmod
                  end

                  (MODIFICATION(modification = SOME(CLASSMOD(args1, _))), arg2 && MODIFICATION(modification = SOME(CLASSMOD(args2, eq2))))  => begin
                       #=  mod1
                       =#
                       #=  Delete all items from args2 that are not in args1
                       =#
                      res = nil
                      for arg1 in args1
                        @match MODIFICATION(path = p) = arg1
                        if ListUtil.exist(args2, (p) -> isModificationOfPath(path = p))
                          res = _cons(arg1, res)
                        end
                      end
                      res = listReverse(res)
                       #=  Merge the annotations
                       =#
                      res = mergeAnnotations2(res, args2)
                      arg2.modification = SOME(CLASSMOD(res, eq2))
                    arg2
                  end
                end
              end
          mod
        end

        function annotationToElementArgs(ann::Annotation) ::List{ElementArg}
              local args::List{ElementArg}

              @match ANNOTATION(args) = ann
          args
        end

        function pathToTypeSpec(inPath::Path) ::TypeSpec
              local outTypeSpec::TypeSpec

              outTypeSpec = TPATH(inPath, NONE())
          outTypeSpec
        end

        function typeSpecString(inTs::TypeSpec) ::String
              local outStr::String

              outStr = Dump.unparseTypeSpec(inTs)
          outStr
        end

        function crefString(inCr::ComponentRef) ::String
              local outStr::String

              outStr = Dump.printComponentRefStr(inCr)
          outStr
        end

        function typeSpecStringNoQualNoDims(inTs::TypeSpec) ::String
              local outStr::String

              outStr = begin
                  local str::Ident
                  local s::Ident
                  local str1::Ident
                  local str2::Ident
                  local str3::Ident
                  local path::Path
                  local adim::Option{List{Subscript}}
                  local typeSpecLst::List{TypeSpec}
                @match inTs begin
                  TPATH(path = path)  => begin
                      str = pathString(makeNotFullyQualified(path))
                    str
                  end

                  TCOMPLEX(path = path, typeSpecs = typeSpecLst)  => begin
                      str1 = pathString(makeNotFullyQualified(path))
                      str2 = typeSpecStringNoQualNoDimsLst(typeSpecLst)
                      str = stringAppendList(list(str1, "<", str2, ">"))
                    str
                  end
                end
              end
          outStr
        end

        function typeSpecStringNoQualNoDimsLst(inTypeSpecLst::List{<:TypeSpec}) ::String
              local outString::String

              outString = ListUtil.toString(inTypeSpecLst, typeSpecStringNoQualNoDims, "", "", ", ", "", false)
          outString
        end

        function crefStringIgnoreSubs(inCr::ComponentRef) ::String
              local outStr::String

              local p::Path

              p = crefToPathIgnoreSubs(inCr)
              outStr = pathString(makeNotFullyQualified(p))
          outStr
        end

        function importString(inImp::Import) ::String
              local outStr::String

              outStr = Dump.unparseImportStr(inImp)
          outStr
        end

         #= @author: adrpo
         full Ref -> string
         cref/path full qualified, type dims, subscripts in crefs =#
        function refString(inRef::Ref) ::String
              local outStr::String

              outStr = begin
                  local cr::ComponentRef
                  local ts::TypeSpec
                  local im::Import
                @match inRef begin
                  RCR(cr)  => begin
                    crefString(cr)
                  end

                  RTS(ts)  => begin
                    typeSpecString(ts)
                  end

                  RIM(im)  => begin
                    importString(im)
                  end
                end
              end
          outStr
        end

         #= @author: adrpo
         brief Ref -> string
         no cref/path full qualified, no type dims, no subscripts in crefs =#
        function refStringBrief(inRef::Ref) ::String
              local outStr::String

              outStr = begin
                  local cr::ComponentRef
                  local ts::TypeSpec
                  local im::Import
                @match inRef begin
                  RCR(cr)  => begin
                    crefStringIgnoreSubs(cr)
                  end

                  RTS(ts)  => begin
                    typeSpecStringNoQualNoDims(ts)
                  end

                  RIM(im)  => begin
                    importString(im)
                  end
                end
              end
          outStr
        end

        function getArrayDimOptAsList(inArrayDim::Option{<:ArrayDim}) ::ArrayDim
              local outArrayDim::ArrayDim

              outArrayDim = begin
                  local ad::ArrayDim
                @match inArrayDim begin
                  SOME(ad)  => begin
                    ad
                  end

                  _  => begin
                      nil
                  end
                end
              end
          outArrayDim
        end

         #= Removes a variable from a variable list =#
        function removeCrefFromCrefs(inAbsynComponentRefLst::List{<:ComponentRef}, inComponentRef::ComponentRef) ::List{ComponentRef}
              local outAbsynComponentRefLst::List{ComponentRef}

              outAbsynComponentRefLst = begin
                  local n1::String
                  local n2::String
                  local rest_1::List{ComponentRef}
                  local rest::List{ComponentRef}
                  local cr1::ComponentRef
                  local cr2::ComponentRef
                @matchcontinue (inAbsynComponentRefLst, inComponentRef) begin
                  ( nil(), _)  => begin
                    nil
                  end

                  (cr1 <| rest, cr2)  => begin
                      @match CREF_IDENT(name = n1, subscripts = nil) = cr1
                      @match CREF_IDENT(name = n2, subscripts = nil) = cr2
                      @match true = stringEq(n1, n2)
                      rest_1 = removeCrefFromCrefs(rest, cr2)
                    rest_1
                  end

                  (cr1 <| rest, cr2)  => begin
                      @match CREF_QUAL(name = n1) = cr1
                      @match CREF_IDENT(name = n2) = cr2
                      @match true = stringEq(n1, n2)
                      rest_1 = removeCrefFromCrefs(rest, cr2)
                    rest_1
                  end

                  (cr1 <| rest, cr2)  => begin
                      rest_1 = removeCrefFromCrefs(rest, cr2)
                    _cons(cr1, rest_1)
                  end
                end
              end
               #=  If modifier like on comp like: T t(x=t.y) => t.y must be removed
               =#
          outAbsynComponentRefLst
        end

         #= Retrieve e.g. the documentation annotation as a string from the class passed as argument. =#
        function getNamedAnnotationInClass(inClass::Class, id::Path, f::ModFunc) ::Option{TypeA}
              local outString::Option{TypeA}

              outString = begin
                  local str::TypeA
                  local res::TypeA
                  local parts::List{ClassPart}
                  local annlst::List{ElementArg}
                  local ann::List{Annotation}
                @matchcontinue (inClass, id, f) begin
                  (CLASS(body = PARTS(ann = ann)), _, _)  => begin
                      annlst = ListUtil.flatten(ListUtil.map(ann, annotationToElementArgs))
                      @match SOME(str) = getNamedAnnotationStr(annlst, id, f)
                    SOME(str)
                  end

                  (CLASS(body = CLASS_EXTENDS(ann = ann)), _, _)  => begin
                      annlst = ListUtil.flatten(ListUtil.map(ann, annotationToElementArgs))
                      @match SOME(str) = getNamedAnnotationStr(annlst, id, f)
                    SOME(str)
                  end

                  (CLASS(body = DERIVED(comment = SOME(COMMENT(SOME(ANNOTATION(annlst)), _)))), _, _)  => begin
                      @match SOME(res) = getNamedAnnotationStr(annlst, id, f)
                    SOME(res)
                  end

                  (CLASS(body = ENUMERATION(comment = SOME(COMMENT(SOME(ANNOTATION(annlst)), _)))), _, _)  => begin
                      @match SOME(res) = getNamedAnnotationStr(annlst, id, f)
                    SOME(res)
                  end

                  (CLASS(body = OVERLOAD(comment = SOME(COMMENT(SOME(ANNOTATION(annlst)), _)))), _, _)  => begin
                      @match SOME(res) = getNamedAnnotationStr(annlst, id, f)
                    SOME(res)
                  end

                  _  => begin
                      NONE()
                  end
                end
              end
          outString
        end

         #= Helper function to getNamedAnnotationInElementitemlist. =#
        function getNamedAnnotationStr(inAbsynElementArgLst::List{<:ElementArg}, id::Path, f::ModFunc) ::Option{TypeA}
              local outString::Option{TypeA}

              outString = begin
                  local str::TypeA
                  local ann::ElementArg
                  local mod::Option{Modification}
                  local xs::List{ElementArg}
                  local id1::Ident
                  local id2::Ident
                  local rest::Path
                @matchcontinue (inAbsynElementArgLst, id, f) begin
                  (MODIFICATION(path = IDENT(name = id1), modification = mod) <| _, IDENT(id2), _)  => begin
                      @match true = stringEq(id1, id2)
                      str = f(mod)
                    SOME(str)
                  end

                  (MODIFICATION(path = IDENT(name = id1), modification = SOME(CLASSMOD(elementArgLst = xs))) <| _, QUALIFIED(name = id2, path = rest), _)  => begin
                      @match true = stringEq(id1, id2)
                    getNamedAnnotationStr(xs, rest, f)
                  end

                  (_ <| xs, _, _)  => begin
                    getNamedAnnotationStr(xs, id, f)
                  end
                end
              end
          outString
        end

         #= This function splits each part of a cref into CREF_IDENTs and applies the
           given function to each part. If the given cref is a qualified cref then the
           map function is expected to also return CREF_IDENT, so that the split cref
           can be reconstructed. Otherwise the map function is free to return whatever
           it wants. =#
        function mapCrefParts(inCref::ComponentRef, inMapFunc::MapFunc) ::ComponentRef
              local outCref::ComponentRef

              outCref = begin
                  local name::Ident
                  local subs::List{Subscript}
                  local rest_cref::ComponentRef
                  local cref::ComponentRef
                @match (inCref, inMapFunc) begin
                  (CREF_QUAL(name, subs, rest_cref), _)  => begin
                      cref = CREF_IDENT(name, subs)
                      @match CREF_IDENT(name, subs) = inMapFunc(cref)
                      rest_cref = mapCrefParts(rest_cref, inMapFunc)
                    CREF_QUAL(name, subs, rest_cref)
                  end

                  (CREF_FULLYQUALIFIED(cref), _)  => begin
                      cref = mapCrefParts(cref, inMapFunc)
                    CREF_FULLYQUALIFIED(cref)
                  end

                  _  => begin
                        cref = inMapFunc(inCref)
                      cref
                  end
                end
              end
          outCref
        end

        function opEqual(op1::Operator, op2::Operator) ::Bool
              local isEqual::Bool

              isEqual = valueEq(op1, op2)
          isEqual
        end

        function opIsElementWise(op::Operator) ::Bool
              local isElementWise::Bool

              isElementWise = begin
                @match op begin
                  ADD_EW(__)  => begin
                    true
                  end

                  SUB_EW(__)  => begin
                    true
                  end

                  MUL_EW(__)  => begin
                    true
                  end

                  DIV_EW(__)  => begin
                    true
                  end

                  POW_EW(__)  => begin
                    true
                  end

                  UPLUS_EW(__)  => begin
                    true
                  end

                  UMINUS_EW(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          isElementWise
        end

        function dummyTraverseExp(inExp::Exp, inArg::Arg) ::Tuple{Exp, Arg}
              local outArg::Arg
              local outExp::Exp

              outExp = inExp
              outArg = inArg
          (outExp, outArg)
        end

         #= retrives defineunit definitions in elements =#
        function getDefineUnitsInElements(elts::List{<:ElementItem}) ::List{Element}
              local outElts::List{Element}

              outElts = begin
                  local e::Element
                  local rest::List{ElementItem}
                @matchcontinue elts begin
                   nil()  => begin
                    nil
                  end

                  ELEMENTITEM(e && DEFINEUNIT(__)) <| rest  => begin
                      outElts = getDefineUnitsInElements(rest)
                    _cons(e, outElts)
                  end

                  _ <| rest  => begin
                    getDefineUnitsInElements(rest)
                  end
                end
              end
          outElts
        end

         #= Returns the public and protected elements in a class. =#
        function getElementItemsInClass(inClass::Class) ::List{ElementItem}
              local outElements::List{ElementItem}

              outElements = begin
                  local parts::List{ClassPart}
                @match inClass begin
                  CLASS(body = PARTS(classParts = parts))  => begin
                    ListUtil.mapFlat(parts, getElementItemsInClassPart)
                  end

                  CLASS(body = CLASS_EXTENDS(parts = parts))  => begin
                    ListUtil.mapFlat(parts, getElementItemsInClassPart)
                  end

                  _  => begin
                      nil
                  end
                end
              end
          outElements
        end

         #= Returns the public and protected elements in a class part. =#
        function getElementItemsInClassPart(inClassPart::ClassPart) ::List{ElementItem}
              local outElements::List{ElementItem}

              outElements = begin
                  local elts::List{ElementItem}
                @match inClassPart begin
                  PUBLIC(contents = elts)  => begin
                    elts
                  end

                  PROTECTED(contents = elts)  => begin
                    elts
                  end

                  _  => begin
                      nil
                  end
                end
              end
          outElements
        end

        function traverseClassComponents(inClass::Class, inFunc::FuncType, inArg::ArgT)  where {ArgT}
              local outArg::ArgT
              local outClass::Class = inClass

              outClass = begin
                  local body::ClassDef
                @match outClass begin
                  CLASS(__)  => begin
                      (body, outArg) = traverseClassDef(outClass.body, (inFunc) -> traverseClassPartComponents(inFunc = inFunc), inArg)
                      if ! referenceEq(body, outClass.body)
                        outClass.body = body
                      end
                    outClass
                  end
                end
              end
          (outClass, outArg)
        end

        function traverseListGeneric(inList::List{T}, inFunc::FuncType, inArg::ArgT)  where {T, ArgT}
              local outContinue::Bool = true
              local outArg::ArgT = inArg
              local outList::List{T} = nil

              local eq::Bool
              local changed::Bool = false
              local e::T
              local new_e::T
              local rest_e::List{T} = inList

              while ! listEmpty(rest_e)
                @match _cons(e, rest_e) = rest_e
                (new_e, outArg, outContinue) = inFunc(e, outArg)
                eq = referenceEq(new_e, e)
                outList = _cons(if eq
                      e
                    else
                      new_e
                    end, outList)
                changed = changed || ! eq
                if ! outContinue
                  break
                end
              end
              if changed
                outList = ListUtil.append_reverse(outList, rest_e)
              else
                outList = inList
              end
          (outList, outArg, outContinue)
        end

        function traverseClassPartComponents(inClassPart::ClassPart, inFunc::FuncType, inArg::ArgT)  where {ArgT}
              local outContinue::Bool = true
              local outArg::ArgT = inArg
              local outClassPart::ClassPart = inClassPart

              _ = begin
                  local items::List{ElementItem}
                @match outClassPart begin
                  PUBLIC(__)  => begin
                      (items, outArg, outContinue) = traverseListGeneric(outClassPart.contents, (inFunc) -> traverseElementItemComponents(inFunc = inFunc), inArg)
                      outClassPart.contents = items
                    ()
                  end

                  PROTECTED(__)  => begin
                      (items, outArg, outContinue) = traverseListGeneric(outClassPart.contents, (inFunc) -> traverseElementItemComponents(inFunc = inFunc), inArg)
                      outClassPart.contents = items
                    ()
                  end

                  _  => begin
                      ()
                  end
                end
              end
          (outClassPart, outArg, outContinue)
        end

        function traverseElementItemComponents(inItem::ElementItem, inFunc::FuncType, inArg::ArgT)  where {ArgT}
              local outContinue::Bool
              local outArg::ArgT
              local outItem::ElementItem

              (outItem, outArg, outContinue) = begin
                  local elem::Element
                @match inItem begin
                  ELEMENTITEM(__)  => begin
                      (elem, outArg, outContinue) = traverseElementComponents(inItem.element, inFunc, inArg)
                      outItem = if referenceEq(elem, inItem.element)
                            inItem
                          else
                            ELEMENTITEM(elem)
                          end
                    (outItem, outArg, outContinue)
                  end

                  _  => begin
                      (inItem, inArg, true)
                  end
                end
              end
          (outItem, outArg, outContinue)
        end

        function traverseElementComponents(inElement::Element, inFunc::FuncType, inArg::ArgT)  where {ArgT}
              local outContinue::Bool
              local outArg::ArgT
              local outElement::Element = inElement

              (outElement, outArg, outContinue) = begin
                  local spec::ElementSpec
                @match outElement begin
                  ELEMENT(__)  => begin
                      (spec, outArg, outContinue) = traverseElementSpecComponents(outElement.specification, inFunc, inArg)
                      if ! referenceEq(spec, outElement.specification)
                        outElement.specification = spec
                      end
                    (outElement, outArg, outContinue)
                  end

                  _  => begin
                      (inElement, inArg, true)
                  end
                end
              end
          (outElement, outArg, outContinue)
        end

        function traverseElementSpecComponents(inSpec::ElementSpec, inFunc::FuncType, inArg::ArgT)  where {ArgT}
              local outContinue::Bool
              local outArg::ArgT
              local outSpec::ElementSpec = inSpec

              (outSpec, outArg, outContinue) = begin
                  local cls::Class
                  local comps::List{ComponentItem}
                @match outSpec begin
                  COMPONENTS(__)  => begin
                      (comps, outArg, outContinue) = inFunc(outSpec.components, inArg)
                      if ! referenceEq(comps, outSpec.components)
                        outSpec.components = comps
                      end
                    (outSpec, outArg, outContinue)
                  end

                  _  => begin
                      (inSpec, inArg, true)
                  end
                end
              end
          (outSpec, outArg, outContinue)
        end

        function traverseClassDef(inClassDef::ClassDef, inFunc::FuncType, inArg::ArgT)  where {ArgT}
              local outContinue::Bool = true
              local outArg::ArgT = inArg
              local outClassDef::ClassDef = inClassDef

              _ = begin
                  local parts::List{ClassPart}
                @match outClassDef begin
                  PARTS(__)  => begin
                      (parts, outArg, outContinue) = traverseListGeneric(outClassDef.classParts, inFunc, inArg)
                      outClassDef.classParts = parts
                    ()
                  end

                  CLASS_EXTENDS(__)  => begin
                      (parts, outArg, outContinue) = traverseListGeneric(outClassDef.parts, inFunc, inArg)
                      outClassDef.parts = parts
                    ()
                  end

                  _  => begin
                      ()
                  end
                end
              end
          (outClassDef, outArg, outContinue)
        end

        function isEmptyMod(inMod::Modification) ::Bool
              local outIsEmpty::Bool

              outIsEmpty = begin
                @match inMod begin
                  CLASSMOD( nil(), NOMOD(__))  => begin
                    true
                  end

                  CLASSMOD( nil(), EQMOD(exp = TUPLE(expressions =  nil())))  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsEmpty
        end

        function isEmptySubMod(inSubMod::ElementArg) ::Bool
              local outIsEmpty::Bool

              outIsEmpty = begin
                  local mod::Modification
                @match inSubMod begin
                  MODIFICATION(modification = NONE())  => begin
                    true
                  end

                  MODIFICATION(modification = SOME(mod))  => begin
                    isEmptyMod(mod)
                  end
                end
              end
          outIsEmpty
        end

        function elementArgName(inArg::ElementArg) ::Path
              local outName::Path

              outName = begin
                  local e::ElementSpec
                @match inArg begin
                  MODIFICATION(path = outName)  => begin
                    outName
                  end

                  REDECLARATION(elementSpec = e)  => begin
                    makeIdentPathFromString(elementSpecName(e))
                  end
                end
              end
          outName
        end

        function elementArgEqualName(inArg1::ElementArg, inArg2::ElementArg) ::Bool
              local outEqual::Bool

              local name1::Path
              local name2::Path

              outEqual = begin
                @match (inArg1, inArg2) begin
                  (MODIFICATION(path = name1), MODIFICATION(path = name2))  => begin
                    pathEqual(name1, name2)
                  end

                  _  => begin
                      false
                  end
                end
              end
          outEqual
        end

         #= Creates a Msg based on a boolean value. =#
        function optMsg(inShowMessage::Bool, inInfo::SourceInfo) ::Msg
              local outMsg::Msg

              outMsg = if inShowMessage
                    MSG(inInfo)
                  else
                    NO_MSG()
                  end
          outMsg
        end

        function makeSubscript(inExp::Exp) ::Subscript
              local outSubscript::Subscript

              outSubscript = SUBSCRIPT(inExp)
          outSubscript
        end

         #= Splits a cref into parts. =#
        function crefExplode(inCref::ComponentRef, inAccum::List{<:ComponentRef} = nil) ::List{ComponentRef}
              local outCrefParts::List{ComponentRef}

              outCrefParts = begin
                @match inCref begin
                  CREF_QUAL(__)  => begin
                    crefExplode(inCref.componentRef, _cons(crefFirstCref(inCref), inAccum))
                  end

                  CREF_FULLYQUALIFIED(__)  => begin
                    crefExplode(inCref.componentRef, inAccum)
                  end

                  _  => begin
                      listReverse(_cons(inCref, inAccum))
                  end
                end
              end
          outCrefParts
        end

         #= Calls the given function on each subexpression (non-recursively) of the given
           expression, sending in the extra argument to each call. =#
        function traverseExpShallow(inExp::Exp, inArg::ArgT, inFunc::FuncT)  where {ArgT}
              local outExp::Exp = inExp

              _ = begin
                  local e1::Exp
                  local e2::Exp
                @match outExp begin
                  BINARY(__)  => begin
                      outExp.exp1 = inFunc(outExp.exp1, inArg)
                      outExp.exp2 = inFunc(outExp.exp2, inArg)
                    ()
                  end

                  UNARY(__)  => begin
                      outExp.exp = inFunc(outExp.exp, inArg)
                    ()
                  end

                  LBINARY(__)  => begin
                      outExp.exp1 = inFunc(outExp.exp1, inArg)
                      outExp.exp2 = inFunc(outExp.exp2, inArg)
                    ()
                  end

                  LUNARY(__)  => begin
                      outExp.exp = inFunc(outExp.exp, inArg)
                    ()
                  end

                  RELATION(__)  => begin
                      outExp.exp1 = inFunc(outExp.exp1, inArg)
                      outExp.exp2 = inFunc(outExp.exp2, inArg)
                    ()
                  end

                  IFEXP(__)  => begin
                      outExp.ifExp = inFunc(outExp.ifExp, inArg)
                      outExp.trueBranch = inFunc(outExp.trueBranch, inArg)
                      outExp.elseBranch = inFunc(outExp.elseBranch, inArg)
                      outExp.elseIfBranch = list((inFunc(Util.tuple21(e), inArg), inFunc(Util.tuple22(e), inArg)) for e in outExp.elseIfBranch)
                    ()
                  end

                  CALL(__)  => begin
                      outExp.functionArgs = traverseExpShallowFuncArgs(outExp.functionArgs, inArg, inFunc)
                    ()
                  end

                  PARTEVALFUNCTION(__)  => begin
                      outExp.functionArgs = traverseExpShallowFuncArgs(outExp.functionArgs, inArg, inFunc)
                    ()
                  end

                  ARRAY(__)  => begin
                      outExp.arrayExp = list(inFunc(e, inArg) for e in outExp.arrayExp)
                    ()
                  end

                  MATRIX(__)  => begin
                      outExp.matrix = list(list(inFunc(e, inArg) for e in lst) for lst in outExp.matrix)
                    ()
                  end

                  RANGE(__)  => begin
                      outExp.start = inFunc(outExp.start, inArg)
                      outExp.step = Util.applyOption1(outExp.step, inFunc, inArg)
                      outExp.stop = inFunc(outExp.stop, inArg)
                    ()
                  end

                  TUPLE(__)  => begin
                      outExp.expressions = list(inFunc(e, inArg) for e in outExp.expressions)
                    ()
                  end

                  AS(__)  => begin
                      outExp.exp = inFunc(outExp.exp, inArg)
                    ()
                  end

                  CONS(__)  => begin
                      outExp.head = inFunc(outExp.head, inArg)
                      outExp.rest = inFunc(outExp.rest, inArg)
                    ()
                  end

                  LIST(__)  => begin
                      outExp.exps = list(inFunc(e, inArg) for e in outExp.exps)
                    ()
                  end

                  DOT(__)  => begin
                      outExp.exp = inFunc(outExp.exp, inArg)
                      outExp.index = inFunc(outExp.index, inArg)
                    ()
                  end

                  _  => begin
                      ()
                  end
                end
              end
          outExp
        end

        function traverseExpShallowFuncArgs(inArgs::FunctionArgs, inArg::ArgT, inFunc::FuncT)  where {ArgT}
              local outArgs::FunctionArgs = inArgs

              outArgs = begin
                @match outArgs begin
                  FUNCTIONARGS(__)  => begin
                      outArgs.args = list(inFunc(arg, inArg) for arg in outArgs.args)
                    outArgs
                  end

                  FOR_ITER_FARG(__)  => begin
                      outArgs.exp = inFunc(outArgs.exp, inArg)
                      outArgs.iterators = list(traverseExpShallowIterator(it, inArg, inFunc) for it in outArgs.iterators)
                    outArgs
                  end
                end
              end
          outArgs
        end

        function traverseExpShallowIterator(inIterator::ForIterator, inArg::ArgT, inFunc::FuncT)  where {ArgT}
              local outIterator::ForIterator

              local name::String
              local guard_exp::Option{Exp}
              local range_exp::Option{Exp}

              @match ITERATOR(name, guard_exp, range_exp) = inIterator
              guard_exp = Util.applyOption1(guard_exp, inFunc, inArg)
              range_exp = Util.applyOption1(range_exp, inFunc, inArg)
              outIterator = ITERATOR(name, guard_exp, range_exp)
          outIterator
        end

        function isElementItemClass(inElement::ElementItem) ::Bool
              local outIsClass::Bool

              outIsClass = begin
                @match inElement begin
                  ELEMENTITEM(element = ELEMENT(specification = CLASSDEF(__)))  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsClass
        end

        function isElementItem(inElement::ElementItem) ::Bool
              local outIsClass::Bool

              outIsClass = begin
                @match inElement begin
                  ELEMENTITEM(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsClass
        end

        function isAlgorithmItem(inAlg::AlgorithmItem) ::Bool
              local outIsClass::Bool

              outIsClass = begin
                @match inAlg begin
                  ALGORITHMITEM(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsClass
        end

        function isElementItemClassNamed(inName::String, inElement::ElementItem) ::Bool
              local outIsNamed::Bool

              outIsNamed = begin
                  local name::String
                @match inElement begin
                  ELEMENTITEM(element = ELEMENT(specification = CLASSDEF(class_ = CLASS(name = name))))  => begin
                    name == inName
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsNamed
        end

        function isEmptyClassPart(inClassPart::ClassPart) ::Bool
              local outIsEmpty::Bool

              outIsEmpty = begin
                @match inClassPart begin
                  PUBLIC(contents =  nil())  => begin
                    true
                  end

                  PROTECTED(contents =  nil())  => begin
                    true
                  end

                  CONSTRAINTS(contents =  nil())  => begin
                    true
                  end

                  EQUATIONS(contents =  nil())  => begin
                    true
                  end

                  INITIALEQUATIONS(contents =  nil())  => begin
                    true
                  end

                  ALGORITHMS(contents =  nil())  => begin
                    true
                  end

                  INITIALALGORITHMS(contents =  nil())  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
          outIsEmpty
        end

         #= For use with traverseExp =#
        function isInvariantExpNoTraverse(e::Absyn.Exp, b::Bool) ::Tuple{Absyn.Exp, Bool}



              if ! b
                return (e, b)
              end
              b = begin
                @match e begin
                  INTEGER(__)  => begin
                    true
                  end

                  REAL(__)  => begin
                    true
                  end

                  STRING(__)  => begin
                    true
                  end

                  BOOL(__)  => begin
                    true
                  end

                  BINARY(__)  => begin
                    true
                  end

                  UNARY(__)  => begin
                    true
                  end

                  LBINARY(__)  => begin
                    true
                  end

                  LUNARY(__)  => begin
                    true
                  end

                  RELATION(__)  => begin
                    true
                  end

                  IFEXP(__)  => begin
                    true
                  end

                  CALL(function_ = CREF_FULLYQUALIFIED(__))  => begin
                    true
                  end

                  PARTEVALFUNCTION(function_ = CREF_FULLYQUALIFIED(__))  => begin
                    true
                  end

                  ARRAY(__)  => begin
                    true
                  end

                  MATRIX(__)  => begin
                    true
                  end

                  RANGE(__)  => begin
                    true
                  end

                  CONS(__)  => begin
                    true
                  end

                  LIST(__)  => begin
                    true
                  end

                  _  => begin
                      false
                  end
                end
              end
               #=  case CREF(CREF_FULLYQUALIFIED()) then true;
               =#
          (e, b)
        end

         #= Returns the number of parts a path consists of, e.g. A.B.C gives 3. =#
        function pathPartCount(path::Path, partsAccum::ModelicaInteger = 0) ::ModelicaInteger
              local parts::ModelicaInteger

              parts = begin
                @match path begin
                  Path.IDENT(__)  => begin
                    partsAccum + 1
                  end

                  Path.QUALIFIED(__)  => begin
                    pathPartCount(path.path, partsAccum + 1)
                  end

                  Path.FULLYQUALIFIED(__)  => begin
                    pathPartCount(path.path, partsAccum)
                  end
                end
              end
          parts
        end

        function getAnnotationsFromConstraintClass(inCC::Option{<:ConstrainClass}) ::List{ElementArg}
              local outElArgLst::List{ElementArg}

              outElArgLst = begin
                  local elementArgs::List{ElementArg}
                @match inCC begin
                  SOME(CONSTRAINCLASS(comment = SOME(COMMENT(annotation_ = SOME(ANNOTATION(elementArgs))))))  => begin
                    elementArgs
                  end

                  _  => begin
                      nil
                  end
                end
              end
          outElArgLst
        end

        function getAnnotationsFromItems(inComponentItems::List{<:ComponentItem}, ccAnnotations::List{<:ElementArg}) ::List{List{ElementArg}}
              local outLst::List{List{ElementArg}} = nil

              local annotations::List{Absyn.ElementArg}
              local res::List{String}
              local str::String

              for comp in listReverse(inComponentItems)
                annotations = begin
                  @match comp begin
                    Absyn.COMPONENTITEM(comment = SOME(Absyn.COMMENT(annotation_ = SOME(Absyn.ANNOTATION(annotations)))))  => begin
                      listAppend(annotations, ccAnnotations)
                    end

                    _  => begin
                        ccAnnotations
                    end
                  end
                end
                outLst = _cons(annotations, outLst)
              end
          outLst
        end

         #=  This function strips out the `graphics\\' modification from an ElementArg
           list and return two lists, one with the other modifications and the
           second with the `graphics\\' modification =#
        function stripGraphicsAndInteractionModification(inAbsynElementArgLst::List{<:Absyn.ElementArg}) ::Tuple{List{Absyn.ElementArg}, List{Absyn.ElementArg}}
              local outAbsynElementArgLst2::List{Absyn.ElementArg}
              local outAbsynElementArgLst1::List{Absyn.ElementArg}

              (outAbsynElementArgLst1, outAbsynElementArgLst2) = begin
                  local mod::Absyn.ElementArg
                  local rest::List{Absyn.ElementArg}
                  local l1::List{Absyn.ElementArg}
                  local l2::List{Absyn.ElementArg}
                   #=  handle empty
                   =#
                @matchcontinue inAbsynElementArgLst begin
                   nil()  => begin
                    (nil, nil)
                  end

                  Absyn.MODIFICATION(path = Absyn.IDENT(name = "interaction")) <| rest  => begin
                      (l1, l2) = stripGraphicsAndInteractionModification(rest)
                    (l1, l2)
                  end

                  Absyn.MODIFICATION(modification = NONE(), path = Absyn.IDENT(name = "graphics")) <| rest  => begin
                      (l1, l2) = stripGraphicsAndInteractionModification(rest)
                    (l1, l2)
                  end

                  mod && Absyn.MODIFICATION(modification = SOME(_), path = Absyn.IDENT(name = "graphics")) <| rest  => begin
                      (l1, l2) = stripGraphicsAndInteractionModification(rest)
                    (l1, _cons(mod, l2))
                  end

                  mod && Absyn.MODIFICATION(__) <| rest  => begin
                      (l1, l2) = stripGraphicsAndInteractionModification(rest)
                    (_cons(mod, l1), l2)
                  end
                end
              end
               #=  adrpo: remove interaction annotations as we don't handle them currently
               =#
               #=  adrpo: remove empty annotations, to handle bad Dymola annotations, for example: Diagram(graphics)
               =#
               #=  add graphics to the second tuple
               =#
               #=  collect in the first tuple
               =#
          (outAbsynElementArgLst1, outAbsynElementArgLst2)
        end

         #=  This function traverses all classes of a program and applies a function
           to each class. The function takes the Absyn.Class, Absyn.Path option
           and an additional argument and returns an updated class and the
           additional values. The Absyn.Path option contains the path to the class
           that is traversed.
           inputs:  (Absyn.Program,
                       Absyn.Path option,
                       ((Absyn.Class  Absyn.Path option  \\'a) => (Absyn.Class  Absyn.Path option  \\'a)),  /* rel-ation to apply */
                    \\'a, /* extra value passed to re-lation */
                    bool) /* true = traverse protected elements */
           outputs: (Absyn.Program   Absyn.Path option  \\'a) =#
        function traverseClasses(inProgram::Absyn.Program, inPath::Option{<:Absyn.Path}, inFunc::FuncType, inArg::Type_a, inVisitProtected::Bool) ::Tuple{Absyn.Program, Option{Absyn.Path}, Type_a}
              local outTpl::Tuple{Absyn.Program, Option{Absyn.Path}, Type_a}

              outTpl = begin
                  local classes::List{Absyn.Class}
                  local pa_1::Option{Absyn.Path}
                  local pa::Option{Absyn.Path}
                  local args_1::Type_a
                  local args::Type_a
                  local within_::Absyn.Within
                  local visitor::FuncType
                  local traverse_prot::Bool
                  local p::Absyn.Program
                @match (inProgram, inPath, inFunc, inArg, inVisitProtected) begin
                  (p && Absyn.PROGRAM(__), pa, visitor, args, traverse_prot)  => begin
                      (classes, pa_1, args_1) = traverseClasses2(p.classes, pa, visitor, args, traverse_prot)
                      p.classes = classes
                    (p, pa_1, args_1)
                  end
                end
              end
          outTpl
        end

         #=  Helperfunction to traverseClasses. =#
        function traverseClasses2(inClasses::List{<:Absyn.Class}, inPath::Option{<:Absyn.Path}, inFunc::FuncType, inArg::Type_a #= extra argument =#, inVisitProtected::Bool #= visit protected elements =#) ::Tuple{List{Absyn.Class}, Option{Absyn.Path}, Type_a}
              local outTpl::Tuple{List{Absyn.Class}, Option{Absyn.Path}, Type_a}

              outTpl = begin
                  local pa::Option{Absyn.Path}
                  local pa_1::Option{Absyn.Path}
                  local pa_2::Option{Absyn.Path}
                  local pa_3::Option{Absyn.Path}
                  local visitor::FuncType
                  local args::Type_a
                  local args_1::Type_a
                  local args_2::Type_a
                  local args_3::Type_a
                  local class_1::Absyn.Class
                  local class_2::Absyn.Class
                  local class_::Absyn.Class
                  local classes_1::List{Absyn.Class}
                  local classes::List{Absyn.Class}
                  local traverse_prot::Bool
                @matchcontinue (inClasses, inPath, inFunc, inArg, inVisitProtected) begin
                  ( nil(), pa, _, args, _)  => begin
                    (nil, pa, args)
                  end

                  (class_ <| classes, pa, visitor, args, traverse_prot)  => begin
                      (class_1, _, args_1) = visitor((class_, pa, args))
                      (class_2, _, args_2) = traverseInnerClass(class_1, pa, visitor, args_1, traverse_prot)
                      (classes_1, pa_3, args_3) = traverseClasses2(classes, pa, visitor, args_2, traverse_prot)
                    (_cons(class_2, classes_1), pa_3, args_3)
                  end

                  (class_ <| classes, pa, visitor, args, traverse_prot)  => begin
                      (class_2, _, args_2) = traverseInnerClass(class_, pa, visitor, args, traverse_prot)
                      @match true = classHasLocalClasses(class_2)
                      (classes_1, pa_3, args_3) = traverseClasses2(classes, pa, visitor, args_2, traverse_prot)
                    (_cons(class_2, classes_1), pa_3, args_3)
                  end

                  (_ <| classes, pa, visitor, args, traverse_prot)  => begin
                      (classes_1, pa_3, args_3) = traverseClasses2(classes, pa, visitor, args, traverse_prot)
                    (classes_1, pa_3, args_3)
                  end

                  (class_ <| _, _, _, _, _)  => begin
                      print("-traverse_classes2 failed on class:")
                      print(AbsynUtil.pathString(AbsynUtil.className(class_)))
                      print("\\n")
                    fail()
                  end
                end
              end
               #= /* Visitor failed, but class contains inner classes after traversal, i.e. those inner classes didn't fail, and thus
                  the class must be included also */ =#
               #= /* Visitor failed, remove class */ =#
          outTpl
        end

         #= Returns true if class contains a local class =#
        function classHasLocalClasses(cl::Absyn.Class) ::Bool
              local res::Bool

              res = begin
                  local parts::List{Absyn.ClassPart}
                   #=  A class with parts.
                   =#
                @match cl begin
                  Absyn.CLASS(body = Absyn.PARTS(classParts = parts))  => begin
                      res = partsHasLocalClass(parts)
                    res
                  end

                  Absyn.CLASS(body = Absyn.CLASS_EXTENDS(parts = parts))  => begin
                      res = partsHasLocalClass(parts)
                    res
                  end
                end
              end
               #=  An extended class with parts: model extends M end M;
               =#
          res
        end

         #= Help function to classHasLocalClass =#
        function partsHasLocalClass(inParts::List{<:Absyn.ClassPart}) ::Bool
              local res::Bool

              res = begin
                  local elts::List{Absyn.ElementItem}
                  local parts::List{Absyn.ClassPart}
                @matchcontinue inParts begin
                  Absyn.PUBLIC(elts) <| _  => begin
                      @match true = eltsHasLocalClass(elts)
                    true
                  end

                  Absyn.PROTECTED(elts) <| _  => begin
                      @match true = eltsHasLocalClass(elts)
                    true
                  end

                  _ <| parts  => begin
                    partsHasLocalClass(parts)
                  end

                  _  => begin
                      false
                  end
                end
              end
          res
        end

         #= help function to partsHasLocalClass =#
        function eltsHasLocalClass(inElts::List{<:Absyn.ElementItem}) ::Bool
              local res::Bool

              res = begin
                  local elts::List{Absyn.ElementItem}
                @matchcontinue inElts begin
                  Absyn.ELEMENTITEM(Absyn.ELEMENT(specification = Absyn.CLASSDEF(__))) <| _  => begin
                    true
                  end

                  _ <| elts  => begin
                    eltsHasLocalClass(elts)
                  end

                  _  => begin
                      false
                  end
                end
              end
          res
        end

         #=  Helperfunction to traverseClasses2. This function traverses all inner classes of a class. =#
        function traverseInnerClass(inClass::Absyn.Class, inPath::Option{<:Absyn.Path}, inFunc::FuncType, inArg::Type_a #= extra value =#, inVisitProtected::Bool #= if true, traverse protected elts =#) ::Tuple{Absyn.Class, Option{Absyn.Path}, Type_a}
              local outTpl::Tuple{Absyn.Class, Option{Absyn.Path}, Type_a}

              outTpl = begin
                  local tmp_pa::Absyn.Path
                  local pa::Absyn.Path
                  local parts_1::List{Absyn.ClassPart}
                  local parts::List{Absyn.ClassPart}
                  local pa_1::Option{Absyn.Path}
                  local args_1::Type_a
                  local args::Type_a
                  local name::String
                  local bcname::String
                  local p::Bool
                  local f::Bool
                  local e::Bool
                  local visit_prot::Bool
                  local r::Absyn.Restriction
                  local str_opt::Option{String}
                  local file_info::SourceInfo
                  local visitor::FuncType
                  local cl::Absyn.Class
                  local modif::List{Absyn.ElementArg}
                  local typeVars::List{String}
                  local classAttrs::List{Absyn.NamedArg}
                  local cmt::Absyn.Comment
                  local ann::List{Absyn.Annotation}
                   #= /* a class with parts */ =#
                @matchcontinue (inClass, inPath, inFunc, inArg, inVisitProtected) begin
                  (Absyn.CLASS(name, p, f, e, r, Absyn.PARTS(typeVars, classAttrs, parts, ann, str_opt), file_info), SOME(pa), visitor, args, visit_prot)  => begin
                      tmp_pa = AbsynUtil.joinPaths(pa, Absyn.IDENT(name))
                      (parts_1, pa_1, args_1) = traverseInnerClassParts(parts, SOME(tmp_pa), visitor, args, visit_prot)
                    (Absyn.CLASS(name, p, f, e, r, Absyn.PARTS(typeVars, classAttrs, parts_1, ann, str_opt), file_info), pa_1, args_1)
                  end

                  (Absyn.CLASS(name = name, partialPrefix = p, finalPrefix = f, encapsulatedPrefix = e, restriction = r, body = Absyn.PARTS(typeVars = typeVars, classAttrs = classAttrs, classParts = parts, ann = ann, comment = str_opt), info = file_info), NONE(), visitor, args, visit_prot)  => begin
                      (parts_1, pa_1, args_1) = traverseInnerClassParts(parts, SOME(Absyn.IDENT(name)), visitor, args, visit_prot)
                    (Absyn.CLASS(name, p, f, e, r, Absyn.PARTS(typeVars, classAttrs, parts_1, ann, str_opt), file_info), pa_1, args_1)
                  end

                  (Absyn.CLASS(name = name, partialPrefix = p, finalPrefix = f, encapsulatedPrefix = e, restriction = r, body = Absyn.PARTS(typeVars = typeVars, classAttrs = classAttrs, classParts = parts, ann = ann, comment = str_opt), info = file_info), pa_1, visitor, args, visit_prot)  => begin
                      (parts_1, pa_1, args_1) = traverseInnerClassParts(parts, pa_1, visitor, args, visit_prot)
                    (Absyn.CLASS(name, p, f, e, r, Absyn.PARTS(typeVars, classAttrs, parts_1, ann, str_opt), file_info), pa_1, args_1)
                  end

                  (Absyn.CLASS(name = name, partialPrefix = p, finalPrefix = f, encapsulatedPrefix = e, restriction = r, body = Absyn.CLASS_EXTENDS(baseClassName = bcname, comment = str_opt, modifications = modif, parts = parts, ann = ann), info = file_info), SOME(pa), visitor, args, visit_prot)  => begin
                      tmp_pa = AbsynUtil.joinPaths(pa, Absyn.IDENT(name))
                      (parts_1, pa_1, args_1) = traverseInnerClassParts(parts, SOME(tmp_pa), visitor, args, visit_prot)
                    (Absyn.CLASS(name, p, f, e, r, Absyn.CLASS_EXTENDS(bcname, modif, str_opt, parts_1, ann), file_info), pa_1, args_1)
                  end

                  (Absyn.CLASS(name = name, partialPrefix = p, finalPrefix = f, encapsulatedPrefix = e, restriction = r, body = Absyn.CLASS_EXTENDS(baseClassName = bcname, comment = str_opt, modifications = modif, parts = parts, ann = ann), info = file_info), NONE(), visitor, args, visit_prot)  => begin
                      (parts_1, pa_1, args_1) = traverseInnerClassParts(parts, SOME(Absyn.IDENT(name)), visitor, args, visit_prot)
                    (Absyn.CLASS(name, p, f, e, r, Absyn.CLASS_EXTENDS(bcname, modif, str_opt, parts_1, ann), file_info), pa_1, args_1)
                  end

                  (Absyn.CLASS(name = name, partialPrefix = p, finalPrefix = f, encapsulatedPrefix = e, restriction = r, body = Absyn.CLASS_EXTENDS(baseClassName = bcname, comment = str_opt, modifications = modif, parts = parts, ann = ann), info = file_info), pa_1, visitor, args, visit_prot)  => begin
                      (parts_1, pa_1, args_1) = traverseInnerClassParts(parts, pa_1, visitor, args, visit_prot)
                    (Absyn.CLASS(name, p, f, e, r, Absyn.CLASS_EXTENDS(bcname, modif, str_opt, parts_1, ann), file_info), pa_1, args_1)
                  end

                  (cl, pa_1, _, args, _)  => begin
                    (cl, pa_1, args)
                  end
                end
              end
               #= /* adrpo: handle also an extended class with parts: model extends M end M; */ =#
               #= /* otherwise */ =#
          outTpl
        end

         #= Helper function to traverseInnerClass =#
        function traverseInnerClassParts(inClassParts::List{<:Absyn.ClassPart}, inPath::Option{<:Absyn.Path}, inFunc::FuncType, inArg::Type_a #= extra argument =#, inVisitProtected::Bool #= visist protected elts =#) ::Tuple{List{Absyn.ClassPart}, Option{Absyn.Path}, Type_a}
              local outTpl::Tuple{List{Absyn.ClassPart}, Option{Absyn.Path}, Type_a}

              outTpl = begin
                  local pa::Option{Absyn.Path}
                  local pa_1::Option{Absyn.Path}
                  local pa_2::Option{Absyn.Path}
                  local args::Type_a
                  local args_1::Type_a
                  local args_2::Type_a
                  local elts_1::List{Absyn.ElementItem}
                  local elts::List{Absyn.ElementItem}
                  local parts_1::List{Absyn.ClassPart}
                  local parts::List{Absyn.ClassPart}
                  local visitor::FuncType
                  local visit_prot::Bool
                  local part::Absyn.ClassPart
                @matchcontinue (inClassParts, inPath, inFunc, inArg, inVisitProtected) begin
                  ( nil(), pa, _, args, _)  => begin
                    (nil, pa, args)
                  end

                  (Absyn.PUBLIC(contents = elts) <| parts, pa, visitor, args, visit_prot)  => begin
                      (elts_1, _, args_1) = traverseInnerClassElements(elts, pa, visitor, args, visit_prot)
                      (parts_1, pa_2, args_2) = traverseInnerClassParts(parts, pa, visitor, args_1, visit_prot)
                    (_cons(Absyn.PUBLIC(elts_1), parts_1), pa_2, args_2)
                  end

                  (Absyn.PROTECTED(contents = elts) <| parts, pa, visitor, args, true)  => begin
                      (elts_1, _, args_1) = traverseInnerClassElements(elts, pa, visitor, args, true)
                      (parts_1, pa_2, args_2) = traverseInnerClassParts(parts, pa, visitor, args_1, true)
                    (_cons(Absyn.PROTECTED(elts_1), parts_1), pa_2, args_2)
                  end

                  (part <| parts, pa, visitor, args, true)  => begin
                      (parts_1, pa_1, args_1) = traverseInnerClassParts(parts, pa, visitor, args, true)
                    (_cons(part, parts_1), pa_1, args_1)
                  end
                end
              end
          outTpl
        end

         #= Helper function to traverseInnerClassParts =#
        function traverseInnerClassElements(inElements::List{<:Absyn.ElementItem}, inPath::Option{<:Absyn.Path}, inFuncType::FuncType, inArg::Type_a, inVisitProtected::Bool #= visit protected elts =#) ::Tuple{List{Absyn.ElementItem}, Option{Absyn.Path}, Type_a}
              local outTpl::Tuple{List{Absyn.ElementItem}, Option{Absyn.Path}, Type_a}

              outTpl = begin
                  local pa::Option{Absyn.Path}
                  local pa_1::Option{Absyn.Path}
                  local pa_2::Option{Absyn.Path}
                  local args::Type_a
                  local args_1::Type_a
                  local args_2::Type_a
                  local elt_spec_1::Absyn.ElementSpec
                  local elt_spec::Absyn.ElementSpec
                  local elts_1::List{Absyn.ElementItem}
                  local elts::List{Absyn.ElementItem}
                  local f::Bool
                  local visit_prot::Bool
                  local r::Option{Absyn.RedeclareKeywords}
                  local io::Absyn.InnerOuter
                  local info::SourceInfo
                  local constr::Option{Absyn.ConstrainClass}
                  local visitor::FuncType
                  local elt::Absyn.ElementItem
                  local repl::Bool
                  local cl::Absyn.Class
                @matchcontinue (inElements, inPath, inFuncType, inArg, inVisitProtected) begin
                  ( nil(), pa, _, args, _)  => begin
                    (nil, pa, args)
                  end

                  (Absyn.ELEMENTITEM(element = Absyn.ELEMENT(finalPrefix = f, redeclareKeywords = r, innerOuter = io, specification = elt_spec, info = info, constrainClass = constr)) <| elts, pa, visitor, args, visit_prot)  => begin
                      (elt_spec_1, _, args_1) = traverseInnerClassElementspec(elt_spec, pa, visitor, args, visit_prot)
                      (elts_1, pa_2, args_2) = traverseInnerClassElements(elts, pa, visitor, args_1, visit_prot)
                    (_cons(Absyn.ELEMENTITEM(Absyn.ELEMENT(f, r, io, elt_spec_1, info, constr)), elts_1), pa_2, args_2)
                  end

                  (Absyn.ELEMENTITEM(element = Absyn.ELEMENT(finalPrefix = f, redeclareKeywords = r, innerOuter = io, specification = Absyn.CLASSDEF(repl, cl), info = info, constrainClass = constr)) <| elts, pa, visitor, args, visit_prot)  => begin
                      (cl, _, args_1) = traverseInnerClass(cl, pa, visitor, args, visit_prot)
                      @match true = classHasLocalClasses(cl)
                      (elts_1, pa_2, args_2) = traverseInnerClassElements(elts, pa, visitor, args_1, visit_prot)
                    (_cons(Absyn.ELEMENTITEM(Absyn.ELEMENT(f, r, io, Absyn.CLASSDEF(repl, cl), info, constr)), elts_1), pa_2, args_2)
                  end

                  (Absyn.ELEMENTITEM(element = Absyn.ELEMENT(__)) <| elts, pa, visitor, args, visit_prot)  => begin
                      (elts_1, pa_2, args_2) = traverseInnerClassElements(elts, pa, visitor, args, visit_prot)
                    (elts_1, pa_2, args_2)
                  end

                  (elt <| elts, pa, visitor, args, visit_prot)  => begin
                      (elts_1, pa_1, args_1) = traverseInnerClassElements(elts, pa, visitor, args, visit_prot)
                    (_cons(elt, elts_1), pa_1, args_1)
                  end
                end
              end
               #= /* Visitor failed in elementspec, but inner classes succeeded, include class */ =#
               #= /* Visitor failed in elementspec, remove class */ =#
          outTpl
        end

         #=  Helperfunction to traverseInnerClassElements =#
        function traverseInnerClassElementspec(inElementSpec::Absyn.ElementSpec, inPath::Option{<:Absyn.Path}, inFuncType::FuncType, inArg::Type_a, inVisitProtected::Bool #= visit protected elts =#) ::Tuple{Absyn.ElementSpec, Option{Absyn.Path}, Type_a}
              local outTpl::Tuple{Absyn.ElementSpec, Option{Absyn.Path}, Type_a}

              outTpl = begin
                  local class_1::Absyn.Class
                  local class_2::Absyn.Class
                  local class_::Absyn.Class
                  local pa_1::Option{Absyn.Path}
                  local pa_2::Option{Absyn.Path}
                  local pa::Option{Absyn.Path}
                  local args_1::Type_a
                  local args_2::Type_a
                  local args::Type_a
                  local repl::Bool
                  local visit_prot::Bool
                  local visitor::FuncType
                  local elt_spec::Absyn.ElementSpec
                @match (inElementSpec, inPath, inFuncType, inArg, inVisitProtected) begin
                  (Absyn.CLASSDEF(replaceable_ = repl, class_ = class_), pa, visitor, args, visit_prot)  => begin
                      (class_1, _, args_1) = visitor((class_, pa, args))
                      (class_2, pa_2, args_2) = traverseInnerClass(class_1, pa, visitor, args_1, visit_prot)
                    (Absyn.CLASSDEF(repl, class_2), pa_2, args_2)
                  end

                  (elt_spec && Absyn.EXTENDS(__), pa, _, args, _)  => begin
                    (elt_spec, pa, args)
                  end

                  (elt_spec && Absyn.IMPORT(__), pa, _, args, _)  => begin
                    (elt_spec, pa, args)
                  end

                  (elt_spec && Absyn.COMPONENTS(__), pa, _, args, _)  => begin
                    (elt_spec, pa, args)
                  end
                end
              end
          outTpl
        end

         #= @auhtor: johti
         Get the typespec path in an ElementItem if it has one =#
        function getTypeSpecFromElementItemOpt(inElementItem::Absyn.ElementItem) ::Option{Absyn.TypeSpec}
              local outTypeSpec::Option{Absyn.TypeSpec}

              outTypeSpec = begin
                  local typeSpec::Absyn.TypeSpec
                  local specification::Absyn.ElementSpec
                @matchcontinue inElementItem begin
                  Absyn.ELEMENTITEM(__)  => begin
                    begin
                      @match inElementItem.element begin
                        Absyn.ELEMENT(specification = specification)  => begin
                          begin
                            @match specification begin
                              Absyn.COMPONENTS(typeSpec = typeSpec)  => begin
                                SOME(typeSpec)
                              end
                            end
                          end
                        end
                      end
                    end
                  end

                  _  => begin
                      NONE()
                  end
                end
              end
          outTypeSpec
        end

         #= @auhtor: johti
             Get a ComponentItem from an ElementItem if it has one =#
        function getElementSpecificationFromElementItemOpt(inElementItem::Absyn.ElementItem) ::Option{Absyn.ElementSpec}
              local outSpec::Option{Absyn.ElementSpec}

              outSpec = begin
                  local specification::Absyn.ElementSpec
                  local element::Absyn.Element
                @matchcontinue inElementItem begin
                  Absyn.ELEMENTITEM(element = element)  => begin
                    begin
                      @match element begin
                        Absyn.ELEMENT(specification = specification)  => begin
                          SOME(specification)
                        end
                      end
                    end
                  end

                  _  => begin
                      NONE()
                  end
                end
              end
          outSpec
        end

         #= @auhtor: johti
         Get the componentItems from a given elemSpec otherwise returns an empty list =#
        function getComponentItemsFromElementSpec(elemSpec::Absyn.ElementSpec) ::List{Absyn.ComponentItem}
              local componentItems::List{Absyn.ComponentItem}

              componentItems = begin
                  local components::List{Absyn.ComponentItem}
                @match elemSpec begin
                  Absyn.COMPONENTS(components = components)  => begin
                    components
                  end

                  _  => begin
                      nil
                  end
                end
              end
          componentItems
        end

         #= @author: johti
         Get the componentItems from a given elementItem =#
        function getComponentItemsFromElementItem(inElementItem::Absyn.ElementItem) ::List{Absyn.ComponentItem}
              local componentItems::List{Absyn.ComponentItem}

              componentItems = begin
                  local elementSpec::Absyn.ElementSpec
                @match getElementSpecificationFromElementItemOpt(inElementItem) begin
                  SOME(elementSpec)  => begin
                    getComponentItemsFromElementSpec(elementSpec)
                  end

                  _  => begin
                      nil
                  end
                end
              end
          componentItems
        end

         #= @author johti
          Get the direction if one exists otherwise returns BIDIR() =#
        function getDirection(elementItem::Absyn.ElementItem) ::Direction
              local oDirection::Direction

              oDirection = begin
                  local element::Element
                @matchcontinue elementItem begin
                  ELEMENTITEM(element = element)  => begin
                    begin
                        local specification::ElementSpec
                      @match element begin
                        ELEMENT(specification = specification)  => begin
                          begin
                              local attributes::ElementAttributes
                            @match specification begin
                              COMPONENTS(attributes = attributes)  => begin
                                begin
                                    local direction::Direction
                                  @match attributes begin
                                    ATTR(direction = direction)  => begin
                                      direction
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end

                  _  => begin
                      BIDIR()
                  end
                end
              end
          oDirection
        end

    #= So that we can use wildcard imports and named imports when they do occur. Not good Julia practice =#
    @exportAll()
  end
