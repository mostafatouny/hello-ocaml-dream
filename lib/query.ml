module type DB = Caqti_lwt.CONNECTION
module T = Caqti_type

let fetch_event =
    let query =
        let open Caqti_request.Infix in
        ( T.int ->! T.(t2 string string) )
        ("SELECT name, desc FROM event WHERE id==$1") in
    fun id (module Db : DB) ->
        let%lwt response_or_error = Db.find query id in
        Caqti_lwt.or_fail response_or_error

let fetch_top_event_dates =
    let query =
        let open Caqti_request.Infix in
        ( T.int ->* T.(t3 int string int) )
        ("SELECT event_id, STRFTIME('%Y-%m-%d', date) unique_day, COUNT(DISTINCT guest_id) count FROM guest_event WHERE event_id==$1 GROUP BY unique_day ORDER BY count DESC LIMIT 3") in
    fun event_id (module Db : DB) ->
        let%lwt response_or_error = Db.collect_list query event_id in
        Caqti_lwt.or_fail response_or_error

let create_guest =
    let query =
        let open Caqti_request.Infix in
        ( T.(t4 string string string string) ->! T.int )
        ("INSERT INTO guest (name, email, affiliation, position) VALUES (?, ?, ?, ?) RETURNING id") in
    fun (name, email, affiliation, position) (module Db : DB) ->
        let%lwt response_or_error = Db.find query (name, email, affiliation, position) in
        Caqti_lwt.or_fail response_or_error

let insert_guest_event =
    let query =
        let open Caqti_request.Infix in
        ( T.(t3 int int string) ->. T.unit )
        ("INSERT INTO guest_event (guest_id, event_id, date) VALUES (?, ?, ?)") in
    fun (guest_id, event_id, date) (module Db : DB) ->
        let%lwt unit_or_error = Db.exec query (guest_id, event_id, date) in
        Caqti_lwt.or_fail unit_or_error


(* let fetch_users = *)
(*     let query = *)
(*         let open Caqti_request.Infix in *)
(*         (T.unit ->* T.(t7 int string string string int (option int) (option int))) *)
(*         "SELECT id, name, password, email, userType_id, academic_id, industry_id FROM user" in *)
(*     fun (module Db : DB) -> *)
(*         let%lwt response_or_error = Db.collect_list query () in *)
(*         Caqti_lwt.or_fail response_or_error *)
(**)
(* let fetch_events = *)
(*     let query = *)
(*         let open Caqti_request.Infix in *)
(*         (T.unit ->* T.(t4 int string string string )) *)
(*         "SELECT id, name, place, date FROM event" in *)
(*     fun (module Db : DB) -> *)
(*         let%lwt response_or_error = Db.collect_list query () in *)
(*         Caqti_lwt.or_fail response_or_error *)
