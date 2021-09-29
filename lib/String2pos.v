(** Convert strings to positive numbers.
    The encoding used is the trivial one (8 bits per character). *)

From Coq Require Import String Ascii ZArith Extraction.

Definition bool_cons_pos (b: bool) (n: positive) : positive :=
  if b then xI n else xO n.

Definition ascii_cons_pos (c: ascii) (n: positive) : positive :=
  match c with
  | Ascii b0 b1 b2 b3 b4 b5 b6 b7 =>
      bool_cons_pos b0 (
      bool_cons_pos b1 (
      bool_cons_pos b2 (
      bool_cons_pos b3 (
      bool_cons_pos b4 (
      bool_cons_pos b5 (
      bool_cons_pos b6 (
      bool_cons_pos b7 n)))))))
  end.

Extract Constant ascii_cons_pos =>
  "(fun c n ->
      let c = Char.code c in
      let n1 = if c land 1 = 0 then XO n else XI n in
      let n2 = if c land 2 = 0 then XO n1 else XI n1 in
      let n3 = if c land 4 = 0 then XO n2 else XI n2 in
      let n4 = if c land 8 = 0 then XO n3 else XI n3 in
      let n5 = if c land 16 = 0 then XO n4 else XI n4 in
      let n6 = if c land 32 = 0 then XO n5 else XI n5 in
      let n7 = if c land 64 = 0 then XO n6 else XI n6 in
      if c land 128 = 0 then XO n7 else XI n7)".

Fixpoint pos_of_string (s: string) : positive :=
  match s with
  | EmptyString => xH
  | String c s => ascii_cons_pos c (pos_of_string s)
  end.
