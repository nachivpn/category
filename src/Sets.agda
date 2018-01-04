module Sets where

open import Category
open import Prelude.Function
open import Prelude.Equality

SetCat : Category (lsuc lzero) lzero lzero
SetCat = record
                { Object = Set
                ; _⇒_ = λ A B → (A → B)
                ; _∙_ = λ f g → f ∘ g
                ; Id = λ A → id
                ; _≈_ = _≡_
                ; assoc = λ A B C D f g h → refl
                ; id-l = λ A B f → refl
                ; id-r = λ A B f → refl
                }