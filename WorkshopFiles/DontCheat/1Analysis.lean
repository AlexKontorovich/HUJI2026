import Mathlib

def FunCont (f : ℝ → ℝ) : Prop :=
  ∀ x, ∀ ε > 0, ∃ δ > 0, ∀ y, |x - y| < δ → |f x - f y| < ε

theorem ContCompose (f g : ℝ → ℝ) (hf : FunCont f) (hg : FunCont g) : FunCont (fun x => f (g x)) := by
  intro x ε εpos
  specialize hf (g x) ε εpos
  choose ε₁ ε₁pos hε₁ using hf
  specialize hg x ε₁ ε₁pos
  choose δg δgpos hδg using hg
  use δg, δgpos
  intro y hy
  specialize hδg y hy
  specialize hε₁ (g y) hδg
  exact hε₁

def SeqLim (a : ℕ → ℝ) (L : ℝ) : Prop :=
  ∀ ε > 0, ∃ N, ∀ n ≥ N, |a n - L| < ε

theorem SeqSqueeze (a b c : ℕ → ℝ) (L : ℝ) (ha : SeqLim a L) (hb : ∀ n, a n ≤ b n) (hc : ∀ n, b n ≤ c n) (hcL : SeqLim c L) : SeqLim b L := by
  intro ε εpos
  specialize ha ε εpos
  choose Na hNa using ha
  specialize hcL ε εpos
  choose Nc hNc using hcL
  let N := max Na Nc
  use N
  intro n hn
  specialize hNa n (by grind)
  specialize hNc n (by grind)
  specialize hb n
  specialize hc n
  rewrite [abs_lt] at hNa hNc ⊢
  split_ands
  · linarith only [hNa.1, hb]
  · linarith only [hNc.2, hc]

def SeqConv (a : ℕ → ℝ) : Prop :=
  ∃ L, SeqLim a L

theorem absConv_of_Conv (a : ℕ → ℝ) (ha : SeqConv a) :
    SeqConv (fun n => |a n|) := by
  choose L hL using ha
  use |L|
  intro ε εpos
  specialize hL ε εpos
  choose N hN using hL
  use N
  intro n hn
  specialize hN n hn
  have : |(|a n|) - (|L|)| ≤ |a n - L| := by
    cases abs_cases (a n - L) <;>
      cases abs_cases (a n) <;>
      cases abs_cases L <;>
      cases abs_cases (|a n| - |L|) <;>
      linarith
  linarith only [this, hN]
