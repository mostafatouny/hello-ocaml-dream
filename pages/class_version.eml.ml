(* pico, title *)
let render_head title =
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="color-scheme" content="light dark">
        <title> <%s title %> </title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css">
        <style>
            :root {
                --pico-spacing: 1.5rem;
                --pico-grid-column-gap: 1rem;
                --pico-grid-row-gap: 1rem;
                --pico-nav-element-spacing-vertical: 0.1rem;
                --pico-nav-element-spacing-horizontal: 1rem;
                --pico-font-family-sans-serif: sans-serif
            }
            header > nav a {
                font-size: 1.50rem;
            }
            .center {
                text-align: center;
            }
            td {
                text-align: center;
                font-size: 1.5rem;
            }
            td > select, td > div {
                width:5rem;
            }
            .right-aligned {
              width: 20%;
              margin-left: auto;
              text-align: right;
            }
        </style>
    </head>

(* top navigation bar *)
let render_bar buttons =
    <header>
        <nav class="container">
            <ul>
                <li><h1>Collectivae</h1></li>
            </ul>
            <ul>
%           buttons |> List.iter begin fun (label, link) ->
                <li><a href="<%s link %>" class="contrast"> <%s label %> </a></li>
%           end;
            </ul>
        </nav>
    <header>

let render_footer =
    <footer>
        <small> Made with love by volunteers </small>
    </footer>

(* login *)
let render_login =
    <html>
    <%s! render_head "Login" %>
    <body>
        <%s! render_bar [("Home", "/"); ("About", "/about");] %>
        
        <main class="container">
            <article>
                <div class="center">
                    <h3> some title </h3>
                    "Hello body"
                </div>
            </article>
            <form>
                <fieldset role="group">
                    <input type="text" name="firstname" placeholder="First name" aria-label="First name" required />
                    <input type="email" name="email" placeholder="Email address" aria-label="Email address" autocomplete="email" required />
                    <button type="submit">Subscribe</button>
                </fieldset>
            </form>
            <form>
                <div class="grid">
                    <input type="text" name="firstname" placeholder="First name" aria-label="First name" required />
                    <input type="text" name="lastname" placeholder="Last name" aria-label="Last name" required />
                    <input type="email" name="email" placeholder="Email address" aria-label="Email address" autocomplete="email" required />
                </div>
                <div class="grid">
                    <button type="button" class="contrast">Back</button>
                    <button type="submit">Subscribe</button>
                </div>
                <nav>
                  <ul></ul>
                  <ul>
                    <li><button type="button" class="contrast">Reset</button></li>
                    <li><button type="button">Back</button></li>
                    <li><button type="Submit">Submit</button></li>
                  </ul>
                </nav>
                <div class="right-aligned">
                    <button type="button" class="contrast">Reset</button>
                    <button type="button">Back</button>
                </div>
            </form>

            <article>
                <header>February 2025</header>
                <div class="overflow-auto">
                    <form>
                        <table class="center">
                            <tbody>
                            <tr>
                              <td>
                                1
                                <select name="select" aria-label="Select" required>
                                  <option selected disabled value="">Select</option>
                                  <option>Solid</option>
                                  <option>Liquid</option>
                                  <option>Gas</option>
                                  <option>Plasma</option>
                                </select>
                              </td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                            </tr>
                            <tr>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                            </tr>
                            <tr>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                            </tr>
                            <tr>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                              <td><div><label> 2 <input type="checkbox" name="d2" /> </label></div></td>
                            </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
                <footer>
                    <div class="grid">
                        <button type="button" class="contrast">Reset</button>
                        <button type="submit">Submit</button>
                    </div>
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
