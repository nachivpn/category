module Lemma.AbstractMorphism where

-- Lemmas about special morphisms

open import Level
open import Category


module Core {o a e} {C : Category o a e} where

  open import Iso
  open import EpiMono
  open import Relation.Binary.SetoidReasoning
  open import Data.Product
  
  open Category.Category C
  open Iso.Core C
  open EpiMono.Core C
  open iso
  
  isoIsEpi : ∀ {A B} {f : A ⇒ B} → iso f → epi f
  isoIsEpi {A} {B} {f} iso =
    record { epic = λ {C} {i} {j} if≈jf →
      begin⟨ Hom B C ⟩
        i
          ≈⟨ sym isEq id-l ⟩
        i ∙ Id B
          ≈⟨ congl _ _ (sym isEq (fnb iso)) i ⟩
        i ∙ (forth iso ∙ back iso)
          ≈⟨ assoc ⟩
        (i ∙ forth iso) ∙ back iso
          ≈⟨ congr _ _ if≈jf (back iso) ⟩
        (j ∙ forth iso) ∙ back iso
          ≈⟨ sym isEq assoc ⟩
        j ∙ (forth iso ∙ back iso)
          ≈⟨ congl _ _ (fnb iso) j ⟩
        j ∙ Id B
          ≈⟨ id-l ⟩
        j ∎  }

  isoIsMono : ∀ {A B} {f : A ⇒ B} → iso f → mono f
  isoIsMono {A} {B} {f} iso =
    record { monic = λ {C} {i} {j} fi≈fj →
      begin⟨ Hom C A ⟩
        i
          ≈⟨ id-r ⟩
        Id A ∙ i
          ≈⟨ congr _ _ (sym isEq (bnf iso)) i ⟩
        back iso ∙ forth iso ∙ i
          ≈⟨ sym isEq assoc ⟩
        back iso ∙ (forth iso ∙ i)
          ≈⟨ congl _ _ fi≈fj (back iso) ⟩
        back iso ∙ (forth iso ∙ j)
          ≈⟨ assoc ⟩
        (back iso ∙ forth iso) ∙ j
          ≈⟨ congr _ _ (bnf iso) j ⟩
        Id A ∙ j
          ≈⟨ sym isEq id-r ⟩
        j ∎      }

  splitMonoIsMono : ∀ {A B} {f : A ⇒ B} → split-mono f → mono f
  splitMonoIsMono {A} {B} {f} record { l-inv = (g , gf≈Id) } =
    record { monic = λ {C} {i} {j} fi≈fj →
      begin⟨ Hom C A ⟩
        i
          ≈⟨ id-r ⟩
        Id A ∙ i
          ≈⟨ substl (sym isEq gf≈Id) ⟩
        g ∙ f ∙ i
          ≈⟨ sym isEq assoc ⟩
        g ∙ (f ∙ i)
          ≈⟨ substr fi≈fj ⟩
        g ∙ (f ∙ j)
          ≈⟨ assoc ⟩
        g ∙ f ∙ j
          ≈⟨ substl gf≈Id ⟩
        Id A ∙ j
          ≈⟨ sym isEq id-r ⟩
       j ∎ }

  splitEpiIsEpi : ∀ {A B} {f : A ⇒ B} → split-epi f → epi f
  splitEpiIsEpi {A} {B} {f} record { r-inv = (g , fg≈Id) } =
    record { epic = λ {C} {i} {j} if≈jf →
      begin⟨ Hom B C ⟩
      i
        ≈⟨ sym isEq id-l ⟩
      i ∙ Id B
        ≈⟨ substr (sym isEq fg≈Id) ⟩
      i ∙ (f ∙ g)
        ≈⟨ assoc ⟩
      (i ∙ f) ∙ g
        ≈⟨ substl if≈jf ⟩
      (j ∙ f) ∙ g
        ≈⟨ sym isEq assoc ⟩
      j ∙ (f ∙ g)
        ≈⟨ substr fg≈Id ⟩
      j ∙ Id B
        ≈⟨ id-l ⟩
      j ∎  }

  iso∙isoIsIso : ∀ {A B C} {f : A ⇒ B} {g : B ⇒ C} → iso f → iso g → iso (g ∙ f)
  iso∙isoIsIso {A} {B} {C} {f} {g} isof isog =
    record { inv = inv isof ∙ inv isog ;
             bnf = 
               begin⟨ Hom A A ⟩
               (back isof ∙ back isog) ∙ (g ∙ f)
                 ≈⟨ assoc4 ⟩
               back isof ∙ (back isog ∙ g) ∙ f
                 ≈⟨ substl (substr (bnf isog)) ⟩
               back isof ∙ (Id B) ∙ f
                 ≈⟨ substl id-l ⟩
               back isof ∙ f
                 ≈⟨ bnf isof ⟩
               Id A ∎ ;
             fnb =
               begin⟨ Hom C C ⟩
               (g ∙ f) ∙ (back isof ∙ back isog) 
                 ≈⟨ assoc4 ⟩
               g ∙ (f ∙ back isof) ∙ back isog
                 ≈⟨ substl (substr (fnb isof)) ⟩
               g ∙ Id B ∙ back isog 
                 ≈⟨ substl id-l ⟩
               g ∙ back isog
                 ≈⟨ fnb isog ⟩
               Id C ∎ }


 
