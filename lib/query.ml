module type DB = Caqti_lwt.CONNECTION
module T = Caqti_type

let queryReq queryStr =
    let query =
        let open Caqti_request.Infix in
        (T.unit ->* T.(t2 int string))
        queryStr in
    fun (module Db : DB) ->
        let%lwt response_or_error = Db.collect_list query () in
        Caqti_lwt.or_fail response_or_error

(* let fetch_comments = queryReq "SELECT id, text FROM comment" *)

let fetch_users = queryReq "SELECT id, name, password FROM user"
(* let fetch_users = queryReq "SELECT id, name, password, email, userType_id, academic_id, industry_id FROM user" *)
