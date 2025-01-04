module type DB = Caqti_lwt.CONNECTION
module T = Caqti_type

let fetch_comments =
    let query =
        let open Caqti_request.Infix in
        (T.unit ->* T.(t2 int string))
        "SELECT id, text FROM comment" in
    fun (module Db : DB) ->
        let%lwt response_or_error = Db.collect_list query () in
        Caqti_lwt.or_fail response_or_error

let fetch_users =
    let query =
        let open Caqti_request.Infix in
        (T.unit ->* T.(t7 int string string string int (option int) (option int)))
        "SELECT id, name, password, email, userType_id, academic_id, industry_id FROM user" in
    fun (module Db : DB) ->
        let%lwt response_or_error = Db.collect_list query () in
        Caqti_lwt.or_fail response_or_error

let fetch_events =
    let query =
        let open Caqti_request.Infix in
        (T.unit ->* T.(t4 int string string string ))
        "SELECT id, name, place, date FROM event" in
    fun (module Db : DB) ->
        let%lwt response_or_error = Db.collect_list query () in
        Caqti_lwt.or_fail response_or_error
