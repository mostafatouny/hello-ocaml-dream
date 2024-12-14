let () =
    Dream.run
    
    (* terminal logging *)
    @@ Dream.logger
    
    (* inject a script into the HTML to autoreload by websocket *)
    (* @@ Dream.livereload *)
    
    (* routing urls *)
    @@ Dream.router [

        Dream.get "/"
            (fun _ ->
                Dream.html ("Good morning from the index page.") );

        Dream.get "/:word"
            (fun request ->
                Dream.html
                @@ Pages.Template.render
                @@ Dream.param request "word");

    ]
