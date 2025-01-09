(* login *)
let render_login =
    <html>
    <%s! render_head "Login" %>
    <body>
        <%s! render_bar [("Home", "/"); ("About", "/about");] %>
        
        <main>
            <article>
                <div style="text-align:center;">
                    <h3> some title </h3>
                    Hello body
                </div>
            </article>
            <form>
                <input type="email" name="email" placeholder="Email address" aria-label="Email address" autocomplete="email" value="retrieved from uri@example.com" disabled/>
                <input type="text" name="firstname" placeholder="First name" aria-label="First name" required />
                <input type="password" name="password" placeholder="Password" required />
                <input type="submit">
                <input type="reset">
                <button type="submit">Subscribe</button>
            </form>

            <article>
                <header>February 2025</header>
                <div>
                    <form>
                        <table>
                            <tbody>
                            <tr>
                              <td> hello </td>
                              <td> hello </td>
                            </tr>
                            <tr>
                              <td> hello </td>
                              <td> hello </td>
                            </tr>
                            <tr>
                              <td> hello </td>
                              <td> hello </td>
                            </tr>
                            <tr>
                              <td> hello </td>
                              <td> hello </td>
                            </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
                <footer>
                </footer>
            </article>
            <article>
                <header> Available Dates </header>
                <form>
                    <fieldset role="group">
                        <input type="date" name="date-1" aria-label="Date" value="2025-01-01" min="2024-12-01" max="2025-03-01">
                        <input type="date" name="date-2" aria-label="Date">
                        <input type="date" name="date-3" aria-label="Date">
                        <button type="submit">Submit</button>
                    </fieldset>
                </form>
            </article>
        </main>
    </body>
    </html>

let render_home tasks =
  <html>
    <%s! render_head "Tasks" %>
  <body>
    <%s! render_bar [("Home", "/"); ("Add Task", "/add");] %>
    <main>
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
  </body>
  </html>

let render_tem (tmpList: (int * string * string * string * int * int option * int option) list) =
  <html>
  <body>
%   tmpList |> List.iter (fun (id, name, password, email, userType_id, academic_id, _) ->
      <p>
        <%s Util.Ppx.show_int id %><%s name %><%s password %><%s email %><%s Util.Ppx.show_int userType_id %>
%       begin match academic_id with
%       | Some _ ->
            <a>Academic</a>
%       | None ->
          <a>Not Academic</a>
%       end;
      </p>
    <% ); %>
  </body>
  </html>
