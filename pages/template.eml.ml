(* event *)
let event id title desc date place top_event_dates =
    <html>
    <%s! Component.head title %>
    <body>
        <%s! Component.bar %>

        <main>
            <article>
                <h3 style="text-align:center;"> <%s title %> </h3>

%               begin match date with
%               | Some s ->
                <span style="text-align:center;"> Date &emsp; <%s Util.Date.dateIsoToName s %> </span><br>
%               | None ->

%               end;
                
%               begin match place with
%               | Some s ->
                <span style="text-align:center;"> Place &emsp; <%s s %> </span><br>
%               | None ->

%               end;

%               begin match desc with
%               | Some s ->
                <br><span style="white-space: pre-wrap;"> <%s s %> </span><br>
%               | None ->

%               end;
            </article>
            
            <article>
                <header> Top Dates Submissions </header>
                <table>
                    <thead>
                        <tr>
                            <td> Date </td>
                            <td> Count </td>
                        </tr>
                    </thead>
                    <tbody>
%                       top_event_dates |> List.filter (fun t-> snd t > 0) |> List.iter (fun (date, count) ->
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

%                   begin match date with
%                   | Some s ->
                    <h5> Date </h5>
                    <select name="date-1" required>
                        <option value="<%s s %>" selected> <%s Util.Date.dateIsoToName s %> </option>
                    </select>
%                   | None ->
                    <h5> Available Dates </h5>
                    <div id="date-inputs">
                        <select name="date-1" required>
%                           top_event_dates |> List.iter (fun (date, _) ->
                                <option value="<%s date %>"> <%s Util.Date.dateIsoToName date %> </option>
                            <% ); %>
                        </select>
                    </div>
                    <fieldset role="group">
                        <button type="button" id="add-date">Add Date</button>
                        <button type="button" id="remove-date">Remove Date</button>
                    </fieldset>
%                   end;

                   <fieldset role="group">
                        <button type="submit">Submit</button>
                        <input type="reset">
                    </fieldset>
                </form>
            </article>

            <%s! Component.interactiveAddDeleteButtons "date-inputs" "date" %>
        </main>
    </body>
    </html>

(* list public events *)
let eventsList publicEvents = 
    <html>
    <%s! Component.head "Events" %>
    <body>
        <%s! Component.bar %>
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
                            <td> <%s Util.Date.dateIsoToName s %> </td>
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
    <%s! Component.head "Create" %>
    <body>
        <%s! Component.bar %>
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
                        <button type="button" id="remove-date">Remove Date</button>
                    </fieldset>

                    <fieldset role="group">
                        <button type="submit">Submit</button>
                        <input type="reset">
                    </fieldset>
                </form>
            </article>
        </main>

        <%s! Component.interactiveAddDeleteButtons "date-inputs" "date" %>
    </body>
    </html>

(* request response alert *)
let alert title para =
    <html>
    <%s! Component.head "Alert" %>
    <body>
        <%s! Component.bar %>
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
