(* pico, title *)
let render_head title =
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="color-scheme" content="light dark">
        <title> <%s title %> </title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.classless.min.css"
    </head>

(* top navigation bar *)
let render_bar =
    <header>
        <nav style="font-size: 1.2rem;">
            <ul>
                <li><h1>Collectivae</h1></li>
            </ul>
            <ul>
%           [ ("AUC Launch", "/event/1"); ("Home", "/"); ("About", "/about"); ] |> List.iter begin fun (label, link) ->
                <li><a href="<%s link %>"> <%s label %> </a></li>
%           end;
            </ul>
        </nav>
    <header>

(* footer *)
let render_footer =
    <footer>
        <small> Made with love by volunteers </small>
    </footer>

(* event *)
let render_event id title desc top_event_dates =
    <html>
    <%s! render_head title %>
    <body>
        <%s! render_bar %>

        <main>
            <article>
                <div style="text-align:center;">
                    <h3> <%s title %> </h3>
                    <%s desc %>
                </div>
            </article>
            
            <article>
                <header> Top Available Dates </header>
                <table style="font-size:1rem">
                    <thead>
                        <tr>
                            <td> Date </td>
                            <td> Available Count </td>
                        </tr>
                    </thead>
                    <tbody>
%                       top_event_dates |> List.iter (fun (_, date, count) ->
                            <tr>
                                <td> <%s Util.Date.dateIsoToName date %> </td>
                                <td> <%s Util.Ppx.show_int count %> </td>
                            </tr>
                        <% ); %>
                    </tbody>
                </table>
            </article>

            <article>
                <header> Submit </header>
                <form action="/attendee/submit" method="get">
                    <input name="event_id" value=<%s string_of_int id %> hidden>
                    <h5> Available Dates </h5>
                    <fieldset role="group">
                        <input type="date" name="date-1"
%                           if not (List.is_empty top_event_dates) then begin
                                value=<%s List.hd top_event_dates |> (fun (_, date, _) -> String.sub date 0 10) %>
%                           end;
                            min="2025-1-20" max="2025-03-01" required>
                        <select name="time-1" aria-label="Time" required>
                          <option value="08:00:00">Morning 8:00 AM</option>
                          <option value="18:00:00">Evening 6:00 PM</option>
                        </select>
                    </fieldset>
                    <fieldset role="group">
                        <input type="date" name="date-2" value="">
                        <select name="time-2" aria-label="Time">
                          <option selected></option>
                          <option value="08:00:00">Morning 8:00 AM</option>
                          <option value="18:00:00">Evening 6:00 PM</option>
                        </select>
                    </fieldset>
                    <fieldset role="group">
                        <input type="date" name="date-3">
                        <select name="time-3" aria-label="Time">
                          <option selected></option>
                          <option value="08:00:00">Morning 8:00 AM</option>
                          <option value="18:00:00">Evening 6:00 PM</option>
                        </select>
                    </fieldset>
                    <h5> Name </h5>
                    <fieldset role="group">
                        <input type="text" name="firstname" placeholder="First" required />
                        <input type="text" name="lastname" placeholder="Last" required />
                    </fieldset>
                    <h5> Email </h5>
                    <input type="email" name="email" placeholder="Email" required />
                    <h5> Affiliation </h5>
                    <fieldset role="group">
                        <input type="text" name="affiliation" placeholder="University or Company" required />
                        <input type="text" name="position" placeholder="Position" required />
                    </fieldset>
                    <fieldset role="group">
                        <button type="submit">Submit</button>
                        <input type="reset">
                    </fieldset>
                </form>
            </article>

            <form>
            </form>

        </main>
    </body>
    </html>

(* request response alert *)
let render_alert title para =
    <html>
    <%s! render_head "Alert" %>
    <body>
        <%s! render_bar %>
        <main>
            <article>
                <div style="text-align:center;">
                    <h3> <%s title %> </h3>
                    <%s para %>
                </div>
            </article>
        </main>
    </body>
    </html>
