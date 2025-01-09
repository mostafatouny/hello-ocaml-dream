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
    (* @@ Dream.sql_sessions *)
    @@ Dream.router [

    Dream.get "/"
        (fun request ->
            let%lwt top_event_dates = Dream.sql request (Qr.fetch_top_event_dates 2) in
            top_event_dates
            |> [%show: (int * string * int) list]
            |> Dream.html);

    Dream.get "/home"
        (fun request ->
            let%lwt top_event_dates = Dream.sql request (Qr.fetch_top_event_dates 1) in
            top_event_dates     (* [ (1, "2025-01-01", 2); (2, "2025-01-02", 1) ] *)
            |> Pages.Template.render_home
            |> Dream.html);
    
    (* Dream.get "/" *)
    (*     (fun request -> *)
    (*         let%lwt users = Dream.sql request Qr.fetch_users in *)
    (*         users *)
    (*         (* |> Util.Ppx.show_user_list *) *)
    (*         |> Pages.Template.render_tem *)
    (*         |> Dream.html); *)

    (* Dream.get "/login" *)
    (*     (fun _ -> *)
    (*         Pages.Template.render_login *)
    (*         |> Dream.html); *)
    (*  *)
    (* Dream.get "/tasks" *)
    (*     (fun _ -> *)
    (*         Pages.Template.render_home tasks_hardcoded *)
    (*         |> Dream.html); *)
    (**)
    (* Dream.get "/task/echo/:task" *)
    (*     (fun request -> *)
    (*         Dream.param request "task" *)
    (*         |> Pages.Template.render_task tasks_hardcoded *)
    (*         |> Dream.html); *)

   ]
