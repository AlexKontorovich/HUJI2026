import Mathlib

theorem sum_of_odds (n : ℕ) :
    ∑ k ∈ Finset.range n, (2 * k + 1) = n ^ 2 := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ]
    rw [ih]
    ring

theorem mul_nonzero_isPerm {p : ℕ}
  (a : (ZMod p)ˣ) :
  Function.Bijective (a * .) := by
  split_ands
  · intro x y h
    simpa using h
  · intro x
    use a⁻¹ * x
    simp

theorem fermatLittle (p : ℕ) [Fact (Nat.Prime p)]
  (a : (ZMod p)ˣ) :
    a ^ (p - 1) = 1 := by
  set k₁ := ∏ x : (ZMod p)ˣ, x with hk₁
  set k₂ := ∏ x : (ZMod p)ˣ, a * x with hk₂
  have zpCard : (Finset.univ : Finset (ZMod p)ˣ).card = p - 1 := by
    rw [Finset.card_univ]
    rw [Fintype.card_units]
    simp
  have h₀ : k₂ = a ^ (p - 1) * k₁ := by
    rw [hk₂, hk₁]
    rw [Finset.prod_mul_distrib]
    rw [Finset.prod_const]
    rw [zpCard]
  have h₁ : k₁ = k₂ := by
    rw [hk₁, hk₂]
    apply Fintype.prod_bijective (he := mul_nonzero_isPerm a⁻¹)
    intro x
    simp
  rw [h₀] at h₁
  simpa using h₁
