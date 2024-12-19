let render_bar title buttons =
    <header>
        <nav class="container">
            <ul>
                <li><strong> header title is <%s title %> </strong></li>
            </ul>
            <ul>
%           buttons |> List.iter begin fun (label, link) ->
                <li><a href="<%s link %>"><%s label %></a></li>
%           end;
            </ul>
        </nav>
    <header>

let render_home tasks =
  <html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://unpkg.com/@picocss/pico@latest/css/pico.min.css">
    <title>Task List</title>
  </head>
  <body>
    <%s! render_bar "my title" [("Home", "/"); ("Add Task", "/add");] %>
    <main class="container">
      <h1>Task List</h1>
%     tasks |> List.iter begin fun (name, complete) ->
        <article>
          <p>Task <%s name %>: 
%           if complete then begin
              <strong>complete!</strong>
%           end
%           else begin
              <strong>not complete.</strong>
%           end;
          </p>
        </article>
%     end;
    </main>
  </body>
  </html>


let render_task tasks task =
  <html>
  <body>
%   begin match List.assoc_opt task tasks with
%   | Some complete ->
      <p>Task: <%s task %></p>
      <p>Complete: <%B complete %></p>
%   | None ->
      <p>Task not found!</p>
%   end;
  </body>
  </html>

let render_comments comments =
  <html>
  <body>

%   comments |> List.iter (fun (_id, comment) ->
      <p><%s comment %></p>
    <% ); %>

    <form method="POST" action="/comments/add">
      <input name="text" autofocus>
    </form>

  </body>
  </html>
