From Coq Require Import String.
From Tries Require Import Benchmark.

Local Open Scope string_scope.

Compute "PrimitiveRecord (repeated keys, x10)".
Time Eval vm_compute in (repeat 10 TestPrimitiveRecord.bench2 tt).
Compute "Record (repeated keys, x10)".
Time Eval vm_compute in (repeat 10 TestRecord.bench2 tt).
Compute "Sigma (repeated keys, x10)".
Time Eval vm_compute in (repeat 10 TestSigma.bench2 tt).
Compute "Original (repeated keys, x10)".
Time Eval vm_compute in (repeat 10 TestOriginal.bench2 tt).
Compute "Canonical (repeated keys, x10)".
Time Eval vm_compute in (repeat 10 TestCanonical.bench2 tt).
