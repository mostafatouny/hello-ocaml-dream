(* query requests *)
module Qr = Util.Query

let tasks_hardcoded = [
    ("first task", true);
    ("second task", false)
]

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

    Dream.get "/login"
        (fun _ ->
            Pages.Template.render_login
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
            let%lwt comments = Dream.sql request Qr.fetch_comments in
            Dream.html( Pages.Template.render_comments comments ));
    ]
