module type DB = Caqti_lwt.CONNECTION
module T = Caqti_type

let tasks_hardcoded = [
    ("Write documentation", true);
    ("Create examples", true);
    ("Publish website", true);
    ("Profit", false);
]

(* let comments_hardcoded = [ *)
(*     (1,"first comment"); *)
(*     (2,"second comment"); *)
(* ] *)

let fetch_comments =
  let query =
    let open Caqti_request.Infix in
    (T.unit ->* T.(t2 int string))
    "SELECT id, text FROM comment" in
  fun (module Db : DB) ->
    let%lwt comments_or_error = Db.collect_list query () in
    Caqti_lwt.or_fail comments_or_error

let () =
    Dream.run
    @@ Dream.logger
    @@ Dream.sql_pool "sqlite3:db.sqlite"
    (* @@ Dream.sql_sessions *)
    @@ Dream.router [

    Dream.get "/"
        (fun _ ->
            ["hello"; "world"]
            |> Util.Ppx.show_string_list
            |> Dream.html);

    Dream.get "/tasks"
        (fun _ ->
            Pages.Template.render_home tasks_hardcoded
            |> Dream.html);

    Dream.get "/task/echo/:task"
        (fun request ->
            Dream.param request "task"
            |> Pages.Template.render_task tasks_hardcoded
            |> Dream.html);
   
    Dream.get "/comments"
        (fun request ->
            let%lwt comments = Dream.sql request fetch_comments in
            Dream.html( Pages.Template.render_comments comments ));
    ]
