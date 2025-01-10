(* query requests *)
module Qr = Util.Query

(* let tasks_hardcoded = [ *)
(*     ("first task", true); *)
(*     ("second task", false) *)
(* ] *)

let () =
    Dream.run
    @@ Dream.logger
    @@ Dream.sql_pool "sqlite3:db.sqlite"
    @@ Dream.router [
    
    Dream.get "/attendee/submit"
        (fun request ->
            (* fetch submission as a list of key-value pairs. e.g. [ ("firstname", "john"); ("lastname", "doe"); .. ] *)
            let keyValueList = Dream.all_queries request in

            (* get value of a key. e.g. "firstname" -> "john" *)
            let getVal key = List.find (fun t -> (fst t) = key) keyValueList |> snd in

            (* insert guest into the guest table and retrieve her new auto incremented id *)
            let%lwt retrieved_guest_id = Qr.create_guest (
                        getVal "firstname" ^ " " ^ getVal "lastname",
                        getVal "email",
                        getVal "affiliation",
                        getVal "position")
                    |> Dream.sql request in

            (* insert guest's available dates into guest_event table *)
            let%lwt _ = Qr.insert_guest_event (
                        retrieved_guest_id,
                        getVal "event_id" |> int_of_string,
                        getVal "date-1" ^ " " ^ getVal "time-1")
                    |> Dream.sql request in

            (* alarm success *)
            Dream.redirect request "/alert?title=Success&para=your+submission+is+received");
    
    (* test. id is not in the database. handle the exception raised by ->! *)
    Dream.get "/event/:event_id"
        (fun request ->
            let event_id = Dream.param request "event_id" |> int_of_string in
            let%lwt (name, desc) = Dream.sql request (Qr.fetch_event event_id) in
            let%lwt top_event_dates = Dream.sql request (Qr.fetch_top_event_dates event_id) in
                Pages.Template.render_event event_id name desc top_event_dates |> Dream.html);

    
    (* expects title, para *)
    (* e.g /alert?title=Success&para=feel+free+to+close *)
    (* e.g /alert?title=Failed&para=your+request+is+missing+a+required+parameter *)
    Dream.get "/alert"
        (fun request ->
            match (Dream.query request "title", Dream.query request "para") with
            | (Some title, Some para) -> Pages.Template.render_alert title para |> Dream.html
            | _ -> Dream.html "ERROR: some URI query parameter is not found");

   ]
