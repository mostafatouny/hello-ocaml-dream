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

(* input add and remove buttons *)
let interactiveAddDeleteButtons containerId inputName = 
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            let count = 1;

            const dateInputsContainer = document.getElementById("<%s containerId %>");
            const addDateButton = document.getElementById("add-date");
            const removeDateButton = document.getElementById("remove-date");
            const input_1 = document.getElementsByName("<%s inputName %>-1")[0];

            addDateButton.addEventListener("click", function() {
                count++;
                const newInput = input_1.cloneNode(true);
                newInput.name = `<%s inputName %>-${count}`;
                dateInputsContainer.appendChild(newInput);
                removeDateButton.disabled = false;
            });

            removeDateButton.addEventListener("click", function() {
                if (count > 1) {
                    dateInputsContainer.removeChild(dateInputsContainer.lastElementChild);
                    count--;
                }
                if (count === 1) {
                    removeDateButton.disabled = true;
                }
            });
        });
    </script>
