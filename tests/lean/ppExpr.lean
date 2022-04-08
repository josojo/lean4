import Lean


/-! Pretty printing tests for `Expr`s that cannot be generated by parsing+elaborating. -/

open Lean

def test (e : Expr) : MetaM Unit := do
  IO.println (← PrettyPrinter.ppExpr e)

-- loose bound variable
#eval test (mkBVar 0)

-- anonymous binder
#eval test (mkLambda Name.anonymous BinderInfo.default (mkSort levelZero) (mkBVar 0))

-- pp annotations
#eval test $
  mkAppN (mkConst `id [levelOne]) #[
    mkConst `Nat,
    mkMData (KVMap.empty.set `pp.explicit true) $ mkAppN (mkConst `id [levelOne]) #[
      mkConst `Nat,
      mkAppN (mkConst `id [levelOne]) #[
        mkConst `Nat,
        mkConst `Nat.zero
  ]]]
