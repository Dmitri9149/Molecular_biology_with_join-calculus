(***********************************************************************)
(*                                                                     *)
(*                           Objective Caml                            *)
(*                                                                     *)
(*            Luc Maranget, projet Moscova, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 2005 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* $Id: join_debug.mli 12965 2012-09-27 16:06:22Z maranget $ *)

val  verbose : int

type 'a t = string -> (('a, unit, string, unit) format4 -> 'a)

val debug : 'a t
val debug0 : 'a t
val debug1 : 'a t
val debug2 : 'a t
val debug3 : 'a t
