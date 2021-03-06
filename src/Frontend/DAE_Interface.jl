#=
 This file is needed to provide a necessary interface for Prefix.jl
=#
const Dimensions = List  #= a list of dimensions =#
@UniontypeDecl VarKind
@UniontypeDecl ConnectorType
@UniontypeDecl VarDirection
@UniontypeDecl VarParallelism
@UniontypeDecl VarVisibility
@UniontypeDecl VarInnerOuter
@UniontypeDecl ElementSource
@UniontypeDecl SymbolicOperation
@UniontypeDecl EquationExp
@UniontypeDecl Element
@UniontypeDecl Function
@UniontypeDecl InlineType
@UniontypeDecl FunctionDefinition
@UniontypeDecl derivativeCond
@UniontypeDecl VariableAttributes
@UniontypeDecl StateSelect
@UniontypeDecl Uncertainty
@UniontypeDecl Distribution
@UniontypeDecl ExtArg
@UniontypeDecl ExternalDecl
@UniontypeDecl DAElist
@UniontypeDecl Algorithm
@UniontypeDecl Constraint
@UniontypeDecl ClassAttributes
@UniontypeDecl Statement
@UniontypeDecl Else
@UniontypeDecl Var
@UniontypeDecl Attributes
@UniontypeDecl BindingSource
@UniontypeDecl Binding
@UniontypeDecl Type
@UniontypeDecl CodeType
@UniontypeDecl EvaluateSingletonType
EvaluateSingletonTypeFunction = Function
@UniontypeDecl FunctionAttributes
@UniontypeDecl FunctionBuiltin
@UniontypeDecl FunctionParallelism
@UniontypeDecl Dimension
@UniontypeDecl DimensionBinding
@UniontypeDecl FuncArg
@UniontypeDecl Const
@UniontypeDecl TupleConst
@UniontypeDecl Properties
@UniontypeDecl EqMod
@UniontypeDecl SubMod
@UniontypeDecl Mod
@UniontypeDecl ClockKind
@UniontypeDecl Exp
@UniontypeDecl TailCall
@UniontypeDecl CallAttributes
@UniontypeDecl ReductionInfo
@UniontypeDecl ReductionIterator
@UniontypeDecl MatchCase
@UniontypeDecl MatchType
@UniontypeDecl Pattern
@UniontypeDecl Operator
@UniontypeDecl ComponentRef
@UniontypeDecl Subscript
@UniontypeDecl Expand
