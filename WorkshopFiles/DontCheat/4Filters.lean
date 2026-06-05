import Mathlib

namespace HUJI

def Ball (x : ℝ) (r : ℝ) : Set ℝ := {y | |x - y| < r}

def nhdFilter (x : ℝ) : Set (Set ℝ) := {T | ∃ ε > 0, Ball x ε ⊆ T}

lemma nhdFilter_univ (x : ℝ) : Set.univ ∈ nhdFilter x := by
  use 1, by grind
  grind

lemma nhdFilter_inter (x : ℝ) (s t : Set ℝ) (hs : s ∈ nhdFilter x) (ht : t ∈ nhdFilter x) :
  (s ∩ t) ∈ nhdFilter x := by
  choose ε₁ ε₁pos hε₁ using hs
  choose ε₂ ε₂pos hε₂ using ht
  let ε := min ε₁ ε₂
  have εpos : ε > 0 := by grind
  use ε, εpos
  have in1 : Ball x ε ⊆ Ball x ε₁ := by
    intro y hy
    rw [Ball, Set.mem_setOf_eq] at hy ⊢
    have : ε ≤ ε₁ := by grind
    linarith
  have in2 : Ball x ε ⊆ Ball x ε₂ := by
    intro y hy
    rw [Ball, Set.mem_setOf_eq] at hy ⊢
    have : ε ≤ ε₂ := by grind
    linarith
  apply Set.subset_inter
  · exact in1.trans hε₁
  · exact in2.trans hε₂

lemma nhdFilter_inclusion (x : ℝ) (s t : Set ℝ) (hs : s ∈ nhdFilter x) (hst : s ⊆ t) :
  t ∈ nhdFilter x := by
  choose ε εpos hε using hs
  use ε, εpos
  exact hε.trans hst

class Filter (X : Type*) where
  sets : Set (Set X)
  univ_is : Set.univ ∈ sets
  finiteInter : ∀ s t, s ∈ sets → t ∈ sets → s ∩ t ∈ sets
  inclusion : ∀ s t, s ∈ sets → s ⊆ t → t ∈ sets

@[reducible]
def nhdFilterIsFilter (x : ℝ) : Filter ℝ where
  sets := nhdFilter x
  univ_is := nhdFilter_univ x
  finiteInter := nhdFilter_inter x
  inclusion := nhdFilter_inclusion x

instance atTop : Filter ℝ where
  sets := {T | ∃ b : ℝ, Set.Ioi b ⊆ T}
  univ_is := by
    use 0
    grind
  finiteInter := by
    intros s t hs ht
    choose bs hbs using hs
    choose bt hbt using ht
    use max bs bt
    grind
  inclusion := by
    intros s t hs hst
    choose b hb using hs
    use b
    grind

@[reducible]
def nhdsRightFilter (x : ℝ) : Filter ℝ where
  sets := {T | ∃ ε > 0, Set.Ioo x (x + ε) ⊆ T}
  univ_is := by
    use 1, by grind
    grind
  finiteInter s t hs ht := by
    choose εs εspos hs' using hs
    choose εt εtpos ht' using ht
    let ε := min εs εt
    have εpos : ε > 0 := by grind
    use ε, εpos
    have in1 : Set.Ioo x (x + ε) ⊆ Set.Ioo x (x + εs) := by
      intro y hy
      rw [Set.mem_Ioo] at hy ⊢
      split_ands
      · linarith
      · grind
    have in2 : Set.Ioo x (x + ε) ⊆ Set.Ioo x (x + εt) := by
      intro y hy
      rw [Set.mem_Ioo] at hy ⊢
      split_ands
      · linarith
      · grind
    apply Set.subset_inter
    · exact in1.trans hs'
    · exact in2.trans ht'
  inclusion s t hs hst := by
    choose ε εpos hε using hs
    rw [Set.mem_setOf_eq]
    use ε, εpos
    exact hε.trans hst

def TendsTo {X Y : Type*} (f : X → Y) (FX : Filter X) (FY : Filter Y) : Prop :=
  ∀ T ∈ FY.sets, f ⁻¹' T ∈ FX.sets


-- This simultaneously proves the Squeeze Theorem for `aₙ → L`, for `f (x) → L` as `x → x₀⁺`, or as
-- `x → ∞`, etc etc.
theorem SqueezeThm {X : Type*} (f g h : X → ℝ) (F : Filter X) (L : ℝ)
    (hf : TendsTo f F (nhdFilterIsFilter L))
    (hh : TendsTo h F (nhdFilterIsFilter L))
    (hfg : ∀ x, f x ≤ g x) (hgh : ∀ x, g x ≤ h x) :
    TendsTo g F (nhdFilterIsFilter L) := by
  intro T hT
  choose ε εpos hε using hT
  set ball := Ball L ε with hball
  have ballIn : ball ∈ nhdFilter L := by
    use ε, εpos
  have gInv : g ⁻¹' ball ⊆ g ⁻¹' T := by
    intro x hx
    rw [Set.mem_preimage, hball] at hx
    rw [Set.mem_preimage]
    exact hε hx
  have key : f ⁻¹' ball ∩ h ⁻¹' ball ⊆ g ⁻¹' ball := by
    intro x hx
    rw [Set.mem_inter_iff, Set.mem_preimage, Set.mem_preimage] at hx
    choose hfx hhx using hx
    rw [hball, Ball, Set.mem_setOf_eq] at hfx hhx
    rw [Set.mem_preimage, hball, Ball, Set.mem_setOf_eq]
    have hflo : L - ε < f x := by grind
    have hhup : h x < L + ε := by grind
    have : f x ≤ g x := hfg x
    have : g x ≤ h x := hgh x
    grind
  specialize hf ball ballIn
  specialize hh ball ballIn
  have hinter := F.finiteInter _ _ hf hh
  have := F.inclusion _ _ hinter key
  exact F.inclusion _ _ this gInv

end HUJI
