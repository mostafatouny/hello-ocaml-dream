(* query requests *)
module Qr = Util.Query


let () =

    (* fetch database path *)
    let dbPath =
        try Sys.getenv "DB_PATH"
        with Not_found ->
            raise (Failure "Database path is not set as an environment variable.") in

    Dream.run ~interface:"0.0.0.0"
    @@ Dream.logger
    @@ Dream.sql_pool ("sqlite3:" ^ dbPath)
    @@ Dream.router [
    
    Dream.get "/"
        (fun request ->
            (* redirect to events list *)
            Dream.redirect request "/event/events");

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
    
    (* list public events *)
    Dream.get "/event/events"
        (fun request -> let%lwt publicEvents = Qr.fetch_publicEvents |> Dream.sql request in
                  Pages.Template.eventsList publicEvents |> Dream.html);

    (* create event *)
    Dream.get "/event/create"
        (fun _ -> Pages.Template.createEvent |> Dream.html );

    (* submit event *)
    Dream.get "/event/submit"
        (fun request ->
            (* fetch submission as a list of key-value pairs. e.g. [ ("name", "AUC"); ("desc", "hello\nthis is by"); .. ] *)
            let keyValueList = Dream.all_queries request in

            (* get value of a key. e.g. "firstname" -> "john" *)
            let getVal key = List.find (fun t -> (fst t) = key) keyValueList |> snd in
            
            (* check if isPublic exists *)
            let isPublic = if List.exists (fun t -> (fst t) = "isPublic") keyValueList then 1 else 0 in

            (* dates strings suffix in iso format *)
            let datesList = List.drop 4 keyValueList |> List.map (fun t -> snd t)
                |> List.map (fun s -> (String.sub s 0 10) ^ " " ^ (String.sub s 11 5) ^ ":00" ) in
            
            (* insert the event *)
            let%lwt retrieved_event_id = Qr.create_event (getVal "name", getVal "desc", getVal "place", isPublic)
                |> Dream.sql request in

            (* let%lwt _ = Qr.insert_event_date (retrieved_event_id, List.hd datesList) |> Dream.sql request in *)

            (* loop on the dates *)
            let%lwt () = datesList |> Lwt_list.iter_s (fun date ->
                (* for each, insert for the created event *)
                Qr.insert_event_date (retrieved_event_id, date) |> Dream.sql request) in
            
            Dream.redirect request ("/alert?title=Success&para=your+event+id+is+" ^ string_of_int(retrieved_event_id) ) );

    (* test. id is not in the database. handle the exception raised by ->! *)
    Dream.get "/event/:event_id"
        (fun request ->
            let event_id = Dream.param request "event_id" |> int_of_string in
            let%lwt (name, desc) = Dream.sql request (Qr.fetch_event event_id) in
            let%lwt top_event_dates = Dream.sql request (Qr.fetch_top_event_dates event_id) in
                Pages.Template.event event_id name desc top_event_dates |> Dream.html);
    
    (* expects title, para *)
    (* e.g /alert?title=Success&para=feel+free+to+close *)
    (* e.g /alert?title=Failed&para=your+request+is+missing+a+required+parameter *)
    Dream.get "/alert"
        (fun request ->
            match (Dream.query request "title", Dream.query request "para") with
            | (Some title, Some para) -> Pages.Template.alert title para |> Dream.html
            | _ -> Dream.html "ERROR: some URI query parameter is not found");

   ]
