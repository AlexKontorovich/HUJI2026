import Mathlib

namespace HUJI

section PointSet

def Ball (x : ℝ) (r : ℝ) : Set ℝ := {y | |x - y| < r}

def IsOpen (S : Set ℝ) : Prop :=
  ∀ x ∈ S, ∃ ε > 0, Ball x ε ⊆ S

lemma isOpen_univ : IsOpen Set.univ := by
  intro x hx
  use 1, by grind
  grind

lemma isOpen_union (I : Type*) (U : I → Set ℝ)
    (hU : ∀ i, IsOpen (U i)) : IsOpen (⋃ i, U i) := by
  intro x hx
  rw [Set.mem_iUnion] at hx
  choose i hi using hx
  specialize hU i x hi
  choose ε εpos hε using hU
  use ε, εpos
  have := Set.subset_iUnion U i
  exact hε.trans this

end PointSet

class TopologicalSpace (X : Type*) where
  isOpen : Set X → Prop
  isOpen_univ : isOpen Set.univ
  isOpen_inter : ∀ U V, isOpen U → isOpen V → isOpen (U ∩ V)
  isOpen_union : ∀ (I : Type*) (U : I → Set X),
    (∀ i, isOpen (U i)) → isOpen (⋃ i, U i)

def isOpen {X : Type*} [TopologicalSpace X] (U : Set X) : Prop :=
  TopologicalSpace.isOpen U

def FunCont {X Y : Type*}
    [TopologicalSpace X] [TopologicalSpace Y] (f : X → Y) :
    Prop :=
  ∀ U, isOpen U → isOpen (f ⁻¹' U)

theorem ContComp {X Y Z : Type*}
    [TopologicalSpace X] [TopologicalSpace Y] [TopologicalSpace Z]
    (f : X → Y) (g : Y → Z) (hf : FunCont f) (hg : FunCont g) :
    FunCont (fun x => g (f x)) := by
  intro U hU
  specialize hg U hU
  specialize hf (g ⁻¹' U) hg
  apply hf

end HUJI
