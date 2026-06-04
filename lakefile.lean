import Lake
open Lake DSL

def moreServerArgs := #[
  "-Dpp.unicode.fun=true", -- pretty-prints `fun a ↦ b`
  "-Dpp.proofs.withType=false",
  "-Dweak.linter.style.multiGoal=false" -- don't complain about missing ·
]

def moreLeanArgs := moreServerArgs

package «HUJI2026» where
  moreServerArgs := moreServerArgs

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib «HUJI2026» where
  globs := #[.submodules `HUJI2026]
  moreLeanArgs := moreLeanArgs
