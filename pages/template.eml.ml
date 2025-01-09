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
let render_bar buttons =
    <header>
        <nav style="font-size: 1.2rem;">
            <ul>
                <li><h1>Collectivae</h1></li>
            </ul>
            <ul>
%           buttons |> List.iter begin fun (label, link) ->
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

let render_home top_event_dates =
    <html>
    <%s! render_head "Home" %>
    <body>
        <%s! render_bar [("Home", "/"); ("About", "/about");] %>
        
        <main>
            <article>
                <div style="text-align:center;">
                    <h3> some title </h3>
                    Hello body
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
                                <td> <%s date %> </td>
                                <td> <%s Util.Ppx.show_int count %> </td>
                            </tr>
                        <% ); %>
                    </tbody>
                </table>
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

            <form>
                <input type="email" name="email" placeholder="Email address" aria-label="Email address" autocomplete="email" value="retrieved from uri@example.com" disabled/>
                <input type="text" name="firstname" placeholder="First name" aria-label="First name" required />
                <input type="password" name="password" placeholder="Password" required />
                <input type="submit">
                <input type="reset">
                <button type="submit">Subscribe</button>
            </form>

        </main>
    </body>
    </html>
