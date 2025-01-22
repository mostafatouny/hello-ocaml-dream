(* pico, title *)
let head title =
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="color-scheme" content="light dark">
        <title> <%s title %> </title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.classless.min.css"
    </head>

(* top navigation bar *)
let bar =
    <header>
        <nav style="font-size: 1.0rem;">
            <ul>
                <li><h1>Collectivae</h1></li>
            </ul>
            <ul>
%           [ ("Events", "/event/events"); ("Create", "/event/create") ] |> List.iter begin fun (label, link) ->
                <li><a href="<%s link %>"> <%s label %> </a></li>
%           end;
            </ul>
        </nav>
    <header>

(* footer *)
let footer =
    <footer>
        <small> Made with love by volunteers </small>
    </footer>

(* event *)
let event id title desc top_event_dates =
    <html>
    <%s! head title %>
    <body>
        <%s! bar %>

        <main>
            <article>
                <div style="text-align:center;">
                    <h3> <%s title %> </h3>
                    <%s desc %>
                </div>
            </article>
            
            <article>
                <header> Top Available Dates </header>
                <table>
                    <thead>
                        <tr>
                            <td> Date </td>
                            <td> Available Count </td>
                        </tr>
                    </thead>
                    <tbody>
%                       top_event_dates |> List.filter (fun t-> snd t > 0 ) |> List.iter (fun (date, count) ->
                            <tr>
                                <td> <%s Util.Date.dateIsoToName date %> </td>
                                <td> <%s string_of_int(count) %> </td>
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
                    <select name="date-1" required>
%                       top_event_dates |> List.iter (fun (date, _) ->
                            <option value=<%s date %> > <%s Util.Date.dateIsoToName date %> </option>
                        <% ); %>
                    </select>
                    <select name="date-2">
                        <option selected disabled> </option>
%                       top_event_dates |> List.iter (fun (date, _) ->
                            <option value=<%s date %> > <%s Util.Date.dateIsoToName date %> </option>
                        <% ); %>
                    </select>
                    <select name="date-3">
                        <option selected disabled> </option>
%                       top_event_dates |> List.iter (fun (date, _) ->
                            <option value=<%s date %> > <%s Util.Date.dateIsoToName date %> </option>
                        <% ); %>
                    </select>
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

(* list public events *)
let eventsList publicEvents = 
    <html>
    <%s! head "Events" %>
    <body>
        <%s! bar %>
        <main>
            <article>
                <h3 style="text-align:center;"> Events </h3>
                
                <table>
                    <thead>
                        <tr>
                            <td> Name </td>
                            <td> Date </td>
                        </tr>
                    </thead>
                    <tbody>
%                   publicEvents |> List.iter (fun (id, name, date) ->
                        <tr>
                            <td> <a href= <%s "/event/" ^ string_of_int(id) %> > <%s name %> </a> </td>
%                           begin match date with
%                           | Some s ->
                            <td> <%s s %> </td>
%                           | None ->
                            <td> </td>
%                           end;
                        </tr>
                    <% ); %>
                    </tbody>
                </table>
            </article>
        </main>
    </body>
    </html>

(* create a new event *)
let createEvent =
    <html>
    <%s! head "Create" %>
    <body>
        <%s! bar %>
        <main>
            <article>
                <h3 style="text-align:center;"> Create Event </h3>
                <form action="/event/submit" method="get">
                    <h5> Name </h5>
                    <input type="text" name="name" required>
                    <h5> Description </h5>
                    <textarea name="desc"> </textarea>
                    <h5> Place </h5>
                    <input type="text" name="place">
                    <h5> Publicly Listed </h5>
                    <fieldset>
                        <input type="checkbox" name="isPublic">
                        <label htmlFor="isPublic">Yes</label>
                    </fieldset>
                    <h5> Dates </h5>
                    <div id="date-inputs">
                        <input type="datetime-local" name="date-1" required>
                    </div>
                    
                    <fieldset role="group">
                        <button type="button" id="add-date">Add Date</button>
                        <button type="button" id="remove-date" disabled>Remove Date</button>
                    </fieldset>

                    <fieldset role="group">
                        <button type="submit">Submit</button>
                        <input type="reset">
                    </fieldset>
                </form>
            </article>
        </main>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                let dateCount = 1;

                const dateInputsContainer = document.getElementById('date-inputs');
                const addDateButton = document.getElementById('add-date');
                const removeDateButton = document.getElementById('remove-date');

                addDateButton.addEventListener('click', function() {
                    dateCount++;
                    const newDateInput = document.createElement('input');
                    newDateInput.type = 'datetime-local';
                    newDateInput.name = `date-${dateCount}`;
                    dateInputsContainer.appendChild(newDateInput);
                    removeDateButton.disabled = false;
                });

                removeDateButton.addEventListener('click', function() {
                    if (dateCount > 1) {
                        dateInputsContainer.removeChild(dateInputsContainer.lastElementChild);
                        dateCount--;
                    }
                    if (dateCount === 1) {
                        removeDateButton.disabled = true;
                    }
                });
            });
        </script>
    </body>
    </html>

(* request response alert *)
let alert title para =
    <html>
    <%s! head "Alert" %>
    <body>
        <%s! bar %>
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
